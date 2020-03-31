from pathlib import Path

ghdl_dir = Path("build/ghdl_artifacts/lib")
ghdl_dlls = [(str(dll.resolve()), "lib") for dll in ghdl_dir.glob("*.dll")]

mingw_dir = Path("build/mingw/bin")
mingw_dlls = [(str(dll.resolve()), ".") for dll in mingw_dir.glob("*.dll")]

datas = [(str(ghdl_dir.resolve()), "lib")]

block_cipher = None
a = Analysis(
    ["ghdl-ls.py"],
    binaries=ghdl_dlls + mingw_dlls,
    datas=datas,
    hiddenimports=[],
    hookspath=None,
    runtime_hooks=None,
    excludes=None,
    cipher=block_cipher,
)
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)
exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    name="ghdl-ls",
    debug=False,
    strip=False,
    upx=False,
    runtime_tmpdir=None,
    console=True,
)
coll = COLLECT(exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    name="ghdl-ls",
    strip=False,
    upx=False,
)