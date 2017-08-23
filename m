Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32835 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932251AbdHWQMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 12:12:54 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
Date: Wed, 23 Aug 2017 16:12:06 +0000
Message-ID: <1503504725.2484.7.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gSW4g
UmVkIEhhdCBpbnRlcm5hbCBzdG9yYWdlIHRlc3Qgd3J0LiBibGstbXEgc2NoZWR1bGVyLCB3ZQ0K
PiBmb3VuZCB0aGF0IEkvTyBwZXJmb3JtYW5jZSBpcyBtdWNoIGJhZCB3aXRoIG1xLWRlYWRsaW5l
LCBlc3BlY2lhbGx5DQo+IGFib3V0IHNlcXVlbnRpYWwgSS9PIG9uIHNvbWUgbXVsdGktcXVldWUg
U0NTSSBkZXZjaWVzKGxwZmMsIHFsYTJ4eHgsDQo+IFNSUC4uLikNCg0KSGVsbG8gTWluZyBhbmQg
SmVucywNCg0KVGhlcmUgbWF5IG5vdCBiZSBlbm91Z2ggdGltZSBsZWZ0IHRvIHJlYWNoIGFncmVl
bWVudCBhYm91dCB0aGUgd2hvbGUgcGF0Y2gNCnNlcmllcyBiZWZvcmUgdGhlIGtlcm5lbCB2NC4x
NCBtZXJnZSB3aW5kb3cgb3BlbnMuIEhvdyBhYm91dCBmb2N1c2luZyBvbg0KcGF0Y2hlcyAxLi44
IG9mIHRoaXMgc2VyaWVzIGZvciBrZXJuZWwgdjQuMTQgYW5kIHJldmlzaXRpbmcgdGhlIHJlc3Qg
b2YgdGhpcw0KcGF0Y2ggc2VyaWVzIGxhdGVyPw0KDQpUaGFua3MsDQoNCkJhcnQu
