#!/bin/sh

###############################################################################
# (A) Update `FORMULA` with `${nextRelease.version}`
###############################################################################
sed -i -e "s_^\(version:\).*_\1 ${1}_" FORMULA


###############################################################################
# (B) Use `m2r` to convert automatically produced `.md` docs to `.rst`
###############################################################################

# Install `m2r`
sudo -H pip install m2r

# Copy and then convert the `.md` docs
cp *.md docs/
cd docs/
m2r --overwrite *.md

# Change excess `H1` headings to `H2` in converted `CHANGELOG.rst`
sed -i -e '/^=.*$/s/=/-/g' CHANGELOG.rst
sed -i -e '1,4s/-/=/g' CHANGELOG.rst

# Use for debugging output, when required
# cat AUTHORS.rst
# cat CHANGELOG.rst

# Return back to the main directory
cd ..


###############################################################################
# (C) Update `ssf/defaults.yaml` with `${nextRelease.version}`
###############################################################################
V_REPR=v${1}
sed -i -e "s_^\(\s\+body: '\* Automated using \`ssf-formula\` (\).*\()'\)_\1${V_REPR}\2_" ssf/defaults.yaml