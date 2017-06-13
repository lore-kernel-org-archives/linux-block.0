Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 03/11] blk-mq: expose stream write stats through debugfs
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-4-git-send-email-axboe@kernel.dk>
 <8290144C-3C0E-4200-B5FF-A949BC3FD87B@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b285e542-b7bf-0dc1-da51-970b9199b526@kernel.dk>
Date: Tue, 13 Jun 2017 14:11:37 -0600
MIME-Version: 1.0
In-Reply-To: <8290144C-3C0E-4200-B5FF-A949BC3FD87B@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 01:21 PM, Andreas Dilger wrote:
> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Useful to verify that things are working the way they should.
>> Reading the file will return number of kb written to each
>> stream. Writing the file will reset the statistics. No care
>> is taken to ensure that we don't race on updates.
> 
> This is one of the few places where there is an arbitrary limit on the
> number of stream IDs, which is strange because it doesn't correspond to
> any limit in a struct field or the physical hardware or external protocol...
> 
> Bumping the stream_writes[] stats array up to 16 wouldn't make any
> significant difference to the size of struct request_queue.

For my testing, it was actually 16. Until we enable the use of more
than 4 streams, I think we should limit it to just 4. But yes, cheap
to change.

>> @@ -2057,6 +2057,8 @@ blk_qc_t generic_make_request(struct bio *bio)
>> 	do {
>> 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>>
>> +		q->stream_writes[bio_stream(bio)] += bio->bi_iter.bi_size >> 9;
> 
> This should probably limit the value returned from bio_stream(), and put values
>> = WRITE_LIFE_NR into an "overflow" bucket or similar?  At some point in the
> future this could be made more flexible, based on the actual usage, but at
> least the limitation on the implementation isn't something arbitrary like stats.

Agree, we need to either check here or ensure that bio_stream() never returns
anything above WRITE_LIFE_EXTREME. I'll make that change.

-- 
Jens Axboe
