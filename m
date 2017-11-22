Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2142 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdKVQrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 11:47:51 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH] block: drain queue before waiting for q_usage_counter
 becoming zero
Date: Wed, 22 Nov 2017 16:47:48 +0000
Message-ID: <1511369267.3061.5.camel@sandisk.com>
References: <20171122051143.31943-1-ming.lei@redhat.com>
In-Reply-To: <20171122051143.31943-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTExLTIyIGF0IDEzOjExICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCj4gaW5kZXggMTEwOTc0
NzdlZWFiLi4zZDM3OTczMjc0OTEgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1tcS5jDQo+ICsr
KyBiL2Jsb2NrL2Jsay1tcS5jDQo+IEBAIC0xNjEsNiArMTYxLDggQEAgdm9pZCBibGtfZnJlZXpl
X3F1ZXVlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQ0KPiAgCSAqIGV4cG9ydGVkIHRvIGRyaXZl
cnMgYXMgdGhlIG9ubHkgdXNlciBmb3IgdW5mcmVlemUgaXMgYmxrX21xLg0KPiAgCSAqLw0KPiAg
CWJsa19mcmVlemVfcXVldWVfc3RhcnQocSk7DQo+ICsJaWYgKCFxLT5tcV9vcHMpDQo+ICsJCWJs
a19kcmFpbl9xdWV1ZShxKTsNCj4gIAlibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXQocSk7DQo+ICB9
DQoNClNpbmNlIHFfdXNhZ2VfY291bnRlciBub3cgdHJhY2tzIGxlZ2FjeSByZXF1ZXN0cywgaXMg
dGhlcmUgYW55IHJlYXNvbiB3aHkgd2UNCnN0aWxsIG5lZWQgX19ibGtfZHJhaW5fcXVldWUoKT8g
SGF2ZSB5b3UgY29uc2lkZXJlZCB0byBlbGltaW5hdGUNCl9fYmxrX2RyYWluX3F1ZXVlKCkgYW5k
IHRvIGNhbGwgYmxrX3J1bl9xdWV1ZSgpIGZyb20gaW5zaWRlIGJsa19mcmVlemVfcXVldWUoKQ0K
aW5zdGVhZCBvZiBjYWxsaW5nIGJsa19kcmFpbl9xdWV1ZSgpPyBJJ20gYXNraW5nIHRoaXMgYmVj
YXVzZQ0KYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0KCkgdXNlcyBhIG1vcmUgZWZmaWNpZW50IG1l
Y2hhbmlzbSAod2FpdF9ldmVudCgpKQ0KdGhhbiBfX2Jsa19kcmFpbl9xdWV1ZSgpICh3aGlsZSAo
Li4uKSBtc2xlZXAoMTApKS4NCg0KQmFydC4=
