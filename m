Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41998 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdI0JyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2017 05:54:13 -0400
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
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "cavery@redhat.com" <cavery@redhat.com>
Subject: Re: [PATCH V6 6/6] SCSI: set block queue at preempt only when SCSI
 device is put into quiesce
Date: Wed, 27 Sep 2017 09:54:09 +0000
Message-ID: <1506506047.2654.3.camel@wdc.com>
References: <20170927054853.6647-1-ming.lei@redhat.com>
         <20170927054853.6647-7-ming.lei@redhat.com>
In-Reply-To: <20170927054853.6647-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTA5LTI3IGF0IDEzOjQ4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gQEAg
LTI5MjgsMTIgKzI5MjksMjggQEAgc2NzaV9kZXZpY2VfcXVpZXNjZShzdHJ1Y3Qgc2NzaV9kZXZp
Y2UgKnNkZXYpDQo+ICB7DQo+ICAJaW50IGVycjsNCj4gIA0KPiArCS8qDQo+ICsJICogU2ltcGx5
IHF1aWVzaW5nIFNDU0kgZGV2aWNlIGlzbid0IHNhZmUsIGl0IGlzIGVhc3kNCj4gKwkgKiB0byB1
c2UgdXAgcmVxdWVzdHMgYmVjYXVzZSBhbGwgdGhlc2UgYWxsb2NhdGVkIHJlcXVlc3RzDQo+ICsJ
ICogY2FuJ3QgYmUgZGlzcGF0Y2hlZCB3aGVuIGRldmljZSBpcyBwdXQgaW4gUUlVRVNDRS4NCj4g
KwkgKiBUaGVuIG5vIHJlcXVlc3QgY2FuIGJlIGFsbG9jYXRlZCBhbmQgd2UgbWF5IGhhbmcNCj4g
KwkgKiBzb21ld2hlcmUsIHN1Y2ggYXMgc3lzdGVtIHN1c3BlbmQvcmVzdW1lLg0KPiArCSAqDQo+
ICsJICogU28gd2Ugc2V0IGJsb2NrIHF1ZXVlIGluIHByZWVtcHQgb25seSBmaXJzdCwgbm8gbmV3
DQo+ICsJICogbm9ybWFsIHJlcXVlc3QgY2FuIGVudGVyIHF1ZXVlIGFueSBtb3JlLCBhbmQgYWxs
IHBlbmRpbmcNCj4gKwkgKiByZXF1ZXN0cyBhcmUgZHJhaW5lZCBvbmNlIGJsa19zZXRfcHJlZW1w
dF9vbmx5KCkNCj4gKwkgKiByZXR1cm5zLiBPbmx5IFJRRl9QUkVFTVBUIGlzIGFsbG93ZWQgaW4g
cHJlZW1wdCBvbmx5IG1vZGUuDQo+ICsJICovDQo+ICsJYmxrX3NldF9wcmVlbXB0X29ubHkoc2Rl
di0+cmVxdWVzdF9xdWV1ZSwgdHJ1ZSk7DQo+ICsNCj4gIAltdXRleF9sb2NrKCZzZGV2LT5zdGF0
ZV9tdXRleCk7DQo+ICAJZXJyID0gc2NzaV9kZXZpY2Vfc2V0X3N0YXRlKHNkZXYsIFNERVZfUVVJ
RVNDRSk7DQo+ICAJbXV0ZXhfdW5sb2NrKCZzZGV2LT5zdGF0ZV9tdXRleCk7DQo+ICANCj4gLQlp
ZiAoZXJyKQ0KPiArCWlmIChlcnIpIHsNCj4gKwkJYmxrX3NldF9wcmVlbXB0X29ubHkoc2Rldi0+
cmVxdWVzdF9xdWV1ZSwgZmFsc2UpOw0KPiAgCQlyZXR1cm4gZXJyOw0KPiArCX0NCj4gIA0KPiAg
CXNjc2lfcnVuX3F1ZXVlKHNkZXYtPnJlcXVlc3RfcXVldWUpOw0KPiAgCXdoaWxlIChhdG9taWNf
cmVhZCgmc2Rldi0+ZGV2aWNlX2J1c3kpKSB7DQo+IEBAIC0yOTY0LDYgKzI5ODEsOCBAQCB2b2lk
IHNjc2lfZGV2aWNlX3Jlc3VtZShzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYpDQo+ICAJICAgIHNj
c2lfZGV2aWNlX3NldF9zdGF0ZShzZGV2LCBTREVWX1JVTk5JTkcpID09IDApDQo+ICAJCXNjc2lf
cnVuX3F1ZXVlKHNkZXYtPnJlcXVlc3RfcXVldWUpOw0KPiAgCW11dGV4X3VubG9jaygmc2Rldi0+
c3RhdGVfbXV0ZXgpOw0KPiArDQo+ICsJYmxrX3NldF9wcmVlbXB0X29ubHkoc2Rldi0+cmVxdWVz
dF9xdWV1ZSwgZmFsc2UpOw0KDQpZb3Ugc2hvdWxkIGhhdmUgcmVhbGl6ZWQgeW91cnNlbGYgdGhh
dCB0aGlzIGNvZGUgaXMgcmFjeS4gSWYgYSByZXF1ZXN0IGlzDQphbGxvY2F0ZWQganVzdCBiZWZv
cmUgc2NzaV9kZXZpY2VfcXVpZXNjZSgpIGlzIGNhbGxlZCBhbmQgZGlzcGF0Y2hlZCBqdXN0DQph
ZnRlciB0aGUgZGV2aWNlIHN0YXRlIGhhcyBiZWVuIGNoYW5nZWQgaW50byBTREVWX1FVSUVTQ0Ug
dGhlbiB0aGUgbG9vcCB0aGF0DQp3YWl0cyBmb3IgYWxsIGNvbW1hbmRzIHRvIGNvbXBsZXRlIHdp
bGwgd2FpdCBmb3JldmVyIGR1ZSB0byB0aGUgU0NTSSBwcmVwDQpmdW5jdGlvbiByZXR1cm5pbmcg
QkxLUFJFUF9ERUZFUi4NCg0KQmFydC4=
