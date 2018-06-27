Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
Subject: Re: [PATCH] block: Simplify the bio cloning implementation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20180626222624.11739-1-bart.vanassche@wdc.com>
 <20180627011259.GC9970@ming.t460p>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <5766ea06-4016-6ad1-a18a-b2c9f31788cf@wdc.com>
Date: Wed, 27 Jun 2018 10:48:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180627011259.GC9970@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/26/18 18:13, Ming Lei wrote:
> On Tue, Jun 26, 2018 at 03:26:24PM -0700, Bart Van Assche wrote:
>> There is no good reason to use different code paths for different
>> request operations. Hence remove the switch/case statement from
>> bio_clone_bioset().
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> ---
>>   block/bio.c | 15 ++-------------
>>   1 file changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index f7e3d88bd0b6..4c27cc9ea55e 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -691,19 +691,8 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
>>   	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
>>   	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
>>   
>> -	switch (bio_op(bio)) {
>> -	case REQ_OP_DISCARD:
>> -	case REQ_OP_SECURE_ERASE:
>> -	case REQ_OP_WRITE_ZEROES:
>> -		break;
>> -	case REQ_OP_WRITE_SAME:
>> -		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
>> -		break;
>> -	default:
>> -		bio_for_each_segment(bv, bio_src, iter)
>> -			bio->bi_io_vec[bio->bi_vcnt++] = bv;
>> -		break;
>> -	}
>> +	bio_for_each_segment(bv, bio_src, iter)
>> +		bio->bi_io_vec[bio->bi_vcnt++] = bv;
> 
> The above change may not be correct for WRITE_SAME, since
> bio_src->bi_iter.bi_size should be the actual bytes to write by drive.

Since bio_for_each_segment() neither modifies bio_src->bi_iter nor 
bio->bi_iter, the above patch retains the value copied into 
bio->bi_iter.bi_size before bio_for_each_segment() was called. In other 
words, bio_src->bi_iter.bi_size is not modified and the resulting 
bio->bi_iter.bi_size should be identical with or without this patch.

> Also Christoph has killed bio_clone_bioset() already, and I think that is
> correct thing to do, see:
> 
> 	https://marc.info/?l=linux-block&m=152938432207215&w=2

Anyway, I'm fine with using Christoph's approach and dropping this patch.

Bart.
