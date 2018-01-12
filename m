Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28697 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964998AbeALTEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jan 2018 14:04:30 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: [PATCH V3 2/5] dm-mpath: return DM_MAPIO_REQUEUE in case of rq
 allocation failure
Date: Fri, 12 Jan 2018 19:04:28 +0000
Message-ID: <1515783866.2396.43.camel@sandisk.com>
References: <20180111060159.12991-1-ming.lei@redhat.com>
         <20180111060159.12991-3-ming.lei@redhat.com>
In-Reply-To: <20180111060159.12991-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE4LTAxLTExIGF0IDE0OjAxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0tbXBhdGguYyBiL2RyaXZlcnMvbWQvZG0tbXBhdGguYw0K
PiBpbmRleCA4NmJmNTAyYThlNTEuLmZjZGRmNWE2MjU4MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tZC9kbS1tcGF0aC5jDQo+ICsrKyBiL2RyaXZlcnMvbWQvZG0tbXBhdGguYw0KPiBAQCAtNTMz
LDggKzUzMywyMCBAQCBzdGF0aWMgaW50IG11bHRpcGF0aF9jbG9uZV9hbmRfbWFwKHN0cnVjdCBk
bV90YXJnZXQgKnRpLCBzdHJ1Y3QgcmVxdWVzdCAqcnEsDQo+ICAJCWlmIChxdWV1ZV9keWluZykg
ew0KPiAgCQkJYXRvbWljX2luYygmbS0+cGdfaW5pdF9pbl9wcm9ncmVzcyk7DQo+ICAJCQlhY3Rp
dmF0ZV9vcl9vZmZsaW5lX3BhdGgocGdwYXRoKTsNCj4gKwkJCXJldHVybiBETV9NQVBJT19ERUxB
WV9SRVFVRVVFOw0KPiAgCQl9DQo+IC0JCXJldHVybiBETV9NQVBJT19ERUxBWV9SRVFVRVVFOw0K
PiArDQo+ICsJCS8qDQo+ICsJCSAqIGJsay1tcSdzIFNDSEVEX1JFU1RBUlQgY2FuIGNvdmVyIHRo
aXMgcmVxdWV1ZSwgc28NCj4gKwkJICogd2UgbmVlZG4ndCB0byBkZWFsIHdpdGggaXQgYnkgREVM
QVlfUkVRVUVVRS4gTW9yZQ0KPiArCQkgKiBpbXBvcnRhbnRseSwgd2UgaGF2ZSB0byByZXR1cm4g
RE1fTUFQSU9fUkVRVUVVRQ0KPiArCQkgKiBzbyB0aGF0IGJsay1tcSBjYW4gZ2V0IHRoZSBxdWV1
ZSBidXN5IGZlZWRiYWNrLA0KPiArCQkgKiBvdGhlcndpc2UgSS9PIG1lcmdlIGNhbiBiZSBodXJ0
Lg0KPiArCQkgKi8NCj4gKwkJaWYgKHEtPm1xX29wcykNCj4gKwkJCXJldHVybiBETV9NQVBJT19S
RVFVRVVFOw0KPiArCQllbHNlDQo+ICsJCQlyZXR1cm4gRE1fTUFQSU9fREVMQVlfUkVRVUVVRTsN
Cj4gIAl9DQoNClNvcnJ5IGJ1dCB0aGUgYXBwcm9hY2ggb2YgdGhpcyBwYXRjaCBsb29rcyB3cm9u
ZyB0byBtZS4gSSdtIGFmcmFpZCB0aGF0IHRoaXMNCmFwcHJvYWNoIHdpbGwgY2F1c2UgMTAwJSBD
UFUgY29uc3VtcHRpb24gaWYgdGhlIHVuZGVybHlpbmcgLnF1ZXVlX3JxKCkNCmZ1bmN0aW9uIHJl
dHVybnMgQkxLX1NUU19SRVNPVVJDRSBmb3IgYW5vdGhlciByZWFzb24gdGhhbiB3aGF0IGNhbiBi
ZSBkZXRlY3RlZA0KYnkgdGhlIC5nZXRfYnVkZ2V0KCkgY2FsbC4gVGhpcyBjYW4gaGFwcGVuIGlm
IGUuZy4gYSBTQ1NJIExMRCAucXVldWVjb21tYW5kKCkNCmltcGxlbWVudGF0aW9uIHJldHVybnMg
U0NTSV9NTFFVRVVFX0hPU1RfQlVTWS4gTWFueSBTQ1NJIExMRHMgY2FuIGRvIHRoaXM6DQokIGdp
dCBncmVwICdTQ1NJX01MUVVFVUVfW15fXSpfQlVTWScgfCB3YyAtbA0KMjA0DQoNCklzbid0IHRo
aXMgYSBzZXZlcmUgcmVncmVzc2lvbj8NCg0KQmFydC4=
