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
 <0f6c248b-eb67-9b02-a4b9-0366d476e70d@kernel.dk>
 <ef22f6c5-84c4-1ebf-b4b5-d0a2d1d29927@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1ed647a3-7a4f-c288-ac4d-c1d42313626c@kernel.dk>
Date: Wed, 31 Jan 2018 20:35:47 -0700
MIME-Version: 1.0
In-Reply-To: <ef22f6c5-84c4-1ebf-b4b5-d0a2d1d29927@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/31/18 8:33 PM, jianchao.wang wrote:
> Sorry, Jens, I think I didn't get the point.
> Do I miss anything ?
> 
> On 02/01/2018 11:07 AM, Jens Axboe wrote:
>> Yeah I agree, and my last patch missed that we do care about segments for
>> discards. Below should be better...
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 8452fc7164cc..055057bd727f 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -553,9 +553,8 @@ static bool req_no_special_merge(struct request *req)
>>  static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>>  				struct request *next)
>>  {
>> -	int total_phys_segments;
>> -	unsigned int seg_size =
>> -		req->biotail->bi_seg_back_size + next->bio->bi_seg_front_size;
>> +	int total_phys_segments = req->nr_phys_segments +
>> +					next->nr_phys_segments;
> 
> For DISCARD reqs, the total_phys_segments is still zero here.

This seems broken, it should count the ranges in the discard request.

>> @@ -574,8 +573,15 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>>  	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
>>  		return 0;
>>  
>> -	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
>> -	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
>> +	/*
>> +	 * If the requests aren't carrying any data payloads, we don't need
>> +	 * to look at the segment count
>> +	 */
>> +	if (bio_has_data(next->bio) &&
>> +	    blk_phys_contig_segment(q, req->biotail, next->bio)) {
>> +		unsigned int seg_size = req->biotail->bi_seg_back_size +
>> +						next->bio->bi_seg_front_size;
> 
> Yes, total_phys_segments will not be decreased.
> 
>> +
>>  		if (req->nr_phys_segments == 1)
>>  			req->bio->bi_seg_front_size = seg_size;
>>  		if (next->nr_phys_segments == 1)
>> @@ -584,7 +590,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>>  	}
>>  
>>  	if (total_phys_segments > queue_max_segments(q))
>> -		return 0;
>> +			return 0;
>>  
>>  	if (blk_integrity_merge_rq(q, req, next) == false)
>>  		return 0;
> 
> But finally, the merged DISCARD req's nr_phys_segment is still zero.
> 
> blk_rq_nr_discard_segments will return 1 but this req has two bios.
> blk_rq_nr_discard_segments 's comment says

They should have the range count. The discard merge stuff is a bit of
a hack, it would be nice to get that improved.

-- 
Jens Axboe
