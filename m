Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBA367F4A
	for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050380; cv=none; b=uwiVMnOM4tB7jI/kcqV1bYCwjtUvgTtRycZVEoonZpAv8HgIjfnJLc6QXzdTaO5cNV0RTK5cQym7PPACagg8xxTE4m+wiCoNFykhArATIV1nfzT5UGuOMk2XadfqnEkyR9Hkfp1lwFcYjuTqv+Xhvmkg18gtSMMfOCvMpOb/+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050380; c=relaxed/simple;
	bh=ZabKe5E7hQaeta+i1gpG26EptKw1h2aS8CscSjWN6DM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyUyOviU7bhd7YGbje9fKXmn8IhcZ4ABnsWkLhTTm7AwNuo9m8N7nMGSiTAb91ODK07bCYUEbt2AliEG8yMMMIrNE7xOazzRVVUJ5aq1k2+B8pAvJ6LS8E6vOBzMyJ9rdeJZ1PfmsCFz6JvZ5Kcd4fWzqzEw7nR1r5cePz9a1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii2JFM9l; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii2JFM9l"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c6be9cd7afso14795525ad.1
        for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782050378; x=1782655178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNTGtnZY5zRsA4z+5Uwq3U+N25cEnPuOjGZ1HDsGRcw=;
        b=ii2JFM9llR5aj2DE2mosXHs92pvb1qhBEPqgzmbdGT5HMjNVlhvGNR1jZeMSlYq6hs
         2IKLxjVCE0SHfjSFh+yb9Rs/+Fp/WvTkYS4pLsv8loLqm4ycmFxSO7zopj9kOxUlZyXc
         rq/njQkNpHRkxhqP52VGv+WSgyR7TQjBiJ+0vZm3adu6D1xpdGVwXF6tz4vuLzjus4IO
         tmX4IU8c+I0V5xajH3jdPKfB1Sy1HMiEYK/cZeQv3mZ0rqzUWyQw1gbS34TwyG50D/iR
         kZPX8eA2Lwr/1E9/93qmasSfF8QMC+k4H+PBo7kcEowBnLX/usMXDG4cuBRjnDHMtWt5
         kwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782050378; x=1782655178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNTGtnZY5zRsA4z+5Uwq3U+N25cEnPuOjGZ1HDsGRcw=;
        b=SB7lUghJxAVkIEi7mhdAB/a+Xm+rljN0L1DQShZzlFkiVafp3rOQBNJDSyrpbwSgvy
         ff9l9L/nKgxzz8CPPPceUi2hDShWECYwkofy4knI/jIVD3xRgzAUIJ0BO0OZj67dpPR1
         vJnisArTEt62DakYEUmEmivb0eIC6CpZZZ9CZNqLfGSx8onffuCRKf5soNXM24K2hV6D
         KbZCfhPjxYItf2YCmGG84PtuXKjYUI+idCiZbbaK70boDvxOab1mOWPNriHKmKqsxHtg
         CqWK36dI8vngnSjNmmP1IKOF9F1LHKVC7WIf+IaGMmKRi8U+TTI4ZcoJWcpL/cY2YH6m
         uRAg==
X-Gm-Message-State: AOJu0YwlskfcPbo74/VSfxMXyF6glYPyUbQFVq2dJoqXIhZow4NPiL5d
	L5N7vKVQCR46M9iUtVWZkxyv1hfKABxY//gAkG1EsdawuUz65QkB7zhj
X-Gm-Gg: AfdE7cn/+aZOOJaXzMkQKUSPy9qfXzwm1fIN1iNYeRPIh5nj3iSAmjceBaXJ7jmegS/
	1JwlvcKdQpScCcQWa/fvoUbqdG/wdWM3tncg9x8o/tNQlToiSLw8+kZL+hrlBm4eRcHVIWCYZ4M
	s85zWCXeQNlRVh4z+/hfJpcahzenClzXXG0k18PRI5MGpkdkk6IYi+MEVeA3fr0e2KYWlqX9NJO
	14d929o5Rdg5UY1YMms7q1tylI2qcxG84qEcRDHUkVfWcGe9lDT7RYB1pA3A10Sklh1IpGlyFyB
	PEHQu+6ImGKfEbgvdtPed4l6GH7TNRjFVO4XE8U+sdzctLkdo3Y6spAzBU9CjyWldj7Jx5+ZNri
	otlvYSizPKzHs9IX2CSf4obm6s2nCANcDjqeP+Jf2Ept9zV17fD0P0sZaJpkcfjC/BCPJjPw7uQ
	GOariGIPg=
X-Received: by 2002:a17:902:e850:b0:2c4:397:b77f with SMTP id d9443c01a7336-2c718fe3018mr118223355ad.18.1782050378156;
        Sun, 21 Jun 2026 06:59:38 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe8aasm46881325ad.68.2026.06.21.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:59:36 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Yu Kuai <yukuai@fygo.io>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] block, bfq: protect async queue reset with blkcg locks
Date: Sun, 21 Jun 2026 21:59:30 +0800
Message-Id: <20260621135930.2657810-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing 0 to BFQ's low_latency attribute ends weight raising for active,
idle and async queues. The async cgroup path walks q->blkg_list, converts
each blkg to BFQ policy data and then reads bfqg->async_bfqq and
bfqg->async_idle_bfqq.

That walk was protected only by bfqd->lock. blkcg release work is
serialized by q->blkcg_mutex and q->queue_lock instead, and
blkg_free_workfn() can call BFQ's pd_free_fn before it removes
blkg->q_node from q->blkg_list. A low_latency reset can therefore still
find the blkg on the queue list after the BFQ policy data has been freed.

The buggy scenario involves two paths, with each column showing the order
within that path:

BFQ low_latency reset:              blkcg blkg release work:
1. bfq_low_latency_store()          1. blkg_free_workfn() takes
   calls bfq_end_wr().                 q->blkcg_mutex.
2. bfq_end_wr_async() walks         2. BFQ pd_free_fn drops the
   q->blkg_list.                       final bfq_group reference.
3. blkg_to_bfqg() returns           3. blkg->q_node remains on
   the stale policy data.              q->blkg_list until list_del_init().
4. bfq_end_wr_async_queues()
   reads async queue fields.

Fix this by taking q->blkcg_mutex and q->queue_lock around the
q->blkg_list walk, then taking bfqd->lock before touching BFQ async
queues. The mutex serializes against policy-data free and queue_lock
stabilizes the list. Move the async reset out of bfq_end_wr()'s existing
bfqd->lock critical section so the lock order matches blkcg policy
callbacks.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in bfq_end_wr_async_queues+0x246/0x340

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? bfq_end_wr_async_queues+0x246/0x340
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x20d/0x410
 ? bfq_end_wr_async_queues+0x246/0x340
 kasan_report+0xe0/0x110
 ? bfq_end_wr_async_queues+0x246/0x340
 bfq_end_wr_async_queues+0x246/0x340
 bfq_end_wr_async+0xba/0x180
 bfq_low_latency_store+0x4e5/0x690
 ? 0xffffffffc02150da
 ? __pfx_bfq_low_latency_store+0x10/0x10
 ? __pfx_bfq_low_latency_store+0x10/0x10
 elv_attr_store+0xc4/0x110
 kernfs_fop_write_iter+0x2f5/0x4a0
 vfs_write+0x604/0x11f0
 ? __pfx_locks_remove_posix+0x10/0x10
 ? __pfx_vfs_write+0x10/0x10
 ksys_write+0xf9/0x1d0
 ? __pfx_ksys_write+0x10/0x10
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Allocated by task 544:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 bfq_pd_alloc+0xc0/0x1b0
 blkg_alloc+0x346/0x960
 blkg_create+0x8c2/0x10d0
 bio_associate_blkg_from_css+0x9f3/0xfa0
 bio_associate_blkg+0xd9/0x200
 bio_init+0x303/0x640
 __blkdev_direct_IO_simple+0x56b/0x8a0
 blkdev_direct_IO+0x8e7/0x2580
 blkdev_read_iter+0x205/0x400
 vfs_read+0x7b0/0xda0
 ksys_read+0xf9/0x1d0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 465:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x307/0x580
 blkg_free_workfn+0xef/0x460
 process_one_work+0x8d0/0x1870
 worker_thread+0x575/0xf80
 kthread+0x2e7/0x3c0
 ret_from_fork+0x576/0x810
 ret_from_fork_asm+0x1a/0x30

Fixes: 44e44a1b329e ("block, bfq: improve responsiveness")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 block/bfq-cgroup.c  | 13 ++++++++++++-
 block/bfq-iosched.c |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 0bd0332b3d78..d8fdace464b4 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -936,14 +936,23 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 
 void bfq_end_wr_async(struct bfq_data *bfqd)
 {
+	struct request_queue *q = bfqd->queue;
 	struct blkcg_gq *blkg;
 
-	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
+	mutex_lock(&q->blkcg_mutex);
+	spin_lock_irq(&q->queue_lock);
+	spin_lock(&bfqd->lock);
+
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		bfq_end_wr_async_queues(bfqd, bfqg);
 	}
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
+
+	spin_unlock(&bfqd->lock);
+	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 }
 
 static int bfq_io_show_weight_legacy(struct seq_file *sf, void *v)
@@ -1416,7 +1425,9 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio) {}
 
 void bfq_end_wr_async(struct bfq_data *bfqd)
 {
+	spin_lock_irq(&bfqd->lock);
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
+	spin_unlock_irq(&bfqd->lock);
 }
 
 struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..eec9be62061b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2653,9 +2653,10 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	}
 	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
 		bfq_bfqq_end_wr(bfqq);
-	bfq_end_wr_async(bfqd);
 
 	spin_unlock_irq(&bfqd->lock);
+
+	bfq_end_wr_async(bfqd);
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
-- 
2.43.0

