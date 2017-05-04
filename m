Date: Thu, 4 May 2017 08:22:17 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 10/12] blk-mq-debugfs: allow schedulers to register
 debugfs attributes
Message-ID: <20170504142217.GC9292@kernel.dk>
References: <cover.1493882751.git.osandov@fb.com>
 <006e6393f62e9ac84d7ee76634b80cb4fe49b66e.1493882751.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <006e6393f62e9ac84d7ee76634b80cb4fe49b66e.1493882751.git.osandov@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 04 2017, Omar Sandoval wrote:
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 596e9b16d3d1..29ecb43aa412 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -2,6 +2,15 @@
>  #define INT_BLK_MQ_DEBUGFS_H
>  
>  #ifdef CONFIG_BLK_DEBUG_FS
> +struct blk_mq_debugfs_attr {
> +	const char *name;
> +	umode_t mode;
> +	int (*show)(void *, struct seq_file *);
> +	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
> +	/* Set either .show or .seq_ops. */
> +	const struct seq_operations *seq_ops;
> +};
> +
>  int blk_mq_debugfs_register(struct request_queue *q);
>  void blk_mq_debugfs_unregister(struct request_queue *q);
>  int blk_mq_debugfs_register_hctx(struct request_queue *q,

This needs a <linux/seq_file.h> include in blk-mq-debugfs.h, or my
compile starts breaking on both kyber and mq-deadline.

-- 
Jens Axboe
