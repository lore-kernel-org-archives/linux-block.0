Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE411A3166
	for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050370; cv=none; b=XhyscmrW8IEYEAuYaYezIX9wx/cdAzrZVrMWlIeKQFShMvQEeDJwOclb6RxNpx5JB0Duu2KeTSw95xZ7IcpecSbP7xqXePS3b+/TLK2fiDFYC9CLbseb0+MTflOus9cKMJIQuFAr84MFXbKhCLVC1SYaBtW4ggUp/ZG6/BMVgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050370; c=relaxed/simple;
	bh=7E8W3VETOqPs9uJNQ/rJsMQaDBaWzPuymTc/8AWSl9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UVZ7OqJB2RCoWQ5ioqbSJQufDs9MmbMxiq3HJx83rB+6VrCNJXqN2Mw4DtQG4C6TOluQ4PUtUfGfKSzuqPV7drinwZrvJm2DwnTzo/RRVTHaOwpADV01wCsD984tUiWb02d0NbvFK08fEgz+mc4z6YyMikWoSH0RqOP4TiioeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KADqT/t7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KADqT/t7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c77d52bec4so1596715ad.1
        for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782050368; x=1782655168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOlLZDSp/+f4baWmQ+nL2uVR8nR0njaY3srnmTa/4vA=;
        b=KADqT/t7A8AxSN7wX/GeeM3MSeNHVpFwjMHO4zZ4YFxlENfvjP14UtpN7mOM9y/bKK
         JddU/IWDcH01+G2pMkvbMpYC3yschpu+K40bTGLVIG7ZERU88dNyuYFIMdTdvghXBLwk
         z4toQjbPNQgofZ6KMPYU1kjC6GuiE5tOjpDQrAS4l3QtAmaouC77Qi6B1FPFix5B2amB
         GdMxffF+UeEzWi2RNLRldG3YCFQ8bT7ojNQHf2PUB2YQX/+XlPUqHljZYclbi0B+5LQ4
         mvxrgIYPtAy23HKPC7ejvhcOHNjDt8yY+aHBsbmCwiO7Z2LFqKlvbkjUo6Xd7wcJz6zb
         weRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782050368; x=1782655168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOlLZDSp/+f4baWmQ+nL2uVR8nR0njaY3srnmTa/4vA=;
        b=Q7HHc4aJyP0cxAVM+cN/278iqV0SVnykV364u8y0kLD0cfMkUYs+j4OqmnhlPVtL5w
         vucz3Q7WafyBBmiSmtlIZ8GtolgsfcC+eR1RtRfjie67mFXNmF7Mx6zs3OR/hLuHok48
         ajSwZsDBbS9fRDOcVDNvzYB3hdW4RuQIUbML9SaOYpN+aNwS8o9xmgudxysUIT5nB0lA
         Xsqc6uBWKAm3+nmWZdS78XIdNMkeAaz4e2E+62i+3zHuZyvnHz8RcTKRA0Q4mTCY9mJo
         +MOOTabtmYhi7JCvUwh2U0s5knXgUHvXcmXDcKZq2zDxysbs+uW8LjMCah6qFoiRJn53
         uNrg==
X-Forwarded-Encrypted: i=1; AHgh+RoIvVwV7coGuReQSFKFL4kA5DEV5m+75jsAoMcFCf8igNrnw90Soq42YW8KznzpFY94I2y7Eg5SRvbkEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5frA93EnZSjclqnAvTS18egfQk7MOvypIsyYv6eGniqLH6Xe4
	sqEzEKBuMIhHAMtM53otoxHOLScsycRlT3q4SgzXA6MdahzIdd6SJjjr
X-Gm-Gg: AfdE7cn5/EfCSdY7YKudrNNhY4l4f/9jlWXJKPxmJZ1LyUsjHMr+TkrmIijps6GuCqd
	6NPHmWqq9A+cP/EYVGB1tiT6Kr3LV3gYqsqDJm9VMDIrsi4ThJTKbyuJOFZb4onM3/RGmw0HZRI
	ST1/MM3dDvmk4UQiyZo8/9/Ss0a7Po/tF/uwFGk6xTIX65znmKZX22G6w/rM5eKqPvUEMbkXD2I
	qx4Ys2T+W8YeEegh0cY40TDiTBkDXUqJo/lUWI0dhM3czIW4lvfqJYncc9P/ue8r9X9l0S5CEJ5
	5zL7C9EgY2D0YaDQ1XvPyFj1rMUkfxuyth7Yot8SG4X5tXHBIaqyiZQMwqJclGLtbKEuAUUipe3
	XvDEQAuOgOu5p3CIYsOLTv++m6oQAfiN7wXneRx5S1iMhi4BydjaQn07CtGtra6y2njDOXWNdS3
	HKvPH9gp8=
X-Received: by 2002:a17:903:3b8f:b0:2bf:1aa9:6c8a with SMTP id d9443c01a7336-2c719548b7bmr92391135ad.12.1782050367929;
        Sun, 21 Jun 2026 06:59:27 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f5ff5sm50948385ad.29.2026.06.21.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:59:27 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] blk-iolatency: flush enable work after policy deactivation
Date: Sun, 21 Jun 2026 21:59:16 +0800
Message-Id: <20260621135916.2657247-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A blk-iolatency rq-qos teardown can free struct blk_iolatency while a
freshly queued enable_work callback still references it. The observed
failure is:

blkcg_iolatency_exit() flushes enable_work before deactivating the
iolatency policy. However, blkcg_deactivate_policy() calls
iolatency_pd_offline() for online policy data, and iolatency_pd_offline()
clears min_lat_nsec through iolatency_set_min_lat_nsec(). If this clears
the last nonzero latency target, enable_cnt reaches zero and schedules
enable_work again after the flush has already returned.

The buggy scenario involves two paths, with each column showing the order
within that path:

blkcg_iolatency_exit() path:          system_wq worker path:
1. Flush old enable_work.             1. enable_work is idle.
2. Deactivate the policy.             2. no worker owns it.
3. Offline queues new enable_work.    3. work item becomes pending.
4. Free blkiolat.                     4. worker later runs the item.
5. Owner storage is gone.             5. worker dereferences blkiolat.

Flush enable_work again after blkcg_deactivate_policy() returns and before
freeing blkiolat. Policy offline callbacks have completed at that point,
so the second drain covers the late queueing path without changing the
normal enable/disable accounting rules.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in assign_work+0x2a/0x150

Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_report+0xd0/0x630
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0xea/0x1a0
 ? assign_work+0x2a/0x150
 kasan_report+0xce/0x100
 ? assign_work+0x2a/0x150
 assign_work+0x2a/0x150
 worker_thread+0x1b7/0x500
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x192/0x1d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2ac/0x3c0
 ? __pfx_ret_from_fork+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __switch_to+0x2d5/0x6e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 470:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 iolatency_set_limit+0x301/0x450
 cgroup_file_write+0x178/0x2e0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 611:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x43/0x70
 kfree+0x131/0x390
 rq_qos_exit+0x5d/0x90
 __del_gendisk+0x394/0x490
 del_gendisk+0xa1/0xe0
 virtblk_remove+0x41/0xd0
 virtio_dev_remove+0x63/0xe0
 device_release_driver_internal+0x246/0x2e0
 unbind_store+0xa9/0xb0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 kasan_record_aux_stack+0x8c/0xa0
 __queue_work+0x42a/0x800
 queue_work_on+0x5d/0x70
 iolatency_set_min_lat_nsec+0x196/0x230
 iolatency_pd_offline+0x1f/0x40
 blkcg_deactivate_policy+0x194/0x270
 blkcg_iolatency_exit+0x33/0x40
 rq_qos_exit+0x5d/0x90
 __del_gendisk+0x394/0x490
 del_gendisk+0xa1/0xe0
 virtblk_remove+0x41/0xd0
 virtio_dev_remove+0x63/0xe0
 device_release_driver_internal+0x246/0x2e0
 unbind_store+0xa9/0xb0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60
 kasan_record_aux_stack+0x8c/0xa0
 __queue_work+0x42a/0x800
 queue_work_on+0x5d/0x70
 iolatency_set_min_lat_nsec+0x196/0x230
 iolatency_set_limit+0x3f1/0x450
 cgroup_file_write+0x178/0x2e0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO hangs on offline")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 block/blk-iolatency.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 1aaee6fb0f59..a0bdd8a5c94c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -639,6 +639,11 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	timer_shutdown_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
 	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
+	/*
+	 * blkcg_deactivate_policy() invokes iolatency_pd_offline(), which may
+	 * queue enable_work again when it clears the last latency target.
+	 */
+	flush_work(&blkiolat->enable_work);
 	kfree(blkiolat);
 }
 
-- 
2.43.0

