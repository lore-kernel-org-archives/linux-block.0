Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27914 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755593AbdLORox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Dec 2017 12:44:53 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "mauricfo@linux.vnet.ibm.com" <mauricfo@linux.vnet.ibm.com>,
        "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Date: Fri, 15 Dec 2017 17:44:50 +0000
Message-ID: <1513359889.2571.18.camel@wdc.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
         <20171127124147.GA16095@ming.t460p>
         <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
         <1513201983.2413.11.camel@sandisk.com>
         <ceb3a7fc-83cb-dbc5-4bc6-c8f2c089640f@hisilicon.com>
In-Reply-To: <ceb3a7fc-83cb-dbc5-4bc6-c8f2c089640f@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTEyLTE1IGF0IDE1OjU4ICswODAwLCBjaGVueGlhbmcgKE0pIHdyb3RlOg0K
PiBJIHRlc3RlZCB2MiBvZiB0aGlzIHNlcmllcyBiYXNlZCBvbiBNYXJ0aW4ncyBmb3ItNC4xNiBT
Q1NJIHRyZWUgd2hpY2ggDQo+IGJyYW5jaCBlcnJvciBoYW5kbGVyIGlzc3VlICJzY3NpOiBjb3Jl
OiBFbnN1cmUgdGhhdCB0aGUNCj4gU0NTSSBlcnJvciBoYW5kbGVyIGdldHMgd29rZW4gdXAiIGlz
IG1lcmdlZC4gQW5kIHN5c3RlbSBpcyBzdGlsbCBodW5nIA0KPiBhZnRlciByZXBlYXQgbXkgdGVz
dGNhc2UuDQoNCkhlbGxvIGNoZW54aWFuZywNCg0KVGhhbmtzIGZvciBoYXZpbmcgcnVuIHRoaXMg
dGVzdCBhbmQgZm9yIGhhdmluZyBzaGFyZWQgdGhlIHJlc3VsdHMuIEkgd2lsbCBzZWUNCndoZXRo
ZXIgSSBjYW4gcmVwcm9kdWNlIHRoaXMgb24gbXkgdGVzdCBzZXR1cC4NCg0KQmFydC4=
