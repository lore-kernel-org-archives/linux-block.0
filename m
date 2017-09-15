Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3 06/12] scsi: sd_zbc: Rearrange code
Date: Fri, 15 Sep 2017 14:51:03 +0000
Message-ID: <1505487062.2852.12.camel@wdc.com>
References: <20170915100645.17999-1-damien.lemoal@wdc.com>
	 <20170915100645.17999-7-damien.lemoal@wdc.com>
In-Reply-To: <20170915100645.17999-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE3LTA5LTE1IGF0IDE5OjA2ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gUmVhcnJhbmdlIHNkX3piY19zZXR1cCgpIHRvIGluY2x1ZGUgdXNlXzE2X2Zvcl9ydyBhbmQg
dXNlXzEwX2Zvcl9ydw0KPiBhc3NpZ25tZW50cyBhbmQgbW92ZSB0aGUgY2FsY3VsYXRpb24gb2Yg
c2RrcC0+em9uZV9zaGlmdCB0b2dldGhlcg0KPiB3aXRoIHRoZSBhc3NpZ25tZW50IG9mIHRoZSB2
ZXJpZmllZCB6b25lX2Jsb2NrcyB2YWx1ZSBpbg0KPiBzZF96YmNfY2hlY2tfem9uZV9zaXplKCku
DQoNCkJvdGggZnVuY3Rpb25zIGFyZSBjYWxsZWQgZnJvbSBpbnNpZGUgYmxvY2tfZGV2aWNlX29w
ZXJhdGlvbnMucmV2YWxpZGF0ZV9kaXNrLg0KSXNuJ3QgdGhhdCB0b28gbGF0ZSB0byBzZXQgdXNl
XzFbMDZdX2Zvcl9ydz8gU2hvdWxkbid0IGJvdGggYmUgc2V0IGp1c3QgYWZ0ZXINCnRoZSBzbGF2
ZV9hbGxvYyBjYWxsYmFjayBoYXMgYmVlbiBjYWxsZWQ/DQoNClRoYW5rcywNCg0KQmFydC4=
