Return-Path: <prvs=562a2f801=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "gavin.dg@linux.alibaba.com" <gavin.dg@linux.alibaba.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC] hard LOCKUP caused by race between blk_init_queue_node and
 blkcg_print_blkgs
Date: Wed, 31 Jan 2018 16:39:17 +0000
Message-ID: <1517416756.2505.11.camel@wdc.com>
References: <5ac9562b-b20a-9f5a-90c5-2187552b6f09@linux.alibaba.com>
	 <1517347168.2589.56.camel@wdc.com>
	 <e34840cd-d317-b195-aad8-f32668608f1f@linux.alibaba.com>
In-Reply-To: <e34840cd-d317-b195-aad8-f32668608f1f@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTAxLTMxIGF0IDA5OjUzICswODAwLCBKb3NlcGggUWkgd3JvdGU6DQo+IEF0
IHRoZSBmaXJzdCBnbGFuY2UsIEknbSB0aGlua2luZyBvZiBtb3ZpbmcgdGhlIGJsa2NnX2luaXRf
cXVldWUgYWZ0ZXINCj4gdGhlIHF1ZXVlX2xvY2sgaXMgb3ZlcnJpZGRlbi4gQnV0IEkgZG9uJ3Qg
aGF2ZSBhbiBpZGVhIHlldCB0byBhdm9pZCB0aGUNCj4gcmlzayBkdXJpbmcgY2xlYW51cC4NCj4g
U2luY2UgdGhlIGluaXRpYWxpemF0aW9uIG9mIHJlcXVlc3QgcXVldWUgaXMgc28gZnVuZGFtZW50
YWwsIEknbSBub3QNCj4gc3VyZSBpZiB0aGVyZSBpcyB0aGUgc2FtZSByaXNrIGluIHNldmVyYWwg
b3RoZXIgcGxhY2VzLg0KDQpIZWxsbyBKb3NlcGgsDQoNCk1vdmluZyB0aGUgYmxrY2dfaW5pdF9x
dWV1ZSgpIGNhbGwgZnJvbSBibGtfYWxsb2NfcXVldWVfbm9kZSgpIGludG8NCmJsa19pbml0X2Fs
bG9jYXRlZF9xdWV1ZV9ub2RlKCkgd291bGQgZHJvcCBjZ3JvdXAgc3VwcG9ydCBmcm9tIGFsbCBi
bG9jaw0KZHJpdmVycyB0aGF0IGRvIG5vdCBjYWxsIGJsa19pbml0X2FsbG9jYXRlZF9xdWV1ZV9u
b2RlKCkuIEkgdGhpbmsgdGhlc2UNCmRyaXZlcnMgYXJlIGJyZCwgZHJiZCwgbnVsbF9ibGssIHBr
dGNkdmQsIHBzM3ZyYW0sIHJzeHgsIHVtZW0sIHpyYW0sDQpsaWdodG52bSwgYmNhY2hlLCBkbSBp
biBiaW8gbW9kZSwgbWQsIG52ZGltbSwgdGhlIE5WTWUgbXVsdGlwYXRoIGRyaXZlciwNCmRjc3Ni
bGsgYW5kIHhwcmFtLiBUaGVzZSBkcml2ZXJzIGNhbiBiZSBmb3VuZCBieSBzZWFyY2hpbmcgZm9y
DQpibGtfcXVldWVfbWFrZV9yZXF1ZXN0KCkgY2FsbHMgaW4gdGhlIGtlcm5lbCBzb3VyY2UgY29k
ZS4gSSdtIG5vdCBzdXJlIHdlDQpjYW4gZHJvcCBjZ3JvdXAgc3VwcG9ydCBmcm9tIGFsbCB0aGVz
ZSBibG9jayBkcml2ZXJzLg0KDQpCYXJ0Lg==
