Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 4/4] blk-mq-debugfs: Add 'kick' operation
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
 <20170531213050.30276-5-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0ddc8a94-5fb7-3842-1370-5ed1778c185b@suse.de>
Date: Thu, 1 Jun 2017 07:48:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170531213050.30276-5-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/31/2017 11:30 PM, Bart Van Assche wrote:
> Running a queue causes the block layer to examine the per-CPU and
> hw queues but not the requeue list. Hence add a 'kick' operation
> that also examines the requeue list.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index fa0f624dfccd..962c8417809d 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -114,10 +114,12 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
>  		blk_mq_run_hw_queues(q, true);
>  	} else if (strcmp(op, "start") == 0) {
>  		blk_mq_start_stopped_hw_queues(q, true);
> +	} else if (strcmp(op, "kick") == 0) {
> +		blk_mq_kick_requeue_list(q);
>  	} else {
>  		pr_err("%s: unsupported operation '%s'\n", __func__, op);
>  inval:
> -		pr_err("%s: use either 'run' or 'start'\n", __func__);
> +		pr_err("%s: use 'run', 'start' or 'kick'\n", __func__);
>  		return -EINVAL;
>  	}
>  	return count;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
