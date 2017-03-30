Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>
Subject: Re: null_blk: add blocking mode
Date: Thu, 30 Mar 2017 19:33:22 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA12EC99@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <9a2b8d7e-1b04-4c94-2c79-c16fa8134f9d@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/30/2017 11:53 AM, Jens Axboe wrote:=0A=
> This adds a new module parameter to null_blk, blocking. If set, null_blk=
=0A=
> will set the BLK_MQ_F_BLOCKING flag, indicating that it sometimes/always=
=0A=
> needs to block in its ->queue_rq() function.  The intent is to help find=
=0A=
> regressions in blocking drivers, since not many of them exist.=0A=
> =0A=
> If null_blk is loaded with submit_queues > 1 and blocking=3D1, this=0A=
> shows the regression recently fixed by bf4907c05e61.=0A=
=0A=
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=0A=
