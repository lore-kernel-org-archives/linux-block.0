Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>, "osandov@osandov.com"
	<osandov@osandov.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: Fix poll_stat for new size-based bucketing.
Date: Thu, 20 Apr 2017 23:13:46 +0000
Message-ID: <8F6E7173-D719-4E85-9F18-7B20319E972C@raithlin.com>
References: <1492729151-20983-1-git-send-email-sbates@raithlin.com>
 <44a0b09e-d150-a0e8-f5e2-5792f4d4f74a@kernel.dk>
In-Reply-To: <44a0b09e-d150-a0e8-f5e2-5792f4d4f74a@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

DQo+IFRoYW5rcywgYWRkZWQuIEJUVywgaW4gdGhlIGZ1dHVyZSwgd2UgaGF2ZSBhIGZvcm1hdCBm
b3Igc3BlY2lmeWluZw0KPiBpZiBhIHBhdGNoIGZpeGVzIGFub3RoZXIgcGF0Y2guIFRoaXMgc2hv
dWxkIGhhdmUgYmVlbjoNCg0KVGhhbmtzIQ0KDQo+IEZpeGVzOiA3MjBiOGNjYzQ1MDAgKCJibGst
bXE6IEFkZCBhIHBvbGxpbmcgc3BlY2lmaWMgc3RhdHMgZnVuY3Rpb24iKQ0KDQpEdWx5IG5vdGVk
IGZvciBuZXh0IHRpbWUuIEFwb2xvZ2llcyBmb3IgdGhlIG1pc3PigKYNCg0KDQoNCg==
