import setuptools

import fildem

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="fildem",
    version=fildem.__version__,
    author="Inled",
    author_email="jaime@inled.es",
    description="Fildem Global Menu and HUD for GNOME Desktop",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/InledGroup/Fildem",
    packages=setuptools.find_packages(),
    data_files=[("share/applications", ["fildem-hud.desktop"])],
    install_requires=["PyGObject>=3.30.0"],
    license="GPL-3.0-or-later",
    classifiers=[
        "Programming Language :: Python :: 3",
        "Operating System :: POSIX :: Linux",
    ],
    project_urls={
        "Bug Reports": "https://github.com/InledGroup/Fildem/issues",
        "Source": "https://github.com/InledGroup/Fildem",
    },
    entry_points={
        "console_scripts": [
            "fildem = fildem.run:main",
            "fildem-hud = fildem.inithud:main",
        ]
    },
)
