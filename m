Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D01EF0A3
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635973; cv=none; b=pJ62uZKBEZ4X2FRB3NvPm9MinTU8Vr8rzkaPgOSI1uyRcrcUXv4B1EZac37JxkRMdSg6a7m53soyBCVaOd/v1SHKPoKu7Musa4OJK1cEigRCGL2ZStRgnXlBgSp/8vA6fNC4qvUhku+Ilix1Md5whKDGzXug3UuEdGiISw0/waQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635973; c=relaxed/simple;
	bh=3WNHciglXMK94NsAem4lJ8P4gyiF6z4VQ1ZjR09fx3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AonPbSyCFKn6Fmu4JSZAwlsmfCpFMZ00HeRYaBw3riTyZA+KflbZibv8aMO4uvbZ7bjM6xSTyuKqLTiZqGTDEJy8+XaIRSiI14Zi3NZcynMB9dhhwTprIc1NyIRvqfdiu+M/BFy77CetYiRbGsGK/+EeLnQHnsK5U/fKWC1uPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSb/UmOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSb/UmOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwIHiQInI0FacGFRNLyCZ0hgKnG1GhFYHsz0PHY2c6A=;
	b=fSb/UmOmullHXhNhUp0lH6f6nIcbkA/FrtHynNd/99xkEUgzUMbZWoH6uog8MeKeYXjcQH
	WvF8RE0HPhZcIp8u8uatdiAabRqkXLvnfYZOvYaP/+AXD1pgz3SOyv0No5OW3OFLq7zGKM
	4N78Uj6qph2hspoBZVC1R/8TAejtIsU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-tKvP4eA4PlSgH28vQ2Wb6g-1; Sat,
 22 Mar 2025 05:32:49 -0400
X-MC-Unique: tKvP4eA4PlSgH28vQ2Wb6g-1
X-Mimecast-MFC-AGG-ID: tKvP4eA4PlSgH28vQ2Wb6g_1742635968
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67AD81801A06;
	Sat, 22 Mar 2025 09:32:48 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14BD9195609D;
	Sat, 22 Mar 2025 09:32:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/8] selftests: ublk: move common code into common.c
Date: Sat, 22 Mar 2025 17:32:12 +0800
Message-ID: <20250322093218.431419-5-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move two functions for initializing & de-initializing backing file
into common.c.

Also move one common helper into kublk.h.

Prepare for supporting ublk-stripe.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile      |  2 +-
 tools/testing/selftests/ublk/common.c      | 55 ++++++++++++++++++++++
 tools/testing/selftests/ublk/file_backed.c | 52 --------------------
 tools/testing/selftests/ublk/kublk.h       |  2 +
 4 files changed, 58 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/common.c

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 652ab40adb73..03dae5184d08 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -18,7 +18,7 @@ TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c
+$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/common.c b/tools/testing/selftests/ublk/common.c
new file mode 100644
index 000000000000..01580a6f8519
--- /dev/null
+++ b/tools/testing/selftests/ublk/common.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "kublk.h"
+
+void backing_file_tgt_deinit(struct ublk_dev *dev)
+{
+	int i;
+
+	for (i = 1; i < dev->nr_fds; i++) {
+		fsync(dev->fds[i]);
+		close(dev->fds[i]);
+	}
+}
+
+int backing_file_tgt_init(struct ublk_dev *dev)
+{
+	int fd, i;
+
+	assert(dev->nr_fds == 1);
+
+	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
+		char *file = dev->tgt.backing_file[i];
+		unsigned long bytes;
+		struct stat st;
+
+		ublk_dbg(UBLK_DBG_DEV, "%s: file %d: %s\n", __func__, i, file);
+
+		fd = open(file, O_RDWR | O_DIRECT);
+		if (fd < 0) {
+			ublk_err("%s: backing file %s can't be opened: %s\n",
+					__func__, file, strerror(errno));
+			return -EBADF;
+		}
+
+		if (fstat(fd, &st) < 0) {
+			close(fd);
+			return -EBADF;
+		}
+
+		if (S_ISREG(st.st_mode))
+			bytes = st.st_size;
+		else if (S_ISBLK(st.st_mode)) {
+			if (ioctl(fd, BLKGETSIZE64, &bytes) != 0)
+				return -1;
+		} else {
+			return -EINVAL;
+		}
+
+		dev->tgt.backing_file_size[i] = bytes;
+		dev->fds[dev->nr_fds] = fd;
+		dev->nr_fds += 1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index f58fa4ec9b51..a2e8793390a8 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -2,58 +2,6 @@
 
 #include "kublk.h"
 
-static void backing_file_tgt_deinit(struct ublk_dev *dev)
-{
-	int i;
-
-	for (i = 1; i < dev->nr_fds; i++) {
-		fsync(dev->fds[i]);
-		close(dev->fds[i]);
-	}
-}
-
-static int backing_file_tgt_init(struct ublk_dev *dev)
-{
-	int fd, i;
-
-	assert(dev->nr_fds == 1);
-
-	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
-		char *file = dev->tgt.backing_file[i];
-		unsigned long bytes;
-		struct stat st;
-
-		ublk_dbg(UBLK_DBG_DEV, "%s: file %d: %s\n", __func__, i, file);
-
-		fd = open(file, O_RDWR | O_DIRECT);
-		if (fd < 0) {
-			ublk_err("%s: backing file %s can't be opened: %s\n",
-					__func__, file, strerror(errno));
-			return -EBADF;
-		}
-
-		if (fstat(fd, &st) < 0) {
-			close(fd);
-			return -EBADF;
-		}
-
-		if (S_ISREG(st.st_mode))
-			bytes = st.st_size;
-		else if (S_ISBLK(st.st_mode)) {
-			if (ioctl(fd, BLKGETSIZE64, &bytes) != 0)
-				return -1;
-		} else {
-			return -EINVAL;
-		}
-
-		dev->tgt.backing_file_size[i] = bytes;
-		dev->fds[dev->nr_fds] = fd;
-		dev->nr_fds += 1;
-	}
-
-	return 0;
-}
-
 static enum io_uring_op ublk_to_uring_op(const struct ublksrv_io_desc *iod, int zc)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 40b89dcf0704..eaadd7364e25 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -320,4 +320,6 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 
+void backing_file_tgt_deinit(struct ublk_dev *dev);
+int backing_file_tgt_init(struct ublk_dev *dev);
 #endif
-- 
2.47.0

