Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq-sched: don't run the queue async from
 blk_mq_try_issue_directly()
Date: Tue, 14 Mar 2017 15:17:07 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0EC183@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <3ac4f49e-3bc0-7fc6-e93a-db9ec7ad21cf@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/14/2017 07:57 AM, Jens Axboe wrote:=0A=
> If we have scheduling enabled, we jump directly to insert-and-run.=0A=
> That's fine, but we run the queue async and we don't pass in information=
=0A=
> on whether we can block from this context or not. Fixup both these=0A=
> cases.=0A=
=0A=
How about renaming "can_block" into "may_sleep"? Otherwise this patch=0A=
looks fine to me.=0A=
=0A=
Bart.=0A=
