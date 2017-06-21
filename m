Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] blk-mq: Make it safe to call
 blk_mq_quiesce_queue_nowait() from an interrupt handler
Date: Wed, 21 Jun 2017 01:51:06 +0000
Message-ID: <1498009865.4138.0.camel@wdc.com>
References: <20170620164020.18260-1-bart.vanassche@wdc.com>
	 <20170621014231.GA8382@ming.t460p> <20170621014633.GB8382@ming.t460p>
	 <98d22529-f462-09c0-f1cf-20cdc3eccff1@kernel.dk>
In-Reply-To: <98d22529-f462-09c0-f1cf-20cdc3eccff1@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTA2LTIwIGF0IDE5OjQ4IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBH
b29kIGNhdGNoLiBCYXJ0LCB3aWxsIHlvdSBzcGluIGEgdjI/DQoNCkhlbGxvIEplbnMsDQoNClRo
YXQncyB0aGUgZmlyc3QgdGFzayBJIHdpbGwgd29yayBvbiB0b21vcnJvdyBtb3JuaW5nLg0KDQpC
YXJ0Lg==
