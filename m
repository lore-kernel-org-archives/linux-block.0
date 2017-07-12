Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: dispatch request to prevent queue stalling
 after the request completion
To: Paolo Valente <paolo.valente@linaro.org>, Hou Tao <houtao1@huawei.com>
Cc: linux-block@vger.kernel.org
References: <1499781495-44090-1-git-send-email-houtao1@huawei.com>
 <3F836EDA-18EA-4678-BA06-21F1AA073E29@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f4dafec9-9d07-f24b-cb13-37182878aa7f@kernel.dk>
Date: Wed, 12 Jul 2017 08:22:30 -0600
MIME-Version: 1.0
In-Reply-To: <3F836EDA-18EA-4678-BA06-21F1AA073E29@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/12/2017 03:41 AM, Paolo Valente wrote:
> 
>> Il giorno 11 lug 2017, alle ore 15:58, Hou Tao <houtao1@huawei.com> ha scritto:
>>
>> There are mq devices (eg., virtio-blk, nbd and loopback) which don't
>> invoke blk_mq_run_hw_queues() after the completion of a request.
>> If bfq is enabled on these devices and the slice_idle attribute or
>> strict_guarantees attribute is set as zero,
> 
> I guess you meant slice_idle > 0 or strict_guarantees equal to 1 here.
> 
>> it is possible that
>> after a request completion the remaining requests of busy bfq queue
>> will stalled in the bfq schedule until a new request arrives.
>>
>> To fix the scheduler latency problem, we need to check whether or not
>> all issued requests have completed and dispatch more requests to driver
>> if there is no request in driver.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>
> 
> Thanks for this fix.  My only (possible) concern is whether there
> would be some more coherent and possibly more efficient solution to
> this problem, outside BFQ.  For example, would it make sense to call
> blk_mq_run_hw_queues(), after a request completion, from the offended
> devices too?  This would make the behavior of these devices coherent
> with that of the other devices.  Unfortunately I have no sound answer
> to such a question.  Apart from this concern:

No, that's wrong. If a scheduler decides to stop dispatching
requests before the list has been drained, it is the schedulers
responsibility to restart dispatch. Some drivers need to restart
the queue for other reasons, don't confuse the two.

-- 
Jens Axboe
