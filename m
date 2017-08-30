Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24911 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdH3QCd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 12:02:33 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 03/14] blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
Date: Wed, 30 Aug 2017 16:01:34 +0000
Message-ID: <1504108891.2526.24.camel@wdc.com>
References: <20170826163332.28971-1-ming.lei@redhat.com>
         <20170826163332.28971-4-ming.lei@redhat.com>
In-Reply-To: <20170826163332.28971-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA4LTI3IGF0IDAwOjMzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhp
cyBmdW5jdGlvbiBpcyBpbnRyb2R1Y2VkIGZvciBkZXF1ZXVpbmcgcmVxdWVzdA0KPiBmcm9tIHN3
IHF1ZXVlIHNvIHRoYXQgd2UgY2FuIGRpc3BhdGNoIGl0IGluDQo+IHNjaGVkdWxlcidzIHdheS4N
Cj4gDQo+IE1vcmUgaW1wb3J0YW50bHksIHNvbWUgU0NTSSBkZXZpY2VzIG1heSBzZXQNCj4gcS0+
cXVldWVfZGVwdGgsIHdoaWNoIGlzIGEgcGVyLXJlcXVlc3RfcXVldWUgbGltaXQsDQo+IGFuZCBh
cHBsaWVkIG9uIHBlbmRpbmcgSS9PIGZyb20gYWxsIGhjdHhzLiBUaGlzDQo+IGZ1bmN0aW9uIGlz
IGludHJvZHVjZWQgZm9yIGF2b2lkaW5nIHRvIGRlcXVldWUgdG9vDQo+IG1hbnkgcmVxdWVzdHMg
ZnJvbSBzdyBxdWV1ZSB3aGVuIC0+ZGlzcGF0Y2ggaXNuJ3QNCj4gZmx1c2hlZCBjb21wbGV0ZWx5
Lg0KDQpSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29t
Pg==
