Return-Path: <prvs=686e31ba0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
Date: Mon, 4 Jun 2018 08:59:39 +0000
Message-ID: <f9d3387040d554fdcb07e32737c56f14e61151b1.camel@wdc.com>
References: <20180522235505.20937-1-bart.vanassche@wdc.com>
	 <20180523013020.GA12391@kmo-pixel>
	 <65261494f966d140a7542fb1533a4dd2f7fd02a1.camel@wdc.com>
	 <20180523021607.GB12391@kmo-pixel>
In-Reply-To: <20180523021607.GB12391@kmo-pixel>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDIyOjE2IC0wNDAwLCBLZW50IE92ZXJzdHJlZXQgd3JvdGU6
DQo+IE1heSAyMiAyMjoxMzo0NiBtb3JpYS1rdm0ta3ZtLWt2bS1rdm0gbXVsdGlwYXRoZFszODdd
OiBzZGE6IGZhaWwgdG8gZ2V0IHNlcmlhbA0KPiBNYXkgMjIgMjI6MTM6NDYgbW9yaWEta3ZtLWt2
bS1rdm0ta3ZtIG11bHRpcGF0aGRbMzg3XTogc2RhOiB1c2luZyBkZXByZWNhdGVkDQo+IGdldHVp
ZCBjYWxsb3V0DQo+IE1heSAyMiAyMjoxMzo0NiBtb3JpYS1rdm0ta3ZtLWt2bS1rdm0gbXVsdGlw
YXRoZFszODddOg0KPiAvLi4uL3NycC10ZXN0L2Jpbi9nZXR1aWRfY2FsbG91dCBleGl0ZWQgd2l0
aCAyNTUNCg0KKGJhY2sgZnJvbSB0cmF2ZWxpbmcpDQoNCkhlbGxvIEtlbnQsDQoNClBsZWFzZSBj
b21tZW50IG91dCB0aGUgZ2V0dWlkX2NhbGxvdXQgbGluZSBmcm9tIC9ldGMvbXVsdGlwYXRoLmNv
bmYgYW5kIHRyeSBhZ2Fpbi4NCkNoYW5naW5nIHRoZSAiLy4uLiIgcGFydCBpbnRvIHRoZSBwYXRo
IG9mIHRoZSBzcnAtdGVzdCBzb2Z0d2FyZSBzaG91bGQgYWxzbyBoZWxwLg0KVGhhdCBsaW5lIGlz
IGEgbGVmdC1vdmVyIGZyb20gdGhlIHRpbWUgd2hlbiB0aGUgTlZNZSBpbml0aWF0b3IgZHJpdmVy
cyBzdXBwb3J0ZWQNCmRtLW11bHRpcGF0aC4gSSB3aWxsIHVwZGF0ZSB0aGUgc3JwLXRlc3QgUkVB
RE1FLm1kIHRvIG1ha2UgdGhpcyBtb3JlIGNsZWFyLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
