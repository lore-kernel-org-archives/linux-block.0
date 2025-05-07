Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6641DB34B
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592789; cv=none; b=WrhIkwDWBFYz0yctDrZwjUOvAkE0yZtvBKfrJSTTBerToyWcjcml/cKC8PJ2kjt51GdN/MEXV800MTVZLggEw2Qx69JtuUwYbbFrxU7VqGvIFhJvNjdD2fxMl25XWs9q+Q2PnoNIOp3o1iOU0Fiz/A/zgdkKymtVQ8Y9Dckh8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592789; c=relaxed/simple;
	bh=ZBQJRG/IbRZYAYRC3Jv5O4Z9J+cU8eoEssbzzrIDQmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGa749dF3t7g3ygPpok8bsEO0HBIezWDay7/BxdXmg/dwaLeDtnCrP0CvfezpvYLz94QJV8QG78Ck7giRg/MCiWYccYGPvhwWGkQoLLVW01rPF1SkVopwbq/CIsP4Tu/M26AeTLvuYi75JDTSaL16hKb1998CESrng6cZOuT91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PictIx5c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PictIx5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746592786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+jODWvqgMFIYVjRq6fmnVuapAxvsPS2ig+k2K1wCjc=;
	b=PictIx5cnlwVlnUtpOXB7OizFkWnyU13k5z/6zc1XXz8wVU8VAIiikmmcWktpzaxZLC0w4
	bJ9uUobbGCwlZIUzBeofYcdj0vqHIYUdq9bXhJrsOlNnP4ADTbDu/WefB7LYBpWNmeSszU
	qMNKdO8jvKjI0pnoRM3uuFnqoFuQtu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-vWtjECI4PKO7AVZ-kVjpdw-1; Wed,
 07 May 2025 00:39:42 -0400
X-MC-Unique: vWtjECI4PKO7AVZ-kVjpdw-1
X-Mimecast-MFC-AGG-ID: vWtjECI4PKO7AVZ-kVjpdw_1746592781
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08CD2195423C;
	Wed,  7 May 2025 04:39:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2608718002B2;
	Wed,  7 May 2025 04:39:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/6] selftests: ublk: support UBLK_F_AUTO_BUF_REG
Date: Wed,  7 May 2025 12:38:56 +0800
Message-ID: <20250507043859.2978132-6-ming.lei@redhat.com>
In-Reply-To: <20250507043859.2978132-1-ming.lei@redhat.com>
References: <20250507043859.2978132-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Enable UBLK_F_AUTO_BUF_REG support for ublk utility by argument `--auto_zc`,
meantime support this feature in null, loop and stripe target code.

Add function test generic_08 for covering basic UBLK_F_AUTO_BUF_REG feature.

Also cover UBLK_F_AUTO_BUF_REG in stress_03, stress_04 and stress_05 test too.

'fio/t/io_uring -p0 /dev/ublkb0' shows that F_AUTO_BUF_REG can improve
IOPS by 50% compared with F_SUPPORT_ZERO_COPY in my test VM.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  2 +
 tools/testing/selftests/ublk/file_backed.c    | 12 ++++--
 tools/testing/selftests/ublk/kublk.c          | 21 +++++++--
 tools/testing/selftests/ublk/kublk.h          |  7 +++
 tools/testing/selftests/ublk/null.c           | 43 ++++++++++++++-----
 tools/testing/selftests/ublk/stripe.c         | 21 ++++-----
 .../testing/selftests/ublk/test_generic_08.sh | 32 ++++++++++++++
 .../testing/selftests/ublk/test_stress_03.sh  |  6 +++
 .../testing/selftests/ublk/test_stress_04.sh  |  6 +++
 .../testing/selftests/ublk/test_stress_05.sh  |  8 ++++
 10 files changed, 129 insertions(+), 29 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index e2e7b1e52a06..14d574ac142c 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -15,6 +15,8 @@ TEST_PROGS += test_generic_05.sh
 TEST_PROGS += test_generic_06.sh
 TEST_PROGS += test_generic_07.sh
 
+TEST_PROGS += test_generic_08.sh
+
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_loop_01.sh
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 6f34eabfae97..9dc00b217a66 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -29,19 +29,23 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
 static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
-	int zc = ublk_queue_use_zc(q);
-	enum io_uring_op op = ublk_to_uring_op(iod, zc);
+	unsigned zc = ublk_queue_use_zc(q);
+	unsigned auto_zc = ublk_queue_use_auto_zc(q);
+	enum io_uring_op op = ublk_to_uring_op(iod, zc | auto_zc);
 	struct io_uring_sqe *sqe[3];
+	void *addr = (zc | auto_zc) ? NULL : (void *)iod->addr;
 
-	if (!zc) {
+	if (!zc || auto_zc) {
 		ublk_queue_alloc_sqes(q, sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
 		io_uring_prep_rw(op, sqe[0], 1 /*fds[1]*/,
-				(void *)iod->addr,
+				addr,
 				iod->nr_sectors << 9,
 				iod->start_sector << 9);
+		if (auto_zc)
+			sqe[0]->buf_index = tag;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
 		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 842b40736a9b..bf666bfd7ddd 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -420,9 +420,12 @@ static int ublk_queue_init(struct ublk_queue *q)
 	q->cmd_inflight = 0;
 	q->tid = gettid();
 
-	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
+	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_BUF_REG)) {
 		q->state |= UBLKSRV_NO_BUF;
-		q->state |= UBLKSRV_ZC;
+		if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY)
+			q->state |= UBLKSRV_ZC;
+		if (dev->dev_info.flags & UBLK_F_AUTO_BUF_REG)
+			q->state |= UBLKSRV_AUTO_BUF_REG;
 	}
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
@@ -461,7 +464,7 @@ static int ublk_queue_init(struct ublk_queue *q)
 		goto fail;
 	}
 
-	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
+	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_BUF_REG)) {
 		ret = io_uring_register_buffers_sparse(&q->ring, q->q_depth);
 		if (ret) {
 			ublk_err("ublk dev %d queue %d register spare buffers failed %d",
@@ -579,6 +582,11 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	else
 		cmd->addr	= 0;
 
+	if (q->state & UBLKSRV_AUTO_BUF_REG) {
+		cmd->auto_buf.index = tag;
+		cmd->auto_buf.flags = 0;
+	}
+
 	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
 	io_uring_sqe_set_data64(sqe[0], user_data);
 
@@ -661,6 +669,7 @@ static void ublk_handle_cqe(struct io_uring *r,
 
 	if (cqe->res == UBLK_IO_RES_OK) {
 		assert(tag < q->q_depth);
+
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
@@ -1206,6 +1215,7 @@ static int cmd_dev_get_features(void)
 		[const_ilog2(UBLK_F_USER_COPY)] = "USER_COPY",
 		[const_ilog2(UBLK_F_ZONED)] = "ZONED",
 		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
+		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1245,7 +1255,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
-	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g]\n");
+	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
@@ -1300,6 +1310,7 @@ int main(int argc, char *argv[])
 		{ "recovery_fail_io",	1,	NULL, 'e'},
 		{ "recovery_reissue",	1,	NULL, 'i'},
 		{ "get_data",		1,	NULL, 'g'},
+		{ "auto_zc",		0,	NULL,  0},
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1368,6 +1379,8 @@ int main(int argc, char *argv[])
 				ublk_dbg_mask = 0;
 			if (!strcmp(longopts[option_idx].name, "foreground"))
 				ctx.fg = 1;
+			if (!strcmp(longopts[option_idx].name, "auto_zc"))
+				ctx.flags |= UBLK_F_AUTO_BUF_REG;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 81fb5864ab72..ebbfad9e70aa 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -115,6 +115,7 @@ struct ublk_io {
 #define UBLKSRV_NEED_COMMIT_RQ_COMP	(1UL << 1)
 #define UBLKSRV_IO_FREE			(1UL << 2)
 #define UBLKSRV_NEED_GET_DATA           (1UL << 3)
+#define UBLKSRV_NEED_REG_BUF            (1UL << 4)
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
@@ -168,6 +169,7 @@ struct ublk_queue {
 #define UBLKSRV_QUEUE_IDLE	(1U << 1)
 #define UBLKSRV_NO_BUF		(1U << 2)
 #define UBLKSRV_ZC		(1U << 3)
+#define UBLKSRV_AUTO_BUF_REG		(1U << 4)
 	unsigned state;
 	pid_t tid;
 	pthread_t thread;
@@ -387,6 +389,11 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 	return q->state & UBLKSRV_ZC;
 }
 
+static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
+{
+	return q->state & UBLKSRV_AUTO_BUF_REG;
+}
+
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 91fec3690d4b..1362dd422c6e 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -42,10 +42,22 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	return 0;
 }
 
+static void __setup_nop_io(int tag, const struct ublksrv_io_desc *iod,
+		struct io_uring_sqe *sqe)
+{
+	unsigned ublk_op = ublksrv_get_op(iod);
+
+	io_uring_prep_nop(sqe);
+	sqe->buf_index = tag;
+	sqe->flags |= IOSQE_FIXED_FILE;
+	sqe->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
+	sqe->len = iod->nr_sectors << 9; 	/* injected result */
+	sqe->user_data = build_user_data(tag, ublk_op, 0, 1);
+}
+
 static int null_queue_zc_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
-	unsigned ublk_op = ublksrv_get_op(iod);
 	struct io_uring_sqe *sqe[3];
 
 	ublk_queue_alloc_sqes(q, sqe, 3);
@@ -55,12 +67,8 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 
-	io_uring_prep_nop(sqe[1]);
-	sqe[1]->buf_index = tag;
-	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
-	sqe[1]->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
-	sqe[1]->len = iod->nr_sectors << 9; 	/* injected result */
-	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	__setup_nop_io(tag, iod, sqe[1]);
+	sqe[1]->flags |= IOSQE_IO_HARDLINK;
 
 	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
@@ -69,6 +77,16 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	return 2;
 }
 
+static int null_queue_auto_zc_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	struct io_uring_sqe *sqe[1];
+
+	ublk_queue_alloc_sqes(q, sqe, 1);
+	__setup_nop_io(tag, iod, sqe[0]);
+	return 1;
+}
+
 static void ublk_null_io_done(struct ublk_queue *q, int tag,
 		const struct io_uring_cqe *cqe)
 {
@@ -94,15 +112,18 @@ static void ublk_null_io_done(struct ublk_queue *q, int tag,
 static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
-	int zc = ublk_queue_use_zc(q);
+	unsigned auto_zc = ublk_queue_use_auto_zc(q);
+	unsigned zc = ublk_queue_use_zc(q);
 	int queued;
 
-	if (!zc) {
+	if (auto_zc)
+		queued = null_queue_auto_zc_io(q, tag);
+	else if (zc)
+		queued = null_queue_zc_io(q, tag);
+	else {
 		ublk_complete_io(q, tag, iod->nr_sectors << 9);
 		return 0;
 	}
-
-	queued = null_queue_zc_io(q, tag);
 	ublk_queued_tgt_io(q, tag, queued);
 	return 0;
 }
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 5dbd6392d83d..8fd8faeb5e76 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -70,7 +70,7 @@ static void free_stripe_array(struct stripe_array *s)
 }
 
 static void calculate_stripe_array(const struct stripe_conf *conf,
-		const struct ublksrv_io_desc *iod, struct stripe_array *s)
+		const struct ublksrv_io_desc *iod, struct stripe_array *s, void *base)
 {
 	const unsigned shift = conf->shift - 9;
 	const unsigned chunk_sects = 1 << shift;
@@ -102,7 +102,7 @@ static void calculate_stripe_array(const struct stripe_conf *conf,
 		}
 
 		assert(this->nr_vec < this->cap);
-		this->vec[this->nr_vec].iov_base = (void *)(iod->addr + done);
+		this->vec[this->nr_vec].iov_base = (void *)(base + done);
 		this->vec[this->nr_vec++].iov_len = nr_sects << 9;
 
 		start += nr_sects;
@@ -126,15 +126,17 @@ static inline enum io_uring_op stripe_to_uring_op(
 static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
 {
 	const struct stripe_conf *conf = get_chunk_shift(q);
-	int zc = !!(ublk_queue_use_zc(q) != 0);
-	enum io_uring_op op = stripe_to_uring_op(iod, zc);
+	unsigned auto_zc = (ublk_queue_use_auto_zc(q) != 0);
+	unsigned zc = (ublk_queue_use_zc(q) != 0);
+	enum io_uring_op op = stripe_to_uring_op(iod, zc | auto_zc);
 	struct io_uring_sqe *sqe[NR_STRIPE];
 	struct stripe_array *s = alloc_stripe_array(conf, iod);
 	struct ublk_io *io = ublk_get_io(q, tag);
 	int i, extra = zc ? 2 : 0;
+	void *base = (zc | auto_zc) ? NULL : (void *)iod->addr;
 
 	io->private_data = s;
-	calculate_stripe_array(conf, iod, s);
+	calculate_stripe_array(conf, iod, s, base);
 
 	ublk_queue_alloc_sqes(q, sqe, s->nr + extra);
 
@@ -153,12 +155,11 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 				(void *)t->vec,
 				t->nr_vec,
 				t->start << 9);
-		if (zc) {
+		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
+		if (auto_zc || zc) {
 			sqe[i]->buf_index = tag;
-			io_uring_sqe_set_flags(sqe[i],
-					IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK);
-		} else {
-			io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
+			if (zc)
+				sqe[i]->flags |= IOSQE_IO_HARDLINK;
 		}
 		/* bit63 marks us as tgt io */
 		sqe[i]->user_data = build_user_data(tag, ublksrv_get_op(iod), i - zc, 1);
diff --git a/tools/testing/selftests/ublk/test_generic_08.sh b/tools/testing/selftests/ublk/test_generic_08.sh
new file mode 100755
index 000000000000..b222f3a77e12
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_08.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_08"
+ERR_CODE=0
+
+if ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test UBLK_F_AUTO_BUF_REG"
+
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t loop -q 2 --auto_zc "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+if ! _mkfs_mount_test /dev/ublkb"${dev_id}"; then
+	_cleanup_test "generic"
+	_show_result $TID 255
+fi
+
+dev_id=$(_add_ublk_dev -t stripe --auto_zc "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index e0854f71d35b..b5a5520dcae6 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -32,6 +32,12 @@ _create_backfile 2 128M
 ublk_io_and_remove 8G -t null -q 4 -z &
 ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
 ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+
+if _have_feature "AUTO_BUF_REG"; then
+	ublk_io_and_remove 8G -t null -q 4 --auto_zc &
+	ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+fi
 wait
 
 _cleanup_test "stress"
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 1798a98387e8..5b49a8025002 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -31,6 +31,12 @@ _create_backfile 2 128M
 ublk_io_and_kill_daemon 8G -t null -q 4 -z &
 ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+
+if _have_feature "AUTO_BUF_REG"; then
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+fi
 wait
 
 _cleanup_test "stress"
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 88601b48f1cd..6f758f6070a5 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -60,5 +60,13 @@ if _have_feature "ZERO_COPY"; then
 	done
 fi
 
+if _have_feature "AUTO_BUF_REG"; then
+	for reissue in $(seq 0 1); do
+		ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		wait
+	done
+fi
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.47.0

