Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6338F24A
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612099; cv=none; b=QNLoFPuxOGSRcJUxcZpOtgPYmlxgGqJZRj7FpZMR+nCmGyFcaDNUz476CoAXuoSDoXQQ5zBkswVm51By7lPy0zQrs7kJUz/O6KtLVdcA+T99OSCiwlcQCiyVl05cKOz/zV4Jgm3rSFzSuV6ApLQ4aAmTip9MBLuLN5JKbz0Z2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612099; c=relaxed/simple;
	bh=dKCR7pybUyAPWG3tJyNF5cYzi+Msf0/5LLEP7cUr6+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0Vt8dJ4ADMHnY3TPjvpCcPO6xf79C6baF+Ct0pXU8olg1iQNAzHLoMtr4lPcVAD1RHuJmfEnegiHmLWCSq49Mi64fFb4sog13NHGsP/SjBgFnPX9fTKJ9/1YH7VMN1UdDSpOgQYg39rfmxLDgq4NdopdtKbnWRGiKJzf/tBQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onDsU6fC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onDsU6fC"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so1848995b3a.3
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774612089; x=1775216889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTgArwDFua9Bni/2aeQGmjeoKAPdB8oefON+7G3CfUE=;
        b=onDsU6fCczL3pJjelkA1TyrlTg03UhkBaq5cVX4Pqk67XxEBYTiOCspkNeloBjDhrI
         wW/4s3mFF6kU3fYsjcumlu6v+Lm4suBAiQoZSmih/n9WDNeQ8lLv0LVfChcvuE9gQnnh
         KGfH6PgRXf5Dofdrrav7ozmsu9wjxYETEPdQ9AQ2bxqUuM9ItF50SdB5o6u7T345nCBU
         MB2y2LNVbu3PeAm+IJv3ezA6ei+yZp5BVmddw1vpPYv62MtNFOSOsGLGx1x4XrK6X85h
         5azv17JTB+vvAWSIgPue1brMi+qPuvfUFkFbiGzogJqyPFl69W+iXxk8mFfqQkEWrwbX
         pesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612089; x=1775216889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTgArwDFua9Bni/2aeQGmjeoKAPdB8oefON+7G3CfUE=;
        b=ZRaYMoLLIdCI0sZCW+aeia2cd3yfFpXpbMRDx1Q5V978PrBzNMBe9zVvR32J0PjBzP
         X/NzkRl6orXFW2ST14iVxRLVsNUmx8GtpJl2UxiIxR2ie87kTdk9Dv/PXxSEycOGfhjE
         aCKofGLn3k62lDEIjjHdDLIxsV+r0px2APuT6IdmL/qjmT7Mygx3pcjgMHaYpc385AOD
         vlE10xaFmcdOFJghSO5/YXn0wDRfAjPcrXRekp5nBCHe1a9viWSJHXIiDGOAPs1NjowK
         2KZFjsNHASuX3qcHgTFZmrxS9bAL0X+D0txJEmpIEai0fe+d4LzsVwx4Sskha2R8fI7z
         1AVA==
X-Gm-Message-State: AOJu0Yz6fV3A9zX0bmNO+8XC/mvqVqr6JKDHCDeA2Fbdb5LRwzcmuwNx
	NoKjr74KKlYj1JZdcfLo3hP4JjYb/kOHFHkn1DnrGGbTlrYNeesdF9iP
X-Gm-Gg: ATEYQzz0FN5SxedNLsK4we34ns4oK++1429sQLgzgdPhjZ6qRV47EKQ2TlVX2f6XmZK
	Y4jUve5nSJbx+wApCdeKUD05clIIV6V4JHwxxWS/HgauN1GNgDlCyjwa3jEq4lSIcXyWDWoIl/o
	3ym4Nbs2eO+qEttX/HwHE+Pd+quEq3YnFqo5GGmfO8o9gjjPzYpd0Z7ajre77oUltPgbW4gXpg4
	UZrRgZ5ZTkDJiZhpu4FzWLoYMiqWia8fuc3ZdGfkHGwzUCaJOWHxm0UfwoXm5bMfUeqn/oKxCuE
	IWsMKDUuJOSYyqHY2vS8dQXRP1BsJ63M6ZG0D3kvAZEPRfu4dXyo884AJmnTNhID+GQrlMYMadN
	GU2UfZzw1LRWdoOxKycE0oVps05OgiRQUMx0uFfGU/PVNtGWwjxL358USM0sw9aCxiHanrq7h5P
	mRu1m1G96jKOoVWRC9L3v11fM7DSnzgOn11aIXyIhZxQODygq3JwSO7g==
X-Received: by 2002:a05:6a00:27a0:b0:81e:12f1:d8a with SMTP id d2e1a72fcca58-82c95ebecabmr2416695b3a.34.1774612089285;
        Fri, 27 Mar 2026 04:48:09 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3c289dsm5235572b3a.47.2026.03.27.04.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Mar 2026 04:48:08 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [RFC 1/2] block: Introduce the UFQ I/O scheduler
Date: Fri, 27 Mar 2026 19:47:40 +0800
Message-ID: <20260327114741.91500-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260327114741.91500-1-pilgrimtao@gmail.com>
References: <20260327114741.91500-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 block/blk-merge.c     |  49 +++-
 block/blk-mq-sched.h  |   4 +
 block/blk-mq.c        |   8 +-
 block/blk-mq.h        |   2 +-
 block/blk.h           |   2 +
 block/ufq-bpfops.c    | 213 +++++++++++++++++
 block/ufq-iosched.c   | 526 ++++++++++++++++++++++++++++++++++++++++++
 block/ufq-iosched.h   |  38 +++
 block/ufq-kfunc.c     |  91 ++++++++
 11 files changed, 934 insertions(+), 8 deletions(-)
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
index c65f4da93702..9bb9144079aa 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
+obj-$(CONFIG_IOSCHED_UFQ)	+= ufq-iosched.o ufq-bpfops.o ufq-kfunc.o
 
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o \
 				   bio-integrity-auto.o
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..8bdc459ae631 100644
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
@@ -1169,3 +1175,34 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
+
+bool blk_mq_sched_merge_fn(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs, struct request **merged_request,
+		struct request *rq, enum elv_merge type, void (*fn)
+		(struct request_queue *, struct request *, enum elv_merge))
+{
+	switch (type) {
+	case ELEVATOR_BACK_MERGE:
+		if (!blk_mq_sched_allow_merge(q, rq, bio))
+			return false;
+		if (bio_attempt_back_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
+			return false;
+		*merged_request = attempt_back_merge(q, rq);
+		if (!*merged_request)
+			fn(q, rq, ELEVATOR_BACK_MERGE);
+		return true;
+	case ELEVATOR_FRONT_MERGE:
+		if (!blk_mq_sched_allow_merge(q, rq, bio))
+			return false;
+		if (bio_attempt_front_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
+			return false;
+		*merged_request = attempt_front_merge(q, rq);
+		if (!*merged_request)
+			fn(q, rq, ELEVATOR_FRONT_MERGE);
+		return true;
+	case ELEVATOR_DISCARD_MERGE:
+		return bio_attempt_discard_merge(q, rq, bio) == BIO_MERGE_OK;
+	default:
+		return false;
+	}
+}
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5678e15bd33c..e5f7187044c4 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,6 +7,10 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
+bool blk_mq_sched_merge_fn(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs, struct request **merged_request,
+		struct request *rq, enum elv_merge type, void (*fn)
+		(struct request_queue *, struct request *, enum elv_merge));
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3da2215b2912..b8282f9a534b 100644
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
index f6053e9dd2aa..2da3958ec27b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -449,6 +449,8 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
 
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
+struct request *bpf_attempt_merge(struct request_queue *q, struct request *rq,
+				  struct request *next);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
diff --git a/block/ufq-bpfops.c b/block/ufq-bpfops.c
new file mode 100644
index 000000000000..c293ed834829
--- /dev/null
+++ b/block/ufq-bpfops.c
@@ -0,0 +1,213 @@
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
+#include "ufq-iosched.h"
+
+struct ufq_iosched_ops ufq_ops;
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
+	 * merge_req's third argument is int *type.  btf_ctx_access() treats
+	 * pointers that are not "pointer to struct" as scalars (no reg_type),
+	 * so loading the pointer from ctx leaves a SCALAR and *type stores
+	 * fail verification.  Model it as a read/write buffer of merge_type.
+	 */
+	if (off == 16 && size == sizeof(__u64) &&
+	    prog->aux->attach_func_name &&
+	    !strcmp(prog->aux->attach_func_name, "merge_req")) {
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
+static int bpf_ufq_enable(struct ufq_iosched_ops *ops)
+{
+	ufq_ops = *ops;
+	return 0;
+}
+
+static void bpf_ufq_disable(struct ufq_iosched_ops *ops)
+{
+	memset(&ufq_ops, 0, sizeof(ufq_ops));
+}
+
+static int bpf_ufq_reg(void *kdata, struct bpf_link *link)
+{
+	return bpf_ufq_enable(kdata);
+}
+
+static void bpf_ufq_unreg(void *kdata, struct bpf_link *link)
+{
+	bpf_ufq_disable(kdata);
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
+static struct request *former_req_stub(struct request_queue *q, struct request *rq)
+{
+	return NULL;
+}
+
+static struct request *next_req_stub(struct request_queue *q, struct request *rq)
+{
+	return NULL;
+}
+
+static struct request *merge_req_stub(struct request_queue *q, struct request *rq,
+				      int *type)
+{
+	*type = ELEVATOR_NO_MERGE;
+	return NULL;
+}
+
+static void req_merged_stub(struct request_queue *q, struct request *rq,
+			    int type)
+{
+}
+
+static struct ufq_iosched_ops __bpf_ops_ufq_ops = {
+	.init_sched	= init_sched_stub,
+	.exit_sched	= exit_sched_stub,
+	.insert_req	= insert_req_stub,
+	.dispatch_req	= dispatch_req_stub,
+	.has_req	= has_req_stub,
+	.former_req	= former_req_stub,
+	.next_req	= next_req_stub,
+	.merge_req	= merge_req_stub,
+	.req_merged	= req_merged_stub,
+	.finish_req	= finish_req_stub,
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
+
diff --git a/block/ufq-iosched.c b/block/ufq-iosched.c
new file mode 100644
index 000000000000..8c10e0d74b0e
--- /dev/null
+++ b/block/ufq-iosched.c
@@ -0,0 +1,526 @@
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
+/* For testing and debugging */
+struct ufq_ops_stats {
+	atomic_t dispatch_ok_count;
+	atomic64_t dispatch_ok_sectors;
+	atomic_t dispatch_null_count;
+	atomic_t insert_ok_count;
+	atomic64_t insert_ok_sectors;
+	atomic_t insert_err_count;
+	atomic_t merge_ok_count;
+	atomic64_t merge_ok_sectors;
+	atomic_t finish_ok_count;
+	atomic64_t finish_ok_sectors;
+};
+
+struct ufq_data {
+	struct request_queue *q;
+	u32 async_depth;
+	atomic_t rqs_count;
+	struct ufq_ops_stats ops_stats;
+};
+
+enum ufq_priv_state {
+	UFQ_PRIV_NOT_IN_SCHED = 0,
+	UFQ_PRIV_IN_BPF = 1,
+	UFQ_PRIV_IN_UFQ = 2,
+	UFQ_PRIV_IN_SCHED = 3,
+};
+
+static void ufq_request_merged(struct request_queue *q, struct request *req,
+			       enum elv_merge type)
+{
+	if (ufq_ops.req_merged)
+		ufq_ops.req_merged(q, req, (int)type);
+}
+
+static struct request *ufq_dispatch_request(struct blk_mq_hw_ctx *hctx)
+{
+	struct ufq_data *ufq = hctx->queue->elevator->elevator_data;
+	struct blk_mq_ctx *ctx;
+	struct request *rq = NULL;
+	unsigned short idx;
+
+	if (ufq_ops.dispatch_req) {
+		rq = ufq_ops.dispatch_req(hctx->queue);
+		if (!rq) {
+			atomic_inc(&ufq->ops_stats.dispatch_null_count);
+			return NULL;
+		}
+		atomic_inc(&ufq->ops_stats.dispatch_ok_count);
+		atomic64_add(blk_rq_sectors(rq), &ufq->ops_stats.dispatch_ok_sectors);
+
+		ctx = rq->mq_ctx;
+		spin_lock(&ctx->lock);
+		list_del_init(&rq->queuelist);
+		rq->rq_flags |= RQF_STARTED;
+		if (hctx->queue->last_merge == rq)
+			hctx->queue->last_merge = NULL;
+		if (list_empty(&ctx->rq_lists[rq->mq_hctx->type]))
+			sbitmap_clear_bit(&rq->mq_hctx->ctx_map,
+					  ctx->index_hw[rq->mq_hctx->type]);
+		spin_unlock(&ctx->lock);
+		rq->elv.priv[0] = (void *)((uintptr_t)rq->elv.priv[0]
+				  & ~UFQ_PRIV_IN_UFQ);
+	} else {
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
+	struct ufq_data *ufq;
+
+	ufq = kzalloc_node(sizeof(*ufq), GFP_KERNEL, q->node);
+	if (!ufq)
+		return -ENOMEM;
+
+	eq->elevator_data = ufq;
+	ufq->q = q;
+
+	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
+	q->elevator = eq;
+
+	q->async_depth = q->nr_requests;
+	ufq->async_depth = q->nr_requests;
+
+	if (ufq_ops.init_sched)
+		ufq_ops.init_sched(q);
+
+	ufq_depth_updated(q);
+	return 0;
+}
+
+static void ufq_exit_sched(struct elevator_queue *e)
+{
+	struct ufq_data *ufq = e->elevator_data;
+
+	if (ufq_ops.exit_sched)
+		ufq_ops.exit_sched(ufq->q);
+
+	WARN_ON_ONCE(atomic_read(&ufq->rqs_count));
+
+	kfree(ufq);
+}
+
+static void ufq_merged_request(struct request_queue *q, struct request *rq,
+		enum elv_merge type)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (e->type->ops.request_merged)
+		e->type->ops.request_merged(q, rq, type);
+
+	q->last_merge = rq;
+}
+
+static bool ufq_sched_try_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs, struct request **merged_request)
+{
+	enum elv_merge type = ELEVATOR_NO_MERGE;
+	struct request *rq = NULL, *last;
+	bool ret;
+
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
+		spin_lock(&last->mq_ctx->lock);
+		if (last == q->last_merge && elv_bio_merge_ok(last, bio)) {
+			type = blk_try_merge(last, bio);
+			if (type != ELEVATOR_NO_MERGE) {
+				rq = last;
+				goto merge;
+			}
+		}
+		spin_unlock(&last->mq_ctx->lock);
+	}
+
+	if (blk_queue_noxmerges(q))
+		return false;
+
+	if (ufq_ops.find_req_from_sector) {
+		rq = ufq_ops.find_req_from_sector(q, bio->bi_iter.bi_sector,
+						    bio_end_sector(bio));
+		if (rq && elv_bio_merge_ok(rq, bio))
+			type = blk_try_merge(rq, bio);
+		else
+			return false;
+	}
+
+	if (!rq || type == ELEVATOR_NO_MERGE)
+		return false;
+
+	spin_lock(&rq->mq_ctx->lock);
+merge:
+	ret = blk_mq_sched_merge_fn(q, bio, nr_segs, merged_request, rq,
+				    type, ufq_merged_request);
+	spin_unlock(&rq->mq_ctx->lock);
+
+	return ret;
+}
+
+/*
+ * Attempt to merge a bio into an existing request. This function is called
+ * before @bio is associated with a request.
+ */
+static bool ufq_bio_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs)
+{
+	struct ufq_data *ufq = q->elevator->elevator_data;
+	struct request *free = NULL;
+	bool ret;
+
+	ret = ufq_sched_try_merge(q, bio, nr_segs, &free);
+
+	if (free) {
+		blk_mq_free_request(free);
+		atomic_dec(&ufq->rqs_count);
+	}
+
+	return ret;
+}
+
+static enum elv_merge ufq_try_insert_merge(struct request_queue *q,
+					   struct request **new)
+{
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
+		if (last == q->last_merge && bpf_attempt_merge(q, last, rq)) {
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
+	if (ufq_ops.merge_req) {
+		target = ufq_ops.merge_req(q, rq, &merge_type);
+		type = (enum elv_merge)merge_type;
+	}
+
+	if (type == ELEVATOR_NO_MERGE || !target) {
+		return ELEVATOR_NO_MERGE;
+	} else if (type == ELEVATOR_FRONT_MERGE) {
+		spin_lock(&target->mq_ctx->lock);
+		free = bpf_attempt_merge(q, rq, target);
+		if (!free) {
+			spin_unlock(&target->mq_ctx->lock);
+			pr_err("ufq-iosched: front merge failed\n");
+			return ELEVATOR_NO_MERGE;
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
+			return ELEVATOR_NO_MERGE;
+		}
+		*new = target;
+		q->last_merge = target;
+	}
+
+	spin_unlock(&target->mq_ctx->lock);
+end:
+	atomic_inc(&ufq->ops_stats.merge_ok_count);
+	atomic64_add(blk_rq_sectors(free), &ufq->ops_stats.merge_ok_sectors);
+	blk_mq_free_request(free);
+	return type;
+}
+
+static void ufq_insert_requests(struct blk_mq_hw_ctx *hctx,
+			       struct list_head *list,
+			       blk_insert_t flags)
+{
+	struct request_queue *q = hctx->queue;
+	struct ufq_data *ufq = q->elevator->elevator_data;
+	struct blk_mq_ctx *ctx;
+	enum elv_merge type;
+	int bit, ret = 0;
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
+		if (rq && ufq_ops.insert_req) {
+			rq->elv.priv[0] = (void *)((uintptr_t)rq->elv.priv[0]
+				  | UFQ_PRIV_IN_BPF);
+			ret = ufq_ops.insert_req(q, rq, flags);
+			if (ret) {
+				atomic_inc(&ufq->ops_stats.insert_err_count);
+				pr_err("ufq-iosched: bpf insert_req error (%d)\n", ret);
+			} else {
+				atomic_inc(&ufq->ops_stats.insert_ok_count);
+				atomic64_add(blk_rq_sectors(rq), &ufq->ops_stats.insert_ok_sectors);
+			}
+		}
+	}
+}
+
+static void ufq_prepare_request(struct request *rq)
+{
+	rq->elv.priv[0] = (void *)(uintptr_t)UFQ_PRIV_NOT_IN_SCHED;
+}
+
+static void ufq_finish_request(struct request *rq)
+{
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
+	if (ufq_ops.finish_req)
+		ufq_ops.finish_req(rq);
+
+	atomic_inc(&ufq->ops_stats.finish_ok_count);
+	atomic64_add(blk_rq_stats_sectors(rq), &ufq->ops_stats.finish_ok_sectors);
+}
+
+static struct request *ufq_find_next_request(struct request_queue *q, struct request *rq)
+{
+	if (ufq_ops.next_req)
+		return ufq_ops.next_req(q, rq);
+
+	return NULL;
+}
+
+static struct request *ufq_find_former_request(struct request_queue *q, struct request *rq)
+{
+	if (ufq_ops.former_req)
+		return ufq_ops.former_req(q, rq);
+
+	return NULL;
+}
+
+static bool ufq_has_work(struct blk_mq_hw_ctx *hctx)
+{
+	struct ufq_data *ufq = hctx->queue->elevator->elevator_data;
+	int rqs_count = atomic_read(&ufq->rqs_count);
+
+	WARN_ON_ONCE(rqs_count < 0);
+	if (ufq_ops.has_req)
+		return ufq_ops.has_req(hctx->queue, rqs_count);
+
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
+	seq_printf(m, "merge_ok_count %d\n",
+		   atomic_read(&s->merge_ok_count));
+	seq_printf(m, "merge_ok_sectors %lld\n",
+		   (long long)atomic64_read(&s->merge_ok_sectors));
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
+		.next_request		= ufq_find_next_request,
+		.former_request		= ufq_find_former_request,
+		.bio_merge		= ufq_bio_merge,
+		.request_merged		= ufq_request_merged,
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
index 000000000000..c717362eab31
--- /dev/null
+++ b/block/ufq-iosched.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 KylinSoft Corporation.
+ * Copyright (c) 2026 Kaitao Cheng <chengkaitao@kylinos.cn>
+ */
+#ifndef _BLOCK_UFQ_IOSCHED_H
+#define _BLOCK_UFQ_IOSCHED_H
+
+#include "elevator.h"
+#include "blk-mq.h"
+
+#ifndef BPF_IOSCHED_NAME_MAX
+#define BPF_IOSCHED_NAME_MAX	16
+#endif
+
+struct ufq_iosched_ops {
+	int (*init_sched)(struct request_queue *q);
+	int (*insert_req)(struct request_queue *q, struct request *rq,
+			blk_insert_t flags);
+	int (*exit_sched)(struct request_queue *q);
+	bool (*has_req)(struct request_queue *q, int rqs_count);
+	void (*req_merged)(struct request_queue *q, struct request *rq, int type);
+	void (*finish_req)(struct request *rq);
+	struct request *(*merge_req)(struct request_queue *q, struct request *rq,
+			int *type);
+	struct request *(*find_req_from_sector)(struct request_queue *q,
+			sector_t start, sector_t end);
+	struct request *(*former_req)(struct request_queue *q, struct request *rq);
+	struct request *(*next_req)(struct request_queue *q, struct request *rq);
+	struct request *(*dispatch_req)(struct request_queue *q);
+	char name[BPF_IOSCHED_NAME_MAX];
+};
+extern struct ufq_iosched_ops ufq_ops;
+
+int bpf_ufq_ops_init(void);
+int bpf_ufq_kfunc_init(void);
+
+#endif /* _BLOCK_UFQ_IOSCHED_H */
diff --git a/block/ufq-kfunc.c b/block/ufq-kfunc.c
new file mode 100644
index 000000000000..35acc98fd979
--- /dev/null
+++ b/block/ufq-kfunc.c
@@ -0,0 +1,91 @@
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
+__bpf_kfunc struct request *bpf_request_from_id(struct request_queue *q,
+						sector_t offset)
+{
+	return elv_rqhash_find(q, offset);
+}
+
+__bpf_kfunc struct request *bpf_request_acquire(struct request *rq)
+{
+	if (req_ref_inc_not_zero(rq))
+		return rq;
+	return NULL;
+}
+
+__bpf_kfunc bool bpf_request_put(struct request *rq)
+{
+	if (req_ref_put_and_test(rq))
+		return false;
+
+	return true;
+}
+
+__bpf_kfunc void bpf_request_release(struct request *rq)
+{
+	if (req_ref_put_and_test(rq))
+		__blk_mq_free_request(rq);
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
+BTF_ID_FLAGS(func, bpf_request_from_id, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_request_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_request_put)
+BTF_ID_FLAGS(func, bpf_request_release, KF_RELEASE)
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
2.43.0

