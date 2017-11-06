Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8929 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753704AbdKFQtp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2017 11:49:45 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq: quiesce queue during switching io sched and
 updating nr_requests
Date: Mon, 6 Nov 2017 16:49:42 +0000
Message-ID: <1509986980.2409.27.camel@wdc.com>
References: <20171106104322.3861-1-ming.lei@redhat.com>
In-Reply-To: <20171106104322.3861-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gTW9uLCAyMDE3LTExLTA2IGF0IDE4OjQzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gQEAg
LTI2NjUsNiArMjY2NSw3IEBAIGludCBibGtfbXFfdXBkYXRlX25yX3JlcXVlc3RzKHN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxLCB1bnNpZ25lZCBpbnQgbnIpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0K
PiAgDQo+ICAJYmxrX21xX2ZyZWV6ZV9xdWV1ZShxKTsNCj4gKwlibGtfbXFfcXVpZXNjZV9xdWV1
ZShxKTsNCj4gIA0KPiAgCXJldCA9IDA7DQo+ICAJcXVldWVfZm9yX2VhY2hfaHdfY3R4KHEsIGhj
dHgsIGkpIHsNCg0KQmVmb3JlIG1vcmUgYmxrX21xX3F1aWVzY2VfcXVldWUoKSBjYWxsZXJzIGFy
ZSBhZGRlZCBhIGNvdW50ZXIgbWVjaGFuaXNtDQpoYXMgdG8gYmUgYWRkZWQgaW50byBibGtfbXFf
cXVpZXNjZV9xdWV1ZV9ub3dhaXQoKSBhbmQgYmxrX21xX3VucXVpZXNjZV9xdWV1ZSgpDQp0byBh
dm9pZCB0cm91YmxlIGR1ZSB0byBjb25jdXJyZW50IGJsa19tcV9xdWllc2NlX3F1ZXVlX25vd2Fp
dCgpIGFuZC9vcg0KYmxrX21xX3VucXVpZXNjZV9xdWV1ZSgpIGNhbGxzLg0KDQpCYXJ0Lg==
