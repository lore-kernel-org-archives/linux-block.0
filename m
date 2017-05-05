Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
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
Subject: Re: [PATCH v2] x86, uaccess: introduce copy_from_iter_wt for pmem /
 writethrough operations
Date: Fri, 5 May 2017 22:44:40 +0000
Message-ID: <1494024273.30303.71.camel@hpe.com>
References: <20170427063054.soejyqocqqrihfdw@gmail.com>
         <149340820800.28724.16189291963486607562.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1494016773.30303.69.camel@hpe.com>
         <CAPcyv4igCk9EBXSCVr8W1B-oNwq8q5kr7AMTkwvnMAhdwMgjRA@mail.gmail.com>
In-Reply-To: <CAPcyv4igCk9EBXSCVr8W1B-oNwq8q5kr7AMTkwvnMAhdwMgjRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA1LTA1IGF0IDE1OjI1IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIEZyaSwgTWF5IDUsIDIwMTcgYXQgMTozOSBQTSwgS2FuaSwgVG9zaGltaXRzdSA8dG9zaGku
a2FuaUBocGUuY29tPg0KPiB3cm90ZToNCiA6DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgc2lu
Y2UgdGhlIGluaXRpYWwgUkZDOg0KPiA+ID4gKiBzL3dyaXRldGhydS93dC8gc2luY2Ugd2UgYWxy
ZWFkeSBoYXZlIGlvcmVtYXBfd3QoKSwNCj4gPiA+IHNldF9tZW1vcnlfd3QoKSwgZXRjLiAoSW5n
bykNCj4gPiANCj4gPiBTb3JyeSBJIHNob3VsZCBoYXZlIHNhaWQgZWFybGllciwgYnV0IEkgdGhp
bmsgdGhlIHRlcm0gInd0IiBpcw0KPiA+IG1pc2xlYWRpbmcuwqDCoE5vbi10ZW1wb3JhbCBzdG9y
ZXMgdXNlZCBpbiBtZW1jcHlfd3QoKSBwcm92aWRlIFdDDQo+ID4gc2VtYW50aWNzLCBub3QgV1Qg
c2VtYW50aWNzLg0KPiANCj4gVGhlIG5vbi10ZW1wb3JhbCBzdG9yZXMgZG8sIGJ1dCBtZW1jcHlf
d3QoKSBpcyB1c2luZyBhIGNvbWJpbmF0aW9uIG9mDQo+IG5vbi10ZW1wb3JhbCBzdG9yZXMgYW5k
IGV4cGxpY2l0IGNhY2hlIGZsdXNoaW5nLg0KPiANCj4gPiBIb3cgYWJvdXQgdXNpbmcgIm5vY2Fj
aGUiIGFzIGl0J3MgYmVlbg0KPiA+IHVzZWQgaW4gX19jb3B5X3VzZXJfbm9jYWNoZSgpPw0KPiAN
Cj4gVGhlIGRpZmZlcmVuY2UgaW4gbXkgbWluZCBpcyB0aGF0IHRoZSAiX25vY2FjaGUiIHN1ZmZp
eCBpbmRpY2F0ZXMNCj4gb3Bwb3J0dW5pc3RpYyAvIG9wdGlvbmFsIGNhY2hlIHBvbGx1dGlvbiBh
dm9pZGFuY2Ugd2hlcmVhcyAiX3d0Ig0KPiBzdHJpY3RseSBhcnJhbmdlcyBmb3IgY2FjaGVzIG5v
dCB0byBjb250YWluIGRpcnR5IGRhdGEgdXBvbg0KPiBjb21wbGV0aW9uIG9mIHRoZSByb3V0aW5l
LiBGb3IgZXhhbXBsZSwgbm9uLXRlbXBvcmFsIHN0b3JlcyBvbiBvbGRlcg0KPiB4ODYgY3B1cyBj
b3VsZCBwb3RlbnRpYWxseSBsZWF2ZSBkaXJ0eSBkYXRhIGluIHRoZSBjYWNoZSwgc28NCj4gbWVt
Y3B5X3d0IG9uIHRob3NlIGNwdXMgd291bGQgbmVlZCB0byB1c2UgZXhwbGljaXQgY2FjaGUgZmx1
c2hpbmcuDQoNCkkgc2VlLiAgSSBhZ3JlZSB0aGF0IGl0cyBiZWhhdmlvciBpcyBkaWZmZXJlbnQg
ZnJvbSB0aGUgZXhpc3Rpbmcgb25lDQp3aXRoICJfbm9jYWNoZSIuICAgVGhhdCBzYWlkLCBJIHRo
aW5rICJ3dCIgb3IgIndyaXRlLXRocm91Z2giIGdlbmVyYWxseQ0KbWVhbnMgdGhhdCB3cml0ZXMg
YWxsb2NhdGUgY2FjaGVsaW5lcyBhbmQga2VlcCB0aGVtIGNsZWFuIGJ5IHdyaXRpbmcgdG8NCm1l
bW9yeS4gIFNvLCBzdWJzZXF1ZW50IHJlYWRzIHRvIHRoZSBkZXN0aW5hdGlvbiB3aWxsIGhpdCB0
aGUNCmNhY2hlbGluZXMuICBUaGlzIGlzIG5vdCB0aGUgY2FzZSB3aXRoIHRoaXMgaW50ZXJmYWNl
Lg0KDQpUaGFua3MsDQotVG9zaGkNCiA=
