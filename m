Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD839A073
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780634; cv=none; b=IcMQO1TGucNRPYVnhTuR5HxM95er6o/+w+i77F7dwsEk9RP+zOQBO3JDkR3o/ZYVRA5IiiWfwpTuTTEkv/lfJzXwARz6LMTAzewmgRMBl+Qg4nlxnJQ9oILcJPKCucHzU0sLtOq3XwPUEV1WW4SvhFz1jFAgiIIJSHPE2A0yrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780634; c=relaxed/simple;
	bh=VlVNnET59qp7sYtNfvZm/ug9u86ZIpy7lydevuufoEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX+9HDKjkkBnMW3vxAFimdabSASGXKQ4uhU8zxkMY7VS5Qs/S+SA4pkHEIKnFvPzPTUup/1XTpjK1d8eOM1cWftAQkF6ksau2CJPcCZpfTGT5AO00bE4hpjoqIes5meQVzKWUZOUlPLua3okSQjEPInb0kteDAaA+rUr/j8FXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nC1TZffg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nC1TZffg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777780630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JibZg3K6fdIKERhnG5WNIDYBBg7/eFAvH5BOk/poHKE=;
	b=nC1TZffgQ5t5RnO8YvKOXnjYlg0XwPGiwmE8tQXrg/KnxuSur/Ek+6zZqad3CeoVF/U7zn
	X3ckHatIc9ZQHHTKy/a4HD+D7ldItvPKlzffFoWD2i1EOIZVQ0l/WdVH/kVhJLxrzKr40H
	PRcP92U64/TDLD/JtcOq+HHztpYTB0c=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: axboe@kernel.dk,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [RFC v2 2/3] block: Introduce the UFQ I/O scheduler
Date: Sun,  3 May 2026 11:56:22 +0800
Message-ID: <20260503035623.28771-3-kaitao.cheng@linux.dev>
In-Reply-To: <20260503035623.28771-1-kaitao.cheng@linux.dev>
References: <20260503035623.28771-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Introduce IOSCHED_UFQ, a blk-mq elevator ("ufq: User-programmable
Flexible Queueing") whose policy is supplied by an eBPF program via
struct_ops (insert, dispatch, merge, finish, etc.).

When no eBPF program is attached, the UFQ I/O scheduler uses a simple,
per-ctx queueing policy (similar to none). After an eBPF program is
attached, the user-defined scheduling policy replaces UFQ’s built-in
queueing policy, while per-ctx queues remain available as a fallback
mechanism.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 block/Kconfig.iosched |   8 +
 block/Makefile        |   1 +
 block/blk-merge.c     |  28 +-
 block/blk-mq.c        |   8 +-
 block/blk-mq.h        |   2 +-
 block/blk.h           |   5 +
 block/ufq-bpfops.c    | 241 ++++++++++++++++
 block/ufq-iosched.c   | 640 ++++++++++++++++++++++++++++++++++++++++++
 block/ufq-iosched.h   |  64 +++++
 block/ufq-kfunc.c     | 131 +++++++++
 10 files changed, 1115 insertions(+), 13 deletions(-)
 create mode 100644 block/ufq-bpfops.c
 create mode 100644 block/ufq-iosched.c
 create mode 100644 block/ufq-iosched.h
 create mode 100644 block/ufq-kfunc.c

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 27f11320b8d1..56afc425cc52 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -44,4 +44,12 @@ config BFQ_CGROUP_DEBUG
 	Enable some debugging help. Currently it exports additional stat
 	files in a cgroup which can be useful for debugging.
 
+config IOSCHED_UFQ
+	tristate "UFQ I/O scheduler"
+	default y
+	help
+	The UFQ I/O scheduler is a programmable I/O scheduler. When
+	enabled, an out-of-kernel I/O scheduler based on eBPF can be
+	designed to interact with it, leveraging its customizable
+	hooks to redefine I/O scheduling policies.
 endmenu
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..a58ea7384b7a 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
+obj-$(CONFIG_IOSCHED_UFQ)	+= ufq-iosched.o ufq-bpfops.o ufq-kfunc.o
 
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o \
 				   bio-integrity-auto.o bio-integrity-fs.o
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..7a98dc75a06f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -774,8 +774,8 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be held.
  */
-static struct request *attempt_merge(struct request_queue *q,
-				     struct request *req, struct request *next)
+static struct request *attempt_merge(struct request_queue *q, struct request *req,
+				     struct request *next, bool nohash)
 {
 	if (!rq_mergeable(req) || !rq_mergeable(next))
 		return NULL;
@@ -842,7 +842,7 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	req->__data_len += blk_rq_bytes(next);
 
-	if (!blk_discard_mergable(req))
+	if (!nohash && !blk_discard_mergable(req))
 		elv_merge_requests(q, req, next);
 
 	blk_crypto_rq_put_keyslot(next);
@@ -868,7 +868,7 @@ static struct request *attempt_back_merge(struct request_queue *q,
 	struct request *next = elv_latter_request(q, rq);
 
 	if (next)
-		return attempt_merge(q, rq, next);
+		return attempt_merge(q, rq, next, false);
 
 	return NULL;
 }
@@ -879,11 +879,17 @@ static struct request *attempt_front_merge(struct request_queue *q,
 	struct request *prev = elv_former_request(q, rq);
 
 	if (prev)
-		return attempt_merge(q, prev, rq);
+		return attempt_merge(q, prev, rq, false);
 
 	return NULL;
 }
 
+struct request *bpf_attempt_merge(struct request_queue *q, struct request *rq,
+				  struct request *next)
+{
+	return attempt_merge(q, rq, next, true);
+}
+
 /*
  * Try to merge 'next' into 'rq'. Return true if the merge happened, false
  * otherwise. The caller is responsible for freeing 'next' if the merge
@@ -892,7 +898,7 @@ static struct request *attempt_front_merge(struct request_queue *q,
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 			   struct request *next)
 {
-	return attempt_merge(q, rq, next);
+	return attempt_merge(q, rq, next, false);
 }
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
@@ -1035,11 +1041,11 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
 	return BIO_MERGE_FAILED;
 }
 
-static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
-						   struct request *rq,
-						   struct bio *bio,
-						   unsigned int nr_segs,
-						   bool sched_allow_merge)
+enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
+					    struct request *rq,
+					    struct bio *bio,
+					    unsigned int nr_segs,
+					    bool sched_allow_merge)
 {
 	if (!blk_rq_merge_ok(rq, bio))
 		return BIO_MERGE_NONE;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..bebc1306d8fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -796,7 +796,7 @@ static void blk_mq_finish_request(struct request *rq)
 	}
 }
 
-static void __blk_mq_free_request(struct request *rq)
+void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
@@ -1844,6 +1844,12 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 		if (list_empty(&ctx->rq_lists[type]))
 			sbitmap_clear_bit(sb, bitnr);
 	}
+
+	if (dispatch_data->rq) {
+		dispatch_data->rq->rq_flags |= RQF_STARTED;
+		if (hctx->queue->last_merge == dispatch_data->rq)
+			hctx->queue->last_merge = NULL;
+	}
 	spin_unlock(&ctx->lock);
 
 	return !dispatch_data->rq;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index aa15d31aaae9..3f85cae7bf57 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -56,7 +56,7 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
 void blk_mq_put_rq_ref(struct request *rq);
-
+void __blk_mq_free_request(struct request *rq);
 /*
  * Internal helpers for allocating/freeing the request map
  */
diff --git a/block/blk.h b/block/blk.h
index ec4674cdf2ea..51adc4cdcee4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -313,6 +313,9 @@ enum bio_merge_status {
 
 enum bio_merge_status bio_attempt_back_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs);
+enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
+		struct request *rq, struct bio *bio, unsigned int nr_segs,
+		bool sched_allow_merge);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
@@ -444,6 +447,8 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
 
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
+struct request *bpf_attempt_merge(struct request_queue *q, struct request *rq,
+				  struct request *next);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
diff --git a/block/ufq-bpfops.c b/block/ufq-bpfops.c
new file mode 100644
index 000000000000..1c3c62e6c47e
--- /dev/null
+++ b/block/ufq-bpfops.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+#include <linux/rcupdate.h>
+#include "ufq-iosched.h"
+
+struct ufq_iosched_ops ufq_ops;
+static atomic_t ufq_bpfops_enabled;
+static atomic_t ufq_bpfops_users;
+static DECLARE_WAIT_QUEUE_HEAD(ufq_bpfops_wq);
+
+const struct ufq_iosched_ops *ufq_bpfops_tryget(void)
+{
+	if (!atomic_read(&ufq_bpfops_enabled))
+		return NULL;
+
+	atomic_inc(&ufq_bpfops_users);
+	/*
+	 * Pairs with disable path flipping ufq_bpfops_enabled to make sure no
+	 * callback runs after teardown starts.
+	 */
+	smp_mb__after_atomic();
+
+	if (unlikely(!atomic_read(&ufq_bpfops_enabled))) {
+		if (atomic_dec_and_test(&ufq_bpfops_users))
+			wake_up_all(&ufq_bpfops_wq);
+		return NULL;
+	}
+
+	return &ufq_ops;
+}
+
+void ufq_bpfops_put(void)
+{
+	if (atomic_dec_and_test(&ufq_bpfops_users))
+		wake_up_all(&ufq_bpfops_wq);
+}
+
+static const struct bpf_func_proto *
+bpf_ufq_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id, prog);
+}
+
+static bool bpf_ufq_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (type != BPF_READ)
+		return false;
+	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	/*
+	 * btf_ctx_access() treats pointers that are not "pointer to struct"
+	 * as scalars (no reg_type), so loading pointers like merge_req()'s
+	 * int *type or merge_bio()'s bool *merged from ctx leaves a SCALAR
+	 * and stores through them fail verification. Model both as writable
+	 * buffers.
+	 */
+	if (size == sizeof(__u64) && prog->aux->attach_func_name &&
+	    ((!strcmp(prog->aux->attach_func_name, "merge_req") && off == 16) ||
+	     (!strcmp(prog->aux->attach_func_name, "merge_bio") && off == 24))) {
+		if (!btf_ctx_access(off, size, type, prog, info))
+			return false;
+		info->reg_type = PTR_TO_BUF;
+		return true;
+	}
+
+	return btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_verifier_ops bpf_ufq_verifier_ops = {
+	.get_func_proto = bpf_ufq_get_func_proto,
+	.is_valid_access = bpf_ufq_is_valid_access,
+};
+
+static int bpf_ufq_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	const struct ufq_iosched_ops *uops = udata;
+	struct ufq_iosched_ops *ops = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	int ret;
+
+	switch (moff) {
+	case offsetof(struct ufq_iosched_ops, name):
+		ret = bpf_obj_name_cpy(ops->name, uops->name,
+				       sizeof(ops->name));
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	/* other var adding .... */
+	}
+
+	return 0;
+}
+
+static int bpf_ufq_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int bpf_ufq_enable(void *ops)
+{
+	ufq_ops = *(struct ufq_iosched_ops *)ops;
+	atomic_set(&ufq_bpfops_enabled, 1);
+	return 0;
+}
+
+static void bpf_ufq_disable(struct ufq_iosched_ops *ops)
+{
+	atomic_set(&ufq_bpfops_enabled, 0);
+	wait_event(ufq_bpfops_wq, !atomic_read(&ufq_bpfops_users));
+	memset(&ufq_ops, 0, sizeof(ufq_ops));
+}
+
+static int bpf_ufq_reg(void *kdata, struct bpf_link *link)
+{
+	return ufq_prepare_bpf_attach(bpf_ufq_enable, kdata);
+}
+
+static void bpf_ufq_unreg(void *kdata, struct bpf_link *link)
+{
+	bpf_ufq_disable(kdata);
+	ufq_kick_all_hw_queues();
+}
+
+static int bpf_ufq_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_ufq_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	/*
+	 * UFQ does not support live-updating an already-attached BPF scheduler:
+	 * partial failure during callback setup (e.g. init_sched) would be hard
+	 * to reason about, and update can race with unregister/teardown.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int bpf_ufq_validate(void *kdata)
+{
+	return 0;
+}
+
+static int init_sched_stub(struct request_queue *q)
+{
+	return -EPERM;
+}
+
+static int exit_sched_stub(struct request_queue *q)
+{
+	return -EPERM;
+}
+
+static int insert_req_stub(struct request_queue *q, struct request *rq,
+			   blk_insert_t flags)
+{
+	return 0;
+}
+
+static struct request *dispatch_req_stub(struct request_queue *q)
+{
+	return NULL;
+}
+
+static bool has_req_stub(struct request_queue *q, int rqs_count)
+{
+	return rqs_count > 0;
+}
+
+static void finish_req_stub(struct request *rq)
+{
+}
+
+static struct request *merge_req_stub(struct request_queue *q, struct request *rq,
+				      int *type)
+{
+	*type = ELEVATOR_NO_MERGE;
+	return NULL;
+}
+
+static struct request *merge_bio_stub(struct request_queue *q, struct bio *bio,
+				      unsigned int nr_segs, bool *merged)
+{
+	if (merged)
+		*merged = false;
+
+	return NULL;
+}
+
+static struct ufq_iosched_ops __bpf_ops_ufq_ops = {
+	.init_sched		= init_sched_stub,
+	.exit_sched		= exit_sched_stub,
+	.insert_req		= insert_req_stub,
+	.dispatch_req		= dispatch_req_stub,
+	.has_req		= has_req_stub,
+	.merge_req		= merge_req_stub,
+	.finish_req		= finish_req_stub,
+	.merge_bio		= merge_bio_stub,
+};
+
+static struct bpf_struct_ops bpf_iosched_ufq_ops = {
+	.verifier_ops = &bpf_ufq_verifier_ops,
+	.reg = bpf_ufq_reg,
+	.unreg = bpf_ufq_unreg,
+	.check_member = bpf_ufq_check_member,
+	.init_member = bpf_ufq_init_member,
+	.init = bpf_ufq_init,
+	.update = bpf_ufq_update,
+	.validate = bpf_ufq_validate,
+	.name = "ufq_iosched_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_ops_ufq_ops
+};
+
+int bpf_ufq_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_iosched_ufq_ops, ufq_iosched_ops);
+}
diff --git a/block/ufq-iosched.c b/block/ufq-iosched.c
new file mode 100644
index 000000000000..ebbb63e0ef51
--- /dev/null
+++ b/block/ufq-iosched.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/sbitmap.h>
+#include <linux/workqueue.h>
+
+#include <trace/events/block.h>
+
+#include "elevator.h"
+#include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-sched.h"
+#include "blk-mq-debugfs.h"
+#include "ufq-iosched.h"
+
+static DEFINE_MUTEX(ufq_active_queues_lock);
+static LIST_HEAD(ufq_active_queues);
+
+enum ufq_priv_state {
+	UFQ_PRIV_NOT_IN_SCHED = 0,
+	UFQ_PRIV_IN_BPF = 1,
+	UFQ_PRIV_IN_UFQ = 2,
+	UFQ_PRIV_IN_SCHED = 3,
+};
+
+static struct request *ufq_dispatch_request(struct blk_mq_hw_ctx *hctx)
+{
+	struct ufq_data *ufq = hctx->queue->elevator->elevator_data;
+	const struct ufq_iosched_ops *ops;
+	struct blk_mq_ctx *ctx;
+	struct request *rq = NULL;
+	unsigned short idx;
+
+	ops = ufq_bpfops_tryget();
+	if (ops && ops->dispatch_req) {
+		rq = ops->dispatch_req(hctx->queue);
+		if (!rq) {
+			atomic_inc(&ufq->ops_stats.dispatch_null_count);
+			ufq_bpfops_put();
+			return NULL;
+		}
+		ufq_bpfops_put();
+
+		/* The BPF insert_req callback bumps the request's reference
+		 * count; dispatch_req returns that same request with an extra
+		 * reference held. The kernel must put that reference here,
+		 * and the request's refcount is always greater than zero at
+		 * this point.
+		 */
+		if (WARN_ON_ONCE(req_ref_put_and_test(rq))) {
+			__blk_mq_free_request(rq);
+			return NULL;
+		}
+
+		ctx = rq->mq_ctx;
+		spin_lock(&ctx->lock);
+		if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IDLE ||
+			     (rq->rq_flags & RQF_STARTED) ||
+			     list_empty(&rq->queuelist))) {
+			spin_unlock(&ctx->lock);
+			return NULL;
+		}
+		list_del_init(&rq->queuelist);
+		rq->rq_flags |= RQF_STARTED;
+		if (hctx->queue->last_merge == rq)
+			hctx->queue->last_merge = NULL;
+		if (list_empty(&ctx->rq_lists[rq->mq_hctx->type]))
+			sbitmap_clear_bit(&rq->mq_hctx->ctx_map,
+					  ctx->index_hw[rq->mq_hctx->type]);
+		spin_unlock(&ctx->lock);
+		atomic_inc(&ufq->ops_stats.dispatch_ok_count);
+		atomic64_add(blk_rq_sectors(rq), &ufq->ops_stats.dispatch_ok_sectors);
+		rq->elv.priv[0] = (void *)((uintptr_t)rq->elv.priv[0]
+				  & ~UFQ_PRIV_IN_UFQ);
+	} else {
+		if (ops)
+			ufq_bpfops_put();
+		ctx = READ_ONCE(hctx->dispatch_from);
+		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
+		if (rq) {
+			idx = rq->mq_ctx->index_hw[hctx->type];
+			if (++idx == hctx->nr_ctx)
+				idx = 0;
+			WRITE_ONCE(hctx->dispatch_from, hctx->ctxs[idx]);
+		}
+	}
+
+	if (rq)
+		atomic_dec(&ufq->rqs_count);
+	return rq;
+}
+
+/*
+ * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
+ * function is used by __blk_mq_get_tag().
+ */
+static void ufq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
+{
+	struct ufq_data *ufq = data->q->elevator->elevator_data;
+
+	/* Do not throttle synchronous reads. */
+	if (op_is_sync(opf) && !op_is_write(opf))
+		return;
+
+	/*
+	 * Throttle asynchronous requests and writes such that these requests
+	 * do not block the allocation of synchronous requests.
+	 */
+	data->shallow_depth = ufq->async_depth;
+}
+
+static void ufq_depth_updated(struct request_queue *q)
+{
+	struct ufq_data *ufq = q->elevator->elevator_data;
+
+	ufq->async_depth = q->nr_requests;
+	q->async_depth = q->nr_requests;
+	blk_mq_set_min_shallow_depth(q, 1);
+}
+
+static int ufq_init_sched(struct request_queue *q, struct elevator_queue *eq)
+{
+	const struct ufq_iosched_ops *ops;
+	struct ufq_data *ufq;
+
+	ufq = kzalloc_node(sizeof(*ufq), GFP_KERNEL, q->node);
+	if (!ufq)
+		return -ENOMEM;
+
+	eq->elevator_data = ufq;
+	ufq->q = q;
+	INIT_LIST_HEAD(&ufq->active_node);
+
+	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
+	q->elevator = eq;
+
+	q->async_depth = q->nr_requests;
+	ufq->async_depth = q->nr_requests;
+
+	ops = ufq_bpfops_tryget();
+	if (ops) {
+		if (ops->init_sched)
+			ops->init_sched(q);
+		ufq_bpfops_put();
+	}
+
+	mutex_lock(&ufq_active_queues_lock);
+	list_add_tail(&ufq->active_node, &ufq_active_queues);
+	mutex_unlock(&ufq_active_queues_lock);
+
+	ufq_depth_updated(q);
+	return 0;
+}
+
+static void ufq_exit_sched(struct elevator_queue *e)
+{
+	const struct ufq_iosched_ops *ops;
+	struct ufq_data *ufq = e->elevator_data;
+
+	ops = ufq_bpfops_tryget();
+	if (ops) {
+		if (ops->exit_sched)
+			ops->exit_sched(ufq->q);
+		ufq_bpfops_put();
+	}
+
+	mutex_lock(&ufq_active_queues_lock);
+	if (!list_empty(&ufq->active_node))
+		list_del_init(&ufq->active_node);
+	mutex_unlock(&ufq_active_queues_lock);
+
+	WARN_ON_ONCE(atomic_read(&ufq->rqs_count));
+
+	kfree(ufq);
+	e->elevator_data = NULL;
+}
+
+void ufq_kick_all_hw_queues(void)
+{
+	struct ufq_data *ufq;
+
+	mutex_lock(&ufq_active_queues_lock);
+	list_for_each_entry(ufq, &ufq_active_queues, active_node)
+		blk_mq_run_hw_queues(ufq->q, true);
+	mutex_unlock(&ufq_active_queues_lock);
+}
+
+static int ufq_drain_ctx_rqs(struct ufq_data *ufq)
+{
+	struct request_queue *q = ufq->q;
+	unsigned long deadline = jiffies + 8 * HZ;
+
+	while (atomic_read(&ufq->rqs_count) > 0 && time_before(jiffies, deadline)) {
+		blk_mq_run_hw_queues(q, false);
+		if (atomic_read(&ufq->rqs_count) > 0) {
+			struct blk_mq_hw_ctx *hctx;
+			unsigned long i;
+
+			queue_for_each_hw_ctx(q, hctx, i)
+				flush_delayed_work(&hctx->run_work);
+			flush_delayed_work(&q->requeue_work);
+		}
+		cond_resched();
+	}
+
+	if (atomic_read(&ufq->rqs_count) > 0) {
+		pr_warn_ratelimited("ufq: drain timeout (%d rqs) before BPF attach\n",
+				    atomic_read(&ufq->rqs_count));
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/*
+ * Mirror elevator_change(): freeze each queue, cancel mq dispatch work,
+ * then drain software-ctx requests while BPF callbacks are still off.
+ * @enable runs with all those queues still frozen so new ctx backlog cannot
+ * race ahead of turning BPF dispatch on.
+ */
+int ufq_prepare_bpf_attach(int (*enable)(void *kdata), void *kdata)
+{
+	struct ufq_data *ufq;
+	unsigned int memflags;
+	int frozen = 0, ret = 0;
+
+	mutex_lock(&ufq_active_queues_lock);
+	if (list_empty(&ufq_active_queues)) {
+		mutex_unlock(&ufq_active_queues_lock);
+		return enable(kdata);
+	}
+
+	memflags = memalloc_noio_save();
+	list_for_each_entry(ufq, &ufq_active_queues, active_node) {
+		blk_mq_freeze_queue_nomemsave(ufq->q);
+		blk_mq_cancel_work_sync(ufq->q);
+		frozen++;
+		ret = ufq_drain_ctx_rqs(ufq);
+		if (ret)
+			goto unfreeze;
+	}
+
+	ret = enable(kdata);
+unfreeze:
+	list_for_each_entry(ufq, &ufq_active_queues, active_node) {
+		if (!frozen--)
+			break;
+		blk_mq_unfreeze_queue_nomemrestore(ufq->q);
+	}
+	memalloc_noio_restore(memflags);
+	mutex_unlock(&ufq_active_queues_lock);
+	return ret;
+}
+
+static bool ufq_bio_merge(struct request_queue *q, struct bio *bio,
+			  unsigned int nr_segs)
+{
+	struct ufq_data *ufq = q->elevator->elevator_data;
+	const struct ufq_iosched_ops *ops;
+	struct request *rq = NULL, *last;
+	enum bio_merge_status mstat;
+	struct blk_mq_ctx *ctx;
+	bool ret = false;
+
+	/*
+	 * Levels of merges:
+	 *	nomerges:  No merges at all attempted
+	 *	noxmerges: Only simple one-hit cache try
+	 *	merges:    All merge tries attempted
+	 */
+	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
+		return false;
+
+	last = q->last_merge;
+	if (last) {
+		ctx = last->mq_ctx;
+		spin_lock(&ctx->lock);
+		if (last == q->last_merge && !list_empty(&last->queuelist)
+		    && elv_bio_merge_ok(last, bio)) {
+			mstat = blk_attempt_bio_merge(q, last, bio, nr_segs, true);
+			if (mstat == BIO_MERGE_OK) {
+				spin_unlock(&ctx->lock);
+				atomic_inc(&ufq->ops_stats.merge_bio_ok_count);
+				atomic64_add(bio->bi_iter.bi_size >> SECTOR_SHIFT,
+					     &ufq->ops_stats.merge_bio_ok_sectors);
+				return true;
+			}
+			if (mstat == BIO_MERGE_FAILED) {
+				spin_unlock(&ctx->lock);
+				return false;
+			}
+		}
+		spin_unlock(&ctx->lock);
+	}
+
+	if (blk_queue_noxmerges(q))
+		return false;
+
+	ops = ufq_bpfops_tryget();
+	if (ops) {
+		if (ops->merge_bio) {
+			rq = ops->merge_bio(q, bio, nr_segs, &ret);
+			if (ret) {
+				atomic_inc(&ufq->ops_stats.merge_bio_ok_count);
+				atomic64_add(bio->bi_iter.bi_size >> SECTOR_SHIFT,
+					     &ufq->ops_stats.merge_bio_ok_sectors);
+			} else {
+				ufq_bpfops_put();
+				return false;
+			}
+
+			if (rq) {
+				ufq_bpfops_put();
+				spin_lock(&rq->mq_ctx->lock);
+				if (!list_empty(&rq->queuelist)) {
+					list_del_init(&rq->queuelist);
+					atomic_dec(&ufq->rqs_count);
+				}
+				spin_unlock(&rq->mq_ctx->lock);
+				blk_mq_free_request(rq);
+				atomic_inc(&ufq->ops_stats.merge_request_ok_count);
+				atomic64_add(bio->bi_iter.bi_size >> SECTOR_SHIFT,
+					     &ufq->ops_stats.merge_request_ok_sectors);
+				return ret;
+			}
+		}
+		ufq_bpfops_put();
+	}
+
+	return ret;
+}
+
+static enum elv_merge ufq_try_insert_merge(struct request_queue *q,
+					   struct request **new)
+{
+	const struct ufq_iosched_ops *ops;
+	struct request *target = NULL, *free = NULL, *last, *rq = *new;
+	struct ufq_data *ufq = q->elevator->elevator_data;
+	enum elv_merge type = ELEVATOR_NO_MERGE;
+	int merge_type = ELEVATOR_NO_MERGE;
+
+	if (!rq_mergeable(rq))
+		return ELEVATOR_NO_MERGE;
+
+	if (blk_queue_nomerges(q))
+		return ELEVATOR_NO_MERGE;
+
+	last = q->last_merge;
+	if (last) {
+		spin_lock(&last->mq_ctx->lock);
+		if (last == q->last_merge && !list_empty(&last->queuelist)
+		    && bpf_attempt_merge(q, last, rq)) {
+			spin_unlock(&last->mq_ctx->lock);
+			type = ELEVATOR_BACK_MERGE;
+			free = rq;
+			*new = NULL;
+			goto end;
+		}
+		spin_unlock(&last->mq_ctx->lock);
+	}
+
+	if (blk_queue_noxmerges(q))
+		return ELEVATOR_NO_MERGE;
+
+	ops = ufq_bpfops_tryget();
+	if (ops && ops->merge_req) {
+		target = ops->merge_req(q, rq, &merge_type);
+		type = (enum elv_merge)merge_type;
+	}
+
+	if (target && WARN_ON_ONCE(req_ref_put_and_test(target))) {
+		__blk_mq_free_request(target);
+		ufq_bpfops_put();
+		return ELEVATOR_NO_MERGE;
+	}
+
+	if (type == ELEVATOR_NO_MERGE || !target) {
+		if (ops)
+			ufq_bpfops_put();
+		return ELEVATOR_NO_MERGE;
+	} else if (type == ELEVATOR_FRONT_MERGE) {
+		if (rq->mq_ctx != target->mq_ctx || rq->mq_hctx != target->mq_hctx)
+			goto rollback;
+		spin_lock(&target->mq_ctx->lock);
+		free = bpf_attempt_merge(q, rq, target);
+		if (!free) {
+			spin_unlock(&target->mq_ctx->lock);
+			pr_err("ufq-iosched: front merge failed\n");
+			goto rollback;
+		}
+		rq->elv.priv[0] = (void *)((uintptr_t)rq->elv.priv[0]
+				  | UFQ_PRIV_IN_UFQ);
+		list_replace_init(&target->queuelist, &rq->queuelist);
+		rq->fifo_time = target->fifo_time;
+		q->last_merge = rq;
+	} else if (type == ELEVATOR_BACK_MERGE) {
+		spin_lock(&target->mq_ctx->lock);
+		free = bpf_attempt_merge(q, target, rq);
+		if (!free) {
+			spin_unlock(&target->mq_ctx->lock);
+			pr_err("ufq-iosched: back merge failed\n");
+			goto rollback;
+		}
+		*new = target;
+		q->last_merge = target;
+	}
+
+	spin_unlock(&target->mq_ctx->lock);
+	if (ops)
+		ufq_bpfops_put();
+end:
+	atomic_inc(&ufq->ops_stats.merge_request_ok_count);
+	atomic64_add(blk_rq_sectors(free), &ufq->ops_stats.merge_request_ok_sectors);
+	blk_mq_free_request(free);
+	return type;
+
+rollback:
+	if (ops) {
+		if (ops->insert_req && ops->insert_req(q, target, 0)) {
+			atomic_inc(&ufq->ops_stats.insert_err_count);
+			pr_err("ufq-iosched: rollback insert_req error\n");
+		}
+		ufq_bpfops_put();
+	}
+
+	return ELEVATOR_NO_MERGE;
+}
+
+static void ufq_insert_requests(struct blk_mq_hw_ctx *hctx,
+			       struct list_head *list,
+			       blk_insert_t flags)
+{
+	struct request_queue *q = hctx->queue;
+	struct ufq_data *ufq = q->elevator->elevator_data;
+	const struct ufq_iosched_ops *ops;
+	struct blk_mq_ctx *ctx;
+	enum elv_merge type;
+	int bit, ret = 0;
+
+	ops = ufq_bpfops_tryget();
+
+	while (!list_empty(list)) {
+		struct request *rq;
+
+		rq = list_first_entry(list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+
+		type = ufq_try_insert_merge(q, &rq);
+		if (type == ELEVATOR_NO_MERGE) {
+			rq->fifo_time = jiffies;
+			ctx = rq->mq_ctx;
+			rq->elv.priv[0] = (void *)((uintptr_t)rq->elv.priv[0]
+					  | UFQ_PRIV_IN_UFQ);
+			spin_lock(&ctx->lock);
+			if (flags & BLK_MQ_INSERT_AT_HEAD)
+				list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
+			else
+				list_add_tail(&rq->queuelist,
+					&ctx->rq_lists[hctx->type]);
+
+			bit = ctx->index_hw[hctx->type];
+			if (!sbitmap_test_bit(&hctx->ctx_map, bit))
+				sbitmap_set_bit(&hctx->ctx_map, bit);
+			q->last_merge = rq;
+			spin_unlock(&ctx->lock);
+			atomic_inc(&ufq->rqs_count);
+		}
+
+		if (ops && rq && ops->insert_req) {
+			rq->elv.priv[0] = (void *)((uintptr_t)rq->elv.priv[0]
+				  | UFQ_PRIV_IN_BPF);
+			ret = ops->insert_req(q, rq, flags);
+			if (ret) {
+				atomic_inc(&ufq->ops_stats.insert_err_count);
+				pr_err("ufq-iosched: bpf insert_req error (%d)\n", ret);
+			} else {
+				atomic_inc(&ufq->ops_stats.insert_ok_count);
+				atomic64_add(blk_rq_sectors(rq), &ufq->ops_stats.insert_ok_sectors);
+			}
+		}
+	}
+
+	if (ops)
+		ufq_bpfops_put();
+}
+
+static void ufq_prepare_request(struct request *rq)
+{
+	rq->elv.priv[0] = (void *)(uintptr_t)UFQ_PRIV_NOT_IN_SCHED;
+}
+
+static void ufq_finish_request(struct request *rq)
+{
+	const struct ufq_iosched_ops *ops;
+	struct ufq_data *ufq = rq->q->elevator->elevator_data;
+
+	/*
+	 * The block layer core may call ufq_finish_request() without having
+	 * called ufq_insert_requests(). Skip requests that bypassed I/O
+	 * scheduling.
+	 */
+	if (!((uintptr_t)rq->elv.priv[0] & UFQ_PRIV_IN_BPF))
+		return;
+
+	ops = ufq_bpfops_tryget();
+	if (ops) {
+		if (ops->finish_req)
+			ops->finish_req(rq);
+		ufq_bpfops_put();
+	}
+
+	atomic_inc(&ufq->ops_stats.finish_ok_count);
+	atomic64_add(blk_rq_stats_sectors(rq), &ufq->ops_stats.finish_ok_sectors);
+}
+
+static bool ufq_has_work(struct blk_mq_hw_ctx *hctx)
+{
+	const struct ufq_iosched_ops *ops;
+	struct ufq_data *ufq = hctx->queue->elevator->elevator_data;
+	int rqs_count = atomic_read(&ufq->rqs_count);
+
+	ops = ufq_bpfops_tryget();
+	if (!ops)
+		return rqs_count > 0;
+
+	if (ops->has_req)
+		rqs_count = ops->has_req(hctx->queue, rqs_count);
+	ufq_bpfops_put();
+	return rqs_count > 0;
+}
+
+#ifdef CONFIG_BLK_DEBUG_FS
+static int ufq_ops_stats_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct ufq_data *ufq = q->elevator->elevator_data;
+	struct ufq_ops_stats *s = &ufq->ops_stats;
+
+	/* for debug */
+	seq_printf(m, "dispatch_ok_count %d\n",
+		   atomic_read(&s->dispatch_ok_count));
+	seq_printf(m, "dispatch_ok_sectors %lld\n",
+		   (long long)atomic64_read(&s->dispatch_ok_sectors));
+	seq_printf(m, "dispatch_null_count %d\n",
+		   atomic_read(&s->dispatch_null_count));
+	seq_printf(m, "insert_ok_count %d\n",
+		   atomic_read(&s->insert_ok_count));
+	seq_printf(m, "insert_ok_sectors %lld\n",
+		   (long long)atomic64_read(&s->insert_ok_sectors));
+	seq_printf(m, "insert_err_count %d\n",
+		   atomic_read(&s->insert_err_count));
+	seq_printf(m, "merge_req_ok_count %d\n",
+		   atomic_read(&s->merge_request_ok_count));
+	seq_printf(m, "merge_req_ok_sectors %lld\n",
+		   (long long)atomic64_read(&s->merge_request_ok_sectors));
+	seq_printf(m, "merge_bio_ok_count %d\n",
+		   atomic_read(&s->merge_bio_ok_count));
+	seq_printf(m, "merge_bio_ok_sectors %lld\n",
+		   (long long)atomic64_read(&s->merge_bio_ok_sectors));
+	seq_printf(m, "finish_ok_count %d\n",
+		   atomic_read(&s->finish_ok_count));
+	seq_printf(m, "finish_ok_sectors %lld\n",
+		   (long long)atomic64_read(&s->finish_ok_sectors));
+	return 0;
+}
+
+static const struct blk_mq_debugfs_attr ufq_iosched_debugfs_attrs[] = {
+	{"ops_stats", 0400, ufq_ops_stats_show},
+	{},
+};
+#endif
+
+static struct elevator_type ufq_iosched_mq = {
+	.ops = {
+		.depth_updated		= ufq_depth_updated,
+		.limit_depth		= ufq_limit_depth,
+		.insert_requests	= ufq_insert_requests,
+		.dispatch_request	= ufq_dispatch_request,
+		.prepare_request	= ufq_prepare_request,
+		.finish_request		= ufq_finish_request,
+		.bio_merge		= ufq_bio_merge,
+		.has_work		= ufq_has_work,
+		.init_sched		= ufq_init_sched,
+		.exit_sched		= ufq_exit_sched,
+	},
+
+#ifdef CONFIG_BLK_DEBUG_FS
+	.queue_debugfs_attrs = ufq_iosched_debugfs_attrs,
+#endif
+	.elevator_name = "ufq",
+	.elevator_alias = "ufq_iosched",
+	.elevator_owner = THIS_MODULE,
+};
+MODULE_ALIAS("ufq-iosched");
+
+static int __init ufq_init(void)
+{
+	int ret;
+
+	ret = elv_register(&ufq_iosched_mq);
+	if (ret)
+		return ret;
+
+	ret = bpf_ufq_kfunc_init();
+	if (ret) {
+		pr_err("ufq-iosched: Failed to register kfunc sets (%d)\n", ret);
+		elv_unregister(&ufq_iosched_mq);
+		return ret;
+	}
+
+	ret = bpf_ufq_ops_init();
+	if (ret) {
+		pr_err("ufq-iosched: Failed to register struct_ops (%d)\n", ret);
+		elv_unregister(&ufq_iosched_mq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit ufq_exit(void)
+{
+	elv_unregister(&ufq_iosched_mq);
+}
+
+module_init(ufq_init);
+module_exit(ufq_exit);
+
+MODULE_AUTHOR("Kaitao Cheng <chengkaitao@kylinos.cn>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("User-programmable Flexible Queueing");
diff --git a/block/ufq-iosched.h b/block/ufq-iosched.h
new file mode 100644
index 000000000000..26a9c1708e8b
--- /dev/null
+++ b/block/ufq-iosched.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#ifndef _BLOCK_UFQ_IOSCHED_H
+#define _BLOCK_UFQ_IOSCHED_H
+
+#include <linux/types.h>
+#include "elevator.h"
+#include "blk-mq.h"
+
+#ifndef BPF_IOSCHED_NAME_MAX
+#define BPF_IOSCHED_NAME_MAX	16
+#endif
+
+/* For testing and debugging */
+struct ufq_ops_stats {
+	atomic_t dispatch_ok_count;
+	atomic64_t dispatch_ok_sectors;
+	atomic_t dispatch_null_count;
+	atomic_t insert_ok_count;
+	atomic64_t insert_ok_sectors;
+	atomic_t insert_err_count;
+	atomic_t merge_request_ok_count;
+	atomic64_t merge_request_ok_sectors;
+	atomic_t merge_bio_ok_count;
+	atomic64_t merge_bio_ok_sectors;
+	atomic_t finish_ok_count;
+	atomic64_t finish_ok_sectors;
+};
+
+struct ufq_iosched_ops {
+	int (*init_sched)(struct request_queue *q);
+	int (*exit_sched)(struct request_queue *q);
+	bool (*has_req)(struct request_queue *q, int rqs_count);
+	int (*insert_req)(struct request_queue *q, struct request *rq,
+			blk_insert_t flags);
+	void (*finish_req)(struct request *rq);
+	struct request *(*merge_req)(struct request_queue *q, struct request *rq,
+			int *type);
+	struct request *(*merge_bio)(struct request_queue *q, struct bio *bio,
+			unsigned int nr_segs, bool *merged);
+	struct request *(*dispatch_req)(struct request_queue *q);
+	char name[BPF_IOSCHED_NAME_MAX];
+};
+
+struct ufq_data {
+	struct request_queue *q;
+	u32 async_depth;
+	atomic_t rqs_count;
+	struct list_head active_node;
+	struct ufq_ops_stats ops_stats;
+};
+
+const struct ufq_iosched_ops *ufq_bpfops_tryget(void);
+void ufq_bpfops_put(void);
+void ufq_kick_all_hw_queues(void);
+int ufq_prepare_bpf_attach(int (*enable)(void *kdata), void *kdata);
+
+int bpf_ufq_ops_init(void);
+int bpf_ufq_kfunc_init(void);
+
+#endif /* _BLOCK_UFQ_IOSCHED_H */
diff --git a/block/ufq-kfunc.c b/block/ufq-kfunc.c
new file mode 100644
index 000000000000..c799eeffcba0
--- /dev/null
+++ b/block/ufq-kfunc.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <trace/events/block.h>
+#include "blk.h"
+#include "ufq-iosched.h"
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc struct request *bpf_request_acquire(struct request *rq)
+{
+	if (req_ref_inc_not_zero(rq))
+		return rq;
+	return NULL;
+}
+
+__bpf_kfunc void bpf_request_release(struct request *rq)
+{
+	if (req_ref_put_and_test(rq))
+		__blk_mq_free_request(rq);
+}
+
+__bpf_kfunc bool bpf_request_bio_try_merge(struct request *rq, struct bio *bio,
+					   unsigned int nr_segs)
+{
+	struct blk_mq_ctx *ctx;
+	bool merged;
+
+	if (!rq || !bio)
+		return false;
+
+	ctx = rq->mq_ctx;
+	if (!ctx || !rq->q || !bio->bi_bdev || !bio->bi_bdev->bd_disk ||
+	    bio->bi_bdev->bd_disk->queue != rq->q)
+		return false;
+
+	spin_lock(&ctx->lock);
+	merged = blk_attempt_bio_merge(rq->q, rq, bio, nr_segs, true) == BIO_MERGE_OK;
+	spin_unlock(&ctx->lock);
+
+	return merged;
+}
+
+__bpf_kfunc struct request *bpf_request_try_merge(struct request *rq, struct request *next)
+{
+	struct blk_mq_ctx *ctx;
+	struct ufq_data *ufq;
+	struct request *free;
+
+	if (!rq || !next || !rq->q || rq->q != next->q)
+		return NULL;
+
+	ufq = rq->q->elevator->elevator_data;
+	if (!ufq)
+		return NULL;
+
+	if (rq->mq_ctx != next->mq_ctx || rq->mq_hctx != next->mq_hctx)
+		return NULL;
+
+	ctx = rq->mq_ctx;
+	if (!ctx)
+		return NULL;
+
+	spin_lock(&ctx->lock);
+	free = bpf_attempt_merge(rq->q, rq, next);
+	if (free) {
+		if (rq->q->last_merge == free)
+			rq->q->last_merge = NULL;
+		list_del_init(&free->queuelist);
+		atomic_dec(&ufq->rqs_count);
+	}
+	spin_unlock(&ctx->lock);
+
+	return free;
+}
+
+__bpf_kfunc_end_defs();
+
+#if defined(CONFIG_X86_KERNEL_IBT)
+static const void * const __used __section(".discard.ibt_endbr_noseal")
+__ibt_noseal_bpf_request_release = (void *)bpf_request_release;
+#endif
+
+BTF_KFUNCS_START(ufq_kfunc_set_ops)
+BTF_ID_FLAGS(func, bpf_request_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_request_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_request_bio_try_merge, KF_SPIN_LOCK)
+BTF_ID_FLAGS(func, bpf_request_try_merge, KF_SPIN_LOCK)
+BTF_KFUNCS_END(ufq_kfunc_set_ops)
+
+static const struct btf_kfunc_id_set bpf_ufq_kfunc_set = {
+	.owner			= THIS_MODULE,
+	.set			= &ufq_kfunc_set_ops,
+};
+
+BTF_ID_LIST(bpf_ufq_dtor_kfunc_ids)
+BTF_ID(struct, request)
+BTF_ID(func, bpf_request_release)
+
+int bpf_ufq_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc bpf_ufq_dtor_kfunc[] = {
+		{
+		  .btf_id       = bpf_ufq_dtor_kfunc_ids[0],
+		  .kfunc_btf_id = bpf_ufq_dtor_kfunc_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_ufq_kfunc_set);
+	if (ret)
+		return ret;
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_ufq_kfunc_set);
+	if (ret)
+		return ret;
+	ret = register_btf_id_dtor_kfuncs(bpf_ufq_dtor_kfunc,
+					  ARRAY_SIZE(bpf_ufq_dtor_kfunc),
+					  THIS_MODULE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
-- 
2.50.1 (Apple Git-155)

