Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "broonie@kernel.org" <broonie@kernel.org>,
	"avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>, "tj@kernel.org"
	<tj@kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
Date: Sat, 18 Mar 2017 17:46:47 +0000
Message-ID: <1489859192.2339.12.camel@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
	 <1488848390.3125.14.camel@sandisk.com>
	 <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
	 <1489509154.2676.6.camel@sandisk.com>
	 <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org>
	 <CACRpkdZhA8FY2FH_fnTsnPotZoZwX5qUfhdavWLwfzcnLkZUMQ@mail.gmail.com>
In-Reply-To: <CACRpkdZhA8FY2FH_fnTsnPotZoZwX5qUfhdavWLwfzcnLkZUMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE3LTAzLTE4IGF0IDE4OjA5ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBTYXQsIE1hciAxOCwgMjAxNyBhdCAxMTo1MiBBTSwgUGFvbG8gVmFsZW50ZQ0KPiA8cGFv
bG8udmFsZW50ZUBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiA+IElsIGdpb3JubyAxNCBtYXIgMjAx
NywgYWxsZSBvcmUgMTY6MzIsIEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAc2FuZGlz
ay5jb20+IGhhIHNjcml0dG86DQo+ID4gPiAoLi4uKSB3aGF0IHNob3VsZA0KPiA+ID4gYSBkZXZl
bG9wZXIgZG8gd2hvIG9ubHkgaGFzIGFjY2VzcyB0byBhIHNtYWxsIHN1YnNldCBvZiBhbGwgdGhl
IHN0b3JhZ2UNCj4gPiA+IGRldmljZXMgdGhhdCBhcmUgc3VwcG9ydGVkIGJ5IHRoZSBMaW51eCBr
ZXJuZWwgYW5kIGhlbmNlIHdobyBjYW4gbm90IHJ1biB0aGUNCj4gPiA+IGJlbmNobWFyayBhZ2Fp
bnN0IGV2ZXJ5IHN1cHBvcnRlZCBzdG9yYWdlIGRldmljZT8NCj4gDQo+IERvbid0IHdlIHVzZSB0
aGUgY29tbXVuaXR5IGZvciB0aGF0PyBXZSBhcmUgZGVwZW5kZW50IG9uIHBlb3BsZQ0KPiBkb3du
bG9hZGluZyBhbmQgdGVzdGluZyBvdXIgY29kZSBldmVudHVhbGx5LCBJIG1lYW4gc3VyZSBpdCdz
IGdvb2QgaWYNCj4gd2UgbWFrZSBzb21lIHJlYXNvbmFibGUgZWZmb3J0IHRvIHRlc3QgY2hhbmdl
cyB3ZSBkbywgYnV0IHdlIGFyZQ0KPiBvbmx5IGh1bWFucywgYW5kIHdlIGdldCBjb3JyZWN0ZWQg
YnkgdGhlIGV4cGVyaWVuY2Ugb2Ygb3RoZXIgaHVtYW5zLg0KDQpIZWxsbyBMaW51cywNCg0KRG8g
eW91IG1lYW4gcmVseWluZyBvbiB0aGUgY29tbXVuaXR5IHRvIHRlc3Qgb3RoZXIgc3RvcmFnZSBk
ZXZpY2VzIGJlZm9yZQ0Kb3IgYWZ0ZXIgYSBwYXRjaCBpcyB1cHN0cmVhbT8gUmVseWluZyBvbiB0
aGUgY29tbXVuaXR5IHRvIGZpbGUgYnVnIHJlcG9ydHMNCmFmdGVyIGEgcGF0Y2ggaXMgdXBzdHJl
YW0gd291bGQgYmUgd3JvbmcuIFRoZSBMaW51eCBrZXJuZWwgc2hvdWxkIG5vdCBiZQ0KdXNlZCBm
b3IgZXhwZXJpbWVudHMuIEFzIHlvdSBrbm93IHBhdGNoZXMgdGhhdCBhcmUgc2VudCB1cHN0cmVh
bSBzaG91bGQNCm5vdCBpbnRyb2R1Y2UgcmVncmVzc2lvbnMuDQoNCk15IHByaW1hcnkgY29uY2Vy
biBhYm91dCBCRlEgaXMgdGhhdCBpdCBpcyBhIHZlcnkgY29tcGxpY2F0ZWQgSS9PIHNjaGVkdWxl
cg0KYW5kIGFsc28gdGhhdCB0aGUgY29uY2VwdHMgdXNlZCBpbnRlcm5hbGx5IGluIHRoYXQgSS9P
IHNjaGVkdWxlciBhcmUgZmFyDQphd2F5IGZyb20gdGhlIGNvbmNlcHRzIHdlIGFyZSB1c2VkIHRv
IHdoZW4gcmVhc29uaW5nIGFib3V0IEkvTyBkZXZpY2VzLiBJJ20NCmNvbmNlcm5lZCB0aGF0IHRo
aXMgd2lsbCBtYWtlIHRoZSBCRlEgSS9PIHNjaGVkdWxlciBoYXJkIHRvIG1haW50YWluLg0KDQpC
YXJ0Lg==
