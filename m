Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593441163F
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971191; cv=none; b=lQg7VdH9kAQSLE4pf/220pojPFwonEfRRhhk7B9Uo6ESMI/PGqoG+5rNnjasMemH0AUhgnGwdIFha5lZJeIj7iAA47Q6eM/N5N3cfRwvxG148rc8JhjJN59jyEYiPCsUnrwUB9jEiNJLhE5gFV1I3pxyXIvKPH5wU3iYD4olEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971191; c=relaxed/simple;
	bh=ldLHWwPcvqcTDwNP7L27St5+/SUJn4bKn+WlLfNiKEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NI6Xcanrf78i9wHqtRSxI5FlJLNl/tl+7RyLNkewT1OYAKVV2NhycOwW+2q1++t9wurGZ2j5aGTbaRZLlp9s8m1OJePT0ahhPXrpPWkG5DnVbt7LHDQaLfzJdlrDyukhE7/X7nNLx4rkMWp1icqTxl+iyZ36fDmfMMzcSgfr/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJYS05db; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJYS05db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5UYRSpPluNiAHbbuPwAjSWApfYzLgHYEqbUe2e2eOg=;
	b=EJYS05dbPSkCxFKz2r/Tg6YkxCbpVyGtUcftrmYfVMY2GUeSKUO6tBsgb8yaf/f9lfq8QB
	6uoCIUg5gdsf4VpeF0DTDXSEQ+bkppW82NMY2XISkjsJZuQ6JDP8gD8ifjrfg/SQCgdsZ8
	PmPtHACyFlEY3ykwGrP233ycCB97LQs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-L39KEl3ENpu0BTFkhdO_rQ-1; Tue,
 31 Mar 2026 11:32:56 -0400
X-MC-Unique: L39KEl3ENpu0BTFkhdO_rQ-1
X-Mimecast-MFC-AGG-ID: L39KEl3ENpu0BTFkhdO_rQ_1774971175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECC31944DC8;
	Tue, 31 Mar 2026 15:32:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 747D030001A2;
	Tue, 31 Mar 2026 15:32:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 10/10] selftests/ublk: add read-only buffer registration test
Date: Tue, 31 Mar 2026 23:32:01 +0800
Message-ID: <20260331153207.3635125-11-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add --rdonly_shmem_buf option to kublk that registers shared memory
buffers with UBLK_SHMEM_BUF_READ_ONLY (read-only pinning without
FOLL_WRITE) and mmaps with PROT_READ only.

Add test_shmemzc_04.sh which exercises the new flag with a null target,
hugetlbfs buffer, and write workload. Write I/O works because the
server only reads from the shared buffer — the data flows from client
to kernel to the shared pages, and the server reads them out.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 17 +++--
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_shmemzc_04.sh | 72 +++++++++++++++++++
 4 files changed, 86 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 3d1ad1730d93..d07f90fdd5b8 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -54,6 +54,7 @@ TEST_PROGS += test_part_02.sh
 TEST_PROGS += test_shmemzc_01.sh
 TEST_PROGS += test_shmemzc_02.sh
 TEST_PROGS += test_shmemzc_03.sh
+TEST_PROGS += test_shmemzc_04.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index bd97e34f131b..7ed2fd5d6a0e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1212,11 +1212,13 @@ static void ublk_shmem_unregister_all(void)
 	shmem_count = 0;
 }
 
-static int ublk_ctrl_reg_buf(struct ublk_dev *dev, void *addr, size_t size)
+static int ublk_ctrl_reg_buf(struct ublk_dev *dev, void *addr, size_t size,
+			     __u32 flags)
 {
-	struct ublk_buf_reg buf_reg = {
+	struct ublk_shmem_buf_reg buf_reg = {
 		.addr = (unsigned long)addr,
 		.len = size,
+		.flags = flags,
 	};
 	struct ublk_ctrl_cmd_data data = {
 		.cmd_op = UBLK_U_CMD_REG_BUF,
@@ -1265,7 +1267,7 @@ static void ublk_shmem_handle_client(int sock_fd, struct ublk_dev *dev)
 	}
 
 	/* Register server's VA range with kernel for PFN matching */
-	ret = ublk_ctrl_reg_buf(dev, base, size);
+	ret = ublk_ctrl_reg_buf(dev, base, size, 0);
 	if (ret < 0) {
 		ublk_dbg(UBLK_DBG_DEV,
 			 "shmem_zc: kernel reg failed %d\n", ret);
@@ -1350,7 +1352,8 @@ static int ublk_shmem_htlb_setup(const struct dev_ctx *ctx,
 		return -EINVAL;
 	}
 
-	base = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE,
+	base = mmap(NULL, st.st_size,
+		    ctx->rdonly_shmem_buf ? PROT_READ : PROT_READ | PROT_WRITE,
 		    MAP_SHARED | MAP_POPULATE, fd, 0);
 	if (base == MAP_FAILED) {
 		ublk_err("htlb: mmap failed\n");
@@ -1358,7 +1361,8 @@ static int ublk_shmem_htlb_setup(const struct dev_ctx *ctx,
 		return -ENOMEM;
 	}
 
-	ret = ublk_ctrl_reg_buf(dev, base, st.st_size);
+	ret = ublk_ctrl_reg_buf(dev, base, st.st_size,
+			       ctx->rdonly_shmem_buf ? UBLK_SHMEM_BUF_READ_ONLY : 0);
 	if (ret < 0) {
 		ublk_err("htlb: reg_buf failed: %d\n", ret);
 		munmap(base, st.st_size);
@@ -2122,6 +2126,7 @@ int main(int argc, char *argv[])
 		{ "no_auto_part_scan",	0,	NULL,  0 },
 		{ "shmem_zc",		0,	NULL,  0  },
 		{ "htlb",		1,	NULL,  0  },
+		{ "rdonly_shmem_buf",	0,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -2241,6 +2246,8 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_SHMEM_ZC;
 			if (!strcmp(longopts[option_idx].name, "htlb"))
 				ctx.htlb_path = strdup(optarg);
+			if (!strcmp(longopts[option_idx].name, "rdonly_shmem_buf"))
+				ctx.rdonly_shmem_buf = 1;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 20d0a1eab41f..467af9f487e9 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -80,6 +80,7 @@ struct dev_ctx {
 	unsigned int	no_ublk_fixed_fd:1;
 	unsigned int	safe_stop:1;
 	unsigned int	no_auto_part_scan:1;
+	unsigned int	rdonly_shmem_buf:1;
 	__u32 integrity_flags;
 	__u8 metadata_size;
 	__u8 pi_offset;
diff --git a/tools/testing/selftests/ublk/test_shmemzc_04.sh b/tools/testing/selftests/ublk/test_shmemzc_04.sh
new file mode 100755
index 000000000000..899de088ece4
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_shmemzc_04.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test: shmem_zc with read-only buffer registration on null target
+#
+# Same as test_shmemzc_01 but with --rdonly_shmem_buf: pages are pinned
+# without FOLL_WRITE (UBLK_BUF_F_READ).  Write I/O works because
+# the server only reads from the shared buffer.
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+_prep_test "shmem_zc" "null target hugetlbfs shmem zero-copy rdonly_buf test"
+
+if ! _have_program fio; then
+	echo "SKIP: fio not available"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! grep -q hugetlbfs /proc/filesystems; then
+	echo "SKIP: hugetlbfs not supported"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# Allocate hugepages
+OLD_NR_HP=$(cat /proc/sys/vm/nr_hugepages)
+echo 10 > /proc/sys/vm/nr_hugepages
+NR_HP=$(cat /proc/sys/vm/nr_hugepages)
+if [ "$NR_HP" -lt 2 ]; then
+	echo "SKIP: cannot allocate hugepages"
+	echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# Mount hugetlbfs
+HTLB_MNT=$(mktemp -d "${UBLK_TEST_DIR}/htlb_mnt_XXXXXX")
+if ! mount -t hugetlbfs none "$HTLB_MNT"; then
+	echo "SKIP: cannot mount hugetlbfs"
+	rmdir "$HTLB_MNT"
+	echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
+	exit "$UBLK_SKIP_CODE"
+fi
+
+HTLB_FILE="$HTLB_MNT/ublk_buf"
+fallocate -l 4M "$HTLB_FILE"
+
+dev_id=$(_add_ublk_dev -t null --shmem_zc --htlb "$HTLB_FILE" --rdonly_shmem_buf)
+_check_add_dev $TID $?
+
+fio --name=htlb_zc_rdonly \
+	--filename=/dev/ublkb"${dev_id}" \
+	--ioengine=io_uring \
+	--rw=randwrite \
+	--direct=1 \
+	--bs=4k \
+	--size=4M \
+	--iodepth=32 \
+	--mem=mmaphuge:"$HTLB_FILE" \
+	> /dev/null 2>&1
+ERR_CODE=$?
+
+# Delete device first so daemon releases the htlb mmap
+_ublk_del_dev "${dev_id}"
+
+rm -f "$HTLB_FILE"
+umount "$HTLB_MNT"
+rmdir "$HTLB_MNT"
+echo "$OLD_NR_HP" > /proc/sys/vm/nr_hugepages
+
+_cleanup_test "shmem_zc"
+
+_show_result $TID $ERR_CODE
-- 
2.53.0

