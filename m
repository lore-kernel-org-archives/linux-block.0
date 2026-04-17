Received: from out198-26.us.a.mail.aliyun.com (out198-26.us.a.mail.aliyun.com [47.90.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0533A9DA1;
	Fri, 17 Apr 2026 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414512; cv=none; b=h5hvIG5uUCAndwr4X3XYGNVtNB/VPYVtUuFa5x0PhmMFBNvy/2G7pK/v5nwOCPweaWQmt+VaksZW/pcoNF7aqL0hzpmszy9sSUFp5D2iCAOc3No8CaKgfZ3zAWC+F7HuOfJImvpaS6rX07ZoVttNArpCajFam0rWE/voUZDdQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414512; c=relaxed/simple;
	bh=zz5B1N8zKLdE5jQaf9Rld/NgwIwzuSx5wEo9EAB/Ips=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnsJNORyNrnq3auy0OsX8rcXPYyH1tFPnBGDQ4ar8rWGDULnhQDX4WTMWXjRmv8zqdjxyL0yOpVll9x0/pTX++t75aSNQUMsGBP+KdwG25FCl0pIwH4dox6XBHiY4PmA3xtdMqLMqT/IQccVyyh9wQHkYmnnh9T9PhKvegrOLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=47.90.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436401|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0493771-0.00136213-0.949261;FP=10679044195444220635|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hECk5nG_1776414487;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.hECk5nG_1776414487 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Apr 2026 16:28:10 +0800
From: Michael Wu <michael@allwinnertech.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix deadlock between blk_mq_freeze_queue and blk_mq_dispatch_list
Date: Fri, 17 Apr 2026 16:27:44 +0800
Message-Id: <20260417082744.30124-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel: Linux version 6.18.16
Platform: Android

A three-way deadlock can occur between blk_mq_freeze_queue and
blk_mq_dispatch_list involving percpu_ref reference counting and rwsem
synchronization:

- Task A holds io_rwsem (e.g., F2FS write path) and enters __bio_queue_enter(),
  where it acquires percpu_ref and waits for mq_freeze_depth==0
- Task B holds mq_freeze_depth=1 (elevator_change) and waits for
  q_usage_counter to reach zero in blk_mq_freeze_queue_wait()
- Task C is scheduled out via schedule() while waiting for io_rwsem.
  Before switching, __blk_flush_plug() triggers blk_mq_dispatch_list()
  which acquires percpu_ref via percpu_ref_get(). If preempt_schedule_notrace()
  is triggered before percpu_ref_put(), Task C holds the reference while
  blocked on the rwsem.

Since Task C cannot release its percpu_ref while blocked, Task B cannot
unfreeze the queue, and Task A cannot proceed to release the io_rwsem,
creating a circular dependency deadlock.

Change:
Fix by disabling preemption in blk_mq_dispatch_list() when called from
schedule() (from_sched=true), ensuring percpu_ref_get() and percpu_ref_put()
are atomic with respect to context switches. With from_sched=true,
blk_mq_run_hw_queue() dispatches asynchronously via kblockd, so no driver
callbacks run in this context and preempt_disable() is safe.

Detailed scenario description:
When process 1838 performs f2fs_submit_page_write, it obtains io_rwsem via
f2fs_down_write_trace. When process 1865 performs f2fs_down_write_trace and
wants to obtain io_rwsem, it needs to wait for process 1838 to release it,
so it can only be scheduled out via schedule. Before being scheduled out,
it clears the plug via __blk_flush_plug, so it will run to blk_mq_dispatch_list.
Process 619 is modifying the I/O scheduling algorithm, calling elevator_change
to set mq_freeze_depth=1. After that, blk_mq_freeze_queue_wait will wait for
the reference count of q_usage_counter to return to zero. Coincidentally,
process 1838 needs to wait for mq_freeze_depth=0 when it reaches
__bio_queue_enter, so it can only wait to be woken up after q_freeze_depth=0.
At this time, process 1865, when blk_mq_dispatch_list reaches the point where
percpu_ref_get increments the q_usage_counter reference, and before
percpu_ref_put, it calls preempt_schedule_notrace to schedule the process out
due to preemption, causing q_usage_counter to never reach zero.

At this point, process 1865 depends on io_rwsem to wake up, process 1838
depends on mq_freeze_depth=0 to wake up, and process 619 depends on
q_usage_counter being zero to wake up and unfreeze (setting mq_freeze_depth=0),
resulting in a deadlock between these three processes.

Stack traces from the deadlock:

Task 1838 (Back-P10-3) - holds io_rwsem, waiting for queue unfreeze:
Call trace:
 __switch_to+0x1a4/0x35c
 __schedule+0x8e0/0xec4
 schedule+0x54/0xf8
 __bio_queue_enter+0xbc/0x19c
 blk_mq_submit_bio+0x118/0x814
 __submit_bio+0x9c/0x234
 submit_bio_noacct_nocheck+0x10c/0x2d4
 submit_bio_noacct+0x354/0x544
 submit_bio+0x1e8/0x208
 f2fs_submit_write_bio+0x44/0xe4
 __submit_merged_bio+0x40/0x114
 f2fs_submit_page_write+0x3f0/0x7e0
 do_write_page+0x180/0x2fc
 f2fs_outplace_write_data+0x78/0x100
 f2fs_do_write_data_page+0x3b8/0x500
 f2fs_write_single_data_page+0x1ac/0x6e0
 f2fs_write_data_pages+0x838/0xdfc
 do_writepages+0xd0/0x19c
 filemap_write_and_wait_range+0x204/0x274
 f2fs_commit_atomic_write+0x54/0x960
 __f2fs_ioctl+0x2128/0x42c8
 f2fs_ioctl+0x38/0xb4
 __arm64_sys_ioctl+0xa0/0xf4

Task 619 (android.hardwar) - holds mq_freeze_depth=1, waiting for percpu_ref:
Call trace:
 __switch_to+0x1a4/0x35c
 __schedule+0x8e0/0xec4
 schedule+0x54/0xf8
 blk_mq_freeze_queue_wait+0x68/0xb0
 blk_mq_freeze_queue_nomemsave+0x68/0x7c
 elevator_change+0x70/0x14c
 elv_iosched_store+0x1b0/0x234
 queue_attr_store+0xe0/0x134
 sysfs_kf_write+0x98/0xbc
 kernfs_fop_write_iter+0x118/0x1e8
 vfs_write+0x2e8/0x448
 ksys_write+0x78/0xf0
 __arm64_sys_write+0x1c/0x2c

Task 1865 (sp-control-1) - holds percpu_ref, preempted in dispatch_list:
Call trace:
 __switch_to+0x1a4/0x35c
 __schedule+0x8e0/0xec4
 preempt_schedule_notrace+0x60/0x7c
 blk_mq_dispatch_list+0x5c0/0x690
 blk_mq_flush_plug_list+0x13c/0x170
 __blk_flush_plug+0x11c/0x17c
 schedule+0x40/0xf8
 schedule_preempt_disabled+0x24/0x40
 rwsem_down_write_slowpath+0x61c/0xc88
 down_write+0x3c/0x158
 f2fs_down_write_trace+0x30/0x84
 f2fs_submit_page_write+0x78/0x7e0
 do_write_page+0x180/0x2fc
 f2fs_outplace_write_data+0x78/0x100
 f2fs_do_write_data_page+0x3b8/0x500
 f2fs_write_single_data_page+0x1ac/0x6e0
 f2fs_write_data_pages+0x838/0xdfc
 do_writepages+0xd0/0x19c
 filemap_write_and_wait_range+0x204/0x274
 f2fs_commit_atomic_write+0x54/0x960
 __f2fs_ioctl+0x2128/0x42c8
 f2fs_ioctl+0x38/0xb4
 __arm64_sys_ioctl+0xa0/0xf4

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 block/blk-mq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8f..c290bb12c1ecb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2936,6 +2936,14 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 	*rqs = requeue_list;
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
+	/*
+	 * When called from schedule(), prevent preemption and interrupts between
+	 * ref_get and ref_put. This ensures percpu_ref_get() and percpu_ref_put()
+	 * are atomic with respect to context switches, avoiding a deadlock with
+	 * blk_mq_freeze_queue where a blocked task holds a percpu_ref reference.
+	 */
+	if (from_sched)
+		local_irq_disable();
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
 	/* passthrough requests should never be issued to the I/O scheduler */
 	if (is_passthrough) {
@@ -2951,6 +2959,8 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
 	}
 	percpu_ref_put(&this_hctx->queue->q_usage_counter);
+	if (from_sched)
+		local_irq_enable();
 }
 
 static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
-- 
2.29.0

