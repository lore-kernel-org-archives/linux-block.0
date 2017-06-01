Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/4] Extend blk-mq-debugfs functionality further
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20170601155513.26712-1-bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b6bc9856-7165-9938-c7e9-9dbe96b022b2@kernel.dk>
Date: Thu, 1 Jun 2017 12:03:26 -0700
MIME-Version: 1.0
In-Reply-To: <20170601155513.26712-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/01/2017 08:55 AM, Bart Van Assche wrote:
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
> 
>  block/blk-mq-debugfs.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)

Added for 4.13, thanks Bart.

-- 
Jens Axboe
