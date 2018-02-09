Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41397 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeBISyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Feb 2018 13:54:13 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: v4.16-rc1 + dm-mpath + BFQ
Date: Fri, 9 Feb 2018 18:54:10 +0000
Message-ID: <1518202449.2871.32.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

SGVsbG8gUGFvbG8sDQoNCklmIEkgZW5hYmxlIHRoZSBCRlEgc2NoZWR1bGVyIGZvciBhIGRtLW1w
YXRoIGRldmljZSB0aGVuIGEga2VybmVsIG9vcHMNCmFwcGVhcnMgKHNlZSBhbHNvIGJlbG93KS4g
VGhpcyBoYXBwZW5zIHN5c3RlbWF0aWNhbGx5IHdpdGggTGludXMnIHRyZWUgZnJvbQ0KdGhpcyBt
b3JuaW5nIChjb21taXQgNTRjZTY4NWNhZTMwKSBtZXJnZWQgd2l0aCBKZW5zJyBmb3ItbGludXMg
YnJhbmNoIChjb21taXQNCmE3ODc3MzkwNjE0NyAoImJsb2NrLCBiZnE6IGFkZCByZXF1ZXVlLXJl
cXVlc3QgaG9vayIpKSBhbmQgZm9yLW5leHQgYnJhbmNoDQooY29tbWl0IDg4NDU1YWQ3ZjkyOCku
IElzIHRoaXMgYSBrbm93biBpc3N1ZT8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQpCVUc6IHVuYWJs
ZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCAwMDAwMDAwMDAw
MDAwMjAwDQpJUDogcmJfZXJhc2UrMHgyODQvMHgzODANClBHRCAwIFA0RCAwIA0KT29wczogMDAw
MiBbIzFdIFBSRUVNUFQgU01QDQpDUFU6IDEgUElEOiAwIENvbW06IHN3YXBwZXIvMSBUYWludGVk
OiBHICAgICAgICBXICAgICAgICA0LjE1LjAtZGJnKyAjMQ0KSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4wLjAtcHJlYnVpbHQucWVt
dS1wcm9qZWN0Lm9yZyAwNC8wMS8yMDE0DQpSSVA6IDAwMTA6cmJfZXJhc2UrMHgyODQvMHgzODAN
CkNhbGwgVHJhY2U6DQogPElSUT4NCiBlbHZfcmJfZGVsKzB4MjAvMHgzMA0KIGJmcV9yZW1vdmVf
cmVxdWVzdCsweDhkLzB4MmUwIFtiZnFdDQogYmZxX2ZpbmlzaF9yZXF1ZXVlX3JlcXVlc3QrMHgy
YmIvMHgzOTAgW2JmcV0NCiBibGtfbXFfZnJlZV9yZXF1ZXN0KzB4NTEvMHgxNzANCiBkbV9zb2Z0
aXJxX2RvbmUrMHhkNS8weDI0MCBbZG1fbW9kXQ0KIGZsdXNoX3NtcF9jYWxsX2Z1bmN0aW9uX3F1
ZXVlKzB4OTIvMHgxNDANCiBzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGVfaW50ZXJydXB0KzB4NDcv
MHgyYjANCiBjYWxsX2Z1bmN0aW9uX3NpbmdsZV9pbnRlcnJ1cHQrMHhhMi8weGIwDQogPC9JUlE+
