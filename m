Return-Path: <prvs=57171364e=bart.vanassche@wdc.com>
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
To: Jens Axboe <axboe@kernel.dk>,
 "paolo.valente@linaro.org" <paolo.valente@linaro.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
Date: Fri, 9 Feb 2018 11:14:13 -0800
MIME-Version: 1.0
In-Reply-To: <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 02/09/18 10:58, Jens Axboe wrote:
> On 2/9/18 11:54 AM, Bart Van Assche wrote:
>> Hello Paolo,
>>
>> If I enable the BFQ scheduler for a dm-mpath device then a kernel oops
>> appears (see also below). This happens systematically with Linus' tree from
>> this morning (commit 54ce685cae30) merged with Jens' for-linus branch (commit
>> a78773906147 ("block, bfq: add requeue-request hook")) and for-next branch
>> (commit 88455ad7f928). Is this a known issue?
> 
> Does it happen on Linus -git as well, or just with my for-linus merged in?
> What I'm getting at is if a78773906147 caused this or not.

Hello Jens,

Thanks for chiming in. After having reverted commit a78773906147, after 
having rebuilt the BFQ scheduler, after having rebooted and after having 
repeated the test I see the same kernel oops being reported. I think 
that means that this regression is not caused by commit a78773906147. In 
case it would be useful, here is how gdb translates the crash address:

$ gdb block/bfq*ko
(gdb) list *(bfq_remove_request+0x8d)
0x280d is in bfq_remove_request (block/bfq-iosched.c:1760).
1755                    list_del_init(&rq->queuelist);
1756            bfqq->queued[sync]--;
1757            bfqd->queued--;
1758            elv_rb_del(&bfqq->sort_list, rq);
1759
1760            elv_rqhash_del(q, rq);
1761            if (q->last_merge == rq)
1762                    q->last_merge = NULL;
1763
1764            if (RB_EMPTY_ROOT(&bfqq->sort_list)) {

Bart.
