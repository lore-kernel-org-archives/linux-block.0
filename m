Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2] blk-mq: Make blk_mq_get_request() error path less
 confusing
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
References: <20171016233226.5488-1-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <48cef984-4260-461c-a6ee-48275275f04a@suse.de>
Date: Tue, 17 Oct 2017 08:35:03 +0200
MIME-Version: 1.0
In-Reply-To: <20171016233226.5488-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 01:32 AM, Bart Van Assche wrote:
> blk_mq_get_tag() can modify data->ctx. This means that in the
> error path of blk_mq_get_request() data->ctx should be passed to
> blk_mq_put_ctx() instead of local_ctx. Note: since blk_mq_put_ctx()
> ignores its argument, this patch does not change any functionality.
> 
> References: commit 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
> Changes compared to v1:
> - Removed "Cc: <stable>"
> - Removed "bug fix" from the description.
> 
>  block/blk-mq.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
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
