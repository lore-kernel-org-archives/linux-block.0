Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block, bfq: dispatch request to prevent queue stalling after the request completion
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <f4dafec9-9d07-f24b-cb13-37182878aa7f@kernel.dk>
Date: Wed, 12 Jul 2017 16:45:21 +0200
Cc: Hou Tao <houtao1@huawei.com>,
 linux-block@vger.kernel.org
Message-Id: <68FA3180-082E-4982-B93B-13BF2A3476DF@linaro.org>
References: <1499781495-44090-1-git-send-email-houtao1@huawei.com> <3F836EDA-18EA-4678-BA06-21F1AA073E29@linaro.org> <f4dafec9-9d07-f24b-cb13-37182878aa7f@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 12 lug 2017, alle ore 16:22, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 07/12/2017 03:41 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 11 lug 2017, alle ore 15:58, Hou Tao <houtao1@huawei.com> =
ha scritto:
>>>=20
>>> There are mq devices (eg., virtio-blk, nbd and loopback) which don't
>>> invoke blk_mq_run_hw_queues() after the completion of a request.
>>> If bfq is enabled on these devices and the slice_idle attribute or
>>> strict_guarantees attribute is set as zero,
>>=20
>> I guess you meant slice_idle > 0 or strict_guarantees equal to 1 =
here.
>>=20
>>> it is possible that
>>> after a request completion the remaining requests of busy bfq queue
>>> will stalled in the bfq schedule until a new request arrives.
>>>=20
>>> To fix the scheduler latency problem, we need to check whether or =
not
>>> all issued requests have completed and dispatch more requests to =
driver
>>> if there is no request in driver.
>>>=20
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>=20
>>=20
>> Thanks for this fix.  My only (possible) concern is whether there
>> would be some more coherent and possibly more efficient solution to
>> this problem, outside BFQ.  For example, would it make sense to call
>> blk_mq_run_hw_queues(), after a request completion, from the offended
>> devices too?  This would make the behavior of these devices coherent
>> with that of the other devices.  Unfortunately I have no sound answer
>> to such a question.  Apart from this concern:
>=20
> No, that's wrong. If a scheduler decides to stop dispatching
> requests before the list has been drained, it is the schedulers
> responsibility to restart dispatch. Some drivers need to restart
> the queue for other reasons, don't confuse the two.
>=20

Thanks for clearing up this point.  As I already wrote, the patch is
then ok for me.

Thanks,
Paolo

> --=20
> Jens Axboe
