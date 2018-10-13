Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] blk-mq: some fixes about updating hw queues
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d50f599-4243-6a11-b7d0-9eee9d71ec63@kernel.dk>
Date: Sat, 13 Oct 2018 16:51:44 -0600
MIME-Version: 1.0
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:07 AM, Jianchao Wang wrote:
> Hi Jens
> 
> This patch set fixes some defects during update hw queues.
> 
> 1st patch refactor the blk-mq debugfs and sysfs register during
> blk_mq_update_nr_hw_queues.
> 
> 2nd patch change the GFP_KERNEL to GFP_NOIO during blk_mq_realloc_hw_ctxs,
> 
> 3rd patch try to realloc hctx when this hctx is mapped to a different node.
> 
> 4th patch should be able to fix the panic reported in follwing link
> https://marc.info/?l=linux-block&m=153799465603723&w=2
> 
> V2:
>  - Newly add 2nd and 3rd patch.
>  - Use blk_mq_map_queues when __blk_mq_update_nr_hw_queues fallbacks to
>    previous nr_hw_queues to avoid driver's .map_queues leak mapping of
>    some cpus due the fallback nr_hw_queues.
>  - Add Ming's Reviewed-by in 1st patch.
> 
> 
> Jianchao Wang[4]
> blk-mq: adjust debugfs and sysfs register when
> blk-mq: change gfp flags to GFP_NOIO in
> blk-mq: realloc hctx when hw queue is mapped to
> blk-mq: fallback to previous nr_hw_queues when
> 
>  block/blk-core.c  |   2 +-
>  block/blk-flush.c |   6 +--
>  block/blk-mq.c    | 155 ++++++++++++++++++++++++++++++++++--------------------
>  block/blk.h       |   2 +-
>  4 files changed, 102 insertions(+), 63 deletions(-)
> 

Applied, thanks.

-- 
Jens Axboe
