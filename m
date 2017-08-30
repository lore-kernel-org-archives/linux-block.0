Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4215 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdH3Qff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 12:35:35 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 05/14] blk-mq-sched: improve dispatching from sw queue
Date: Wed, 30 Aug 2017 16:34:47 +0000
Message-ID: <1504110886.2526.36.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-6-ming.lei@redhat.com>
In-Reply-To: <20170826163332.28971-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA4LTI3IGF0IDAwOjMzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxrLW1xLmggYi9pbmNsdWRlL2xpbnV4L2Jsay1tcS5o
DQo+IGluZGV4IDUwYzY0ODVjYjA0Zi4uN2I3YTM2NmE5N2YzIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2Jsay1tcS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvYmxrLW1xLmgNCj4gQEAg
LTMwLDYgKzMwLDggQEAgc3RydWN0IGJsa19tcV9od19jdHggew0KPiAgDQo+ICAJc3RydWN0IHNi
aXRtYXAJCWN0eF9tYXA7DQo+ICANCj4gKwlzdHJ1Y3QgYmxrX21xX2N0eAkqZGlzcGF0Y2hfZnJv
bTsNCj4gKw0KPiAgCXN0cnVjdCBibGtfbXFfY3R4CSoqY3R4czsNCj4gIAl1bnNpZ25lZCBpbnQJ
CW5yX2N0eDsNCg0KSGVsbG8gTWluZywNCg0KQXJlIHlvdSByZWx5aW5nIGhlcmUgb24gdGhlIGZh
Y3QgdGhhdCB0aGUgcGVyLUNQVSBxdWV1ZXMgYXJlIG5ldmVyDQpyZWFsbG9jYXRlZCwgZXZlbiBp
ZiBDUFUgaG90LXBsdWdnaW5nIG9jY3Vycz8gU29ycnkgYnV0IHRoYXQgc2VlbXMgZnJhZ2lsZQ0K
dG8gbWUuIEkgd291bGQgbGlrZSB0byBzZWUgJ2Rpc3BhdGNoX2Zyb20nIGJlIGNvbnZlcnRlZCBp
bnRvIGFuIGludGVnZXIuIEl0DQppcyBlYXN5IHRvIGNoZWNrIHdoZXRoZXIgYW4gaW50ZWdlciBz
b2Z0d2FyZSBxdWV1ZSBpbmRleCBpcyBvdXQgb2YgcmFuZ2UNCmJ1dCBpdCdzIG5vdCB0aGF0IGVh
c3kgdG8gY2hlY2sgd2hldGhlciBhIHBvaW50ZXIgYmVjYW1lIGludmFsaWQuDQoNClRoYW5rcywN
Cg0KQmFydC4=
