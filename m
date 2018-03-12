Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62256 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbeCLHhn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Mar 2018 03:37:43 -0400
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
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue
Date: Mon, 12 Mar 2018 07:37:38 +0000
Message-ID: <1520840257.20980.98.camel@intel.com>
References: <20180309033218.23042-1-ming.lei@redhat.com>
         <20180309033218.23042-2-ming.lei@redhat.com>
In-Reply-To: <20180309033218.23042-2-ming.lei@redhat.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

TGludXgtUmVncmVzc2lvbi1JRDogbHIjMTVhMTE1DQoNCk9uIEZyaSwgMjAxOC0wMy0wOSBhdCAx
MTozMiArMDgwMCwgTWluZyBMZWkgd3JvdGU6DQo+IEZyb20gODQ2NzZjMWYyMSAoZ2VuaXJxL2Fm
ZmluaXR5OiBhc3NpZ24gdmVjdG9ycyB0byBhbGwgcG9zc2libGUgQ1BVcyksDQo+IG9uZSBtc2l4
IHZlY3RvciBjYW4gYmUgY3JlYXRlZCB3aXRob3V0IGFueSBvbmxpbmUgQ1BVIG1hcHBlZCwgdGhl
biBvbmUNCj4gY29tbWFuZCdzIGNvbXBsZXRpb24gbWF5IG5vdCBiZSBub3RpZmllZC4NCj4gDQo+
IFRoaXMgcGF0Y2ggc2V0dXBzIG1hcHBpbmcgYmV0d2VlbiBjcHUgYW5kIHJlcGx5IHF1ZXVlIGFj
Y29yZGluZyB0byBpcnENCj4gYWZmaW5pdHkgaW5mbyByZXRyaXZlZCBieSBwY2lfaXJxX2dldF9h
ZmZpbml0eSgpLCBhbmQgdXNlcyB0aGlzIG1hcHBpbmcNCj4gdGFibGUgdG8gY2hvb3NlIHJlcGx5
IHF1ZXVlIGZvciBxdWV1aW5nIG9uZSBjb21tYW5kLg0KPiANCj4gVGhlbiB0aGUgY2hvc2VuIHJl
cGx5IHF1ZXVlIGhhcyB0byBiZSBhY3RpdmUsIGFuZCBmaXhlcyBJTyBoYW5nIGNhdXNlZA0KPiBi
eSB1c2luZyBpbmFjdGl2ZSByZXBseSBxdWV1ZSB3aGljaCBkb2Vzbid0IGhhdmUgYW55IG9ubGlu
ZSBDUFUgbWFwcGVkLg0KPiANCj4gQ2M6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0K
PiBDYzogIk1hcnRpbiBLLiBQZXRlcnNlbiIgPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPiwN
Cj4gQ2M6IEphbWVzIEJvdHRvbWxleSA8amFtZXMuYm90dG9tbGV5QGhhbnNlbnBhcnRuZXJzaGlw
LmNvbT4sDQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4sDQo+IENjOiBEb24g
QnJhY2UgPGRvbi5icmFjZUBtaWNyb3NlbWkuY29tPg0KPiBDYzogS2FzaHlhcCBEZXNhaSA8a2Fz
aHlhcC5kZXNhaUBicm9hZGNvbS5jb20+DQo+IENjOiBMYXVyZW5jZSBPYmVybWFuIDxsb2Jlcm1h
bkByZWRoYXQuY29tPg0KPiBDYzogTWVlbGlzIFJvb3MgPG1yb29zQGxpbnV4LmVlPg0KPiBDYzog
QXJ0ZW0gQml0eXV0c2tpeSA8YXJ0ZW0uYml0eXV0c2tpeUBpbnRlbC5jb20+DQo+IENjOiBNaWtl
IFNuaXR6ZXIgPHNuaXR6ZXJAcmVkaGF0LmNvbT4NCj4gVGVzdGVkLWJ5OiBMYXVyZW5jZSBPYmVy
bWFuIDxsb2Jlcm1hbkByZWRoYXQuY29tPg0KPiBUZXN0ZWQtYnk6IERvbiBCcmFjZSA8ZG9uLmJy
YWNlQG1pY3Jvc2VtaS5jb20+DQo+IEZpeGVzOiA4NDY3NmMxZjIxZTggKCJnZW5pcnEvYWZmaW5p
dHk6IGFzc2lnbiB2ZWN0b3JzIHRvIGFsbCBwb3NzaWJsZSBDUFVzIikNCj4gU2lnbmVkLW9mZi1i
eTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQoNClRlc3RlZC1ieTogQXJ0ZW0gQml0
eXV0c2tpeSA8YXJ0ZW0uYml0eXV0c2tpeUBpbnRlbC5jb20+DQpMaW5rOiBodHRwczovL2xrbWwu
a2VybmVsLm9yZy9yLzE1MTkzMTEyNzAuMjUzNS41My5jYW1lbEBpbnRlbC5jb20NCg0KVGhlc2Ug
MiBwYXRjaGVzIG1ha2UgdGhlIERlbGwgUjY0MCByZWdyZXNzaW9uIHRoYXQgSSByZXBvcnRlZCBn
byBhd2F5Lg0KVGVzdGVkIG9uIHRvcCBvZiB2NC4xNi1yYzUsIHRoYW5rcyENCg0KLS0gDQpCZXN0
IFJlZ2FyZHMsDQpBcnRlbSBCaXR5dXRza2l5Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBGaW5sYW5kIE95
ClJlZ2lzdGVyZWQgQWRkcmVzczogUEwgMjgxLCAwMDE4MSBIZWxzaW5raSAKQnVzaW5lc3MgSWRl
bnRpdHkgQ29kZTogMDM1NzYwNiAtIDQgCkRvbWljaWxlZCBpbiBIZWxzaW5raSAKClRoaXMgZS1t
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFs
IGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmll
dyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5k
ZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=
