Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1362 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdHVUVI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 16:21:08 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 08/20] blk-mq-sched: use q->queue_depth as hint for
 q->nr_requests
Date: Tue, 22 Aug 2017 20:20:20 +0000
Message-ID: <1503433217.2508.17.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-9-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-9-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gU0NT
SSBzZXRzIHEtPnF1ZXVlX2RlcHRoIGZyb20gc2hvc3QtPmNtZF9wZXJfbHVuLCBhbmQNCj4gcS0+
cXVldWVfZGVwdGggaXMgcGVyIHJlcXVlc3RfcXVldWUgYW5kIG1vcmUgcmVsYXRlZCB0bw0KPiBz
Y2hlZHVsZXIgcXVldWUgY29tcGFyZWQgd2l0aCBodyBxdWV1ZSBkZXB0aCwgd2hpY2ggY2FuIGJl
DQo+IHNoYXJlZCBieSBxdWV1ZXMsIHN1Y2ggYXMgVEFHX1NIQVJFRC4NCj4gDQo+IFRoaXMgcGF0
Y2ggdHJ5cyB0byB1c2UgcS0+cXVldWVfZGVwdGggYXMgaGludCBmb3IgY29tcHV0aW5nDQogICAg
ICAgICAgICAgXl5eXg0KICAgICAgICAgICAgIHRyaWVzPw0KPiBxLT5ucl9yZXF1ZXN0cywgd2hp
Y2ggc2hvdWxkIGJlIG1vcmUgZWZmZWN0aXZlIHRoYW4NCj4gY3VycmVudCB3YXkuDQoNClJldmll
d2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0K
