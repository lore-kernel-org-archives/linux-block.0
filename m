Return-Path: <axboe@kernel.dk>
Subject: Re: Hang with blk-mq map series (block/008)
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d4cafa94-919c-e83d-eb91-d10dc06fc515@kernel.dk>
 <20180411020252.GA4494@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6e1d9201-e0f6-cdf4-9572-c67bf5a7e06e@kernel.dk>
Date: Tue, 10 Apr 2018 20:08:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180411020252.GA4494@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/10/18 8:02 PM, Ming Lei wrote:
> On Tue, Apr 10, 2018 at 09:51:41AM -0600, Jens Axboe wrote:
>> Hi Ming,
>>
>> Ran the above blktests on the current tree, and we end up getting
>> a hang that we never recover from. There's on request perpetually
>> stuck:
>>
>> root@dell:/sys/kernel/debug/block/nvme0n1/hctx2# cat busy 
>> 000000005e2b09fe {.op=READ, .cmd_flags=, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=313, .internal_tag=-1}
>>
>> and no amount of manual running or kicking the queue will bring it
>> back to life. If I run it on 'master', it works fine.
>>
>> Did you run blktests on your series?
> 
> Not yet.
> 
> Will take a look at it, but this seems related with driver, since
> the request has been submitted to hardware already.

It might be, but it repeatedly failed for me on for-linus, and not on
master. I can try doing some more runs just to gain more confidence.

-- 
Jens Axboe
