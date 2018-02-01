Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
 <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <7459ffed-c63c-38a9-84f5-456c2a5c4fe0@oracle.com>
Date: Thu, 1 Feb 2018 11:03:01 +0800
MIME-Version: 1.0
In-Reply-To: <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi Jens


On 01/31/2018 11:29 PM, Jens Axboe wrote:
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

This patch will avoid the nr_phys_segments to be set to 0xffff,
but the merged req will have two bios but zero nr_phys_segments.

We have to align with the DISCARD merging strategy.

Please refer to:
/*
 * Number of discard segments (or ranges) the driver needs to fill in.
 * Each discard bio merged into a request is counted as one segment.
 */
static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
{
       return max_t(unsigned short, rq->nr_phys_segments, 1);
}
bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
		struct bio *bio)
{
	unsigned short segments = blk_rq_nr_discard_segments(req);

	if (segments >= queue_max_discard_segments(q))
		goto no_merge;
	if (blk_rq_sectors(req) + bio_sectors(bio) >
	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
		goto no_merge;

	req->biotail->bi_next = bio;
	req->biotail = bio;
	req->__data_len += bio->bi_iter.bi_size;
	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
	req->nr_phys_segments = segments + 1;

	blk_account_io_start(req, false);
	return true;
no_merge:
	req_set_nomerge(q, req);
	return false;
}

blk_rq_nr_discard_segments will get a wrong value finally.

Maybe we could change blk_rq_nr_discard_segments to iterate and count the bios in one request
to decide the DISCARD request nr_phy_segment. And discard the nr_phys_segments operations in
the DISCARD merging path, plus your patch here.

Thanks
Jianchao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
