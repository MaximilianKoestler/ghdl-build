#! /usr/bin/env python3
import os
import sys

import vhdl_langserver.main as main

os.environ["GHDL_PREFIX"] = os.path.join(sys._MEIPASS, "ghdl")
try:
    main.main()
except KeyboardInterrupt:
    pass
