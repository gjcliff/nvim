-- Making some snippets, how can I include these from a separate file?
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local function to_snake_case(str)
  -- Simple example
  return str:gsub("(%u)", "_%1"):lower():gsub("^_", "")
end

ls.add_snippets("python", {
  s("temp_zenoh",
    fmt([[
import time
import json
import zenoh


class {}:

    def __init__(self):
        self.config = None
        self.session = None

    def zenoh_setup(self):
        # declare publishers and subscribers here
        pub_key_expr = "{}"
        json_key_expr = "{}"
        protobuf_key_expr = "{}"
        self.pub = self.session.declare_publisher(pub_key_expr)
        # self.protobuf_sub = self.declare_zenoh_subscription(
        #     protobuf_key_expr, self.protobuf_callback, self.deserialize_protobuf()
        # )
        # self.json_sub = self.declare_zenoh_subscription(
        #     json_key_expr, self.json_callback, self.deserialize_json
        # )

    def declare_zenoh_subscription(self, key_expr, callback, deserializer):
        try:
            sub = self.zenoh_session.declare_subscriber(
                key_expr,
                lambda sample: callback(deserializer(sample.payload)),
            )
            print(f"[Zenoh] Subscribed to {{key_expr}}")
            return sub
        except Exception as e:
            print(f"[Zenoh] Failed to subscribe to {{key_expr}}: {{e}}")
            return None

    def deserialize_protobuf(self, proto_class=None):
        def inner(payload):
            if proto_class is not None:
                msg = proto_class()
                msg.ParseFromString(bytes(payload))
            else:
                msg = None
            return msg

        return inner

    def deserialize_json(self):
        def inner(sample):
            try:
                data = json.loads(bytes(sample.payload).decode("utf-8"))
                return data
            except Exception as e:
                print(f"Error decoding JSON: {{e}}")

        return inner

    def json_callback(self, data):
        print(f"Got json data: {{data}}")

    def protobuf_callback(self, msg):
        if msg is None:
            print("Protobuf msg was none!")
            return
        else:
            print(f"Got protobuf data: {{msg}}")


def main():
    {} = {}()
    {}.config = zenoh.Config()
    with zenoh.open({}.config) as session:
        {}.session = session
        {}.zenoh_setup()
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("Exiting cleanly.")


if __name__ == "__main__":
    main()
]], {
      i(1, "MyNode"), -- class name
      i(2, "pub_key"),
      i(3, "json_key"),
      i(4, "protobuf_key"),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      rep(1),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 })
    })
  )
})

ls.add_snippets("python", {
  s("temp_zenoh_ros2",
    fmt([[
import os
from ament_index_python.packages import get_package_share_directory

import rclpy
from rclpy.node import Node
from rclpy.executors import MultiThreadedExecutor

import time
import json
import zenoh


class {}(Node):

    def __init__(self):
        self.namespace = self.get_namespace().lstrip("/")

        self.declare_parameter("param", -1)
        self.declare_parameter("zenoh_config_file", "")

        self.param = (
            self.get_parameter("param").get_parameter_value().integer_value
        )
        self.zenoh_config_file = (
            self.get_parameter("zenoh_config_file")
            .get_parameter_value()
            .string_value
        )

        self.config = None
        self.session = None

    def zenoh_setup(self):
        # declare publishers and subscribers here
        pub_key_expr = "{}"
        json_key_expr = "{}"
        protobuf_key_expr = "{}"
        self.pub = self.session.declare_publisher(pub_key_expr)
        # self.protobuf_sub = self.declare_zenoh_subscription(
        #     protobuf_key_expr, self.protobuf_callback, self.deserialize_protobuf()
        # )
        # self.json_sub = self.declare_zenoh_subscription(
        #     json_key_expr, self.json_callback, self.deserialize_json
        # )

    def declare_zenoh_subscription(self, key_expr, callback, deserializer):
        try:
            sub = self.zenoh_session.declare_subscriber(
                key_expr,
                lambda sample: callback(deserializer(sample.payload)),
            )
            print(f"[Zenoh] Subscribed to {{key_expr}}")
            return sub
        except Exception as e:
            print(f"[Zenoh] Failed to subscribe to {{key_expr}}: {{e}}")
            return None

    def deserialize_protobuf(self, proto_class=None):
        def inner(payload):
            if proto_class is not None:
                msg = proto_class()
                msg.ParseFromString(bytes(payload))
            else:
                msg = None
            return msg

        return inner

    def deserialize_json(self):
        def inner(sample):
            try:
                data = json.loads(bytes(sample.payload).decode("utf-8"))
                return data
            except Exception as e:
                print(f"Error decoding JSON: {{e}}")

        return inner

    def json_callback(self, data):
        print(f"Got json data: {{data}}")

    def protobuf_callback(self, msg):
        if msg is None:
            print("Protobuf msg was none!")
            return
        else:
            print(f"Got protobuf data: {{msg}}")


def main(args=None):
    rclpy.init(args=args)

    {} = {}()

    if {}.zenoh_config_file == "":
        {}.zenoh_config = zenoh.Config()
    else:
        {}.zenoh_config = zenoh.Config.from_file(
            os.path.join(
                get_package_share_directory("{}"),
                "config",
                {}.zenoh_config_file,
            )
        )

    with zenoh.open({}.config) as session:
        {}.session = session
        {}.zenoh_setup()
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("Exiting cleanly.")


if __name__ == "__main__":
    main()
]], {
      i(1, "MyNode"),
      i(2, "pub_key"),
      i(3, "json_key"),
      i(4, "protobuf_key"),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      rep(1),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      rep(1),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 }),
      f(function(args) return to_snake_case(args[1][1]) end, { 1 })
    })
  )
})
