Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57322 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdHVUwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 16:52:20 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 14/20] blk-mq-sched: improve IO scheduling on SCSI
 devcie
Date: Tue, 22 Aug 2017 20:51:32 +0000
Message-ID: <1503435090.2508.22.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-15-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-15-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhp
cyBwYXRjaCBpbnRyb2R1Y2VzIHBlci1yZXF1ZXN0X3F1ZXVlIGRpc3BhdGNoDQo+IGxpc3QgZm9y
IHRoaXMgcHVycG9zZSwgYW5kIG9ubHkgd2hlbiBhbGwgcmVxdWVzdHMNCj4gaW4gdGhpcyBsaXN0
IGFyZSBkaXNwYXRjaGVkIG91dCBzdWNjZXNzZnVsbHksIHdlDQo+IGNhbiByZXN0YXJ0IHRvIGRl
cXVldWUgcmVxdWVzdCBmcm9tIHN3L3NjaGVkdWxlcg0KPiBxdWV1ZSBhbmQgZGlzcGF0aCBpdCB0
byBsbGQuDQoNCldhc24ndCBvbmUgb2YgdGhlIGRlc2lnbiBnb2FscyBvZiBibGstbXEgdG8gYXZv
aWQgYSBwZXItcmVxdWVzdF9xdWV1ZSBsaXN0Pw0KDQpUaGFua3MsDQoNCkJhcnQu
