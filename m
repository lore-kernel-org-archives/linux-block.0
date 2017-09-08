Return-Path: <prvs=4177119eb=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	NeilBrown <neilb@suse.com>
Subject: [PATCH 1/5] percpu-refcount: Introduce percpu_ref_switch_to_atomic_nowait()
Date: Fri,  8 Sep 2017 16:52:22 -0700
Message-Id: <20170908235226.26622-2-bart.vanassche@wdc.com>
In-Reply-To: <20170908235226.26622-1-bart.vanassche@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The blk-mq core keeps track of the number of request queue users
through q->q_usage_count. Make it possible to switch this counter
to atomic mode from the context of the block layer power management
code by introducing percpu_ref_switch_to_atomic_nowait().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: NeilBrown <neilb@suse.com>
---
 include/linux/percpu-refcount.h |  1 +
 lib/percpu-refcount.c           | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index c13dceb87b60..0d4bfbb392d7 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -100,6 +100,7 @@ void percpu_ref_exit(struct percpu_ref *ref);
 void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_switch);
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref);
+void percpu_ref_switch_to_atomic_nowait(struct percpu_ref *ref);
 void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill);
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index fe03c6d52761..cf9152ff0892 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -277,6 +277,27 @@ void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
 
+/**
+ * percpu_ref_switch_to_nowait - switch a percpu_ref to atomic mode
+ * @ref: percpu_ref to switch to atomic mode
+ *
+ * Schedule switching of @ref to atomic mode. All its percpu counts will be
+ * collected to the main atomic counter. @ref will stay in atomic mode across
+ * kill/reinit cycles until percpu_ref_switch_to_percpu() is called.
+ *
+ * This function does not block and can be called from any context.
+ */
+void percpu_ref_switch_to_atomic_nowait(struct percpu_ref *ref)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	if (!ref->confirm_switch)
+		__percpu_ref_switch_to_atomic(ref, NULL);
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+}
+EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_nowait);
+
 /**
  * percpu_ref_switch_to_percpu - switch a percpu_ref to percpu mode
  * @ref: percpu_ref to switch to percpu mode
-- 
2.14.1
