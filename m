Return-Path: <keith.busch@intel.com>
Date: Wed, 31 Jan 2018 16:33:04 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
Message-ID: <20180131233304.GE27735@localhost.localdomain>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
 <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 31, 2018 at 08:29:37AM -0700, Jens Axboe wrote:
> 
> How about something like the below?
> 
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 8452fc7164cc..cee102fb060e 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -574,8 +574,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
>  		return 0;
>  
> +	/*
> +	 * For DISCARDs, the segment count isn't interesting since
> +	 * the requests have no data attached.
> +	 */
>  	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
> -	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
> +	if (total_phys_segments &&
> +	    blk_phys_contig_segment(q, req->biotail, next->bio)) {
>  		if (req->nr_phys_segments == 1)
>  			req->bio->bi_seg_front_size = seg_size;
>  		if (next->nr_phys_segments == 1)

That'll keep it from going to 0xffff, but you'll still hit the warning and
IO error. Even worse, this will corrupt memory: blk_rq_nr_discard_segments
will return 1, and since you really had 2 segments, the nvme driver will
overrun its array.
