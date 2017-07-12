Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:8904 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbdGLKhP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 06:37:15 -0400
Subject: Re: [PATCH] block, bfq: dispatch request to prevent queue stalling
 after the request completion
To: Paolo Valente <paolo.valente@linaro.org>
References: <1499781495-44090-1-git-send-email-houtao1@huawei.com>
 <3F836EDA-18EA-4678-BA06-21F1AA073E29@linaro.org>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <9225c0c5-7d95-34a1-bf5e-5bd709cdc90a@huawei.com>
Date: Wed, 12 Jul 2017 18:36:31 +0800
MIME-Version: 1.0
In-Reply-To: <3F836EDA-18EA-4678-BA06-21F1AA073E29@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2017/7/12 17:41, Paolo Valente wrote:
> 
>> Il giorno 11 lug 2017, alle ore 15:58, Hou Tao <houtao1@huawei.com> ha scritto:
>>
>> There are mq devices (eg., virtio-blk, nbd and loopback) which don't
>> invoke blk_mq_run_hw_queues() after the completion of a request.
>> If bfq is enabled on these devices and the slice_idle attribute or
>> strict_guarantees attribute is set as zero,
> 
> I guess you meant slice_idle > 0 or strict_guarantees equal to 1 here.
Sorry for the typo, I mean slice_idle = 0 or strict_guarantees = 1.
Setting slice_idle as 0 alone could also trigger the latency problem.

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
> 
> Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
Thanks for your review.

The inconsistencies between the different mq drivers also make me confused.
I don't known the reason why scsi-mq dispatches the remaining requests
after each request completion and virtio-blk does not.

I'm not sure whether or not fixing in MQ is a better idea, but I has a proposal.
If the BLK_MQ_S_SCHED_RESTART flag has been set, MQ would invoke blk_mq_run_hw_queues()
after the request completion. The BLK_MQ_S_SCHED_RESTART flag will be set by
blk_mq_sched_dispatch_requests() when it finds out that there are residual requests in its
dispatch list. We can let .dispatch_request() return a flag to set the BLK_MQ_S_SCHED_RESTART
flag if the underlying scheduler needs it, so after the request completion, the MQ core will
pull the remaining requests from BFQ.

Regards,
Tao

> 
>> The problem can be reproduced by running the following script
>> on a virtio-blk device with nr_hw_queues as 1:
>>
>> #!/bin/sh
>>
>> dev=vdb
>> # mount point for dev
>> mp=/tmp/mnt
>> cd $mp
>>
>> job=strict.job
>> cat <<EOF > $job
>> [global]
>> direct=1
>> bs=4k
>> size=256M
>> rw=write
>> ioengine=libaio
>> iodepth=128
>> runtime=5
>> time_based
>>
>> [1]
>> filename=1.data
>>
>> [2]
>> new_group
>> filename=2.data
>> EOF
>>
>> echo bfq > /sys/block/$dev/queue/scheduler
>> echo 1 > /sys/block/$dev/queue/iosched/strict_guarantees
>> fio $job
>> ---
>> block/bfq-iosched.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 12bbc6b..94cd682 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -4293,6 +4293,9 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>> 			bfq_bfqq_expire(bfqd, bfqq, false,
>> 					BFQQE_NO_MORE_REQUESTS);
>> 	}
>> +
>> +	if (!bfqd->rq_in_driver)
>> +		bfq_schedule_dispatch(bfqd);
>> }
>>
>> static void bfq_put_rq_priv_body(struct bfq_queue *bfqq)
>> -- 
>> 2.5.0
>>
> 
> 
> .
> 
