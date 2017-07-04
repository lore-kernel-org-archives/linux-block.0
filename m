Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 06:19:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 8/8] xen-blockfront: quiesce IO before device removal
Message-ID: <20170704221908.GA3732@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-9-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1499154912-10420-9-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:55:12AM +0300, Sagi Grimberg wrote:
> Before calling blk_cleanup_queue one must make sure
> that no request is being queued. In order to guarantee that
> we need to use blk_mq_quiesce as it respects the submission
> path rcu grace.
> 
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Roger Pau Monn� <roger.pau@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/block/xen-blkfront.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index c852ed3c01d5..5272ca8fb0dc 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -1187,7 +1187,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
>  		return;
>  
>  	/* No more blkif_request(). */
> -	blk_mq_stop_hw_queues(info->rq);
> +	blk_mq_quiesce_queue(info->rq);
>  
>  	for (i = 0; i < info->nr_rings; i++) {
>  		struct blkfront_ring_info *rinfo = &info->rinfo[i];
> @@ -1217,7 +1217,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
>  static inline void kick_pending_request_queues_locked(struct blkfront_ring_info *rinfo)
>  {
>  	if (!RING_FULL(&rinfo->ring))
> -		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
> +		blk_mq_unquiesce_queue(rinfo->dev_info->rq);
>  }

Looks the above change isn't needed since this blk_mq_start_stopped_hw_queues()
should have been the counterpart of blk_mq_stop_hw_queue() in
blkif_queue_rq().

-- 
Ming
