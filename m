Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FD2E62A9;
	Thu, 23 Apr 2026 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944660; cv=none; b=fHo2+qG4w2SiEWlwtpQlFORWOHJCx7ryI2lCmikTozFh8UVBY6HQRd9QZ4NVIcnTwjrW7ce5T1E4c8bNVz+UdOrORbDVQrBiMlfXRpsr+Sp6tZb7NtDBYvx76Z0WECug3ayJsuYlecey9+/2hs0IWD2CW4mgIWbtqyVf4jnp9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944660; c=relaxed/simple;
	bh=Ujrq01PkDvKhMpT6YyET955QiS8TmniKYjoHMef0JlE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IB5winAjiVPoEvU3GHbnUMTk38pivF1ODTtQuLBXaw0iBVcobF9ZwORkbHV2t/ixg2wS9MeSI71qb3sNUpmF16AbBK/rJGNDn1TA4UcwwfORZKIgec72xPAYAI79QG/RWfyEAJ3q21Ghzgs9R13Stqa49Ex8Y6e0KHbVe9zHc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.195926-0.00103417-0.80304;FP=10750538839528794842|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.hIey6t2_1776943703;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.hIey6t2_1776943703 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 19:28:24 +0800
Message-ID: <86397a66-678b-8328-4066-065e0365759f@allwinnertech.com>
Date: Thu, 23 Apr 2026 19:28:23 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] block: fix deadlock between blk_mq_freeze_queue and
 blk_mq_dispatch_list
Content-Language: en-US
From: Michael Wu <michael@allwinnertech.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk
References: <20260417082744.30124-1-michael@allwinnertech.com>
 <5fec2f0f-97e5-2c7a-73bd-ad2ad95f2e1d@allwinnertech.com>
In-Reply-To: <5fec2f0f-97e5-2c7a-73bd-ad2ad95f2e1d@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I apologize that due to some special circumstances, I was unable to 
receive your reply via email. Therefore, I am replying to you via this 
email.

I have verified that the patch you modified does indeed resolve the 
aforementioned issue. To verify this, I conducted scenario verification 
and Mokey stress testing on my platform.

So, should we choose the current solution as the final solution?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c165a6e..4217aaaa8e47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6966,7 +6966,9 @@ static inline void sched_submit_work(struct 
task_struct *tsk)
          * If we are going to sleep and we have plugged IO queued,
          * make sure to submit it to avoid deadlocks.
          */
+       preempt_disable_notrace();
         blk_flush_plug(tsk->plug, true);
+       preempt_enable_no_resched_notrace();

         lock_map_release(&sched_map);
  }

On 2026/4/20 14:31, Michael Wu wrote:
> I'd like to add some important information:
> 
> The three processes I mentioned—Task 1838 (Back-P10-3), Task 619 
> (android.hardwar), and Task 1865 (sp-control-1)—are all in an 
> uninterruptible sleep state. Therefore, once Task 1865 (sp-control-1) is 
> scheduled out using `preempt_schedule_notrace`, it cannot be scheduled 
> back. The reason Task 1865 (sp-control-1) is in an uninterruptible sleep 
> state is because `down_write` is waiting for `io_rwsem`.
> 
> My analysis of the upstream kernel code doesn't seem to have found a fix 
> for this issue. This situation should theoretically exist, but I don't 
> have a platform to test this low-probability behavior. However, it's 
> certain that this situation occurs during I/O scheduling algorithm 
> switching and concurrent F2FS write operations.
> 
> In this situation, `io_schedule_prepare` is not used. The path used in 
> Task 1865 is 
> `schedule->sched_submit_work->blk_flush_plug->blk_mq_dispatch_list`.
> 
> As you said, this method is indeed not good, but I don't have a better 
> idea to handle this deadlock situation.
> 
> On 2026/4/17 16:27, Michael Wu wrote:
>> Kernel: Linux version 6.18.16
>> Platform: Android
>>
>> A three-way deadlock can occur between blk_mq_freeze_queue and
>> blk_mq_dispatch_list involving percpu_ref reference counting and rwsem
>> synchronization:
>>
>> - Task A holds io_rwsem (e.g., F2FS write path) and enters 
>> __bio_queue_enter(),
>>    where it acquires percpu_ref and waits for mq_freeze_depth==0
>> - Task B holds mq_freeze_depth=1 (elevator_change) and waits for
>>    q_usage_counter to reach zero in blk_mq_freeze_queue_wait()
>> - Task C is scheduled out via schedule() while waiting for io_rwsem.
>>    Before switching, __blk_flush_plug() triggers blk_mq_dispatch_list()
>>    which acquires percpu_ref via percpu_ref_get(). If 
>> preempt_schedule_notrace()
>>    is triggered before percpu_ref_put(), Task C holds the reference while
>>    blocked on the rwsem.
>>
>> Since Task C cannot release its percpu_ref while blocked, Task B cannot
>> unfreeze the queue, and Task A cannot proceed to release the io_rwsem,
>> creating a circular dependency deadlock.
>>
>> Change:
>> Fix by disabling preemption in blk_mq_dispatch_list() when called from
>> schedule() (from_sched=true), ensuring percpu_ref_get() and 
>> percpu_ref_put()
>> are atomic with respect to context switches. With from_sched=true,
>> blk_mq_run_hw_queue() dispatches asynchronously via kblockd, so no driver
>> callbacks run in this context and preempt_disable() is safe.
>>
>> Detailed scenario description:
>> When process 1838 performs f2fs_submit_page_write, it obtains io_rwsem 
>> via
>> f2fs_down_write_trace. When process 1865 performs 
>> f2fs_down_write_trace and
>> wants to obtain io_rwsem, it needs to wait for process 1838 to release 
>> it,
>> so it can only be scheduled out via schedule. Before being scheduled out,
>> it clears the plug via __blk_flush_plug, so it will run to 
>> blk_mq_dispatch_list.
>> Process 619 is modifying the I/O scheduling algorithm, calling 
>> elevator_change
>> to set mq_freeze_depth=1. After that, blk_mq_freeze_queue_wait will 
>> wait for
>> the reference count of q_usage_counter to return to zero. Coincidentally,
>> process 1838 needs to wait for mq_freeze_depth=0 when it reaches
>> __bio_queue_enter, so it can only wait to be woken up after 
>> q_freeze_depth=0.
>> At this time, process 1865, when blk_mq_dispatch_list reaches the 
>> point where
>> percpu_ref_get increments the q_usage_counter reference, and before
>> percpu_ref_put, it calls preempt_schedule_notrace to schedule the 
>> process out
>> due to preemption, causing q_usage_counter to never reach zero.
>>
>> At this point, process 1865 depends on io_rwsem to wake up, process 1838
>> depends on mq_freeze_depth=0 to wake up, and process 619 depends on
>> q_usage_counter being zero to wake up and unfreeze (setting 
>> mq_freeze_depth=0),
>> resulting in a deadlock between these three processes.
>>
>> Stack traces from the deadlock:
>>
>> Task 1838 (Back-P10-3) - holds io_rwsem, waiting for queue unfreeze:
>> Call trace:
>>   __switch_to+0x1a4/0x35c
>>   __schedule+0x8e0/0xec4
>>   schedule+0x54/0xf8
>>   __bio_queue_enter+0xbc/0x19c
>>   blk_mq_submit_bio+0x118/0x814
>>   __submit_bio+0x9c/0x234
>>   submit_bio_noacct_nocheck+0x10c/0x2d4
>>   submit_bio_noacct+0x354/0x544
>>   submit_bio+0x1e8/0x208
>>   f2fs_submit_write_bio+0x44/0xe4
>>   __submit_merged_bio+0x40/0x114
>>   f2fs_submit_page_write+0x3f0/0x7e0
>>   do_write_page+0x180/0x2fc
>>   f2fs_outplace_write_data+0x78/0x100
>>   f2fs_do_write_data_page+0x3b8/0x500
>>   f2fs_write_single_data_page+0x1ac/0x6e0
>>   f2fs_write_data_pages+0x838/0xdfc
>>   do_writepages+0xd0/0x19c
>>   filemap_write_and_wait_range+0x204/0x274
>>   f2fs_commit_atomic_write+0x54/0x960
>>   __f2fs_ioctl+0x2128/0x42c8
>>   f2fs_ioctl+0x38/0xb4
>>   __arm64_sys_ioctl+0xa0/0xf4
>>
>> Task 619 (android.hardwar) - holds mq_freeze_depth=1, waiting for 
>> percpu_ref:
>> Call trace:
>>   __switch_to+0x1a4/0x35c
>>   __schedule+0x8e0/0xec4
>>   schedule+0x54/0xf8
>>   blk_mq_freeze_queue_wait+0x68/0xb0
>>   blk_mq_freeze_queue_nomemsave+0x68/0x7c
>>   elevator_change+0x70/0x14c
>>   elv_iosched_store+0x1b0/0x234
>>   queue_attr_store+0xe0/0x134
>>   sysfs_kf_write+0x98/0xbc
>>   kernfs_fop_write_iter+0x118/0x1e8
>>   vfs_write+0x2e8/0x448
>>   ksys_write+0x78/0xf0
>>   __arm64_sys_write+0x1c/0x2c
>>
>> Task 1865 (sp-control-1) - holds percpu_ref, preempted in dispatch_list:
>> Call trace:
>>   __switch_to+0x1a4/0x35c
>>   __schedule+0x8e0/0xec4
>>   preempt_schedule_notrace+0x60/0x7c
>>   blk_mq_dispatch_list+0x5c0/0x690
>>   blk_mq_flush_plug_list+0x13c/0x170
>>   __blk_flush_plug+0x11c/0x17c
>>   schedule+0x40/0xf8
>>   schedule_preempt_disabled+0x24/0x40
>>   rwsem_down_write_slowpath+0x61c/0xc88
>>   down_write+0x3c/0x158
>>   f2fs_down_write_trace+0x30/0x84
>>   f2fs_submit_page_write+0x78/0x7e0
>>   do_write_page+0x180/0x2fc
>>   f2fs_outplace_write_data+0x78/0x100
>>   f2fs_do_write_data_page+0x3b8/0x500
>>   f2fs_write_single_data_page+0x1ac/0x6e0
>>   f2fs_write_data_pages+0x838/0xdfc
>>   do_writepages+0xd0/0x19c
>>   filemap_write_and_wait_range+0x204/0x274
>>   f2fs_commit_atomic_write+0x54/0x960
>>   __f2fs_ioctl+0x2128/0x42c8
>>   f2fs_ioctl+0x38/0xb4
>>   __arm64_sys_ioctl+0xa0/0xf4
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   block/blk-mq.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 4c5c16cce4f8f..c290bb12c1ecb 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2936,6 +2936,14 @@ static void blk_mq_dispatch_list(struct rq_list 
>> *rqs, bool from_sched)
>>       *rqs = requeue_list;
>>       trace_block_unplug(this_hctx->queue, depth, !from_sched);
>> +    /*
>> +     * When called from schedule(), prevent preemption and interrupts 
>> between
>> +     * ref_get and ref_put. This ensures percpu_ref_get() and 
>> percpu_ref_put()
>> +     * are atomic with respect to context switches, avoiding a 
>> deadlock with
>> +     * blk_mq_freeze_queue where a blocked task holds a percpu_ref 
>> reference.
>> +     */
>> +    if (from_sched)
>> +        local_irq_disable();
>>       percpu_ref_get(&this_hctx->queue->q_usage_counter);
>>       /* passthrough requests should never be issued to the I/O 
>> scheduler */
>>       if (is_passthrough) {
>> @@ -2951,6 +2959,8 @@ static void blk_mq_dispatch_list(struct rq_list 
>> *rqs, bool from_sched)
>>           blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
>>       }
>>       percpu_ref_put(&this_hctx->queue->q_usage_counter);
>> +    if (from_sched)
>> +        local_irq_enable();
>>   }
>>   static void blk_mq_dispatch_multiple_queue_requests(struct rq_list 
>> *rqs)
> 

-- 
Regards,
Michael Wu
