Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27826 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbdH3RRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 13:17:48 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 13/14] blk-mq-sched: refactor blk_mq_sched_try_merge()
Date: Wed, 30 Aug 2017 17:17:05 +0000
Message-ID: <1504113417.2526.57.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-14-ming.lei@redhat.com>
In-Reply-To: <20170826163332.28971-14-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA4LTI3IGF0IDAwOjMzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gLWJv
b2wgYmxrX21xX3NjaGVkX3RyeV9tZXJnZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0
IGJpbyAqYmlvLA0KPiAtCQkJICAgIHN0cnVjdCByZXF1ZXN0ICoqbWVyZ2VkX3JlcXVlc3QpDQo+
ICtzdGF0aWMgYm9vbCBfX2Jsa19tcV90cnlfbWVyZ2Uoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEs
DQo+ICsJCXN0cnVjdCBiaW8gKmJpbywgc3RydWN0IHJlcXVlc3QgKiptZXJnZWRfcmVxdWVzdCwN
Cj4gKwkJc3RydWN0IHJlcXVlc3QgKmNhbmRpZGF0ZSwgZW51bSBlbHZfbWVyZ2UgdHlwZSkNCj4g
IHsNCj4gLQlzdHJ1Y3QgcmVxdWVzdCAqcnE7DQo+ICsJc3RydWN0IHJlcXVlc3QgKnJxID0gY2Fu
ZGlkYXRlOw0KDQpJdCBzZWVtcyB3ZWlyZCB0byBtZSB0aGF0IHRoZSBhcmd1bWVudCAnY2FuZGlk
YXRlJyBpcyBub3QgdXNlZCBvdGhlciB0aGFuIHRvDQpjb3B5IGl0cyB2YWx1ZSBpbnRvIHRoZSBs
b2NhbCB2YXJpYWJsZSAncnEnPyBIb3cgYWJvdXQgcmVtb3ZpbmcgdGhhdCBsb2NhbA0KdmFyaWFi
bGUgYW5kIHJlbmFtaW5nIHRoZSAnY2FuZGlkYXRlJyBhcmd1bWVudCBpbnRvICdycSc/IEFueXdh
eSwgd2l0aCBvcg0Kd2l0aG91dCB0aGF0IGNoYW5nZToNCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFu
IEFzc2NoZSA8YmFydC52YW5hc3NjaGVAd2RjLmNvbT4=
