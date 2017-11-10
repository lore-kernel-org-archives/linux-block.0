Return-Path: <prvs=4801c944a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: fix issue with shared tag queue re-running
Date: Fri, 10 Nov 2017 01:08:49 +0000
Message-ID: <1510276129.2608.31.camel@wdc.com>
References: <98418e6d-2981-0fb7-dcdd-79b635955fcf@kernel.dk>
	 <20171109034133.GA19098@ming.t460p> <20171109100036.GA17976@ming.t460p>
	 <2d03b95b-580b-4cb7-0a84-c4fc069e5efd@kernel.dk>
	 <2add8e70-f107-b8be-eefb-e6092d0effa6@kernel.dk>
In-Reply-To: <2add8e70-f107-b8be-eefb-e6092d0effa6@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE3LTExLTA5IGF0IDA5OjMyIC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBJ
dCdzIGJlZW4gcnVubmluZyBoYXBwaWx5IGZvciA+IDEgaG91ciBub3csIG5vIGlzc3VlcyBvYnNl
cnZlZC4NCg0KVGhlIHNhbWUgbnVsbF9ibGsgdGVzdCBydW5zIGZpbmUgb24gbXkgc2V0dXAuIEJ1
dCB3aGF0J3Mgd2VpcmQgaXMgdGhhdCBpZg0KSSBydW4gdGhlIHNycC10ZXN0IHNvZnR3YXJlIHRo
YXQgSSBhZ2FpbiBzZWUgYSBsb2NrdXAgaW4gc2RfcHJvYmVfYXN5bmMoKS4NClRoYXQgaGFwcGVu
cyBub3Qgb25seSB3aXRoIHRvZGF5J3MgZm9yLW5leHQgYnJhbmNoIGJ1dCBhbHNvIHdpdGggdGhl
IHNhbWUNCmtlcm5lbCB0cmVlIHdpdGggd2hpY2ggbXkgdGVzdHMgcGFzc2VkIHllc3RlcmRheSwg
d2hpY2ggaXMgd2VpcmQuIEkgd2lsbA0KYW5hbHl6ZSB0aGlzIGZ1cnRoZXIuDQoNCkJhcnQu
