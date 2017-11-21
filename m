Return-Path: <msnitzer@redhat.com>
Date: Tue, 21 Nov 2017 09:24:19 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com, ming.lei@redhat.com
Subject: Re: block: early return from blk_queue_split() if q->bio_split is
 NULL
Message-ID: <20171121142418.GA17681@redhat.com>
References: <20171120165401.GA10608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120165401.GA10608@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 20 2017 at 11:54am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> DM appears to be the only block driver that doesn't lean on the block
> core's bio splitting.  My hope is to fix that but in the meantime it
> doesn't make sense for a device that doesn't need blk_queue_split() to
> go through the associated work.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/blk-merge.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index f5dedd5..212004c 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -186,6 +186,9 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
>  	struct bio *split, *res;
>  	unsigned nsegs;
>  
> +	if (!q->bio_split)
> +		return;
> +
>  	switch (bio_op(*bio)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
> -- 
> 2.10.1
> 

Please ignore this patch.  While the patch is perfectly valid, it
doesn't have an existing consumer.  Ming pointed out that, in constrat
to blk_queue_bio(), bio-based DM's dm_make_request() makes it so that
DM never calls blk_queue_split().

Mike
