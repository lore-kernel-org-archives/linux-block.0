Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF81C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635983; cv=none; b=jmV8AlXgYi2BG3iY3Xuw803jhFkev1zcCdHIxMuNYrZ/o8SKQveiWjxsew2ROhIH0z9F2N8EZ4NMEAJmpwLvrZ67HPfwQwyVOFO2ocATPk3jwUKHOoH95IiGwMOmcdwL6JE2CRQ6qhZ65uYCGXfEmEbhOYFHF4FdlTFb8ZT5F3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635983; c=relaxed/simple;
	bh=LxMEn2AyNx3Nko9hLpn5sC7yMNfpAMWqr9GCX3zdl3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5EBaWjm3Alb11lwJqF06Xxk2sTyQtQ2/2n0lHA1AP95ao0WlyKaO4Yyp3mWyoI8rT7Bd4uiR0enKJNkGySE04u7YCOfYvZjNPd63voa0EcLhXwAi69mpm8u4KqbJteZTz2mGdaKb+Ogmmg0IU8YawA4+aL4OoqZuJIETffm/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuvV2QWh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuvV2QWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqStE05uk7xsCNPGehu8r2pJLVjxh4vFiw13cruOQUc=;
	b=NuvV2QWhp+hP5zZdz2pkjXVEaVKVB3CCfxTmPHM76yJPt7o6DceRDNj1NJ9GsEjJrkQDK8
	/AUl0D4I9JPpXVtuQLZkAWKgQUKXR+cshX+9h+tWa1eHrFI6gQw2qPazy1vV1pfh26cfBd
	YWomF7dgYXAFlTOGb8TufmX1dc/kxrs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-AaB0aOUDPYWYo7lOrOiqlw-1; Sat,
 22 Mar 2025 05:32:59 -0400
X-MC-Unique: AaB0aOUDPYWYo7lOrOiqlw-1
X-Mimecast-MFC-AGG-ID: AaB0aOUDPYWYo7lOrOiqlw_1742635978
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AB941800361;
	Sat, 22 Mar 2025 09:32:58 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B4D3180A802;
	Sat, 22 Mar 2025 09:32:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] selftests: ublk: enable zero copy for null target
Date: Sat, 22 Mar 2025 17:32:14 +0800
Message-ID: <20250322093218.431419-7-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Enable zero copy for null target so that we can evaluate performance
from zero copy or not.

Also this should be the simplest ublk zero copy implementation, which
can be served as zc example.

Add test for covering 'add -t null -z'.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile        |  1 +
 tools/testing/selftests/ublk/kublk.h         |  5 ++
 tools/testing/selftests/ublk/null.c          | 70 +++++++++++++++++++-
 tools/testing/selftests/ublk/test_null_02.sh | 20 ++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_null_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 03dae5184d08..36f50c000e55 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -6,6 +6,7 @@ LDLIBS += -lpthread -lm -luring
 TEST_PROGS := test_generic_01.sh
 
 TEST_PROGS += test_null_01.sh
+TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 4eee9ad2bead..48ca16055710 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -198,6 +198,11 @@ static inline unsigned int user_data_to_tgt_data(__u64 user_data)
 	return (user_data >> 24) & 0xffff;
 }
 
+static inline unsigned short ublk_cmd_op_nr(unsigned int op)
+{
+	return _IOC_NR(op);
+}
+
 static inline void ublk_err(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 975a11db22fd..899875ff50fe 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -2,6 +2,14 @@
 
 #include "kublk.h"
 
+#ifndef IORING_NOP_INJECT_RESULT
+#define IORING_NOP_INJECT_RESULT        (1U << 0)
+#endif
+
+#ifndef IORING_NOP_FIXED_BUFFER
+#define IORING_NOP_FIXED_BUFFER         (1U << 3)
+#endif
+
 static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
@@ -20,14 +28,73 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		},
 	};
 
+	if (info->flags & UBLK_F_SUPPORT_ZERO_COPY)
+		dev->tgt.sq_depth = dev->tgt.cq_depth = 2 * info->queue_depth;
 	return 0;
 }
 
+static int null_queue_zc_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	unsigned ublk_op = ublksrv_get_op(iod);
+	struct io_uring_sqe *sqe[3];
+
+	ublk_queue_alloc_sqes(q, sqe, 3);
+
+	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+	sqe[0]->user_data = build_user_data(tag,
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
+	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
+
+	io_uring_prep_nop(sqe[1]);
+	sqe[1]->buf_index = tag;
+	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
+	sqe[1]->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
+	sqe[1]->len = iod->nr_sectors << 9; 	/* injected result */
+	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, 1);
+
+	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
+	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
+
+	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
+	return 2;
+}
+
+static void ublk_null_io_done(struct ublk_queue *q, int tag,
+		const struct io_uring_cqe *cqe)
+{
+	unsigned op = user_data_to_op(cqe->user_data);
+	struct ublk_io *io = ublk_get_io(q, tag);
+
+	if (cqe->res < 0 || op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
+		if (!io->result)
+			io->result = cqe->res;
+		if (cqe->res < 0)
+			ublk_err("%s: io failed op %x user_data %lx\n",
+					__func__, op, cqe->user_data);
+	}
+
+	/* buffer register op is IOSQE_CQE_SKIP_SUCCESS */
+	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
+		io->tgt_ios += 1;
+
+	if (ublk_completed_tgt_io(q, tag))
+		ublk_complete_io(q, tag, io->result);
+}
+
 static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	int zc = ublk_queue_use_zc(q);
+	int queued;
+
+	if (!zc) {
+		ublk_complete_io(q, tag, iod->nr_sectors << 9);
+		return 0;
+	}
 
-	ublk_complete_io(q, tag, iod->nr_sectors << 9);
+	queued = null_queue_zc_io(q, tag);
+	ublk_queued_tgt_io(q, tag, queued);
 	return 0;
 }
 
@@ -35,4 +102,5 @@ const struct ublk_tgt_ops null_tgt_ops = {
 	.name = "null",
 	.init_tgt = ublk_null_tgt_init,
 	.queue_io = ublk_null_queue_io,
+	.tgt_io_done = ublk_null_io_done,
 };
diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing/selftests/ublk/test_null_02.sh
new file mode 100755
index 000000000000..5633ca876655
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_02.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="null_02"
+ERR_CODE=0
+
+_prep_test "null" "basic IO test with zero copy"
+
+dev_id=$(_add_ublk_dev -t null -z)
+_check_add_dev $TID $?
+
+# run fio over the two disks
+fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test "null"
+
+_show_result $TID $ERR_CODE
-- 
2.47.0

