Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
CC: "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH 6/9] blk-mq: rename blk_mq_freeze_queue_wait as
 blk_freeze_queue_wait
Date: Thu, 31 Aug 2017 22:37:46 +0000
Message-ID: <1504219064.31872.68.camel@wdc.com>
References: <20170831172728.15817-1-ming.lei@redhat.com>
         <20170831172728.15817-7-ming.lei@redhat.com>
In-Reply-To: <20170831172728.15817-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTAxIGF0IDAxOjI3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhl
IG9ubHkgY2hhbmdlIG9uIGxlZ2FjeSBpcyB0aGF0IGJsa19kcmFpbl9xdWV1ZSgpIGlzIHJ1bg0K
PiBmcm9tIGJsa19mcmVlemVfcXVldWUoKSwgd2hpY2ggaXMgY2FsbGVkIGluIGJsa19jbGVhbnVw
X3F1ZXVlKCkuDQo+IA0KPiBTbyB0aGlzIHBhdGNoIHJlbW92ZXMgdGhlIGV4cGxpY2l0ZSBfX2Js
a19kcmFpbl9xdWV1ZSgpIGluDQo+IGJsa19jbGVhbnVwX3F1ZXVlKCkuDQoNCkhlbGxvIE1pbmcs
DQoNClNob3VsZG4ndCB0aGUgcmVuYW1lIGFuZCB0aGUgbW92ZSBvZiB0aGUgX19ibGtfZHJhaW5f
cXVldWUoKSBiZQ0Kc2VwYXJhdGUgcGF0Y2hlcz8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
