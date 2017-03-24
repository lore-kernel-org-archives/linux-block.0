Return-Path: <tahsin@google.com>
Return-Path: <tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
To: Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>,
	linux-kernel@vger.kernel.org,
	Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH] blkcg: allocate struct blkcg_gq outside request queue spinlock
Date: Fri, 24 Mar 2017 14:56:27 -0700
Message-Id: <20170324215627.12831-1-tahsin@google.com>
In-Reply-To: <CAAeU0aMvuzfkAyhzheYRxfb7NzLk2oJSzUk5+BoVcktrZDtcRw@mail.gmail.com>
References: <CAAeU0aMvuzfkAyhzheYRxfb7NzLk2oJSzUk5+BoVcktrZDtcRw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

blkg_conf_prep() currently calls blkg_lookup_create() while holding
request queue spinlock. This means allocating memory for struct
blkcg_gq has to be made non-blocking. This causes occasional -ENOMEM
failures in call paths like below:

  pcpu_alloc+0x68f/0x710
  __alloc_percpu_gfp+0xd/0x10
  __percpu_counter_init+0x55/0xc0
  cfq_pd_alloc+0x3b2/0x4e0
  blkg_alloc+0x187/0x230
  blkg_create+0x489/0x670
  blkg_lookup_create+0x9a/0x230
  blkg_conf_prep+0x1fb/0x240
  __cfqg_set_weight_device.isra.105+0x5c/0x180
  cfq_set_weight_on_dfl+0x69/0xc0
  cgroup_file_write+0x39/0x1c0
  kernfs_fop_write+0x13f/0x1d0
  __vfs_write+0x23/0x120
  vfs_write+0xc2/0x1f0
  SyS_write+0x44/0xb0
  entry_SYSCALL_64_fastpath+0x18/0xad

In the code path above, percpu allocator cannot call vmalloc() due to
queue spinlock.

A failure in this call path gives grief to tools which are trying to
configure io weights. We see occasional failures happen shortly after
reboots even when system is not under any memory pressure. Machines
with a lot of cpus are more vulnerable to this condition.

Do struct blkcg_gq allocations outside the queue spinlock to allow
blocking during memory allocations.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
v6:
  Due to Jens' objection to conditionally dropping locks based on gfp
  flags, go back to v1 approach.
  Perform queue bypass and policy enabled checks at every iteration.
  Add blkg_lookup_check() to reduce code duplication.

v5:
  Removed stale blkg_alloc() in blkcg_init_queue()

  Pushed down radix_tree_preload() into blkg_create() because it
  disables preemption on return and makes it unsafe to call blocking
  memory allocations.

v4:
  Simplified error checking in blkg_create()
  Factored out __blkg_lookup_create()

v3:
  Pushed down all blkg allocations into blkg_create()

v2:
  Moved blkg creation into blkg_lookup_create() to avoid duplicating
  blkg_lookup_create() logic.

 block/blk-cgroup.c | 123 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 25 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bbe7ee00bd3d..7c2947128f58 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -772,6 +772,27 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
 }
 EXPORT_SYMBOL_GPL(blkg_rwstat_recursive_sum);
 
+/* Performs queue bypass and policy enabled checks then looks up blkg. */
+static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
+					  const struct blkcg_policy *pol,
+					  struct request_queue *q)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	lockdep_assert_held(q->queue_lock);
+
+	if (!blkcg_policy_enabled(q, pol))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/*
+	 * This could be the first entry point of blkcg implementation and
+	 * we shouldn't allow anything to go through for a bypassing queue.
+	 */
+	if (unlikely(blk_queue_bypass(q)))
+		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
+
+	return __blkg_lookup(blkcg, q, true /* update_hint */);
+}
+
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
  * @blkcg: target block cgroup
@@ -789,6 +810,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	__acquires(rcu) __acquires(disk->queue->queue_lock)
 {
 	struct gendisk *disk;
+	struct request_queue *q;
 	struct blkcg_gq *blkg;
 	struct module *owner;
 	unsigned int major, minor;
@@ -807,44 +829,95 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	if (!disk)
 		return -ENODEV;
 	if (part) {
-		owner = disk->fops->owner;
-		put_disk(disk);
-		module_put(owner);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail;
 	}
 
-	rcu_read_lock();
-	spin_lock_irq(disk->queue->queue_lock);
+	q = disk->queue;
 
-	if (blkcg_policy_enabled(disk->queue, pol))
-		blkg = blkg_lookup_create(blkcg, disk->queue);
-	else
-		blkg = ERR_PTR(-EOPNOTSUPP);
+	rcu_read_lock();
+	spin_lock_irq(q->queue_lock);
 
+	blkg = blkg_lookup_check(blkcg, pol, q);
 	if (IS_ERR(blkg)) {
 		ret = PTR_ERR(blkg);
+		goto fail_unlock;
+	}
+
+	if (blkg)
+		goto success;
+
+	/*
+	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
+	 * non-root blkgs have access to their parents.
+	 */
+	while (true) {
+		struct blkcg *pos = blkcg;
+		struct blkcg *parent;
+		struct blkcg_gq *new_blkg;
+
+		parent = blkcg_parent(blkcg);
+		while (parent && !__blkg_lookup(parent, q, false)) {
+			pos = parent;
+			parent = blkcg_parent(parent);
+		}
+
+		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
+		spin_unlock_irq(q->queue_lock);
 		rcu_read_unlock();
-		spin_unlock_irq(disk->queue->queue_lock);
-		owner = disk->fops->owner;
-		put_disk(disk);
-		module_put(owner);
-		/*
-		 * If queue was bypassing, we should retry.  Do so after a
-		 * short msleep().  It isn't strictly necessary but queue
-		 * can be bypassing for some time and it's always nice to
-		 * avoid busy looping.
-		 */
-		if (ret == -EBUSY) {
-			msleep(10);
-			ret = restart_syscall();
+
+		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
+		if (unlikely(!new_blkg)) {
+			ret = -ENOMEM;
+			goto fail;
 		}
-		return ret;
-	}
 
+		rcu_read_lock();
+		spin_lock_irq(q->queue_lock);
+
+		blkg = blkg_lookup_check(pos, pol, q);
+		if (IS_ERR(blkg)) {
+			ret = PTR_ERR(blkg);
+			goto fail_unlock;
+		}
+
+		if (blkg) {
+			blkg_free(new_blkg);
+		} else {
+			blkg = blkg_create(pos, q, new_blkg);
+			if (unlikely(IS_ERR(blkg))) {
+				ret = PTR_ERR(blkg);
+				goto fail_unlock;
+			}
+		}
+
+		if (pos == blkcg)
+			goto success;
+	}
+success:
 	ctx->disk = disk;
 	ctx->blkg = blkg;
 	ctx->body = body;
 	return 0;
+
+fail_unlock:
+	spin_unlock_irq(q->queue_lock);
+	rcu_read_unlock();
+fail:
+	owner = disk->fops->owner;
+	put_disk(disk);
+	module_put(owner);
+	/*
+	 * If queue was bypassing, we should retry.  Do so after a
+	 * short msleep().  It isn't strictly necessary but queue
+	 * can be bypassing for some time and it's always nice to
+	 * avoid busy looping.
+	 */
+	if (ret == -EBUSY) {
+		msleep(10);
+		ret = restart_syscall();
+	}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
-- 
2.12.1.578.ge9c3154ca4-goog
