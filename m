Return-Path: <prvs=318c2ee8b=eduval@lab126.com>
Date: Thu, 1 Jun 2017 10:14:47 -0700
From: Eduardo Valentin <eduval@amazon.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Christoph
 Hellwig" <hch@lst.de>
Subject: Re: [PATCH v3 0/4] Extend blk-mq-debugfs functionality further
Message-ID: <20170601171447.GB3382@u40b0340c692b58f6553c.ant.amazon.com>
References: <20170601155513.26712-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170601155513.26712-1-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 01, 2017 at 08:55:09AM -0700, Bart Van Assche wrote:
> Hello Jens,
> 
> This series contains four patches that add new features to the blk-mq-debugfs
> code. Please consider these patches for kernel v4.13.
> 
> Thanks,
> 
> Bart.
> 
> Changes between v2 and v3:
> - Renamed a function in the patch that shows busy requests. In the same patch,
>   added a comment as requested by Ming.
> - Added Reviewed-by tags to those patches that got an additional review.  
> 
> Changes compared to v1:
> - Left out the first patch of this series because it's already upstream.
> - Renamed "ctx" into "params" in the patch that shows the busy requests.
> - In the same patch, switched from blk_mq_debugfs_rq_show() to
>   __blk_mq_debugfs_rq_show().
> 
> The patches in this series are:
> 
> Bart Van Assche (4):
>   blk-mq-debugfs: Show atomic request flags
>   blk-mq-debugfs: Show requeue list
>   blk-mq-debugfs: Show busy requests
>   blk-mq-debugfs: Add 'kick' operation

For the patchset, you can add my
Reviewed-by: Eduardo Valentin <eduval@amazon.com>

> 
>  block/blk-mq-debugfs.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> -- 
> 2.12.2
> 
> 

-- 
All the best,
Eduardo Valentin
