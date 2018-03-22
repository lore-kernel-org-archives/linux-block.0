Return-Path: <prvs=6124e0dd9=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Delete gendisk before cleaning up the request
 queue
Date: Thu, 22 Mar 2018 16:59:20 +0000
Message-ID: <1521737959.2637.7.camel@wdc.com>
References: <1521716176-20731-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1521716176-20731-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTIyIGF0IDE4OjU2ICswODAwLCBTaGF3biBMaW4gd3JvdGU6DQo+IGRk
IGlmPS9kZXYvdXJhbmRvbSBvZj0vZGV2L21tY2JsazEgYnM9NGsgY291bnQ9MTAwMDANCj4gd2l0
aCBhIFNEIGNhcmQgaG90cGx1ZyBkdXJpbmcgdHJhbnNmZXIgcmVwb3J0cyBhIHdhcm5pbmcgYmVs
b3cNCj4gaW50cm9kdWNlZCBieSBjb21taXQgYTA2MzA1N2Q3YzczICgiYmxvY2s6IEZpeCBhIHJh
Y2UgYmV0d2Vlbg0KPiByZXF1ZXN0IHF1ZXVlIHJlbW92YWwgYW5kIHRoZSBibG9jayBjZ3JvdXAg
Y29udHJvbGxlciIpLiBTbyB3ZQ0KPiBzaG91bGQgbm93IHJlbW92ZSB0aGUgZGlzaywgcGFydGl0
aW9uIGFuZCBiZGkgc3lzZnMgYXR0cmlidXRlcw0KPiBiZWZvcmUgY2xlYW5pbmcgdXAgdGhlIHJl
cXVlc3QgcXVldWUgYXNzb2NpYXRlZCB3aXRoIHRoZSBkaXNrLg0KDQpTaW5jZSBkZWxfZ2VuZGlz
aygpIG1heSBzdWJtaXQgSS9PIGNhbGxpbmcgYmxrX2NsZWFudXBfcXVldWUoKSBiZWZvcmUNCmRl
bF9nZW5kaXNrKCkgaGFzIG5ldmVyIGJlZW4gc2FmZSBzbyB0aGlzIHJlcXVpcmVtZW50IGlzIG5v
dCByZWFsbHkgbmV3Lg0KQW55d2F5LCB0aGFua3MgZm9yIHRoaXMgcGF0Y2guDQoNClJldmlld2Vk
LWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0K
