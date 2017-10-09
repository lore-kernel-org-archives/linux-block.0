Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23630 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbdJIRd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2017 13:33:57 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "himanshujha199640@gmail.com" <himanshujha199640@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] skd: Use kmem_cache_free
Date: Mon, 9 Oct 2017 17:33:54 +0000
Message-ID: <1507570433.2674.18.camel@wdc.com>
References: <1507498228-11878-1-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1507498228-11878-1-git-send-email-himanshujha199640@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gTW9uLCAyMDE3LTEwLTA5IGF0IDAzOjAwICswNTMwLCBIaW1hbnNodSBKaGEgd3JvdGU6DQo+
IFVzZSBrbWVtX2NhY2hlX2ZyZWUgaW5zdGVhZCBvZiBrZnJlZSBmb3IgZnJlZWluZyB0aGUgbWVt
b3J5IHByZXZpb3VzbHkNCj4gYWxsb2NhdGVkIHdpdGgga21lbV9jYWNoZV96YWxsb2Mva21lbV9j
YWNoZV9hbGxvYy9rbWVtX2NhY2hlX25vZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIaW1hbnNo
dSBKaGEgPGhpbWFuc2h1amhhMTk5NjQwQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Js
b2NrL3NrZF9tYWluLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3NrZF9tYWlu
LmMgYi9kcml2ZXJzL2Jsb2NrL3NrZF9tYWluLmMNCj4gaW5kZXggN2NlZGI0Mi4uNjRkMGZjMSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibG9jay9za2RfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMv
YmxvY2svc2tkX21haW4uYw0KPiBAQCAtMjYwNCw3ICsyNjA0LDcgQEAgc3RhdGljIHZvaWQgKnNr
ZF9hbGxvY19kbWEoc3RydWN0IHNrZF9kZXZpY2UgKnNrZGV2LCBzdHJ1Y3Qga21lbV9jYWNoZSAq
cywNCj4gIAkJcmV0dXJuIE5VTEw7DQo+ICAJKmRtYV9oYW5kbGUgPSBkbWFfbWFwX3NpbmdsZShk
ZXYsIGJ1Ziwgcy0+c2l6ZSwgZGlyKTsNCj4gIAlpZiAoZG1hX21hcHBpbmdfZXJyb3IoZGV2LCAq
ZG1hX2hhbmRsZSkpIHsNCj4gLQkJa2ZyZWUoYnVmKTsNCj4gKwkJa21lbV9jYWNoZV9mcmVlKHMs
IGJ1Zik7DQo+ICAJCWJ1ZiA9IE5VTEw7DQo+ICAJfQ0KPiAgCXJldHVybiBidWY7DQoNClRoYW5r
cyBmb3IgdGhpcyBwYXRjaC4NCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52
YW5hc3NjaGVAd2RjLmNvbT4NCg0K
