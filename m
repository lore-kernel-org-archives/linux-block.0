Return-Path: <linux-block-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:34000 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755319AbdEEUjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2017 16:39:49 -0400
From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH v2] x86, uaccess: introduce copy_from_iter_wt for pmem /
 writethrough operations
Date: Fri, 5 May 2017 20:39:40 +0000
Message-ID: <1494016773.30303.69.camel@hpe.com>
References: <20170427063054.soejyqocqqrihfdw@gmail.com>
         <149340820800.28724.16189291963486607562.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149340820800.28724.16189291963486607562.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTA0LTI4IGF0IDEyOjM5IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFRoZSBwbWVtIGRyaXZlciBoYXMgYSBuZWVkIHRvIHRyYW5zZmVyIGRhdGEgd2l0aCBhIHBlcnNp
c3RlbnQgbWVtb3J5DQo+IGRlc3RpbmF0aW9uIGFuZCBiZSBhYmxlIHRvIHJlbHkgb24gdGhlIGZh
Y3QgdGhhdCB0aGUgZGVzdGluYXRpb24NCj4gd3JpdGVzIGFyZSBub3QgY2FjaGVkLiBJdCBpcyBz
dWZmaWNpZW50IGZvciB0aGUgd3JpdGVzIHRvIGJlIGZsdXNoZWQNCj4gdG8gYSBjcHUtc3RvcmUt
YnVmZmVyIChub24tdGVtcG9yYWwgLyAibW92bnQiIGluIHg4NiB0ZXJtcyksIGFzIHdlDQo+IGV4
cGVjdCB1c2Vyc3BhY2UgdG8gY2FsbCBmc3luYygpIHRvIGVuc3VyZSBkYXRhLXdyaXRlcyBoYXZl
IHJlYWNoZWQgYQ0KPiBwb3dlci1mYWlsLXNhZmUgem9uZSBpbiB0aGUgcGxhdGZvcm0uIFRoZSBm
c3luYygpIHRyaWdnZXJzIGEgUkVRX0ZVQQ0KPiBvciBSRVFfRkxVU0ggdG8gdGhlIHBtZW0gZHJp
dmVyIHdoaWNoIHdpbGwgdHVybiBhcm91bmQgYW5kIGZlbmNlDQo+IHByZXZpb3VzIHdyaXRlcyB3
aXRoIGFuICJzZmVuY2UiLg0KPiANCj4gSW1wbGVtZW50IGEgX19jb3B5X2Zyb21fdXNlcl9pbmF0
b21pY193dCwgbWVtY3B5X3BhZ2Vfd3QsIGFuZA0KPiBtZW1jcHlfd3QsIHRoYXQgZ3VhcmFudGVl
IHRoYXQgdGhlIGRlc3RpbmF0aW9uIGJ1ZmZlciBpcyBub3QgZGlydHkgaW4NCj4gdGhlIGNwdSBj
YWNoZSBvbiBjb21wbGV0aW9uLiBUaGUgbmV3IGNvcHlfZnJvbV9pdGVyX3d0IGFuZCBzdWItDQo+
IHJvdXRpbmVzIHdpbGwgYmUgdXNlZCB0byByZXBsYWNlIHRoZSAicG1lbSBhcGkiIChpbmNsdWRl
L2xpbnV4L3BtZW0uaA0KPiArIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BtZW0uaCkuIFRoZSBhdmFp
bGFiaWxpdHkgb2YNCj4gY29weV9mcm9tX2l0ZXJfd3QoKSBhbmQgbWVtY3B5X3d0KCkgYXJlIGdh
dGVkIGJ5IHRoZQ0KPiBDT05GSUdfQVJDSF9IQVNfVUFDQ0VTU19XVCBjb25maWcgc3ltYm9sLCBh
bmQgZmFsbGJhY2sgdG8NCj4gY29weV9mcm9tX2l0ZXJfbm9jYWNoZSgpIGFuZCBwbGFpbiBtZW1j
cHkoKSBvdGhlcndpc2UuDQo+IA0KPiBUaGlzIGlzIG1lYW50IHRvIHNhdGlzZnkgdGhlIGNvbmNl
cm4gZnJvbSBMaW51cyB0aGF0IGlmIGEgZHJpdmVyDQo+IHdhbnRzIHRvIGRvIHNvbWV0aGluZyBi
ZXlvbmQgdGhlIG5vcm1hbCBub2NhY2hlIHNlbWFudGljcyBpdCBzaG91bGQNCj4gYmUgc29tZXRo
aW5nIHByaXZhdGUgdG8gdGhhdCBkcml2ZXIgWzFdLCBhbmQgQWwncyBjb25jZXJuIHRoYXQNCj4g
YW55dGhpbmcgdWFjY2VzcyByZWxhdGVkIGJlbG9uZ3Mgd2l0aCB0aGUgcmVzdCBvZiB0aGUgdWFj
Y2VzcyBjb2RlDQo+IFsyXS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9saXN0cy4wMS5vcmcvcGlwZXJt
YWlsL2xpbnV4LW52ZGltbS8yMDE3LUphbnVhcnkvMDA4MzY0Lg0KPiBodG1sDQo+IFsyXTogaHR0
cHM6Ly9saXN0cy4wMS5vcmcvcGlwZXJtYWlsL2xpbnV4LW52ZGltbS8yMDE3LUFwcmlsLzAwOTk0
Mi5odA0KPiBtbA0KPiANCj4gQ2M6IDx4ODZAa2VybmVsLm9yZz4NCj4gQ2M6IEphbiBLYXJhIDxq
YWNrQHN1c2UuY3o+DQo+IENjOiBKZWZmIE1veWVyIDxqbW95ZXJAcmVkaGF0LmNvbT4NCj4gQ2M6
IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+DQo+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBD
YzogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+DQo+IENjOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gQ2M6IE1hdHRoZXcgV2lsY294IDxtYXdpbGNveEBt
aWNyb3NvZnQuY29tPg0KPiBDYzogUm9zcyBad2lzbGVyIDxyb3NzLnp3aXNsZXJAbGludXguaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGlu
dGVsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdGhlIGluaXRpYWwgUkZDOg0KPiAqIHMv
d3JpdGV0aHJ1L3d0LyBzaW5jZSB3ZSBhbHJlYWR5IGhhdmUgaW9yZW1hcF93dCgpLA0KPiBzZXRf
bWVtb3J5X3d0KCksIGV0Yy4gKEluZ28pDQoNClNvcnJ5IEkgc2hvdWxkIGhhdmUgc2FpZCBlYXJs
aWVyLCBidXQgSSB0aGluayB0aGUgdGVybSAid3QiIGlzDQptaXNsZWFkaW5nLiAgTm9uLXRlbXBv
cmFsIHN0b3JlcyB1c2VkIGluIG1lbWNweV93dCgpIHByb3ZpZGUgV0MNCnNlbWFudGljcywgbm90
IFdUIHNlbWFudGljcy4gIEhvdyBhYm91dCB1c2luZyAibm9jYWNoZSIgYXMgaXQncyBiZWVuDQp1
c2VkIGluIF9fY29weV91c2VyX25vY2FjaGUoKT8NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
