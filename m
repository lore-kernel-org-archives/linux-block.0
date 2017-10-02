Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12505 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdJBQ2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 12:28:02 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "martin@lichtvoll.de" <martin@lichtvoll.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "hare@suse.com" <hare@suse.com>,
        "cavery@redhat.com" <cavery@redhat.com>
Subject: Re: [PATCH V7 5/6] block: support PREEMPT_ONLY
Date: Mon, 2 Oct 2017 16:27:59 +0000
Message-ID: <1506961678.3368.29.camel@wdc.com>
References: <20170930061214.10622-1-ming.lei@redhat.com>
         <20170930061214.10622-6-ming.lei@redhat.com>
In-Reply-To: <20170930061214.10622-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA5LTMwIGF0IDE0OjEyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK3Zv
aWQgYmxrX3NldF9wcmVlbXB0X29ubHkoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIGJvb2wgcHJl
ZW1wdF9vbmx5KQ0KPiArew0KPiArCWJsa19tcV9mcmVlemVfcXVldWUocSk7DQo+ICsJaWYgKHBy
ZWVtcHRfb25seSkNCj4gKwkJcXVldWVfZmxhZ19zZXRfdW5sb2NrZWQoUVVFVUVfRkxBR19QUkVF
TVBUX09OTFksIHEpOw0KPiArCWVsc2UNCj4gKwkJcXVldWVfZmxhZ19jbGVhcl91bmxvY2tlZChR
VUVVRV9GTEFHX1BSRUVNUFRfT05MWSwgcSk7DQo+ICsJYmxrX21xX3VuZnJlZXplX3F1ZXVlKHEp
Ow0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChibGtfc2V0X3ByZWVtcHRfb25seSk7DQo+ICsNCj4g
IC8qKg0KPiAgICogX19ibGtfcnVuX3F1ZXVlX3VuY29uZCAtIHJ1biBhIHF1ZXVlIHdoZXRoZXIg
b3Igbm90IGl0IGhhcyBiZWVuIHN0b3BwZWQNCj4gICAqIEBxOglUaGUgcXVldWUgdG8gcnVuDQo+
IEBAIC03NzEsOSArNzgyLDE4IEBAIGludCBibGtfcXVldWVfZW50ZXIoc3RydWN0IHJlcXVlc3Rf
cXVldWUgKnEsIHVuc2lnbmVkIGZsYWdzKQ0KPiAgCXdoaWxlICh0cnVlKSB7DQo+ICAJCWludCBy
ZXQ7DQo+ICANCj4gKwkJLyoNCj4gKwkJICogcHJlZW1wdF9vbmx5IGZsYWcgaGFzIHRvIGJlIHNl
dCBhZnRlciBxdWV1ZSBpcyBmcm96ZW4sDQo+ICsJCSAqIHNvIGl0IGNhbiBiZSBjaGVja2VkIGhl
cmUgbG9ja2xlc3MgYW5kIHNhZmVseQ0KPiArCQkgKi8NCj4gKwkJaWYgKGJsa19xdWV1ZV9wcmVl
bXB0X29ubHkocSkpIHsNCj4gKwkJCWlmICghKGZsYWdzICYgQkxLX1JFUV9QUkVFTVBUKSkNCj4g
KwkJCQlnb3RvIHNsb3dfcGF0aDsNCj4gKwkJfQ0KPiArDQo+ICAJCWlmIChwZXJjcHVfcmVmX3Ry
eWdldF9saXZlKCZxLT5xX3VzYWdlX2NvdW50ZXIpKQ0KPiAgCQkJcmV0dXJuIDA7DQoNClNvcnJ5
IGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgaXQgaXMgcG9zc2libGUgd2l0aCB0aGVzZSBjaGFuZ2Vz
IHRvIHByZXZlbnQNCnRoYXQgYSBub24tcHJlZW1wdCByZXF1ZXN0IGdldHMgYWxsb2NhdGVkIGFm
dGVyIGEgKFNDU0kpIHF1ZXVlIGhhcyBiZWVuDQpxdWllc2NlZC4gSWYgdGhlIENQVSB0aGF0IGNh
bGxzIGJsa19xdWV1ZV9lbnRlcigpIG9ic2VydmVzIHRoZSBzZXQgb2YgdGhlDQpQUkVFTVBUX09O
TFkgZmxhZyBhZnRlciB0aGUgcXVldWUgaGFzIGJlZW4gdW5mcm96ZW4gYW5kIGFmdGVyIHRoZSBT
Q1NJDQpkZXZpY2Ugc3RhdGUgaGFzIGJlZW4gY2hhbmdlZCBpbnRvIFFVSUVTQ0VEIHRoZW4gYmxr
X3F1ZXVlX2VudGVyKCkgY2FuDQpzdWNjZWVkIGZvciBhIG5vbi1wcmVlbXB0IHJlcXVlc3QuIEkg
dGhpbmsgdGhpcyBpcyBleGFjdGx5IHRoZSBzY2VuYXJpbw0Kd2Ugd2FudCB0byBhdm9pZC4gVGhp
cyBpcyB3aHkgYSBzeW5jaHJvbml6ZV9yY3UoKSBjYWxsIGlzIHByZXNlbnQgaW4gbXkNCnBhdGNo
IGJlZm9yZSB0aGUgcXVldWUgaXMgdW5mcm96ZW4gYW5kIGFsc28gd2h5IGluIG15IHBhdGNoIHRo
ZQ0KcGVyY3B1X3JlZl90cnlnZXRfbGl2ZSgpIGNhbGwgb2NjdXJzIGJlZm9yZSB0aGUgdGVzdCBv
ZiB0aGUgUFJFRU1QVF9PTkxZDQpmbGFnLg0KDQpCYXJ0Lg==
