Return-Path: <ming.lei@redhat.com>
Date: Thu, 1 Jun 2017 10:50:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2 4/4] blk-mq-debugfs: Add 'kick' operation
Message-ID: <20170601025013.GF23563@ming.t460p>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
 <20170531213050.30276-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531213050.30276-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 02:30:50PM -0700, Bart Van Assche wrote:
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
> -- 
> 2.12.2

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
