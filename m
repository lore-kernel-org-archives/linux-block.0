Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6405 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdH3P4B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 11:56:01 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 02/14] sbitmap: introduce __sbitmap_for_each_set()
Date: Wed, 30 Aug 2017 15:55:13 +0000
Message-ID: <1504108512.2526.23.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-3-ming.lei@redhat.com>
In-Reply-To: <20170826163332.28971-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA4LTI3IGF0IDAwOjMzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gIC8q
Kg0KPiAgICogc2JpdG1hcF9mb3JfZWFjaF9zZXQoKSAtIEl0ZXJhdGUgb3ZlciBlYWNoIHNldCBi
aXQgaW4gYSAmc3RydWN0IHNiaXRtYXAuDQo+ICsgKiBAc3RhcnQ6IFdoZXJlIHRvIHN0YXJ0IHRo
ZSBpdGVyYXRpb24NCg0KVGhhbmtzIGZvciBoYXZpbmcgY2hhbmdlZCB0aGUgbmFtZSBvZiB0aGlz
IGFyZ3VtZW50IC4uLg0KDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgc2JpdG1hcF9mb3JfZWFjaF9z
ZXQoc3RydWN0IHNiaXRtYXAgKnNiLCBzYl9mb3JfZWFjaF9mbiBmbiwNCj4gLQkJCQkJdm9pZCAq
ZGF0YSkNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBfX3NiaXRtYXBfZm9yX2VhY2hfc2V0KHN0cnVj
dCBzYml0bWFwICpzYiwNCj4gKwkJCQkJICB1bnNpZ25lZCBpbnQgc3RhcnQsDQo+ICsJCQkJCSAg
c2JfZm9yX2VhY2hfZm4gZm4sIHZvaWQgKmRhdGEpDQo+ICB7DQo+IC0JdW5zaWduZWQgaW50IGk7
DQo+ICsJdW5zaWduZWQgaW50IGluZGV4ID0gU0JfTlJfVE9fSU5ERVgoc2IsIHN0YXJ0KTsNCj4g
Kwl1bnNpZ25lZCBpbnQgbnIgPSBTQl9OUl9UT19CSVQoc2IsIHN0YXJ0KTsNCj4gKwl1bnNpZ25l
ZCBpbnQgc2Nhbm5lZCA9IDA7DQoNCi4uLiBidXQgSSdtIHN0aWxsIG1pc3NpbmcgYSBjaGVjayBo
ZXJlIHdoZXRoZXIgb3Igbm90IGluZGV4ID49IHNiLT5tYXBfbnIuDQogDQo+IC0JZm9yIChpID0g
MDsgaSA8IHNiLT5tYXBfbnI7IGkrKykgew0KPiAtCQlzdHJ1Y3Qgc2JpdG1hcF93b3JkICp3b3Jk
ID0gJnNiLT5tYXBbaV07DQo+IC0JCXVuc2lnbmVkIGludCBvZmYsIG5yOw0KPiArCXdoaWxlICgx
KSB7DQo+ICsJCXN0cnVjdCBzYml0bWFwX3dvcmQgKndvcmQgPSAmc2ItPm1hcFtpbmRleF07DQo+
ICsJCXVuc2lnbmVkIGludCBkZXB0aCA9IG1pbl90KHVuc2lnbmVkIGludCwgd29yZC0+ZGVwdGgg
LSBuciwNCj4gKwkJCQkJICAgc2ItPmRlcHRoIC0gc2Nhbm5lZCk7DQo+ICANCj4gKwkJc2Nhbm5l
ZCArPSBkZXB0aDsNCj4gIAkJaWYgKCF3b3JkLT53b3JkKQ0KPiAtCQkJY29udGludWU7DQo+ICsJ
CQlnb3RvIG5leHQ7DQo+ICANCj4gLQkJbnIgPSAwOw0KPiAtCQlvZmYgPSBpIDw8IHNiLT5zaGlm
dDsNCj4gKwkJZGVwdGggKz0gbnI7DQo+ICsJCXN0YXJ0ID0gaW5kZXggPDwgc2ItPnNoaWZ0Ow0K
DQpUaGUgYWJvdmUgc3RhdGVtZW50IHJldXNlcyB0aGUgYXJndW1lbnQgJ3N0YXJ0JyBmb3IgYSBu
ZXcgcHVycG9zZS4gVGhpcyBpcw0KY29uZnVzaW5nIC0gcGxlYXNlIGRvbid0IGRvIHRoaXMuIFdo
eSBub3QgdG8ga2VlcCB0aGUgbmFtZSAnb2ZmJz8gVGhhdCB3aWxsDQprZWVwIHRoZSBjaGFuZ2Vz
IG1pbmltYWwuDQoNCkJhcnQu
