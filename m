Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
Date: Thu, 27 Jul 2017 14:47:28 +0000
Message-ID: <1501166846.2516.1.camel@wdc.com>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
	 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
In-Reply-To: <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-07-27 at 08:02 -0600, Jens Axboe wrote:
> The bug looks like SCSI running the queue inline from IRQ
> context, that's not a good idea. Can you confirm the below works for
> you?
>=20
>=20
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f6097b89d5d3..78740ebf966c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -497,7 +497,7 @@ static void scsi_run_queue(struct request_queue *q)
>  		scsi_starved_list_run(sdev->host);
> =20
>  	if (q->mq_ops)
> -		blk_mq_run_hw_queues(q, false);
> +		blk_mq_run_hw_queues(q, true);
>  	else
>  		blk_run_queue(q);
>  }

Hello Jens,

scsi_run_queue() works fine if no scheduler is configured. Additionally, th=
at
code predates the introduction of blk-mq I/O schedulers. I think it is
nontrivial for block driver authors to figure out that a queue has to be ru=
n
from process context if a scheduler has been configured that does not suppo=
rt
to be run from interrupt context. How about adding WARN_ON_ONCE(in_interrup=
t())
to blk_mq_start_hw_queue() or replacing the above patch by the following:


Subject: [PATCH] blk-mq: Make it safe to call blk_mq_start_hw_queues() from=
 interrupt context

blk_mq_start_hw_queues() triggers a queue run. Some functions that
get called to run a queue, e.g. dd_dispatch_request(), are not IRQ-safe.
Hence run the queue asynchronously if blk_mq_start_hw_queues() is called
from interrupt context.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 041f7b7fa0d6..c5cb3b2aabcf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1251,7 +1251,7 @@ void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx=
)
 {
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
=20
-	blk_mq_run_hw_queue(hctx, false);
+	blk_mq_run_hw_queue(hctx, in_interrupt());
 }
 EXPORT_SYMBOL(blk_mq_start_hw_queue);
=20
Thanks,

Bart.=
