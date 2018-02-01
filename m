Return-Path: <axboe@kernel.dk>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
 <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
 <7459ffed-c63c-38a9-84f5-456c2a5c4fe0@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0f6c248b-eb67-9b02-a4b9-0366d476e70d@kernel.dk>
Date: Wed, 31 Jan 2018 20:07:41 -0700
MIME-Version: 1.0
In-Reply-To: <7459ffed-c63c-38a9-84f5-456c2a5c4fe0@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/31/18 8:03 PM, jianchao.wang wrote:
> Hi Jens
> 
> 
> On 01/31/2018 11:29 PM, Jens Axboe wrote:
>> How about something like the below?
>>
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 8452fc7164cc..cee102fb060e 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -574,8 +574,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>>  	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
>>  		return 0;
>>  
>> +	/*
>> +	 * For DISCARDs, the segment count isn't interesting since
>> +	 * the requests have no data attached.
>> +	 */
>>  	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
>> -	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
>> +	if (total_phys_segments &&
>> +	    blk_phys_contig_segment(q, req->biotail, next->bio)) {
>>  		if (req->nr_phys_segments == 1)
>>  			req->bio->bi_seg_front_size = seg_size;
>>  		if (next->nr_phys_segments == 1)
> 
> This patch will avoid the nr_phys_segments to be set to 0xffff,
> but the merged req will have two bios but zero nr_phys_segments.
> 
> We have to align with the DISCARD merging strategy.
> 
> Please refer to:
> /*
>  * Number of discard segments (or ranges) the driver needs to fill in.
>  * Each discard bio merged into a request is counted as one segment.
>  */
> static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
> {
>        return max_t(unsigned short, rq->nr_phys_segments, 1);
> }
> bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
> 		struct bio *bio)
> {
> 	unsigned short segments = blk_rq_nr_discard_segments(req);
> 
> 	if (segments >= queue_max_discard_segments(q))
> 		goto no_merge;
> 	if (blk_rq_sectors(req) + bio_sectors(bio) >
> 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
> 		goto no_merge;
> 
> 	req->biotail->bi_next = bio;
> 	req->biotail = bio;
> 	req->__data_len += bio->bi_iter.bi_size;
> 	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
> 	req->nr_phys_segments = segments + 1;
> 
> 	blk_account_io_start(req, false);
> 	return true;
> no_merge:
> 	req_set_nomerge(q, req);
> 	return false;
> }
> 
> blk_rq_nr_discard_segments will get a wrong value finally.
> 
> Maybe we could change blk_rq_nr_discard_segments to iterate and count the bios in one request
> to decide the DISCARD request nr_phy_segment. And discard the nr_phys_segments operations in
> the DISCARD merging path, plus your patch here.

Yeah I agree, and my last patch missed that we do care about segments for
discards. Below should be better...

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8452fc7164cc..055057bd727f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -553,9 +553,8 @@ static bool req_no_special_merge(struct request *req)
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
-	int total_phys_segments;
-	unsigned int seg_size =
-		req->biotail->bi_seg_back_size + next->bio->bi_seg_front_size;
+	int total_phys_segments = req->nr_phys_segments +
+					next->nr_phys_segments;
 
 	/*
 	 * First check if the either of the requests are re-queued
@@ -574,8 +573,15 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		return 0;
 
-	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
+	/*
+	 * If the requests aren't carrying any data payloads, we don't need
+	 * to look at the segment count
+	 */
+	if (bio_has_data(next->bio) &&
+	    blk_phys_contig_segment(q, req->biotail, next->bio)) {
+		unsigned int seg_size = req->biotail->bi_seg_back_size +
+						next->bio->bi_seg_front_size;
+
 		if (req->nr_phys_segments == 1)
 			req->bio->bi_seg_front_size = seg_size;
 		if (next->nr_phys_segments == 1)
@@ -584,7 +590,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	}
 
 	if (total_phys_segments > queue_max_segments(q))
-		return 0;
+			return 0;
 
 	if (blk_integrity_merge_rq(q, req, next) == false)
 		return 0;

-- 
Jens Axboe
