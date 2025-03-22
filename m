Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9121C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635993; cv=none; b=eOyLV720EPIlHr+s0ESYcghA2YkStBpbfKYCCDoqc+PO9+2ISE0k2xn8uGqG6ajBvO+TIVjzZ/MiF0e+6N4RbWfKRQ8Ne9MgOc9HwSzqsBn4Fi94GW9z4htxx9snYXDQfPviCs6+4yHL3bzThvO/asaLb6gqDDddq3bYsXYBZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635993; c=relaxed/simple;
	bh=OcOrOf9rIbCLj5P4RF3Z5U2vJzJr95adacs9tRAbVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du0ZN0edEjSaglf2fVxeh1ZH7TrehWy4UYtVcNBuQ3Tfog0OIqRcQMl7ggvc0IN9bonu89WByQa9xz01OdF0hCZJ5xxDsUK9koRBWGYNYgIoxPNvnmJJNu4zfjYPPR6fzwIdfTXT3dsQSwLdGlbIne22TJmaeCzSax5fBB6YGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsLP4Rei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsLP4Rei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSoM6tdoHHuMzU2zI4Ix9WJ42z6nt4Ds34HDfWt0MO0=;
	b=JsLP4ReiUVy8KcGtuofkOAc5nDicfPBVzRTnpnE+oNyjC91ofh6diWPcDfCXxNjTp0kiwR
	gaOiq9EQTx0UjEmDl3ezwHubJHL0z3v6HRzHl4aDM4VUX1i+lZp+xQnbHc+bV9RVsQFtz/
	svkVBEUdRWOFrHjiTniqD830R4Oprwo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-8x-tCTsgNEKw-QgkxA-2OA-1; Sat,
 22 Mar 2025 05:33:08 -0400
X-MC-Unique: 8x-tCTsgNEKw-QgkxA-2OA-1
X-Mimecast-MFC-AGG-ID: 8x-tCTsgNEKw-QgkxA-2OA_1742635987
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9491B195E92A;
	Sat, 22 Mar 2025 09:33:07 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 613A51955BC0;
	Sat, 22 Mar 2025 09:33:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/8] selftests: ublk: add stripe target
Date: Sat, 22 Mar 2025 17:32:16 +0800
Message-ID: <20250322093218.431419-9-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add ublk stripe target which can take 1~4 underlying backing files
or block device, with stripe size 4k ~ 512K.

Add two basic tests(write verify & mkfs/mount/umount) over ublk/stripe.

This target is helpful to cover multiple IOs aiming at same
fixed/registered IO kernel buffer.

It is also capable of verifying vectored registered (kernel)buffers
in future for zero copy, so far it isn't supported yet.

Todo: support vectored registered kernel buffer for ublk/zc.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |   4 +-
 tools/testing/selftests/ublk/kublk.c          |   7 +-
 tools/testing/selftests/ublk/kublk.h          |  12 +
 tools/testing/selftests/ublk/stripe.c         | 318 ++++++++++++++++++
 .../testing/selftests/ublk/test_stripe_01.sh  |  34 ++
 .../testing/selftests/ublk/test_stripe_02.sh  |  24 ++
 6 files changed, 397 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/stripe.c
 create mode 100755 tools/testing/selftests/ublk/test_stripe_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 36f50c000e55..7817afe29005 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -11,6 +11,8 @@ TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
+TEST_PROGS += test_stripe_01.sh
+TEST_PROGS += test_stripe_02.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
@@ -19,7 +21,7 @@ TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c
+$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2dd17663ef30..05147b53c361 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -9,6 +9,7 @@ unsigned int ublk_dbg_mask = UBLK_LOG;
 static const struct ublk_tgt_ops *tgt_ops_list[] = {
 	&null_tgt_ops,
 	&loop_tgt_ops,
+	&stripe_tgt_ops,
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
@@ -1060,8 +1061,9 @@ int main(int argc, char *argv[])
 		{ "depth",		1,	NULL, 'd' },
 		{ "debug_mask",		1,	NULL,  0  },
 		{ "quiet",		0,	NULL,  0  },
-		{ "zero_copy",          1,      NULL, 'z' },
+		{ "zero_copy",          0,      NULL, 'z' },
 		{ "foreground",		0,	NULL,  0  },
+		{ "chunk_size", 	1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1071,6 +1073,7 @@ int main(int argc, char *argv[])
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.tgt_type	=	"unknown",
+		.chunk_size 	= 	65536, 	/* def chunk size is 64K */
 	};
 	int ret = -EINVAL, i;
 
@@ -1107,6 +1110,8 @@ int main(int argc, char *argv[])
 				ublk_dbg_mask = 0;
 			if (!strcmp(longopts[option_idx].name, "foreground"))
 				ctx.fg = 1;
+			if (!strcmp(longopts[option_idx].name, "chunk_size"))
+				ctx.chunk_size = strtol(optarg, NULL, 10);
 		}
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 02f0bff7918c..f31a5c4d4143 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -19,6 +19,7 @@
 #include <sys/inotify.h>
 #include <sys/wait.h>
 #include <sys/eventfd.h>
+#include <sys/uio.h>
 #include <liburing.h>
 #include <linux/ublk_cmd.h>
 #include "ublk_dep.h"
@@ -66,6 +67,9 @@ struct dev_ctx {
 	unsigned int	all:1;
 	unsigned int	fg:1;
 
+	/* stripe */
+	unsigned int    chunk_size;
+
 	int _evtfd;
 };
 
@@ -352,7 +356,15 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
+extern const struct ublk_tgt_ops stripe_tgt_ops;
 
 void backing_file_tgt_deinit(struct ublk_dev *dev);
 int backing_file_tgt_init(struct ublk_dev *dev);
+
+static inline unsigned int ilog2(unsigned int x)
+{
+	if (x == 0)
+		return 0;
+	return (sizeof(x) * 8 - 1) - __builtin_clz(x);
+}
 #endif
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
new file mode 100644
index 000000000000..98c564b12f3c
--- /dev/null
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "kublk.h"
+
+#define NR_STRIPE  MAX_BACK_FILES
+
+struct stripe_conf {
+	unsigned nr_files;
+	unsigned shift;
+};
+
+struct stripe {
+	loff_t 		start;
+	unsigned 	nr_sects;
+	int 		seq;
+
+	struct iovec 	*vec;
+	unsigned 	nr_vec;
+	unsigned 	cap;
+};
+
+struct stripe_array {
+	struct stripe 	s[NR_STRIPE];
+	unsigned 	nr;
+	struct iovec 	_vec[];
+};
+
+static inline const struct stripe_conf *get_chunk_shift(const struct ublk_queue *q)
+{
+	return (struct stripe_conf *)q->dev->private_data;
+}
+
+static inline unsigned calculate_nr_vec(const struct stripe_conf *conf,
+		const struct ublksrv_io_desc *iod)
+{
+	const unsigned shift = conf->shift - 9;
+	const unsigned unit_sects = conf->nr_files << shift;
+	loff_t start = iod->start_sector;
+	loff_t end = start + iod->nr_sectors;
+
+	return (end / unit_sects) - (start / unit_sects) + 1;
+}
+
+static struct stripe_array *alloc_stripe_array(const struct stripe_conf *conf,
+		const struct ublksrv_io_desc *iod)
+{
+	unsigned nr_vecs = calculate_nr_vec(conf, iod);
+	unsigned total = nr_vecs * conf->nr_files;
+	struct stripe_array *s;
+	int i;
+
+	s = malloc(sizeof(*s) + total * sizeof(struct iovec));
+
+	s->nr = 0;
+	for (i = 0; i < conf->nr_files; i++) {
+		struct stripe *t = &s->s[i];
+
+		t->nr_vec = 0;
+		t->vec = &s->_vec[i * nr_vecs];
+		t->nr_sects = 0;
+		t->cap = nr_vecs;
+	}
+
+	return s;
+}
+
+static void free_stripe_array(struct stripe_array *s)
+{
+	free(s);
+}
+
+static void calculate_stripe_array(const struct stripe_conf *conf,
+		const struct ublksrv_io_desc *iod, struct stripe_array *s)
+{
+	const unsigned shift = conf->shift - 9;
+	const unsigned chunk_sects = 1 << shift;
+	const unsigned unit_sects = conf->nr_files << shift;
+	off64_t start = iod->start_sector;
+	off64_t end = start + iod->nr_sectors;
+	unsigned long done = 0;
+	unsigned idx = 0;
+
+	while (start < end) {
+		unsigned nr_sects = chunk_sects - (start & (chunk_sects - 1));
+		loff_t unit_off = (start / unit_sects) * unit_sects;
+		unsigned seq = (start - unit_off) >> shift;
+		struct stripe *this = &s->s[idx];
+		loff_t stripe_off = (unit_off / conf->nr_files) +
+			(start & (chunk_sects - 1));
+
+		if (nr_sects > end - start)
+			nr_sects = end - start;
+		if (this->nr_sects == 0) {
+			this->nr_sects = nr_sects;
+			this->start = stripe_off;
+			this->seq = seq;
+			s->nr += 1;
+		} else {
+			assert(seq == this->seq);
+			assert(this->start + this->nr_sects == stripe_off);
+			this->nr_sects += nr_sects;
+		}
+
+		assert(this->nr_vec < this->cap);
+		this->vec[this->nr_vec].iov_base = (void *)(iod->addr + done);
+		this->vec[this->nr_vec++].iov_len = nr_sects << 9;
+
+		start += nr_sects;
+		done += nr_sects << 9;
+		idx = (idx + 1) % conf->nr_files;
+	}
+}
+
+static inline enum io_uring_op stripe_to_uring_op(const struct ublksrv_io_desc *iod)
+{
+	unsigned ublk_op = ublksrv_get_op(iod);
+
+	if (ublk_op == UBLK_IO_OP_READ)
+		return IORING_OP_READV;
+	else if (ublk_op == UBLK_IO_OP_WRITE)
+		return IORING_OP_WRITEV;
+	assert(0);
+}
+
+static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+{
+	const struct stripe_conf *conf = get_chunk_shift(q);
+	enum io_uring_op op = stripe_to_uring_op(iod);
+	struct io_uring_sqe *sqe[NR_STRIPE];
+	struct stripe_array *s = alloc_stripe_array(conf, iod);
+	struct ublk_io *io = ublk_get_io(q, tag);
+	int i;
+
+	io->private_data = s;
+	calculate_stripe_array(conf, iod, s);
+
+	ublk_queue_alloc_sqes(q, sqe, s->nr);
+	for (i = 0; i < s->nr; i++) {
+		struct stripe *t = &s->s[i];
+
+		io_uring_prep_rw(op, sqe[i],
+				t->seq + 1,
+				(void *)t->vec,
+				t->nr_vec,
+				t->start << 9);
+		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
+		/* bit63 marks us as tgt io */
+		sqe[i]->user_data = build_user_data(tag, ublksrv_get_op(iod), i, 1);
+	}
+	return s->nr;
+}
+
+static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+{
+	const struct stripe_conf *conf = get_chunk_shift(q);
+	struct io_uring_sqe *sqe[NR_STRIPE];
+	int i;
+
+	ublk_queue_alloc_sqes(q, sqe, conf->nr_files);
+	for (i = 0; i < conf->nr_files; i++) {
+		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
+		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
+		sqe[i]->user_data = build_user_data(tag, UBLK_IO_OP_FLUSH, 0, 1);
+	}
+	return conf->nr_files;
+}
+
+static int stripe_queue_tgt_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	unsigned ublk_op = ublksrv_get_op(iod);
+	int ret = 0;
+
+	switch (ublk_op) {
+	case UBLK_IO_OP_FLUSH:
+		ret = handle_flush(q, iod, tag);
+		break;
+	case UBLK_IO_OP_WRITE_ZEROES:
+	case UBLK_IO_OP_DISCARD:
+		ret = -ENOTSUP;
+		break;
+	case UBLK_IO_OP_READ:
+	case UBLK_IO_OP_WRITE:
+		ret = stripe_queue_tgt_rw_io(q, iod, tag);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	ublk_dbg(UBLK_DBG_IO, "%s: tag %d ublk io %x %llx %u ret %d\n", __func__, tag,
+			iod->op_flags, iod->start_sector, iod->nr_sectors << 9, ret);
+	return ret;
+}
+
+static int ublk_stripe_queue_io(struct ublk_queue *q, int tag)
+{
+	int queued = stripe_queue_tgt_io(q, tag);
+
+	ublk_queued_tgt_io(q, tag, queued);
+	return 0;
+}
+
+static void ublk_stripe_io_done(struct ublk_queue *q, int tag,
+		const struct io_uring_cqe *cqe)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	unsigned op = user_data_to_op(cqe->user_data);
+	struct ublk_io *io = ublk_get_io(q, tag);
+	int res = cqe->res;
+
+	if (res < 0) {
+		if (!io->result)
+			io->result = res;
+		ublk_err("%s: io failure %d tag %u\n", __func__, res, tag);
+	}
+
+	/* fail short READ/WRITE simply */
+	if (op == UBLK_IO_OP_READ || op == UBLK_IO_OP_WRITE) {
+		unsigned seq = user_data_to_tgt_data(cqe->user_data);
+		struct stripe_array *s = io->private_data;
+
+		if (res < s->s[seq].vec->iov_len)
+			io->result = -EIO;
+	}
+
+	if (ublk_completed_tgt_io(q, tag)) {
+		int res = io->result;
+
+		if (!res)
+			res = iod->nr_sectors << 9;
+
+		ublk_complete_io(q, tag, res);
+
+		free_stripe_array(io->private_data);
+		io->private_data = NULL;
+	}
+}
+
+static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
+{
+	struct ublk_params p = {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.attrs = UBLK_ATTR_VOLATILE_CACHE,
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift	= 12,
+			.io_min_shift	= 9,
+			.max_sectors = dev->dev_info.max_io_buf_bytes >> 9,
+		},
+	};
+	unsigned chunk_size = ctx->chunk_size;
+	struct stripe_conf *conf;
+	unsigned chunk_shift;
+	loff_t bytes = 0;
+	int ret, i;
+
+	if ((chunk_size & (chunk_size - 1)) || !chunk_size) {
+		ublk_err("invalid chunk size %u\n", chunk_size);
+		return -EINVAL;
+	}
+
+	if (chunk_size < 4096 || chunk_size > 512 * 1024) {
+		ublk_err("invalid chunk size %u\n", chunk_size);
+		return -EINVAL;
+	}
+
+	chunk_shift = ilog2(chunk_size);
+
+	ret = backing_file_tgt_init(dev);
+	if (ret)
+		return ret;
+
+	if (!dev->tgt.nr_backing_files || dev->tgt.nr_backing_files > NR_STRIPE)
+		return -EINVAL;
+
+	assert(dev->nr_fds == dev->tgt.nr_backing_files + 1);
+
+	for (i = 0; i < dev->tgt.nr_backing_files; i++)
+		dev->tgt.backing_file_size[i] &= ~((1 << chunk_shift) - 1);
+
+	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
+		unsigned long size = dev->tgt.backing_file_size[i];
+
+		if (size != dev->tgt.backing_file_size[0])
+			return -EINVAL;
+		bytes += size;
+	}
+
+	conf = malloc(sizeof(*conf));
+	conf->shift = chunk_shift;
+	conf->nr_files = dev->tgt.nr_backing_files;
+
+	dev->private_data = conf;
+	dev->tgt.dev_size = bytes;
+	p.basic.dev_sectors = bytes >> 9;
+	dev->tgt.params = p;
+	dev->tgt.sq_depth = dev->dev_info.queue_depth * conf->nr_files;
+	dev->tgt.cq_depth = dev->dev_info.queue_depth * conf->nr_files;
+
+	printf("%s: shift %u files %u\n", __func__, conf->shift, conf->nr_files);
+
+	return 0;
+}
+
+static void ublk_stripe_tgt_deinit(struct ublk_dev *dev)
+{
+	free(dev->private_data);
+	backing_file_tgt_deinit(dev);
+}
+
+const struct ublk_tgt_ops stripe_tgt_ops = {
+	.name = "stripe",
+	.init_tgt = ublk_stripe_tgt_init,
+	.deinit_tgt = ublk_stripe_tgt_deinit,
+	.queue_io = ublk_stripe_queue_io,
+	.tgt_io_done = ublk_stripe_io_done,
+};
diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testing/selftests/ublk/test_stripe_01.sh
new file mode 100755
index 000000000000..c01f3dc325ab
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_01.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_01"
+ERR_CODE=0
+
+_prep_test "stripe" "write and verify test"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+
+dev_id=$(_add_ublk_dev -t stripe "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "${backfile_0}"
+
+# run fio over the ublk disk
+fio --name=write_and_verify \
+    --filename=/dev/ublkb"${dev_id}" \
+    --ioengine=libaio --iodepth=32 \
+    --rw=write \
+    --size=512M \
+    --direct=1 \
+    --verify=crc32c \
+    --do_verify=1 \
+    --bs=4k > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_02.sh b/tools/testing/selftests/ublk/test_stripe_02.sh
new file mode 100755
index 000000000000..e8a45fa82dde
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_02.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_02"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+dev_id=$(_add_ublk_dev -t stripe "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
-- 
2.47.0

