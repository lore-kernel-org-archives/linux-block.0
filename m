Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] block: avoid ordered task state change for polled IO
To: "jianchao.wang" <jianchao.w.wang@oracle.com>, linux-block@vger.kernel.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-5-axboe@kernel.dk>
 <653c9f83-157c-dca9-aa3b-02903dc81f5b@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e213ca38-19c0-70ca-e4d0-096c48d5b4b8@kernel.dk>
Date: Mon, 12 Nov 2018 09:26:59 -0700
MIME-Version: 1.0
In-Reply-To: <653c9f83-157c-dca9-aa3b-02903dc81f5b@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/12/18 2:35 AM, jianchao.wang wrote:
> Hi Jens
> 
> On 11/10/18 11:13 PM, Jens Axboe wrote:
>> We only really need the barrier if we're going to be sleeping,
>> if we're just polling we're fine with the __set_current_state()
>> variant.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index c039abfb2052..e7550b1f9670 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -237,12 +237,23 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  
>>  	qc = submit_bio(&bio);
>>  	for (;;) {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		/*
>> +		 * Using non-atomic task state for polling
>> +		 */
>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>> +
>>  		if (!READ_ONCE(bio.bi_private))
>>  			break;
> 
> When we don't use polling, the blkdev_bio_end_io_simple may come on a different cpu before
> submit_bio returns 
> For example,
> __blkdev_direct_IO_simple
>   qc = submit_bio(&bio) 
>                                           blkdev_bio_end_io_simple
>                                             WRITE_ONCE(bio.bi_private, NULL)
>                                             wake_up_process(waiter)
>   __set_current_state(TASK_UNINTERRUPTIBLE)                              
>   READ_ONCE(bio.bi_private)

While I agree that you are right, that's an existing issue. The store
barrier implied by set_current_state() doesn't fix that.

How about this variant:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-perf&id=036ba7a8d1334889c0fe55d4858d78f4e8022f12

which then changes the later wake up helper patch to be:
 
http://git.kernel.dk/cgit/linux-block/commit/?h=mq-perf&id=f8c3f188425967adb040cfefb799b0a5a1df769d

-- 
Jens Axboe
