Return-Path: <prvs=590d2a92c=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] Fix races between blkcg code and request queue
 initialization and cleanup
Date: Wed, 28 Feb 2018 19:01:33 +0000
Message-ID: <1519844492.2777.11.camel@wdc.com>
References: <20180228181533.29402-1-bart.vanassche@wdc.com>
	 <5fe43ee3-2982-6d6d-2461-519fa02d00cd@kernel.dk>
In-Reply-To: <5fe43ee3-2982-6d6d-2461-519fa02d00cd@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTAyLTI4IGF0IDExOjE5IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBE
aWRuJ3QgTWluZyBhY2sgdGhlIGZpcnN0IHRocmVlPw0KDQpIZWxsbyBKZW5zLA0KDQpUaGlzIG1v
cm5pbmcgSSBkaWQgd2hhdCBJIHVzdWFsbHkgZG8gYmVmb3JlIEkgcmVwb3N0IGEgcGF0Y2ggc2Vy
aWVzLCBuYW1lbHkgdG8NCmxvb2sgYXQgdGhlIHJlcGxpZXMgdG8gaW5kaXZpZHVhbCBwYXRjaGVz
IGZvciByZXZpZXdlZC1ieSB0YWdzLiBUaGF0J3MgaG93IEkNCm92ZXJsb29rZWQgdGhlIGZvbGxv
d2luZyAoc2VlIGFsc28gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtYmxvY2smbT0xNTE5NDc2
Mjg0MTgyMTMpOg0KDQoiRm9yIHBhdGNoZXMgMSB+IDM6IFJldmlld2VkLWJ5OiBNaW5nIExlaSA8
bWluZy5sZWlAcmVkaGF0LmNvbT4iDQoNCkRvIHlvdSB3YW50IG1lIHRvIHJlcG9zdCB0aGlzIHNl
cmllcz8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0KDQo=
