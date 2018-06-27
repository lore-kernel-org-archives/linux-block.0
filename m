Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
Date: Wed, 27 Jun 2018 16:59:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180627235005.GE7583@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/27/18 16:50, Ming Lei wrote:
> On Wed, Jun 27, 2018 at 01:12:31PM -0700, Bart Van Assche wrote:
>> Although __bio_clone_fast() copies bi_io_vec, it does not copy bi_vcnt,
>> the number of elements in bi_io_vec[] that contains data. Copy bi_vcnt
>> such that code that needs this member behaves identically for original
>> and for cloned requests.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Mike Snitzer <snitzer@redhat.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>> ---
>>   block/bio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index f7e3d88bd0b6..55f8e0dedd69 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>>   	bio->bi_opf = bio_src->bi_opf;
>>   	bio->bi_write_hint = bio_src->bi_write_hint;
>>   	bio->bi_iter = bio_src->bi_iter;
>> +	bio->bi_vcnt = bio_src->bi_vcnt;
>>   	bio->bi_io_vec = bio_src->bi_io_vec;
> 
> No, don't do that.

Why not? I think it's a huge booby trap that cloned bio's have a 
bi_io_vec but zero bi_vcnt.

> For a cloned bio, both .bi_vcnt and .bi_io_vec can't be used directly,
> and we have done huge such cleanup for supporting multipage bvec, that is
> the great idea of immutable bvecs invented by Kent.

My understanding is that the above change doesn't conflict at all with 
the immutable biovec work -- to the contrary.

Bart.
