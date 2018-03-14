Return-Path: <linux-scsi-owner@vger.kernel.org>
From: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
To: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        "mroos@linux.ee" <mroos@linux.ee>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH V5 1/5] scsi: hpsa: fix selection of reply queue
Date: Wed, 14 Mar 2018 15:07:10 +0000
Message-ID: <1521040030.20980.228.camel@intel.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
         <20180313094243.8710-2-ming.lei@redhat.com>
In-Reply-To: <20180313094243.8710-2-ming.lei@redhat.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAzLTEzIGF0IDE3OjQyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gRnJv
bSA4NDY3NmMxZjIxIChnZW5pcnEvYWZmaW5pdHk6IGFzc2lnbiB2ZWN0b3JzIHRvIGFsbCBwb3Nz
aWJsZSBDUFVzKSwNCj4gb25lIG1zaXggdmVjdG9yIGNhbiBiZSBjcmVhdGVkIHdpdGhvdXQgYW55
IG9ubGluZSBDUFUgbWFwcGVkLCB0aGVuIG9uZQ0KPiBjb21tYW5kJ3MgY29tcGxldGlvbiBtYXkg
bm90IGJlIG5vdGlmaWVkLg0KPiANCj4gVGhpcyBwYXRjaCBzZXR1cHMgbWFwcGluZyBiZXR3ZWVu
IGNwdSBhbmQgcmVwbHkgcXVldWUgYWNjb3JkaW5nIHRvIGlycQ0KPiBhZmZpbml0eSBpbmZvIHJl
dHJpdmVkIGJ5IHBjaV9pcnFfZ2V0X2FmZmluaXR5KCksIGFuZCB1c2VzIHRoaXMgbWFwcGluZw0K
PiB0YWJsZSB0byBjaG9vc2UgcmVwbHkgcXVldWUgZm9yIHF1ZXVpbmcgb25lIGNvbW1hbmQuDQo+
IA0KPiBUaGVuIHRoZSBjaG9zZW4gcmVwbHkgcXVldWUgaGFzIHRvIGJlIGFjdGl2ZSwgYW5kIGZp
eGVzIElPIGhhbmcgY2F1c2VkDQo+IGJ5IHVzaW5nIGluYWN0aXZlIHJlcGx5IHF1ZXVlIHdoaWNo
IGRvZXNuJ3QgaGF2ZSBhbnkgb25saW5lIENQVSBtYXBwZWQuDQo+IA0KPiBDYzogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IENjOiAiTWFydGluIEsuIFBldGVyc2VuIiA8bWFydGlu
LnBldGVyc2VuQG9yYWNsZS5jb20+LA0KPiBDYzogSmFtZXMgQm90dG9tbGV5IDxqYW1lcy5ib3R0
b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tPiwNCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPiwNCj4gQ2M6IERvbiBCcmFjZSA8ZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb20+DQo+
IENjOiBLYXNoeWFwIERlc2FpIDxrYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbT4NCj4gQ2M6IExh
dXJlbmNlIE9iZXJtYW4gPGxvYmVybWFuQHJlZGhhdC5jb20+DQo+IENjOiBNZWVsaXMgUm9vcyA8
bXJvb3NAbGludXguZWU+DQo+IENjOiBBcnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5
QGludGVsLmNvbT4NCj4gQ2M6IE1pa2UgU25pdHplciA8c25pdHplckByZWRoYXQuY29tPg0KPiBU
ZXN0ZWQtYnk6IExhdXJlbmNlIE9iZXJtYW4gPGxvYmVybWFuQHJlZGhhdC5jb20+DQo+IFRlc3Rl
ZC1ieTogRG9uIEJyYWNlIDxkb24uYnJhY2VAbWljcm9zZW1pLmNvbT4NCj4gVGVzdGVkLWJ5OiBB
cnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGludGVsLmNvbT4NCj4gQWNrZWQtYnk6
IERvbiBCcmFjZSA8ZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb20+DQo+IEZpeGVzOiA4NDY3NmMxZjIx
ZTggKCJnZW5pcnEvYWZmaW5pdHk6IGFzc2lnbiB2ZWN0b3JzIHRvIGFsbCBwb3NzaWJsZSBDUFVz
IikNCj4gU2lnbmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQoNCkNo
ZWNrZWQgdjUgbXkgU2t5bGFrZSBYZW9uIGFuZCB3aXRoIHRoaXMgcGF0Y2ggdGhlIHJlZ3Jlc3Np
b24gdGhhdCBJDQpyZXBvcnRlZCBpcyBmaXhlZC4NCg0KVGVzdGVkLWJ5OiBBcnRlbSBCaXR5dXRz
a2l5IDxhcnRlbS5iaXR5dXRza2l5QGludGVsLmNvbT4NCkxpbms6IGh0dHBzOi8vbGttbC5rZXJu
ZWwub3JnL3IvMTUxOTMxMTI3MC4yNTM1LjUzLmNhbWVsQGludGVsLmNvbQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
SW50ZWwgRmlubGFuZCBPeQpSZWdpc3RlcmVkIEFkZHJlc3M6IFBMIDI4MSwgMDAxODEgSGVsc2lu
a2kgCkJ1c2luZXNzIElkZW50aXR5IENvZGU6IDAzNTc2MDYgLSA0IApEb21pY2lsZWQgaW4gSGVs
c2lua2kgCgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZp
ZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2Ug
Y29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllcy4K
