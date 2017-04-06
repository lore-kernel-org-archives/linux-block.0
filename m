Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"longli@microsoft.com" <longli@microsoft.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "sthemmin@microsoft.com" <sthemmin@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>
Subject: Re: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Thu, 6 Apr 2017 03:45:36 +0000
Message-ID: <1491450335.8994.1.camel@sandisk.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
	 <1491438735.2787.18.camel@sandisk.com>
	 <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE3LTA0LTA2IGF0IDAzOjM4ICswMDAwLCBMb25nIExpIHdyb3RlOg0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQmFydCBWYW4gQXNzY2hlIFttYWls
dG86QmFydC5WYW5Bc3NjaGVAc2FuZGlzay5jb21dDQo+ID4gDQo+ID4gUGxlYXNlIGRyb3AgdGhp
cyBwYXRjaC4gSSdtIHdvcmtpbmcgb24gYSBiZXR0ZXIgc29sdXRpb24uDQo+IA0KPiBUaGFuayB5
b3UuIExvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHBhdGNoLg0KDQpIZWxsbyBMb25nLA0KDQpJdCB3
b3VsZCBoZWxwIGlmIHlvdSBjb3VsZCBzaGFyZSB0aGUgbmFtZSBvZiB0aGUgYmxvY2sgb3IgU0NT
SSBkcml2ZXIgd2l0aA0Kd2hpY2ggeW91IHJhbiBpbnRvIHRoYXQgbG9ja3VwIGFuZCBhbHNvIGlm
IHlvdSBjb3VsZCBzaGFyZSB0aGUgbmFtZSBvZiB0aGUNCkkvTyBzY2hlZHVsZXIgdXNlZCBpbiB5
b3VyIHRlc3QuDQoNClRoYW5rcywNCg0KQmFydC4=
