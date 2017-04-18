Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>
CC: "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "yanaijie@huawei.com"
	<yanaijie@huawei.com>, "miaoxie@huawei.com" <miaoxie@huawei.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Date: Tue, 18 Apr 2017 14:07:53 +0000
Message-ID: <1492524472.2628.3.camel@sandisk.com>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
	 <20170418073526.GA6056@linux-x5ow.site>
In-Reply-To: <20170418073526.GA6056@linux-x5ow.site>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTA0LTE4IGF0IDA5OjM1ICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIE1vbiwgQXByIDE3LCAyMDE3IGF0IDA0OjEwOjAzUE0gLTA3MDAsIEJhcnQgVmFu
IEFzc2NoZSB3cm90ZToNCj4gPiBUaGUgZ2xvYmFsIHZhcmlhYmxlICdyZF9zaXplJyBpcyBkZWNs
YXJlZCBhcyAnaW50JyBpbiBzb3VyY2UgZmlsZQ0KPiA+IGFyY2gvYXJtL2tlcm5lbC9hdGFnc19w
YXJzZS5jIGFuZCBhcyAndW5zaWduZWQgbG9uZycgaW4NCj4gPiBkcml2ZXJzL2Jsb2NrL2JyZC5j
LiBGaXggdGhpcyBpbmNvbnNpc3RlbmN5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhcnQg
VmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAc2FuZGlzay5jb20+DQo+ID4gQ2M6IFJ1c3NlbGwg
S2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPg0KPiA+IENjOiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+DQo+ID4gQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+ID4gQ2M6IDx5YW5h
aWppZUBodWF3ZWkuY29tPg0KPiA+IENjOiA8emhhb2hvbmdqaWFuZ0BodWF3ZWkuY29tPg0KPiA+
IENjOiA8bWlhb3hpZUBodWF3ZWkuY29tPg0KPiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gPiBDYzogbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnDQo+ID4g
LS0tDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnJkLmggYi9pbmNsdWRlL2xpbnV4
L2JyZC5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LmRiYjBmOTJmZWZjOA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L2JyZC5oDQo+ID4gQEAgLTAsMCArMSBAQA0KPiA+ICtleHRlcm4gdW5zaWduZWQgbG9uZyByZF9z
aXplOw0KPiANCj4gU21hbGwgbml0LCBjYW4geW91IGFkZCBhbiBpbmNsdWRlIGd1YXJkIGhlcmUg
YXMgd2VsbD8NCg0KSGVsbG8gSm9oYW5uZXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gQnV0
IGFyZSB5b3UgYXdhcmUgdGhhdCB3aXRoIHRoZSBjdXJyZW50IGNvbnRlbnQgYW4NCmluY2x1ZGUg
Z3VhcmQgaXMgb3ZlcmtpbGwgYmVjYXVzZSBpdCBpcyBzYWZlIHRvIGV2YWx1YXRlIHRoZSAiZXh0
ZXJuIHVuc2lnbmVkDQpsb25nIHJkX3NpemUiIGRlY2xhcmF0aW9uIG11bHRpcGxlIHRpbWVzPw0K
DQpCYXJ0Lg==
