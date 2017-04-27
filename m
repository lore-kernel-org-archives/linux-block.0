Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 27 Apr 2017 15:40:33 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 4/6] blk-mq-debugfs: Show requeue list
Message-ID: <20170427224033.GC2806@vader.DHCP.thefacebook.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427155437.23228-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 27, 2017 at 08:54:35AM -0700, Bart Van Assche wrote:
> When verifying whether or not a blk-mq driver forgot to kick the
> requeue list after having requeued a request it is important to
> be able to verify the contents of the requeue list. Hence export
> that list through debugfs.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 9cb673bc7230..5092d90e37f6 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -341,6 +341,50 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
> +	__acquires(&q->requeue_lock)
> +{
> +	struct request_queue *q = m->private;
> +
> +	spin_lock(&q->requeue_lock);
> +	return seq_list_start(&q->requeue_list, *pos);
> +}
> +
> +static void *queue_requeue_list_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct request_queue *q = m->private;
> +
> +	return seq_list_next(v, &q->requeue_list, pos);
> +}
> +
> +static void queue_requeue_list_stop(struct seq_file *m, void *v)
> +	__releases(&q->requeue_lock)
> +{
> +	struct request_queue *q = m->private;
> +
> +	spin_unlock(&q->requeue_lock);
> +}
> +
> +static const struct seq_operations queue_requeue_list_seq_ops = {
> +	.start	= queue_requeue_list_start,
> +	.next	= queue_requeue_list_next,
> +	.stop	= queue_requeue_list_stop,
> +	.show	= blk_mq_debugfs_rq_show,
> +};
> +
> +static int queue_requeue_list_open(struct inode *inode, struct file *file)
> +{
> +	return blk_mq_debugfs_seq_open(inode, file,
> +				       &queue_requeue_list_seq_ops);
> +}
> +
> +static const struct file_operations queue_requeue_list_fops = {
> +	.open		= queue_requeue_list_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
>  static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
>  	__acquires(&hctx->lock)
>  {
> @@ -831,6 +875,7 @@ static const struct file_operations ctx_completed_fops = {
>  };
>  
>  static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
> +	{"requeue_list", 0400, &queue_requeue_list_fops},
>  	{"poll_stat", 0400, &queue_poll_stat_fops},
>  	{"state", 0600, &blk_queue_flags_fops},
>  	{},
> -- 
> 2.12.2
> 
