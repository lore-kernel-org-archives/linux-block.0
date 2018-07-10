Return-Path: <prvs=72206ecb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mb@lightnvm.io" <mb@lightnvm.io>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"loberman@redhat.com" <loberman@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] null_blk: zone support
Date: Tue, 10 Jul 2018 18:49:17 +0000
Message-ID: <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
	 <1530899118.31977.1.camel@redhat.com>
	 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
	 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
	 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
	 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
	 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
	 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
In-Reply-To: <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA3LTEwIGF0IDEyOjQ1IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBU
aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBqb2IgZmlsZSBhbmQgdGhlDQo+IHdvcmtsb2FkIHJ1
biBjYW4gYmUgaHVnZS4gQ29uc2lkZXIgc29tZXRoaW5nIHJlYWxseSBiYXNpYzoNCj4gDQo+IFty
YW5kd3JpdGVzXQ0KPiBicz00aw0KPiBydz1yYW5kd3JpdGUNCj4gDQo+IHdoaWNoIHdvdWxkIGJl
IDEwMCUgcmFuZG9tIDRrIHdyaXRlcy4gSWYgSSBydW4gdGhpcyBvbiBhIHpvbmVkIGRldmljZSwN
Cj4gdGhlbiB0aGF0J2QgdHVybiBpbnRvIDEwMCUgc2VxdWVudGlhbCB3cml0ZXMuDQoNClRoYXQn
cyBub3QgY29ycmVjdC4gVGhlIFpCRCBjb2RlIGluIHRoZSBnaXRodWIgcHVsbCByZXF1ZXN0IHNl
cmlhbGl6ZXMgd3JpdGVzDQpwZXIgem9uZSwgbm90IGdsb2JhbGx5Lg0KDQo+ID4gV2hhdCBJIGRl
cml2ZWQgZnJvbSB0aGUgZmlvIHNvdXJjZSBjb2RlIGlzIGFzIGZvbGxvd3MgKHBsZWFzZSBjb3Jy
ZWN0IG1lDQo+ID4gaWYgSSBnb3QgYW55dGhpbmcgd3JvbmcpOg0KPiA+ICogVGhlIHB1cnBvc2Ug
b2YgdGhlIHpvbmVzaXplLCB6b25lcmFuZ2UgYW5kIHpvbmVza2lwIGpvYiBvcHRpb25zIGlzIHRv
DQo+ID4gICBsaW1pdCB0aGUgSS9PIHJhbmdlIHRvIGEgc2luZ2xlIHpvbmUgd2l0aCBzaXplICJ6
b25lc2l6ZSIuIFRoZSBJL08NCj4gPiAgIHBhdHRlcm4gZm9yIHpvbmVkIGJsb2NrIGRldmljZXMg
aXMgZGlmZmVyZW50OiBJL08gaGFwcGVucyBpbiBtdWx0aXBsZQ0KPiA+ICAgem9uZXMgc2ltdWx0
YW5lb3VzbHkuIFRoZSBudW1iZXIgb2Ygem9uZXMgdG8gd2hpY2ggSS9PIGhhcHBlbnMgaXMNCj4g
PiAgIGNhbGxlZCB0aGUgbnVtYmVyIG9mIG9wZW4gem9uZXMuDQo+IA0KPiBUaGUgb25seSBkaWZm
ZXJlbmNlIGlzIHRoYXQgZmlvIGN1cnJlbnRseSBvbmx5IGhhcyBvbmUgem9uZSBhY3RpdmUuIFdo
ZW4NCj4gaXQgZmluaXNoZXMgb25lLCBpdCBnb2VzIHRvIHRoZSBuZXh0LiBTZWUgbXkgYWJvdmUg
c3VnZ2VzdGlvbiBvbiBhZGRpbmcNCj4gdGhlIG5vdGlvbiBvZiBvcGVuIHpvbmVzLCB3aGljaCB3
b3VsZCBleHRlbmQgdGhpcyB0byBtb3JlIHRoYW4gMS4NCg0KVGhhbmtzLCBJIHdpbGwgbG9vayBp
bnRvIHRoaXMuDQoNCkJhcnQuDQoNCg0KDQoNCg0K
