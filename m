Return-Path: <prvs=669193e76=Adam.Manzanares@wdc.com>
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "bcrl@kvack.org" <bcrl@kvack.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "rgoldwyn@suse.com"
	<rgoldwyn@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Date: Fri, 18 May 2018 19:54:04 +0000
Message-ID: <2e450c50-b4e0-4c41-0417-991c0f73973c@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-4-adam.manzanares@wdc.com>
 <20180518160636.GH22791@infradead.org>
In-Reply-To: <20180518160636.GH22791@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

DQoNCk9uIDUvMTgvMTggOTowNiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IExvb2tz
IGZpbmUsIGFsdGhvdWdoIEknZCBzcGxpdCBpdCBpbnRvIGEgYWlvIGFuZCBibG9ja19kZXYgcGF0
Y2guDQo+IA0KPiBBbHNvIHBsZWFzZSB3aXJlIHRoaXMgdXAgZm9yIHRoZSBmcy9pb21hcC5jIGRp
cmVjdCBJL08gY29kZSwgaXQgc2hvdWxkDQo+IGJlIGVzc2VudGlhbGx5IHRoZSBzYW1lIHNuaXBs
ZXQgYXMgaW4gdGhlIGJsb2NrX2Rldi5jIGNvZGUuDQo+IA0KDQpXaWxsIGRvLg==
