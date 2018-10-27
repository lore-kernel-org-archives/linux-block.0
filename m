Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V4] block: fix the DISCARD request merge
To: Jens Axboe <axboe@kernel.dk>
Cc: martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540546116-1620-1-git-send-email-jianchao.w.wang@oracle.com>
 <4ee51782-acbb-bcc9-6692-39e9b8df477f@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <303b4275-d310-d27a-2b92-cdd25e76cffe@oracle.com>
Date: Sat, 27 Oct 2018 19:46:10 +0800
MIME-Version: 1.0
In-Reply-To: <4ee51782-acbb-bcc9-6692-39e9b8df477f@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 10/26/18 10:25 PM, Jens Axboe wrote:
> On 10/26/18 3:28 AM, Jianchao Wang wrote:
>> There are two cases when handle DISCARD merge.
>> If max_discard_segments == 1, the bios/requests need to be contiguous
>> to merge. If max_discard_segments > 1, it takes every bio as a range
>> and different range needn't to be contiguous.
>>
>> But now, attempt_merge screws this up. It always consider contiguity
>> for DISCARD for the case max_discard_segments > 1 and cannot merge
>> contiguous DISCARD for the case max_discard_segments == 1, because
>> rq_attempt_discard_merge always returns false in this case.
>> This patch fixes both of the two cases above.
> 
> Looks good to me, but:
> 
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 42a4674..cf817c7a 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -714,6 +714,32 @@ static void blk_account_io_merge(struct request *req)
>>  		part_stat_unlock();
>>  	}
>>  }
>> +/*
>> + * Two cases of handling DISCARD merge:
>> + * If max_discard_segments > 1, the driver takes every bio
>> + * as a range and send them to controller together. The ranges
>> + * needn't to be contiguous.
>> + * Otherwise, the bios/requests will be handled as same as
>> + * others which should be contiguous.
>> + */
>> +static inline bool blk_discard_mergable(struct request *req)
>> +{
>> +	if (req_op(req) == REQ_OP_DISCARD &&
>> +	    queue_max_discard_segments(req->q) > 1)
>> +		return true;
>> +	else
>> +		return false;
>> +}
> 
> Please get rid of the redundant else.
> 

OK, I will change it and post next version.

Thanks
Jianchao
