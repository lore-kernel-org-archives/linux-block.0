Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
 <20181022090058.GF18755@lst.de>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ebc24279-1a26-1560-a810-4e51545e7a91@oracle.com>
Date: Mon, 22 Oct 2018 18:13:20 +0800
MIME-Version: 1.0
In-Reply-To: <20181022090058.GF18755@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 10/22/18 5:00 PM, Christoph Hellwig wrote:
> On Sat, Oct 20, 2018 at 10:29:37PM +0800, Jianchao Wang wrote:
>> There are two cases when handle DISCARD merge
>>  - max_discard_segments == 1
>>    bios need to be contiguous
>>  - max_discard_segments > 1
>>    Only nvme right now. It takes every bio as a range and different
>>    range needn't to be contiguous.
>>
>> But now, attempt_merge screws this up. It always consider contiguity
>> for DISCARD for the case max_discard_segments > 1 and cannot merge
>> contiguous DISCARD for the case max_discard_segments == 1, because
>> rq_attempt_discard_merge always returns false in this case.
>> This patch fixes both of the two cases above.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>
>> V2:
>>   - Add max_discard_segments > 1 checking in attempt_merge
>>   - Change patch title and comment
>>   - Add more comment in attempt_merge
>>
>>  block/blk-merge.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 42a4674..8f22374 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -734,8 +734,15 @@ static struct request *attempt_merge(struct request_queue *q,
>>  	/*
>>  	 * not contiguous
>>  	 */
>> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
>> -		return NULL;
>> +	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)) {
>> +		/*
>> +		 * When max_discard_segments is bigger than 1 (only nvme right
>> +		 * now), needn't consider the contiguity.
>> +		 */
>> +		if (!(req_op(req) == REQ_OP_DISCARD &&
>> +		      queue_max_discard_segments(q) > 1))
>> +			return NULL;
> 
> Why not:
> 
> 		if (req_op(req) != REQ_OP_DISCARD ||
> 		    queue_max_discard_segments(q) == 1)> 
> which would be a lot more obvious?

OK, I will change it

> 
>> +	 * counts here.
>> +	 * Two cases of Handling DISCARD:
>> +	 *  - max_discard_segments == 1
>> +	 *    The bios need to be contiguous.
>> +	 *  - max_discard_segments > 1
>> +	 *    Only nvme right now. It takes every bio as a
>> +	 *    range and send them to controller together. The ranges
>> +	 *    needn't to be contiguous.
> 
> The formatting looks odd.  Also I don't think we should mention the
> users here, as others might grow (virtio is in the pipe, SCSI could
> be supported easily if someone did the work).
> 

Yes, I will change the format and discard the users here.

Thanks
Jianchao
