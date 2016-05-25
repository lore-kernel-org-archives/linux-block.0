Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 1/5] blk mq: take ref to q when running it
To: <mchristi@redhat.com>, <linux-scsi@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <target-devel@vger.kernel.org>
References: <1464162903-14735-1-git-send-email-mchristi@redhat.com>
 <1464162903-14735-2-git-send-email-mchristi@redhat.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <8cab029e-fac5-b4cb-8e80-707abe50ab09@sandisk.com>
Date: Wed, 25 May 2016 08:53:44 -0700
MIME-Version: 1.0
In-Reply-To: <1464162903-14735-2-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 05/25/2016 12:54 AM, mchristi@redhat.com wrote:
> If the __blk_mq_run_hw_queue is a result of a async run or retry
> then we do not have a reference to the queue. At this time,
> blk_cleanup_queue could begin tearing it down while the queue_rq
> function is being run.
>
> This patch just has us do a blk_queue_enter call.
>
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  block/blk-mq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7df9c92..5958a02 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -738,8 +738,13 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>
>  	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask));
>
> -	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
> +	if (blk_queue_enter(q, false)) {
> +		blk_mq_run_hw_queue(hctx, true);
>  		return;
> +	}
> +
> +	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
> +		goto exit_queue;
>
>  	hctx->run++;
>
> @@ -832,6 +837,9 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  		 **/
>  		blk_mq_run_hw_queue(hctx, true);
>  	}
> +
> +exit_queue:
> +	blk_queue_exit(q);
>  }

Hello Mike,

blk_cleanup_queue() waits until delay_work and run_work have finished 
inside blk_sync_queue(). The code in blk_cleanup_queue() before the 
blk_sync_queue() call should be safe to execute concurrently with 
queue_rq(). Or did I perhaps miss something?

Bart.
