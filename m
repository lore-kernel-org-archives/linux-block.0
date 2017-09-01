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
CC: "tj@kernel.org" <tj@kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH V2 6/8] block: allow to allocate req with REQF_PREEMPT
 when queue is frozen
Date: Fri, 1 Sep 2017 20:07:04 +0000
Message-ID: <1504296423.14386.62.camel@wdc.com>
References: <20170901184958.19452-1-ming.lei@redhat.com>
         <20170901184958.19452-8-ming.lei@redhat.com>
In-Reply-To: <20170901184958.19452-8-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE3LTA5LTAyIGF0IDAyOjQ5ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gKwlp
ZiAoKGZsYWdzICYgQkxLX01RX1JFUV9QUkVFTVBUKSAmJiBibGtfcXVldWVfaXNfZnJlZXppbmco
cSkpDQo+ICsJCWJsa19xdWV1ZV9lbnRlcl9saXZlKHEpOw0KPiArCWVsc2UNCj4gKwkJcmV0ID0g
YmxrX3F1ZXVlX2VudGVyKHEsICEoZ2ZwX21hc2sgJiBfX0dGUF9ESVJFQ1RfUkVDTEFJTSkpOw0K
DQpXaHkgZGlkIHlvdSByZXBvc3QgdGhpcyBwYXRjaCBzZXJpZXMgd2l0aG91dCB0cnlpbmcgdG8g
cmVhY2ggYW4gYWdyZWVtZW50DQphYm91dCB0aGUgYXBwcm9hY2g/DQoNCkFueXdheSwgYmVjYXVz
ZSBvZiB0aGUgdW5zYWZlIGJsa19xdWV1ZV9lbnRlcl9saXZlKCkgY2FsbCBpbnRyb2R1Y2VkIGJ5
IHRoaXMNCnBhdGNoLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdG8gdGhlIGRlc2NyaXB0aW9u
IG9mIHRoaXMgcGF0Y2ggd2hlbmV2ZXIgeW91DQpyZXBvc3QgaXQ6DQoNCk5BSy1lZC1ieTogQmFy
dCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KDQo=
