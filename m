Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22949 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdJCSkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 14:40:46 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin@lichtvoll.de" <martin@lichtvoll.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        "cavery@redhat.com" <cavery@redhat.com>
Subject: Re: [PATCH V8 5/8] percpu-refcount: introduce
 __percpu_ref_tryget_live
Date: Tue, 3 Oct 2017 18:40:24 +0000
Message-ID: <1507056023.2567.1.camel@wdc.com>
References: <20171003140406.26060-1-ming.lei@redhat.com>
         <20171003140406.26060-6-ming.lei@redhat.com>
In-Reply-To: <20171003140406.26060-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE3LTEwLTAzIGF0IDIyOjA0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gQmxv
Y2sgbGF5ZXIgbmVlZCB0byBjYWxsIHRoaXMgZnVuY3Rpb24gYWZ0ZXIgaG9sZGluZw0KPiByY3Ug
bG9jayBpbiBhIHJlYWwgaG90IHBhdGgsIHNvIGludHJvZHVjZSB0aGlzIGhlbHBlci4NCg0KU2lu
Y2UgaXQgaXMgYWxsb3dlZCB0byBuZXN0IHJjdV9yZWFkX2xvY2tfc2NoZWQoKSBjYWxscyBJIGRv
bid0IHRoaW5rDQp0aGF0IHRoaXMgcGF0Y2ggaXMgbmVjZXNzYXJ5Lg0KDQpCYXJ0Lg==
