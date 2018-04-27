Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58073 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757457AbeD0QQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Apr 2018 12:16:59 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "james.bottomley@hansenpartnership.com"
        <james.bottomley@hansenpartnership.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH 3/3] scsi: avoid to hold host-wide counter of host_busy
 for scsi_mq
Date: Fri, 27 Apr 2018 16:16:48 +0000
Message-ID: <cf84baf9bd61fd1a3ab34aa956d496d164aef44f.camel@wdc.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
         <20180420065742.8043-4-ming.lei@redhat.com>
In-Reply-To: <20180420065742.8043-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTA0LTIwIGF0IDE0OjU3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK3N0
cnVjdCBzY3NpX2hvc3RfbXFfaW5fZmxpZ2h0IHsNCj4gKwlpbnQgY250Ow0KPiArfTsNCj4gKw0K
PiArc3RhdGljIHZvaWQgc2NzaV9ob3N0X2NoZWNrX2luX2ZsaWdodChzdHJ1Y3QgcmVxdWVzdCAq
cnEsIHZvaWQgKmRhdGEsDQo+ICsJCWJvb2wgcmVzZXJ2ZWQpDQo+ICt7DQo+ICsJc3RydWN0IHNj
c2lfaG9zdF9tcV9pbl9mbGlnaHQgKmluX2ZsaWdodCA9IGRhdGE7DQo+ICsNCj4gKwlpZiAoYmxr
X21xX3JlcXVlc3Rfc3RhcnRlZChycSkpDQo+ICsJCWluX2ZsaWdodC0+Y250Kys7DQo+ICt9DQo+
ICsNCj4gIC8qKg0KPiAgICogc2NzaV9ob3N0X2J1c3kgLSBSZXR1cm4gdGhlIGhvc3QgYnVzeSBj
b3VudGVyDQo+ICAgKiBAc2hvc3Q6CVBvaW50ZXIgdG8gU2NzaV9Ib3N0IHRvIGluYy4NCj4gICAq
Ki8NCj4gIGludCBzY3NpX2hvc3RfYnVzeShzdHJ1Y3QgU2NzaV9Ib3N0ICpzaG9zdCkNCj4gIHsN
Cj4gLQlyZXR1cm4gYXRvbWljX3JlYWQoJnNob3N0LT5ob3N0X2J1c3kpOw0KPiArCXN0cnVjdCBz
Y3NpX2hvc3RfbXFfaW5fZmxpZ2h0IGluX2ZsaWdodCA9IHsNCj4gKwkJLmNudCA9IDAsDQo+ICsJ
fTsNCj4gKw0KPiArCWlmICghc2hvc3QtPnVzZV9ibGtfbXEpDQo+ICsJCXJldHVybiBhdG9taWNf
cmVhZCgmc2hvc3QtPmhvc3RfYnVzeSk7DQo+ICsNCj4gKwlibGtfbXFfdGFnc2V0X2J1c3lfaXRl
cigmc2hvc3QtPnRhZ19zZXQsIHNjc2lfaG9zdF9jaGVja19pbl9mbGlnaHQsDQo+ICsJCQkmaW5f
ZmxpZ2h0KTsNCj4gKwlyZXR1cm4gaW5fZmxpZ2h0LmNudDsNCj4gIH0NCj4gIEVYUE9SVF9TWU1C
T0woc2NzaV9ob3N0X2J1c3kpOw0KDQpUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBzdWJ0bGUgYmVo
YXZpb3IgY2hhbmdlIHRoYXQgaGFzIG5vdCBiZWVuIGV4cGxhaW5lZA0KaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLiBJZiBhIFNDU0kgcmVxdWVzdCBnZXRzIHJlcXVldWVkIHRoYXQgcmVzdWx0cyBpbiBh
DQpkZWNyZWFzZSBvZiB0aGUgLmhvc3RfYnVzeSBjb3VudGVyIGJ5IHNjc2lfZGV2aWNlX3VuYnVz
eSgpIGJlZm9yZSB0aGUgcmVxdWVzdA0KaXMgcmVxdWV1ZWQgYW5kIGFuIGluY3JlYXNlIG9mIHRo
ZSBob3N0X2J1c3kgY291bnRlciB3aGVuIHNjc2lfcXVldWVfcnEoKSBpcw0KY2FsbGVkIGFnYWlu
LiBEdXJpbmcgdGhhdCB0aW1lIHN1Y2ggcmVxdWVzdHMgaGF2ZSB0aGUgc3RhdGUgTVFfUlFfQ09N
UExFVEUgYW5kDQpoZW5jZSBibGtfbXFfcmVxdWVzdF9zdGFydGVkKCkgd2lsbCByZXR1cm4gdHJ1
ZSBhbmQgc2NzaV9ob3N0X2NoZWNrX2luX2ZsaWdodCgpDQp3aWxsIGluY2x1ZGUgdGhlc2UgcmVx
dWVzdHMuIEluIG90aGVyIHdvcmRzLCB0aGlzIHBhdGNoIGludHJvZHVjZXMgYSBzdWJ0bGUNCmJl
aGF2aW9yIGNoYW5nZSB0aGF0IGhhcyBub3QgYmVlbiBleHBsYWluZWQgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLiBIZW5jZSBJJ20NCmRvdWJ0IHRoYXQgdGhpcyBjaGFuZ2UgaXMgY29ycmVjdC4NCg0K
QmFydC4NCg0KDQoNCg==
