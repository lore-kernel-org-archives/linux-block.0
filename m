Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [resend PATCH v2 11/33] dm: add dax_device and dax_operations
 support
Date: Sat, 29 Jul 2017 21:24:07 +0000
Message-ID: <1501363445.3005.1.camel@wdc.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
         <149245618859.10206.13182319600260215993.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1501258623.2413.3.camel@wdc.com>
         <CAPcyv4hc9zBHYtXrzS1XP514dMPcjBxjaSwRnPD8zUig1kCKnA@mail.gmail.com>
In-Reply-To: <CAPcyv4hc9zBHYtXrzS1XP514dMPcjBxjaSwRnPD8zUig1kCKnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE3LTA3LTI5IGF0IDEyOjU3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIEZyaSwgSnVsIDI4LCAyMDE3IGF0IDk6MTcgQU0sIEJhcnQgVmFuIEFzc2NoZSA8QmFydC5W
YW5Bc3NjaGVAd2RjLmNvbT4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE3LTA0LTE3IGF0IDEyOjA5
IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZC9LY29uZmlnIGIvZHJpdmVycy9tZC9LY29uZmlnDQo+ID4gPiBpbmRleCBiNzc2N2RhNTBjMjYu
LjFkZTgzNzJkOTQ1OSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbWQvS2NvbmZpZw0KPiA+
ID4gKysrIGIvZHJpdmVycy9tZC9LY29uZmlnDQo+ID4gPiBAQCAtMjAwLDYgKzIwMCw3IEBAIGNv
bmZpZyBCTEtfREVWX0RNX0JVSUxUSU4NCj4gPiA+ICBjb25maWcgQkxLX0RFVl9ETQ0KPiA+ID4g
ICAgICAgdHJpc3RhdGUgIkRldmljZSBtYXBwZXIgc3VwcG9ydCINCj4gPiA+ICAgICAgIHNlbGVj
dCBCTEtfREVWX0RNX0JVSUxUSU4NCj4gPiA+ICsgICAgIHNlbGVjdCBEQVgNCj4gPiA+ICAgICAg
IC0tLWhlbHAtLS0NCj4gPiA+ICAgICAgICAgRGV2aWNlLW1hcHBlciBpcyBhIGxvdyBsZXZlbCB2
b2x1bWUgbWFuYWdlci4gIEl0IHdvcmtzIGJ5IGFsbG93aW5nDQo+ID4gPiAgICAgICAgIHBlb3Bs
ZSB0byBzcGVjaWZ5IG1hcHBpbmdzIGZvciByYW5nZXMgb2YgbG9naWNhbCBzZWN0b3JzLiAgVmFy
aW91cw0KPiA+IA0KPiA+IChyZXBseWluZyB0byBhbiBlLW1haWwgb2YgdGhyZWUgbW9udGhzIGFn
bykNCj4gPiANCj4gPiBIZWxsbyBEYW4sDQo+ID4gDQo+ID4gV2hpbGUgYnVpbGRpbmcgYSB2NC4x
MiBrZXJuZWwgSSBub3RpY2VkIHRoYXQgZW5hYmxpbmcgZGV2aWNlIG1hcHBlciBzdXBwb3J0DQo+
ID4gbm93IHVuY29uZGl0aW9uYWxseSBlbmFibGVzIERBWC4gSSB0aGluayB0aGVyZSBhcmUgcGxl
bnR5IG9mIHN5c3RlbXMgdGhhdCB1c2UNCj4gPiBkbSBidXQgZG8gbm90IG5lZWQgREFYLiBIYXZl
IHlvdSBjb25zaWRlcmVkIHRvIHJld29yayB0aGlzIHN1Y2ggdGhhdCBpbnN0ZWFkDQo+ID4gb2Yg
ZG0gc2VsZWN0aW5nIERBWCB0aGF0IERBWCBzdXBwb3J0IGlzIG9ubHkgZW5hYmxlZCBpbiBkbSBp
ZiBDT05GSUdfREFYIGlzDQo+ID4gZW5hYmxlZD8NCj4gDQo+IEknZCByYXRoZXIgZmxpcCB0aGlz
IGFyb3VuZCBhbmQgYWRkIGEgQ09ORklHX0RNX0RBWCB0aGF0IGdhdGVzIHdoZXRoZXINCj4gRE0g
ZW5hYmxlcyAvIGxpbmtzIHRvIHRoZSBEQVggY29yZS4gSSdsbCB0YWtlIGEgbG9vayBhdCBhIHBh
dGNoLg0KDQpUaGFua3MhIFBsZWFzZSBhbHNvIGNvbnNpZGVyIHRvIG1vdmUgYWxsIERBWC1yZWxh
dGVkIGRtIGNvZGUgaW50byBhIHNlcGFyYXRlDQpzb3VyY2UgZmlsZSBzdWNoIHRoYXQgdGhlIG51
bWJlciBvZiAjaWZkZWYgQ09ORklHX0RNX0RBWCBzdGF0ZW1lbnRzIGNhbiBiZQ0Ka2VwdCB0byBh
biBhYnNvbHV0ZSBtaW5pbXVtLg0KDQpCYXJ0Lg==
