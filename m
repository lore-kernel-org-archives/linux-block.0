Return-Path: <linux-block-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:25722 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdEFDR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2017 23:17:26 -0400
From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "jack@suse.cz" <jack@suse.cz>
Subject: RE: [PATCH v2] x86, uaccess: introduce copy_from_iter_wt for pmem /
 writethrough operations
Date: Sat, 6 May 2017 03:17:19 +0000
Message-ID: <AT5PR84MB02607F504E354866D8762CD182E80@AT5PR84MB0260.NAMPRD84.PROD.OUTLOOK.COM>
References: <20170427063054.soejyqocqqrihfdw@gmail.com>
 <149340820800.28724.16189291963486607562.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1494016773.30303.69.camel@hpe.com>
 <CAPcyv4igCk9EBXSCVr8W1B-oNwq8q5kr7AMTkwvnMAhdwMgjRA@mail.gmail.com>
 <1494024273.30303.71.camel@hpe.com>
 <CAPcyv4iHGAGfb1ZUDYovUKs1+tr48CxEbngCHE-QiSFXAjeChA@mail.gmail.com>
In-Reply-To: <CAPcyv4iHGAGfb1ZUDYovUKs1+tr48CxEbngCHE-QiSFXAjeChA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

PiBPbiBGcmksIE1heSA1LCAyMDE3IGF0IDM6NDQgUE0sIEthbmksIFRvc2hpbWl0c3UgPHRvc2hp
LmthbmlAaHBlLmNvbT4NCj4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE3LTA1LTA1IGF0IDE1OjI1
IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+ID4+IE9uIEZyaSwgTWF5IDUsIDIwMTcgYXQg
MTozOSBQTSwgS2FuaSwgVG9zaGltaXRzdSA8dG9zaGkua2FuaUBocGUuY29tPg0KPiA+PiB3cm90
ZToNCj4gPiAgOg0KPiA+PiA+ID4gLS0tDQo+ID4+ID4gPiBDaGFuZ2VzIHNpbmNlIHRoZSBpbml0
aWFsIFJGQzoNCj4gPj4gPiA+ICogcy93cml0ZXRocnUvd3QvIHNpbmNlIHdlIGFscmVhZHkgaGF2
ZSBpb3JlbWFwX3d0KCksDQo+ID4+ID4gPiBzZXRfbWVtb3J5X3d0KCksIGV0Yy4gKEluZ28pDQo+
ID4+ID4NCj4gPj4gPiBTb3JyeSBJIHNob3VsZCBoYXZlIHNhaWQgZWFybGllciwgYnV0IEkgdGhp
bmsgdGhlIHRlcm0gInd0IiBpcw0KPiA+PiA+IG1pc2xlYWRpbmcuICBOb24tdGVtcG9yYWwgc3Rv
cmVzIHVzZWQgaW4gbWVtY3B5X3d0KCkgcHJvdmlkZSBXQw0KPiA+PiA+IHNlbWFudGljcywgbm90
IFdUIHNlbWFudGljcy4NCj4gPj4NCj4gPj4gVGhlIG5vbi10ZW1wb3JhbCBzdG9yZXMgZG8sIGJ1
dCBtZW1jcHlfd3QoKSBpcyB1c2luZyBhIGNvbWJpbmF0aW9uIG9mDQo+ID4+IG5vbi10ZW1wb3Jh
bCBzdG9yZXMgYW5kIGV4cGxpY2l0IGNhY2hlIGZsdXNoaW5nLg0KPiA+Pg0KPiA+PiA+IEhvdyBh
Ym91dCB1c2luZyAibm9jYWNoZSIgYXMgaXQncyBiZWVuDQo+ID4+ID4gdXNlZCBpbiBfX2NvcHlf
dXNlcl9ub2NhY2hlKCk/DQo+ID4+DQo+ID4+IFRoZSBkaWZmZXJlbmNlIGluIG15IG1pbmQgaXMg
dGhhdCB0aGUgIl9ub2NhY2hlIiBzdWZmaXggaW5kaWNhdGVzDQo+ID4+IG9wcG9ydHVuaXN0aWMg
LyBvcHRpb25hbCBjYWNoZSBwb2xsdXRpb24gYXZvaWRhbmNlIHdoZXJlYXMgIl93dCINCj4gPj4g
c3RyaWN0bHkgYXJyYW5nZXMgZm9yIGNhY2hlcyBub3QgdG8gY29udGFpbiBkaXJ0eSBkYXRhIHVw
b24NCj4gPj4gY29tcGxldGlvbiBvZiB0aGUgcm91dGluZS4gRm9yIGV4YW1wbGUsIG5vbi10ZW1w
b3JhbCBzdG9yZXMgb24gb2xkZXINCj4gPj4geDg2IGNwdXMgY291bGQgcG90ZW50aWFsbHkgbGVh
dmUgZGlydHkgZGF0YSBpbiB0aGUgY2FjaGUsIHNvDQo+ID4+IG1lbWNweV93dCBvbiB0aG9zZSBj
cHVzIHdvdWxkIG5lZWQgdG8gdXNlIGV4cGxpY2l0IGNhY2hlIGZsdXNoaW5nLg0KPiA+DQo+ID4g
SSBzZWUuICBJIGFncmVlIHRoYXQgaXRzIGJlaGF2aW9yIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBl
eGlzdGluZyBvbmUNCj4gPiB3aXRoICJfbm9jYWNoZSIuICAgVGhhdCBzYWlkLCBJIHRoaW5rICJ3
dCIgb3IgIndyaXRlLXRocm91Z2giIGdlbmVyYWxseQ0KPiA+IG1lYW5zIHRoYXQgd3JpdGVzIGFs
bG9jYXRlIGNhY2hlbGluZXMgYW5kIGtlZXAgdGhlbSBjbGVhbiBieSB3cml0aW5nIHRvDQo+ID4g
bWVtb3J5LiAgU28sIHN1YnNlcXVlbnQgcmVhZHMgdG8gdGhlIGRlc3RpbmF0aW9uIHdpbGwgaGl0
IHRoZQ0KPiA+IGNhY2hlbGluZXMuICBUaGlzIGlzIG5vdCB0aGUgY2FzZSB3aXRoIHRoaXMgaW50
ZXJmYWNlLg0KPiANCj4gVHJ1ZS4uLiBtYXliZSBfbm9jYWNoZV9zdHJpY3QoKT8gT3IsIGxlYXZl
IGl0IF93dCgpIHVudGlsIHNvbWVvbmUNCj4gY29tZXMgYWxvbmcgYW5kIGlzIHN1cnByaXNlZCB0
aGF0IHRoZSBjYWNoZSBpcyBub3Qgd2FybSBmb3IgcmVhZHMNCj4gYWZ0ZXIgbWVtY3B5X3d0KCks
IGF0IHdoaWNoIHBvaW50IHdlIGNhbiBhc2sgIndoeSBub3QganVzdCB1c2UgcGxhaW4NCj4gbWVt
Y3B5IHRoZW4/Iiwgb3Igc2V0IHRoZSBwYWdlLWF0dHJpYnV0ZXMgdG8gV1QuDQoNCkkgcHJlZmVy
IF9ub2NhY2hlX3N0cmljdCgpLCBpZiBpdCdzIG5vdCB0b28gbG9uZywgc2luY2UgaXQgYXZvaWRz
IGFueQ0KY29uZnVzaW9uLiAgSWYgb3RoZXIgYXJjaGVzIGFjdHVhbGx5IGltcGxlbWVudCBpdCB3
aXRoIFdUIHNlbWFudGljcywNCndlIG1pZ2h0IGJlY29tZSB0aGUgb25lIHRvIGNoYW5nZSBpdCwg
aW5zdGVhZCBvZiB0aGUgY2FsbGVyLg0KDQpUaGFua3MsDQotVG9zaGkNCg0K
