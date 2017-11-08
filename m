Return-Path: <prvs=47882fd2f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "osandov@fb.com" <osandov@fb.com>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] blk-mq: fix issue with shared tag queue re-running
Date: Wed, 8 Nov 2017 23:43:09 +0000
Message-ID: <1510184588.8671.23.camel@wdc.com>
References: <98418e6d-2981-0fb7-dcdd-79b635955fcf@kernel.dk>
In-Reply-To: <98418e6d-2981-0fb7-dcdd-79b635955fcf@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTExLTA4IGF0IDE1OjQ4IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiAr
CSAqIFdlIGdvdCBhIHRhZywgcmVtb3ZlIG91dHNlbHZlcyBmcm9tIHRoZSB3YWl0IHF1ZXVlIHRv
IGVuc3VyZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl4NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb3Vyc2VsdmVzPw0KDQpBbnl3YXksIHNpbmNlIHRo
aXMgcGF0Y2ggZml4ZXMgYSBTQ1NJIHF1ZXVlIHN0YWxsIEkgcmFuIGludG8gcmVjZW50bHkNCihz
ZWUgYWxzbyBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2xpbnV4LXNjc2lAdmdlci5rZXJu
ZWwub3JnL21zZzY4MTkwLmh0bWwpOg0KDQpSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxi
YXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KVGVzdGVkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQu
dmFuYXNzY2hlQHdkYy5jb20+DQo=
