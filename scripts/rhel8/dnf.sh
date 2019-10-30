#!/bin/bash

# Check whether the install media is mounted, and if necessary mount it.
if [ ! -d /media/BaseOS/ ] || [ ! -d /media/AppStream/ ]; then
  mount /dev/cdrom /media || (printf "\nFailed mount RHEL cdrom.\n"; exit 1)
fi

# Setup the install DVD as the dnf repo location.
cat <<-EOF > /etc/yum.repos.d/media.repo
[rhel8-base-media]
name=rhel8-base
baseurl=file:///media/BaseOS/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-beta

[rhel8-appstream-media]
name=rhel8-appstream
baseurl=file:///media/AppStream/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF

# Import the Red Hat signing key.
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-beta
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

# Setup the EPEL repo.
base64 --decode > epel-release-8-7.el8.noarch.rpm <<-EOF
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
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+AAAAB////3AAAAAQAAAA
AI6t6AEAAAAAAAAAPQAAEowAAAA/AAAABwAAEnwAAAAQAAAAZAAAAAgAAAAAAAAAAQAAA+gAAAAG
AAAAAgAAAAEAAAPpAAAABgAAAA8AAAABAAAD6gAAAAYAAAARAAAAAQAAA+wAAAAJAAAAFwAAAAEA
AAPtAAAACQAAAFQAAAABAAAD7gAAAAQAAADQAAAAAQAAA+8AAAAGAAAA1AAAAAEAAAPxAAAABAAA
APgAAAABAAAD8gAAAAYAAAD8AAAAAQAAA/MAAAAGAAABCwAAAAEAAAP2AAAABgAAARoAAAABAAAD
9wAAAAYAAAEgAAAAAQAAA/gAAAAJAAABLwAAAAEAAAP8AAAABgAAAUcAAAABAAAD/QAAAAYAAAFy
AAAAAQAAA/4AAAAGAAABeAAAAAEAAAQEAAAABAAAAYAAAAAIAAAEBgAAAAMAAAGgAAAACAAABAkA
AAADAAABsAAAAAgAAAQKAAAABAAAAcAAAAAIAAAECwAAAAgAAAHgAAAACAAABAwAAAAIAAADqAAA
AAgAAAQNAAAABAAAA7AAAAAIAAAEDwAAAAgAAAPQAAAACAAABBAAAAAIAAAD+AAAAAgAAAQUAAAA
BgAABCAAAAABAAAEFQAAAAQAAARAAAAACAAABBcAAAAIAAAEYAAAAAIAAAQYAAAABAAABIQAAAAG
AAAEGQAAAAgAAAScAAAABgAABBoAAAAIAAAFIwAAAAYAAAQdAAAABAAABUwAAAABAAAEHgAAAAgA
AAVQAAAAAQAABB8AAAAIAAAFXwAAAAEAAAQoAAAABgAABWAAAAABAAAEOAAAAAQAAAVoAAAAFAAA
BDkAAAAIAAAFuAAAABQAAAQ6AAAACAAACRwAAAAUAAAERwAAAAQAAA6wAAAACAAABEgAAAAEAAAO
0AAAAAgAAARJAAAACAAADvAAAAAIAAAEWAAAAAQAAA74AAAAAgAABFkAAAAIAAAPAAAAAAIAAARc
AAAABAAADxAAAAAIAAAEXQAAAAgAAA8wAAAACAAABF4AAAAIAAAPrwAAAAUAAARiAAAABgAAECAA
AAABAAAEZAAAAAYAABFwAAAAAQAABGUAAAAGAAARdQAAAAEAAARmAAAABgAAEXgAAAABAAAEbAAA
AAYAABF6AAAAAQAABHQAAAAEAAARlAAAAAgAAAR1AAAABAAAEbQAAAAIAAAEdgAAAAgAABHUAAAA
BAAAE5MAAAAEAAASAAAAAAEAABOUAAAABgAAEgQAAAABAAATxgAAAAYAABIwAAAAAQAAE+QAAAAI
AAASNgAAAAEAABPlAAAABAAAEngAAAABQwBlcGVsLXJlbGVhc2UAOAA3LmVsOABFeHRyYSBQYWNr
YWdlcyBmb3IgRW50ZXJwcmlzZSBMaW51eCByZXBvc2l0b3J5IGNvbmZpZ3VyYXRpb24AVGhpcyBw
YWNrYWdlIGNvbnRhaW5zIHRoZSBFeHRyYSBQYWNrYWdlcyBmb3IgRW50ZXJwcmlzZSBMaW51eCAo
RVBFTCkgcmVwb3NpdG9yeQpHUEcga2V5IGFzIHdlbGwgYXMgY29uZmlndXJhdGlvbiBmb3IgeXVt
LgAAAF2fWVJidWlsZHZtLTA0LnBoeDIuZmVkb3JhcHJvamVjdC5vcmcAAAAAAHY9RmVkb3JhIFBy
b2plY3QARmVkb3JhIFByb2plY3QAR1BMdjIARmVkb3JhIFByb2plY3QAU3lzdGVtIEVudmlyb25t
ZW50L0Jhc2UAaHR0cDovL2Rvd25sb2FkLmZlZG9yYXByb2plY3Qub3JnL3B1Yi9lcGVsAGxpbnV4
AG5vYXJjaAAAAAAGWwAABOEAAASzAAAEUAAAAEsAAAAAAABH0QAAGeKBpIGkgaSBpIGkQe2BpIGk
AAAAAAAAAAAAAAAAAAAAAF2fWRJdn1kSXZ9ZEl2fWRJdn1kSXZ9ZUl2fWRJdn1kSY2QxZGIyMWE4
NjMxODUxMjdmMmUzYjI2NGM5N2ZiMWM2YzQ0YzMxNjM4NTcwNzk5OTA0MWVhNDc1YzExMGQxYwBi
NzQ4NGJlMjQ2YWNlYzgwZmY2YWY5OGM0ODlkZmJkZmE4OGQ1MzI0ODlkMDE5Y2Y4OGEyOTE1ZTRh
ZWQxNmZlADU2Y2UxNzMwNThlYzE1NDkwMTVmNWRjZmNjZmMxMDc2MTk0M2EwMjZmODdlODM0YzMw
NTI2YjQwMWFlMWRmMTIAM2NjZDBhMGNmMWEwOTljZDhkMzgzZmYzOTI5ZWU4ZTBhOTk5NDlhMTk0
ODMyYjRmZmRlNzExOWFiYjJkZjE1ZgAwMzUzNmFhYTljYjczNTM1ODhhODBiNmQ5YmY3MmU0NWY3
NmY5YTEyNDc5OWFhN2M2MGY1ZDljNTQyYWExYTU4AAAwM2E1NWNmYmJiZmNkZmM3NWZlZDhhZWNh
NTM4M2ZlZjEyZGU0ZjAxOWQ1ZmYxNWM1OGYxZTY1ODE0NjUwMDdlADg5N2YwNjg5Mzc4NzJkMmIz
OTgyZGYzNjgyMTYzYmU5MTA2YWQwMmM1OGFkODEyZWEwOGU1ZWFjZjg3YzViNzAAAAAAAAAAAAAA
AAAAAAAAEQAAABEAAAARAAAAAAAAAAAAAAACAAAAAnJvb3QAcm9vdAByb290AHJvb3QAcm9vdABy
b290AHJvb3QAcm9vdAByb290AHJvb3QAcm9vdAByb290AHJvb3QAcm9vdAByb290AHJvb3QAZXBl
bC1yZWxlYXNlLTgtNy5lbDguc3JjLnJwbQAAAAD//////////////////////////wAAAAD/////
/////2NvbmZpZyhlcGVsLXJlbGVhc2UpAGVwZWwtcmVsZWFzZQAAABAAAAgAAAAMAQAACgEAAAoB
AAAKAQAACmNvbmZpZyhlcGVsLXJlbGVhc2UpAHJlZGhhdC1yZWxlYXNlAHJwbWxpYihDb21wcmVz
c2VkRmlsZU5hbWVzKQBycG1saWIoRmlsZURpZ2VzdHMpAHJwbWxpYihQYXlsb2FkRmlsZXNIYXZl
UHJlZml4KQBycG1saWIoUGF5bG9hZElzWHopADgtNy5lbDgAOAAzLjAuNC0xADQuNi4wLTEANC4w
LTEANS4yLTEAAAAAAAAAAGZlZG9yYS1yZWxlYXNlAAA0LjE0LjIAAF2fHUBdf3lAXUlrwF1C1EBd
QtRAXULUQF0wX0BZ0ipAWU5UQFhiV8BXk1xAV1FxQFb7v8BUdG9AVG8pQFRvKUBUBbFAU/8ZwFOh
f0BSrutAU3RlcGhlbiBTbW9vZ2VuIDxzbW9vZ2VAZmVkb3JhcHJvamVjdC5vcmc+IC0gOC03LmVs
OABTdGVwaGVuIFNtb29nZW4gPHNtb29nZUBmZWRvcmFwcm9qZWN0Lm9yZz4gLSA4LTYuZWw4AFN0
ZXBoZW4gU21vb2dlbiA8c21vb2dlQGZlZG9yYXByb2plY3Qub3JnPiAtIDgtNS5lbDgAUGFibG8g
R3JlY28gPHBncmVjb0BjZW50b3Nwcm9qZWN0Lm9yZz4gLSA4LTQAU3RlcGhlbiBTbW9vZ2VuIDxz
bW9vZ2VAZmVkb3JhcHJvamVjdC5vcmc+IC0gOC0zAFN0ZXBoZW4gU21vb2dlbiA8c21vb2dlQGZl
ZG9yYXByb2plY3Qub3JnPiAtIDgtMgBTdGVwaGVuIFNtb29nZW4gPHNtb29nZUBzbW9vZ2VuLWxh
cHRvcC5sb2NhbGRvbWFpbj4gLSA4LTEAS2V2aW4gRmVuemkgPGtldmluQHNjcnllLmNvbT4gLSA3
LTExAEtldmluIEZlbnppIDxrZXZpbkBzY3J5ZS5jb20+IC0gNy0xMABLZXZpbiBGZW56aSA8a2V2
aW5Ac2NyeWUuY29tPiAtIDctOQBLZXZpbiBGZW56aSA8a2V2aW5Ac2NyeWUuY29tPiAtIDctOABL
ZXZpbiBGZW56aSA8a2V2aW5Ac2NyeWUuY29tPiAtIDctNwBKYXNvbiBMIFRpYmJpdHRzIElJSSA8
dGliYnNAbWF0aC51aC5lZHU+IC0gNy02AFJleCBEaWV0ZXIgPHJkaWV0ZXJAZmVkb3JhcHJvamVj
dC5vcmc+IDctNQBSZXggRGlldGVyIDxyZGlldGVyQGZlZG9yYXByb2plY3Qub3JnPiA3LTQAUmV4
IERpZXRlciA8cmRpZXRlckBmZWRvcmFwcm9qZWN0Lm9yZz4gNy0zAEtldmluIEZlbnppIDxrZXZp
bkBzY3J5ZS5jb20+IDctMgBEZW5uaXMgR2lsbW9yZSA8ZGVubmlzQGF1c2lsLnVzPiAtIDctMQBL
ZXZpbiBGZW56aSA8a2V2aW5Ac2NyeWUuY29tPiA3LTAuMgBEZW5uaXMgR2lsbW9yZSA8ZGVubmlz
QGF1c2lsLnVzPiAtIDctMC4xAC0gUmVtb3ZlIGZhaWxvdmVybWV0aG9kIGZyb20gRVBFTDggdHJl
ZS4gSXQgaXMgbm8gbG9uZ2VyIG5lZWRlZC4ALSBDaGFuZ2UgZ3BnIGtleSB0byB1c2UgLTggdmVy
c3VzIC0kcmVsZWFzZXZlci4gVGhpcyBmaXhlcyBiYXNoIHByb2JsZW0ALSBGaXggcGxheWdyb3Vu
ZCByZWxlYXNlIHRvIGhhdmUgb3MvIG9uIGl0cyBuYW1lIFtLZXZpbiBGZW56aV0KLSBNYWtlIHN1
cmUgYWxsIHZhbHVlcyBvZiAkcmVsZWFzZSBhcmUgJHJlbGVhc2V2ZXIALSBVc2UgdGhlIGNvcnJl
Y3QgdmFyIGZvciBkbmYgdG8gZXhwYW5kCi0gVXBkYXRlIHBsYXlncm91bmQgc291cmNlIHVybAot
IFJlbW92ZSBlcGVsLW1vZHVsZXMgcmVwbwotIFVzZSBodHRwcyBpbiBiYXNldXJsAC0gTWFrZSBz
dXJlIHRoYXQgdGhlIGtleSBuYW1lIGlzIG5hbWVkIGNvcnJlY3RseQAtIE1ha2UgYmFzZXVybCBw
YXRocyBtYXRjaCBkbC5mZWRvcmFwcm9qZWN0Lm9yZwotIEFkZCBkcmFmdCBvZiBlcGVsOCBwYWNr
YWdpbmcKLSBGaXggZG9jcwAtIFVwZGF0ZSBmb3IgUkhFTC04Ci0gQWRkIHBsYXlncm91bmQgcmVw
byBkYXRhCi0gQ2xlYW4gb3V0IDkwLWVwZWwucHJlc2V0IHRvIG1ha2Ugc3VyZSB3ZSBkb250IG92
ZXJyaWRlIFJIRUwtOCBpdGVtcy4gSnVzdCBhZGQgaXRlbXMgaW4gd2hpY2ggRVBFTCBuZWVkcy4A
LSBBZGQgQ29uZmxpY3RzIG9uIGZlZG9yYS1yZWxlYXNlIHRvIHByZXZlbnQgcGVvcGxlIGZyb20g
aW5zdGFsbGluZyBvbiBGZWRvcmEgc3lzdGVtcy4gRml4ZXMgYnVnICMxNDk3NzAyAC0gQ2hhbmdl
IG1pcnJvcmxpc3Q9IGluIHJlcG8gZmlsZXMgdG8gYmUgbWV0YWxpbms9IChhcyB0aGF0cyB3aGF0
IHRoZXkgYXJlKS4gRml4ZXMgYnVnICMxNDUxMjEyAC0gQWRkIHByZXNldCBmb3IgZHJiZGxpbmtz
IHBhY2thZ2UuIEZpeGVzIGJ1ZyAjMTQwNTc0NAAtIERyb3AgZHVwbGljYXRlIGxpYnN0b3JhZ2Vt
Z210IGZyb20gcHJlc2V0cy4gRml4ZXMgYnVnICMxMzU4OTcxAC0gRHJvcCBpbml0aWFsLXNldHVw
IGZyb20gcHJlc2V0cy4gRml4ZXMgYnVnICMxMzQyNTExAC0gUmVtb3ZlIG1hY3Jvcy5lcGVsOyBs
ZXQgZXBlbC1ycG0tbWFjcm9zIGhhbmRsZSBpdCBpbnN0ZWFkLgAtIGZpeCB0eXBvIGluIG1hY3Jv
cy5lcGVsAC0gYWRkIHN5c3RlbWQgOTAtZXBlbC5wcmVzZXQALSBpbXBsZW1lbnQgJWVwZWwgbWFj
cm8ALSBNYWtlIHJlcG8gZmlsZXMgY29uZmlnKG5vcmVwbGFjZSkuIEZpeGVzIGJ1ZyAjMTEzNTU3
NgAtIGVuYWJsZSBncGcgY2hlY2tpbmcgbm93IHdlIGFyZSBvdXQgb2YgYmV0YQAtIERyb3AgdW5u
ZWVkZWQgdXAyZGF0ZSBwb3N0L3Bvc3R1bgotIEZpeGVkIHVwIGRlc2NyaXB0aW9uLgotIEZpeGVz
IGJ1Z3MgIzEwNTI0MzQgYW5kICMxMDkzOTE4AC0gaW5pdGlhbCBlcGVsIDcgYnVpbGQuIGdwZyBj
aGVraW5nIGlzIGRpc2FibGVkAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAA
AQAAAAIAAAADAAAABAAAAAUAAAAGAAAABwAAAAgAAAAAAAAAABAAAAgAAAAIOC03LmVsOAA4LTcu
ZWw4AAAAAAAAAAABAAAAAQAAAAEAAAACAAAAAwAAAAQAAAAEUlBNLUdQRy1LRVktRVBFTC04AGVw
ZWwtcGxheWdyb3VuZC5yZXBvAGVwZWwtdGVzdGluZy5yZXBvAGVwZWwucmVwbwA5MC1lcGVsLnBy
ZXNldABlcGVsLXJlbGVhc2UAR1BMAFJFQURNRS1lcGVsLTgtcGFja2FnaW5nLm1kAC9ldGMvcGtp
L3JwbS1ncGcvAC9ldGMveXVtLnJlcG9zLmQvAC91c3IvbGliL3N5c3RlbWQvc3lzdGVtLXByZXNl
dC8AL3Vzci9zaGFyZS9kb2MvAC91c3Ivc2hhcmUvZG9jL2VwZWwtcmVsZWFzZS8ALU8yIC1nIC1w
aXBlIC1XYWxsIC1XZXJyb3I9Zm9ybWF0LXNlY3VyaXR5IC1XcCwtRF9GT1JUSUZZX1NPVVJDRT0y
IC1XcCwtRF9HTElCQ1hYX0FTU0VSVElPTlMgLWZleGNlcHRpb25zIC1mc3RhY2stcHJvdGVjdG9y
LXN0cm9uZyAtZ3JlY29yZC1nY2Mtc3dpdGNoZXMgLXNwZWNzPS91c3IvbGliL3JwbS9yZWRoYXQv
cmVkaGF0LWhhcmRlbmVkLWNjMSAtc3BlY3M9L3Vzci9saWIvcnBtL3JlZGhhdC9yZWRoYXQtYW5u
b2Jpbi1jYzEgLW02NCAtbXR1bmU9Z2VuZXJpYyAtZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVz
IC1mc3RhY2stY2xhc2gtcHJvdGVjdGlvbiAtZmNmLXByb3RlY3Rpb24AY3BpbwB4egAyAG5vYXJj
aC1yZWRoYXQtbGludXgtZ251AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
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
Lrbp3xwCAAAAAApZWg==
EOF

# Install the EPEL release RPM.
dnf --assumeyes install epel-release-8-7.el8.noarch.rpm

# Setup the EPEL release signing key.
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8

# Delete the RPM file.
rm --force epel-release-8-7.el8.noarch.rpm

# Update the EPEL repo to use HTTPS.
sed -i -e "s/^#baseurl/baseurl/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/^mirrorlist/#mirrorlist/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/http:\/\/download.fedoraproject.org\/pub\/epel\//https:\/\/mirrors.kernel.org\/fedora-epel\//g" /etc/yum.repos.d/epel.repo

# Disable the testing repo.
sed --in-place "s/^/# /g" /etc/yum.repos.d/epel-testing.repo
sed --in-place "s/# #/##/g" /etc/yum.repos.d/epel-testing.repo

# Disable the playground repo.
sed --in-place "s/^/# /g" /etc/yum.repos.d/epel-playground.repo
sed --in-place "s/# #/##/g" /etc/yum.repos.d/epel-playground.repo

# Install the basic packages we'd expect to find.
dnf --assumeyes install sudo dmidecode dnf-utils bash-completion man man-pages vim-enhanced sysstat bind-utils wget dos2unix unix2dos lsof telnet net-tools coreutils grep gawk sed curl patch sysstat make cmake libarchive info autoconf automake libtool gcc-c++ libstdc++-devel gcc cpp ncurses-devel glibc-devel glibc-headers kernel-headers psmisc whois

# For some reason the beta thinks this package is installed, when in fact it's missing.
dnf --assumeyes reinstall libunistring
