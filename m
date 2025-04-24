Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4938F58
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498152; cv=none; b=HIatXpH9p5+HGAY5eG4ABzCHbTy2de+59/V7Q3sUbmjRztOJR/0VkrYUXB3KWZlGw+A+9GtoC+Mv0wMev5V9T8hOe7J72XnPzFHbGz5dDzE6ZWe2i/SJh3f1aGbpHV82XLgMtYUk/zhaMzaR5V2z6LnjZe62o+DoTi4oyW+MU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498152; c=relaxed/simple;
	bh=MhJ/vkYI+8fueY4l1qkMYtgHHocXj41xXFtljroDbKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUCmZqCae9N3c8ZpIbddvPCZf2JAfRrFxjcorZq7rmfynbyn23xNFF8VSmuNpjgdwHpwieY9osx7IgU2LN1pUoRZHRBAZQoGJ+tj96N9aY6vz56MfF4m/cbbqHql1rr+F7AyBQFK/p2Iwp9cv5tT/Ph5/8cEJx9eyjCm+B8OFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbQAGkrK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbQAGkrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745498149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QS1AIzkf2IVDN4tpd8D5Zm5m0TtZMhIzPDa7XSbKRWE=;
	b=CbQAGkrKr6cnyfW1KPlHkka6niEpm0UNqCR8bvCIU5+WZDW+oGUOFtztn3dSQ2n/BP+Nn2
	FBGNuSTQFm1qOBrehM6uRR4B9/1uhSqurTGcQAAEROMhVujrxok2Tx63vvuygUtffCwMaH
	xMD0kCfnXo7g+ye9hTzqyaQyo5M85vs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-Qzl1iDDhO9ey8XRHKq8vtw-1; Thu,
 24 Apr 2025 08:35:45 -0400
X-MC-Unique: Qzl1iDDhO9ey8XRHKq8vtw-1
X-Mimecast-MFC-AGG-ID: Qzl1iDDhO9ey8XRHKq8vtw_1745498144
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13BC61800988;
	Thu, 24 Apr 2025 12:35:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.127])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE63619560AB;
	Thu, 24 Apr 2025 12:35:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: fix UBLK_F_NEED_GET_DATA
Date: Thu, 24 Apr 2025 20:35:34 +0800
Message-ID: <20250424123534.1046690-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit 57e13a2e8cd2 ("selftests: ublk: support user recovery") starts to
support UBLK_F_NEED_GET_DATA for covering recovery related test, however the
ublk utility implementation isn't done correctly.

Fix it by pulling intact UBLK_F_NEED_GET_DATA support to ublk utility.

Also add test generic_07 for covering UBLK_F_NEED_GET_DATA.

Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 11 +++++---
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_07.sh | 25 +++++++++++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bc..f34ac0bac696 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -9,6 +9,7 @@ TEST_PROGS += test_generic_03.sh
 TEST_PROGS += test_generic_04.sh
 TEST_PROGS += test_generic_05.sh
 TEST_PROGS += test_generic_06.sh
+TEST_PROGS += test_generic_07.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e57a1486bb48..701b47f98902 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -538,10 +538,12 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 
 	/* we issue because we need either fetching or committing */
 	if (!(io->flags &
-		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
+		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_NEED_GET_DATA)))
 		return 0;
 
-	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
+	if (io->flags & UBLKSRV_NEED_GET_DATA)
+		cmd_op = UBLK_U_IO_NEED_GET_DATA;
+	else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
 		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
 	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
 		cmd_op = UBLK_U_IO_FETCH_REQ;
@@ -658,6 +660,9 @@ static void ublk_handle_cqe(struct io_uring *r,
 		assert(tag < q->q_depth);
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(q, tag);
+	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
+		io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
+		ublk_queue_io_cmd(q, io, tag);
 	} else {
 		/*
 		 * COMMIT_REQ will be completed immediately since no fetching
@@ -1313,7 +1318,7 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:g:az",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 918db5cd633f..44ee1e4ac55b 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -115,6 +115,7 @@ struct ublk_io {
 #define UBLKSRV_NEED_FETCH_RQ		(1UL << 0)
 #define UBLKSRV_NEED_COMMIT_RQ_COMP	(1UL << 1)
 #define UBLKSRV_IO_FREE			(1UL << 2)
+#define UBLKSRV_NEED_GET_DATA           (1UL << 3)
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/testing/selftests/ublk/test_generic_07.sh
new file mode 100755
index 000000000000..5d82b5955006
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_07.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_07"
+ERR_CODE=0
+
+_prep_test "generic" "test UBLK_F_NEED_GET_DATA"
+
+_create_backfile 0 256M
+dev_id=$(_add_ublk_dev -t loop -q 2 -g 1 "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+if ! _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M; then
+	_cleanup_test "generic"
+	_show_result $TID 255
+fi
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
-- 
2.47.0

