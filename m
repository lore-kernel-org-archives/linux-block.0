Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34744 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeAVRZX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 12:25:23 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dave@znu.io" <dave@znu.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk-mq hangs easily with LLVM+clang test suite
Date: Mon, 22 Jan 2018 17:25:20 +0000
Message-ID: <1516641918.2545.32.camel@wdc.com>
References: <83F7B94F-562A-44A5-92F9-939FE4FD5A99@znu.io>
         <1516555064.3434.5.camel@wdc.com>
         <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
In-Reply-To: <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE4LTAxLTIxIGF0IDEyOjM5IC0wNTAwLCBEYXZpZCBaYXJ6eWNraSB3cm90ZToN
Cj4gSGkgQmFydCwNCj4gDQo+IEkgY2FuIGRvIFsxXSBhbmQgWzJdIGJ1dCBJIHdvbuKAmXQgYmUg
YWJsZSB0byBwcm92aWRlIHRoZSBjb21tYW5kIG91dHB1dA0KPiBiZWNhdXNlIHRoZSBoYW5nIGlz
IGFsbW9zdCB0b3RhbC4gTm8gbmV3IGNvbW1hbmRzIGNhbiBydW4gYmVjYXVzZSB0aGUNCj4gc2No
ZWR1bGVyIGlzIGh1bmcuIEZvciBleGFtcGxlLCBzZWUgdGhpcyBiYWNrdHJhY2U6DQo+IA0KPiBo
dHRwOi8vem51LmlvL0lNR18wMzYyLmpwZw0KPiANCj4gSXMgdGhlcmUgYW5vdGhlciBhcHByb2Fj
aCBJIGNhbiB1c2U/DQoNCkhlbGxvIERhdmUsDQoNCldoYXQgSSBwcm9wb3NlZCBpcyBhbiBhcHBy
b2FjaCB0byBmaW5kIHRoZSBjYXVzZSBvZiBhIGJsb2NrIGxheWVyIHF1ZXVlIHRoYXQNCmdvdCBz
dHVjayBkdWUgdG8gYSBtaXNzaW5nIHF1ZXVlIHJ1bi4gSG93ZXZlciwgdGhlIHNjcmVlbnNob3Qg
dGhhdCB5b3Ugc2hhcmVkDQppbiB5b3VyIGUtbWFpbCBzaG93cyB0aGF0IHNvbWV0aGluZyBlbHNl
IGlzIGdvaW5nIG9uLiBJZiB0aGUgbWVzc2FnZQ0KInJjdV9zY2hlZCBkZXRlY3RlZCBzdGFsbHMi
IHRoZW4gdGhhdCBtZWFucyB0aGF0IHNvbWV0aGluZyBwcmV2ZW50ZWQgdGhlIFJDVQ0KY29kZSB0
byBiZSBzY2hlZHVsZWQsIGUuZy4gYmVjYXVzZSBpbnRlcnJ1cHRzIG9jY3VyIGF0IGEgZnJlcXVl
bmN5IHRoYXQgaXMgc28NCmhpZ2ggdGhhdCB0aGUgUkNVIGNvZGUgZG9lc24ndCBnZXQgYSBjaGFu
Y2UgdG8gcnVuLiBGb3IgbW9yZSBpbmZvcm1hdGlvbiwgc2VlDQphbHNvIGh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vUkNVL3N0YWxsd2Fybi50eHQuDQoNCkkgdGhpbmsg
eW91IHdpbGwgbmVlZCB0aGUgaGVscCBvZiBhbiBOVk1lIGV4cGVydCB0byBhbmFseXplIHRoaXMg
ZnVydGhlci4gSWYNCnlvdSB3b3VsZCBub3QgYmUgYXdhcmUgb2YgdGhpcywgdGhlcmUgaXMgYSBt
YWlsaW5nIGxpc3QgdGhhdCBpcyBkZWRpY2F0ZWQgdG8NCk5WTWUuIFNlZSBhbHNvIGh0dHBzOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUuDQoNCkJhcnQu
DQo=
