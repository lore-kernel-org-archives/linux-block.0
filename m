Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2E36B93A;
	Thu, 30 Jul 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379283; cv=none; b=iI6QEPTTdHn8sZDhqx0R6u2mFCZxBF3FRRCiKQUNdFRCq0KhfsYQwkOXXb2E465ScQEtAdrH7tpLb7r3/9oSHBGHJJYDv694EPdAhKrFNToiG8AFfQkTfDASyvTkYSm4WvfozAP8QNmE0sIMkMFdxwVZxqjHTjDIKqlnQy8jTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379283; c=relaxed/simple;
	bh=XmI9L4At5QubQfnDG2NnwW8sqz82omkpGO3gu5xj9ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZMiQBAwJO3mnYsmysi4u8EKYAEi4SOMV8WLbZhPf+WNwISW4mZg+U6rQIq7UQnsU6Lk7VMAHlUZu9HVbtRgFsnKVUDUO+xaQA9hHLsa9zB6a2jaZwGlrlpKNGOECf+UgOTrs+pow9dgtY9RBfA1gmtAaf2O10qwlzjqR9ro950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pMphizFq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pMphizFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=E5
	EJz66XfLv3L+a2r3GJ3Ao+3fEVeAK4wHRPR6IlLBE=; b=pMphizFqD7PAUUwXnY
	3SqAf9OPNmHsKyUPnnsiBuRYr4DVuXTG8j4nw25nHefIFW4tS4Bmix4I8XbKAut9
	xi6+UHPfYPGJLZ0quT9Nzw1fqHT+e6bwFfXPJHTs9Z7CCOcmlE3ZEQHjyyMATwLr
	q5BMIPlf2R9FTGoSxIQduq9y0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_zi0uWpq5MyaMA--.20348S2;
	Thu, 30 Jul 2026 10:40:53 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] selftests: ublk: add rotating auto_buf index regression test
Date: Thu, 30 Jul 2026 10:40:50 +0800
Message-Id: <20260730024050.1062354-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730010910.799346-3-yangxiuwei@kylinos.cn>
References: <20260730010910.799346-3-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_zi0uWpq5MyaMA--.20348S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFW7KrWUWrW3GrWDKr4Uurg_yoW3Kw1Up3
	y0ka4YyF10qF12qF18ArsrWFySgrs7JF4xJr4Sqr9Ivw1UJrs3Zw4xtFW3tFZruFZYqr43
	Za1IqF48WF4DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jahFxUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6hXQYWpqubVe-gAA3i

Batch AUTO_BUF_REG COMMIT must unregister the old auto_buf index before
storing the next one. Fixed per-tag indexing (A == B) masks bugs that
clear after overwriting io->buf.

Add kublk --rotate_auto_buf so each tag alternates between two sparse
buffer indices, and test_batch_04.sh to exercise that path. Without the
driver fix, the request ref stays stuck and I/O hangs; the test uses a
short timeout and kills the ublk daemon to recover. With the fix, a
small write completes quickly.

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/batch.c          |  2 +-
 tools/testing/selftests/ublk/kublk.c          | 19 +++++++-
 tools/testing/selftests/ublk/kublk.h          | 19 +++++++-
 tools/testing/selftests/ublk/test_batch_04.sh | 44 +++++++++++++++++++
 5 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_batch_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 6e4fe8d1fed1..b5d757aa7ee8 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -23,6 +23,7 @@ TEST_PROGS += test_generic_17.sh
 TEST_PROGS += test_batch_01.sh
 TEST_PROGS += test_batch_02.sh
 TEST_PROGS += test_batch_03.sh
+TEST_PROGS += test_batch_04.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index a54025b00917..d8d9ebed5979 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -535,7 +535,7 @@ void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 
 	elem = (struct ublk_batch_elem *)(cb->elem + cb->done * t->commit_buf_elem_size);
 	elem->tag = tag;
-	elem->buf_index = ublk_batch_io_buf_idx(t, q, tag);
+	elem->buf_index = ublk_batch_io_buf_idx_next(t, q, tag);
 	elem->result = res;
 
 	if (!ublk_queue_no_buf(q))
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 0b23c09daea5..10320d9f73d1 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -540,9 +540,14 @@ static int ublk_thread_init(struct ublk_thread *t, unsigned long long extra_flag
 		unsigned max_nr_ios_per_thread = nr_ios / dev->nthreads;
 		max_nr_ios_per_thread += !!(nr_ios % dev->nthreads);
 
+		t->auto_buf_stride = max_nr_ios_per_thread;
 		t->nr_bufs = max_nr_ios_per_thread;
+		if ((extra_flags & UBLKS_Q_ROTATE_AUTO_BUF) &&
+		    (dev->dev_info.flags & UBLK_F_AUTO_BUF_REG))
+			t->nr_bufs *= 2;
 	} else {
 		t->nr_bufs = 0;
+		t->auto_buf_stride = 0;
 	}
 
 	if (ublk_dev_batch_io(dev))
@@ -1436,6 +1441,8 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		extra_flags = UBLKS_Q_AUTO_BUF_REG_FALLBACK;
 	if (ctx->no_ublk_fixed_fd)
 		extra_flags |= UBLKS_Q_NO_UBLK_FIXED_FD;
+	if (ctx->rotate_auto_buf)
+		extra_flags |= UBLKS_Q_ROTATE_AUTO_BUF;
 
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
@@ -2067,7 +2074,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
-	printf("\t[--batch|-b] [--no_auto_part_scan]\n");
+	printf("\t[--batch|-b] [--rotate_auto_buf] [--no_auto_part_scan]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -2141,6 +2148,7 @@ int main(int argc, char *argv[])
 		{ "tag_size",		1,	NULL,  0 },
 		{ "safe",		0,	NULL,  0 },
 		{ "batch",              0,      NULL, 'b'},
+		{ "rotate_auto_buf",	0,	NULL,  0 },
 		{ "no_auto_part_scan",	0,	NULL,  0 },
 		{ "shmem_zc",		0,	NULL,  0  },
 		{ "htlb",		1,	NULL,  0  },
@@ -2228,6 +2236,8 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_AUTO_BUF_REG;
 			if (!strcmp(longopts[option_idx].name, "auto_zc_fallback"))
 				ctx.auto_zc_fallback = 1;
+			if (!strcmp(longopts[option_idx].name, "rotate_auto_buf"))
+				ctx.rotate_auto_buf = 1;
 			if (!strcmp(longopts[option_idx].name, "nthreads"))
 				ctx.nthreads = strtol(optarg, NULL, 10);
 			if (!strcmp(longopts[option_idx].name, "per_io_tasks"))
@@ -2335,6 +2345,13 @@ int main(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (ctx.rotate_auto_buf &&
+	    !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
+	      (ctx.flags & UBLK_F_BATCH_IO))) {
+		ublk_err("rotate_auto_buf requires --auto_zc and --batch\n");
+		return -EINVAL;
+	}
+
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 742c41d77df1..188b97f0cb95 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -82,6 +82,7 @@ struct dev_ctx {
 	unsigned int	safe_stop:1;
 	unsigned int	no_auto_part_scan:1;
 	unsigned int	rdonly_shmem_buf:1;
+	unsigned int	rotate_auto_buf:1;
 	__u32 integrity_flags;
 	__u8 metadata_size;
 	__u8 pi_offset;
@@ -134,6 +135,7 @@ struct ublk_io {
 
 	unsigned short buf_index;
 	unsigned short tgt_ios;
+	unsigned char auto_buf_phase;
 	void *private_data;
 };
 
@@ -184,6 +186,7 @@ struct ublk_queue {
 #define UBLKS_Q_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
 #define UBLKS_Q_NO_UBLK_FIXED_FD	(1ULL << 62)
 #define UBLKS_Q_PREPARED	(1ULL << 61)
+#define UBLKS_Q_ROTATE_AUTO_BUF	(1ULL << 60)
 	__u64 flags;
 	int ublk_fd;	/* cached ublk char device fd */
 	__u8 metadata_size;
@@ -232,6 +235,7 @@ struct ublk_thread {
 	unsigned int io_inflight;
 
 	unsigned short nr_bufs;
+	unsigned short auto_buf_stride;
 
        /* followings are for BATCH_IO */
 	unsigned short commit_buf_start;
@@ -550,7 +554,20 @@ static inline unsigned short ublk_batch_io_buf_idx(
 		const struct ublk_thread *t, const struct ublk_queue *q,
 		unsigned tag)
 {
-	return ublk_queue_idx_in_thread(t, q) * q->q_depth + tag;
+	unsigned short base = ublk_queue_idx_in_thread(t, q) * q->q_depth + tag;
+
+	if (q->flags & UBLKS_Q_ROTATE_AUTO_BUF)
+		return base + q->ios[tag].auto_buf_phase * t->auto_buf_stride;
+	return base;
+}
+
+static inline unsigned short ublk_batch_io_buf_idx_next(
+		const struct ublk_thread *t, struct ublk_queue *q,
+		unsigned tag)
+{
+	if (q->flags & UBLKS_Q_ROTATE_AUTO_BUF)
+		q->ios[tag].auto_buf_phase ^= 1;
+	return ublk_batch_io_buf_idx(t, q, tag);
 }
 
 /* Queue UBLK_U_IO_PREP_IO_CMDS for a specific queue with batch elements */
diff --git a/tools/testing/selftests/ublk/test_batch_04.sh b/tools/testing/selftests/ublk/test_batch_04.sh
new file mode 100755
index 000000000000..cd5e1ff9d630
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_batch_04.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# --rotate_auto_buf: COMMIT must unregister old auto_buf index before store.
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+if ! _have_feature "BATCH_IO" || ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_program fio || ! _have_program timeout; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "batch auto_buf unregister with rotating index"
+
+_create_backfile 0 64M
+
+dev_id=$(_add_ublk_dev_no_settle -t loop -q 1 --nthreads 1 -b --auto_zc \
+	--rotate_auto_buf "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+for ((i = 0; i < 50; i++)); do
+	[ -b /dev/ublkb"${dev_id}" ] && break
+	sleep 0.1
+done
+[ -b /dev/ublkb"${dev_id}" ] || { _cleanup_test; _show_result $TID 1; }
+
+timeout -k 2 5 fio --name=job1 --filename=/dev/ublkb"${dev_id}" \
+	--ioengine=libaio --rw=write --direct=1 --bs=4k --iodepth=1 --size=64k \
+	> /dev/null 2>&1
+ERR_CODE=$?
+
+if [ "$ERR_CODE" -ne 0 ]; then
+	kill -9 "$(_get_ublk_daemon_pid "$dev_id" 2>/dev/null)" 2>/dev/null || true
+	sleep 0.5
+	pkill -9 fio 2>/dev/null || true
+	ERR_CODE=1
+fi
+
+_cleanup_test
+_show_result $TID $ERR_CODE
-- 
2.25.1

