Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62109 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcETRfC (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 20 May 2016 13:35:02 -0400
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"toshi.kani@hpe.com" <toshi.kani@hpe.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"sandeen@sandeen.net" <sandeen@sandeen.net>,
	"david@fromorbit.com" <david@fromorbit.com>
CC: "micah.parrish@hpe.com" <micah.parrish@hpe.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"boaz@plexistor.com" <boaz@plexistor.com>
Subject: Re: [PATCH v4 0/6] Add alignment check for DAX mount
Date: Fri, 20 May 2016 17:34:59 +0000
Message-ID: <1463765696.3005.2.camel@intel.com>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
	 <f265e4ce-9271-1d83-35bc-794f2e2129df@sandeen.net>
	 <1463755257.32042.15.camel@hpe.com>
In-Reply-To: <1463755257.32042.15.camel@hpe.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE2LTA1LTIwIGF0IDE0OjUwICswMDAwLCBLYW5pLCBUb3NoaW1pdHN1IHdyb3Rl
Og0KPiBPbiBUaHUsIDIwMTYtMDUtMTkgYXQgMTg6MzcgLTA1MDAsIEVyaWMgU2FuZGVlbiB3cm90
ZToNCj4gPiANCj4gPiBPbiA1LzEwLzE2IDExOjIzIEFNLCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+IFdoZW4gYSBwYXJ0aXRpb24gaXMgbm90IGFsaWduZWQgYnkgNEtC
LCBtb3VudCAtbyBkYXggc3VjY2VlZHMsDQo+ID4gU29ycnkgZm9yIGJlaW5nIGxhdGUsIGJ1dCAt
DQo+ID4gDQo+ID4gU2hvdWxkbid0IHRoaXMgYW5kIGFsbCBzdWJzZXF1ZW50IHBhdGNoIGNvbW1p
dHMgcmVmZXIgdG8NCj4gPiBQQUdFX1NJWkUsIHJhdGhlciB0aGFuICI0a0I/Ig0KPiBSaWdodCwg
dGhlIHBhdGNoIGNvbW1pdHMgc2hvdWxkIHJlZmVyIHRvIFBBR0VfU0laRSB0byBtYXRjaCB3aXRo
IHRoZQ0KPiBjb2RlDQo+IGNoYW5nZXMuwqDCoEkgYW0gYWZyYWlkIGl0IG1heSBiZSBhIGJpdCB0
b28gbGF0ZSB0byB1cGRhdGUsIHRob3VnaC4uLg0KPiANCj4gVmlzaGFsLCBkbyB5b3UgdGhpbmsg
eW91IGNhbiB0d2VhayB0aGUgbG9ncywgIjRLQiIgdG8gIlBBR0VfU0laRSI/DQo+IA0KPiBUaGFu
a3MsDQo+IC1Ub3NoaQ0KDQpIaSBUb3NoaSwNCg0KSXMgaXQganVzdCBjb21taXQgbWVzc2FnZSBj
aGFuZ2VzPyBJZiBzbyBJJ20gbm90IHN1cmUgaXQgaXMgd29ydGh3aGlsZQ0KdG8gcmViYXNlIGV2
ZXJ5dGhpbmcgZm9yIHRoYXQgLSBpLmUuIG15IGRheCBlcnJvciBoYW5kbGluZyBzZXJpZXMgYW5k
DQpSb3NzJyBkYXgtbG9ja2luZyBicmFuY2ggd291bGQgYm90aCBoYXZlIHRvIGJlIHJlYmFzZWQu
Lg0KDQpJZiB0aGVyZSBhcmUgYW5kIGZpeGVzIGZvciBjb2RlLCB3ZSBjYW4gZG8gdGhlbSBhcyBh
biBhZGQtb24gcGF0Y2gNCnRob3VnaC4=
