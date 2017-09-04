Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30603 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbdIDPV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Sep 2017 11:21:56 -0400
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
Subject: Re: [PATCH V3 6/8] block: introduce preempt version of
 blk_[freeze|unfreeze]_queue
Date: Mon, 4 Sep 2017 15:21:08 +0000
Message-ID: <1504538467.3189.2.camel@wdc.com>
References: <20170902130840.24609-1-ming.lei@redhat.com>
         <20170902130840.24609-7-ming.lei@redhat.com>
In-Reply-To: <20170902130840.24609-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA5LTAyIGF0IDIxOjA4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5o
DQo+IEBAIC01NjUsNiArNTY1LDEwIEBAIHN0cnVjdCByZXF1ZXN0X3F1ZXVlIHsNCj4gIA0KPiAg
CWludAkJCWJ5cGFzc19kZXB0aDsNCj4gIAlhdG9taWNfdAkJbXFfZnJlZXplX2RlcHRoOw0KPiAr
CXNwaW5sb2NrX3QJCWZyZWV6ZV9sb2NrOw0KPiArCXVuc2lnbmVkCQlub3JtYWxfZnJlZXppbmc6
MTsNCj4gKwl1bnNpZ25lZAkJcHJlZW1wdF9mcmVlemluZzoxOw0KPiArCXVuc2lnbmVkCQlwcmVl
bXB0X3VuZnJlZXppbmc6MTsNCj4gIA0KPiAgI2lmIGRlZmluZWQoQ09ORklHX0JMS19ERVZfQlNH
KQ0KPiAgCWJzZ19qb2JfZm4JCSpic2dfam9iX2ZuOw0KDQpSZXF1ZXN0cyBxdWV1ZXMgYWxyZWFk
eSBoYXZlIHRvIG1hbnkgc3RhdGVzIGFuZCB5b3Ugd2FudCB0byBtYWtlIHJlcXVlc3QgcXVldWVz
DQpldmVuIG1vcmUgY29tcGxpY2F0ZWQgYnkgaW50cm9kdWNpbmcgc2V2ZXJhbCBuZXcgc3RhdGUg
dmFyaWFibGVzPyBZaWtlcyENCg0KQmFydC4=
