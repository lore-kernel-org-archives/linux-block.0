Return-Path: <javier@cnexlabs.com>
From: Javier Gonzalez <javier@cnexlabs.com>
To: Jens Axboe <axboe@kernel.dk>
CC: =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
	"mb@lightnvm.io" <mb@lightnvm.io>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date: Thu, 2 Aug 2018 16:01:32 +0000
Message-ID: <E290F3A7-B98F-498C-9969-B7584F340B9A@cnexlabs.com>
References: 
 <1533217674-9514-1-git-send-email-javier@cnexlabs.com>,<2436f855-7a87-9ecd-be3a-358939c9c750@kernel.dk>
In-Reply-To: <2436f855-7a87-9ecd-be3a-358939c9c750@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

DQoNCj4gT24gMiBBdWcgMjAxOCwgYXQgMTcuNTcsIEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4gd3JvdGU6DQo+IA0KPj4gT24gOC8yLzE4IDc6NDcgQU0sIEphdmllciBHb256w6FsZXogd3Jv
dGU6DQo+PiBUYWtlIHRoZSB3cml0ZSBzZW1hcGhvcmUgb24gbWV0YWRhdGEgSS9PcyB0b28uDQo+
IA0KPiBJJ20gZ29pbmcgdG8gbml0IHBpY2sgYSBsaXR0bGUgYml0IGhlcmUsIGJ1dCB0aGlzIGlz
bid0IGEgZ29vZA0KPiBjaGFuZ2Vsb2cgYXQgYWxsLiBBIGdvb2QgY2hhbmdlbG9nIHRlbGxzIHlv
dSBfd2h5XyBhIGNoYW5nZSBpcw0KPiBtYWRlLCBub3QgaG93IGl0J3MgbWFkZS4gWW91ciBjb21t
aXQgbWVzc2FnZSBkb2Vzbid0IHJlYWxseSB0ZWxsDQo+IG1lIGFueXRoaW5nIHRoYXQgSSBjYW4n
dCBlYXNpbHkgZ2xlYW4gZnJvbSBsb29raW5nIGF0IHRoZSBwYXRjaC4NCj4gDQo+IEEgZ29vZCBj
b21taXQgbWVzc2FnZSB3b3VsZCB0ZWxsIG1lIF93aHlfIHdlIGFyZSBub3cgYWxzbw0KPiBncmFi
YmluZyB0aGUgd3JpdGUgc2VtIGZvciBtZXRhZGF0YS4NCj4gDQo+IC0tIA0KPiBKZW5zIEF4Ym9l
DQo+IA0KDQpZb3XigJlyZSByaWdodC4gSeKAmWxsIGZpeCB0aGUgY29tbWl0IG1lc3NhZ2UgYW5k
IHJlc2VuZCB0b21vcnJvdy4gDQoNCkphdmllcg==
