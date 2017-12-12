Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34838 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdLLWUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 17:20:43 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 6/6] blk-mq: remove REQ_ATOM_STARTED
Date: Tue, 12 Dec 2017 22:20:39 +0000
Message-ID: <1513117238.2999.54.camel@wdc.com>
References: <20171212190134.535941-1-tj@kernel.org>
         <20171212190134.535941-7-tj@kernel.org>
In-Reply-To: <20171212190134.535941-7-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE3LTEyLTEyIGF0IDExOjAxIC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEBA
IC00MDksNyArNDA3LDcgQEAgc3RhdGljIHZvaWQgaGN0eF9zaG93X2J1c3lfcnEoc3RydWN0IHJl
cXVlc3QgKnJxLCB2b2lkICpkYXRhLCBib29sIHJlc2VydmVkKQ0KPiAgICAgICAgIGNvbnN0IHN0
cnVjdCBzaG93X2J1c3lfcGFyYW1zICpwYXJhbXMgPSBkYXRhOw0KPiAgDQo+ICAgICAgICAgaWYg
KGJsa19tcV9tYXBfcXVldWUocnEtPnEsIHJxLT5tcV9jdHgtPmNwdSkgPT0gcGFyYW1zLT5oY3R4
ICYmDQo+IC0gICAgICAgICAgIHRlc3RfYml0KFJFUV9BVE9NX1NUQVJURUQsICZycS0+YXRvbWlj
X2ZsYWdzKSkNCj4gKyAgICAgICAgICAgYmxrX21xX3JxX3N0YXRlKHJxKSAhPSBNUV9SUV9JRExF
KQ0KPiAgICAgICAgICAgICAgICAgX19ibGtfbXFfZGVidWdmc19ycV9zaG93KHBhcmFtcy0+bSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2VudHJ5X3Jx
KCZycS0+cXVldWVsaXN0KSk7DQoNClRoZSBhYm92ZSBjb2RlIHNob3VsZCBzaG93IGFsbCByZXF1
ZXN0cyBvd25lZCBieSB0aGUgYmxvY2sgZHJpdmVyLiBQYXRjaA0KImJsay1tcS1kZWJ1Z2ZzOiBB
bHNvIHNob3cgcmVxdWVzdHMgdGhhdCBoYXZlIG5vdCB5ZXQgYmVlbiBzdGFydGVkIiAobm90IHll
dA0KaW4gSmVucycgdHJlZSkgY2hhbmdlcyB0aGUgUkVRX0FUT01fU1RBUlRFRCB0ZXN0IGludG8g
bGlzdF9lbXB0eSgmcnEtPnF1ZXVlbGlzdCkuDQpDYW4gdGhhdCBjaGFuZ2UgYmUgc3VwcG9ydGVk
IHdpdGggdGhlIGV4aXN0aW5nIE1RX1JRXyogc3RhdGVzIG9yIHdpbGwgYSBuZXcNCnN0YXRlIGhh
dmUgdG8gYmUgaW50cm9kdWNlZCB0byBzdXBwb3J0IHRoaXM/IFNlZSBhbHNvDQpodHRwczovL21h
cmMuaW5mby8/bD1saW51eC1ibG9jayZtPTE1MTI1MjE4ODQxMTk5MS4NCg0KVGhhbmtzLA0KDQpC
YXJ0Lg==
