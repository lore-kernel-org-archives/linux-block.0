Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EA2A1AA
	for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816557; cv=none; b=ZT/VvfvQCuWnh7dJqXBf/r8U720Nsds40RxG5rIYo0YFYy0YM2AG/iDSHXHKFdKXYxc+KBt0imsKRqcb7IJ07m2m8xjydB/gIsbBc53Es6ZwF9rlK/9Ci/Y2D5RAXYnuSd9s/VltzhuHcvKhWZTkSnumry/eLumFV2k/swRc5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816557; c=relaxed/simple;
	bh=W/rkiAGRdeBVfq8p8mpoCrKnC1DGGzyz+OwWnEobdWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTRjlacpAIc0Y3HdwEPbi5nWzWc9xvtrq5Eo2ZUldTpVW0KonQsTOpChxajRBhwyZMYfHai8jjPk+OCSUqloZE92iRj+RvJi30tS9zxRCykikd2LPgGfSYRML7EUfqp0My+tuC3gOrY5VpVldZOr6Mq5uGSxbAlA7k21dNqRD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhH/Obdq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhH/Obdq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso22444185e9.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776816554; x=1777421354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kOO6hvHEOXUtMcYtOy5QlL9m9H4iNST+fWSKu3oVIA=;
        b=KhH/ObdqNrBvUlFsn3IEXAorwjnmRAAWlHUccWWPevHdKP2qb1IsJt28X9AOLBxVHM
         ypCeixp1TV7bKy+rrym3KMWORqfL9cnRyxVkF+Dly8vDjrJw+CRl+RSC/FotJB1c1t+W
         xQKRLgtjI7DoUtCxl9vyyN3sbvY2aI9lBkd4Gi5eFB6ZpYH/GMUjdwiOexg4fPb6zV+m
         6+MHXjlNGVgKNLl5rjpp6C/ChIOf6g8d0G1AdAPXRE3ITNzrTbVgP0JtkjBqoX6brtuQ
         ViqO49zBGmNvnWJhaEPnmx1d4tTpmW3w9i+2oSAW7Ipptza6XcqGhfqv8vjDNbrKllp1
         BobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776816554; x=1777421354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kOO6hvHEOXUtMcYtOy5QlL9m9H4iNST+fWSKu3oVIA=;
        b=Iypb9+lKUe6MxCPkxSW7xvbPTEhG2tiJQAkdyBtYdBOLVEwJFrDuyD69Yf22+DkNWW
         9Yf/FqqXoKYvaJrqYgfNtqcpNZO+fjbwhZdUzXo5k1IYxcMVBU7jGjHlB4+sONNe8dA0
         9c04v2568ORWnBVWPqgou0c32GW/CGigoMBNxZ6ga+Y5/EjOycmJn/cY8z92vlOHvTQf
         PvBP7Lacvb9iJlEXegwzaDyI2AtlF2HpVfXwmH5d+Z/z3jGdGGG5PDhy57kccxW3lqhE
         T/GyNMVixsDDrTcW+RGkgorBuls/nXcIZ+nY39xSwef1yKsyEdkSM8uwNzyadfaOhHAw
         Pv/w==
X-Forwarded-Encrypted: i=1; AFNElJ8vUn9czHyNStRLovoQk4JH/n23B18iUimr8zrJokzv5VN1gTR+XXkcuVuPtIKEm4J6VzDV5toRSnYs4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKyCeUPZlleyRKh4lyxjqJDTen8AUGgtFX2SSqFHkMp7q+V8b
	zlxbIuRpDoTNpqYAjRVHCmqs611AsdryMAOGHaVSHUv1T4KDLLQ08dIM
X-Gm-Gg: AeBDieve1UlRKmOgCk/6OUpNY/D09sf7ibi3e1gO13W8QwWQBGgQ1IjiRLbDRKAzY5F
	rX6WxEOCd2RVzH8Kdz4NEyGLs4TToEEDttFAQs8N2szMJ256Yh9fIpz5y1NQL7qVbe/AHSk2Le6
	+ZwMojm7LGiwps63bPImbaQy/fbH0s36sooaBYMft/yNnNbNXYxEuglBg/UbrS8SJ9G0qDXzl+c
	oXdsc5KR3yclEY3Yj9Z/BAuohlfO8gMnqF2ZQgJMop+9lGN+U4OOVG7JIl+kaJMDlBqqd9abf0L
	o1TLfRiLcvqtlVF0uZ1U/irFyoc3EAXSsJ7kqIOjGSowSvY8IxBIA0IbXHYFNoTjpn+PzIBdMfK
	NymZJD00n2YH41w+FzsUkoBLLTdM6afbvRwnN8yozHnljQCCF4DxUycCZUurblWY30wSflwsbsW
	dnYUAR/IK0fz3UM4v/qdjT/9en1f989Acqq5RP7eNtT8/gL+GXC9RryIfWbPujVZhzXLr9nedK9
	h3TY+2UIPF3bb+djjU=
X-Received: by 2002:a05:600d:14:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488fb7957efmr222279255e9.30.1776816554099;
        Tue, 21 Apr 2026 17:09:14 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5499b0edsm97833755e9.14.2026.04.21.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:09:13 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Liam R. Howlett" <liam.howlett@oracle.com>
Subject: [PATCH] ublk: fix maple tree lockdep warning and unpin under spinlock
Date: Wed, 22 Apr 2026 08:08:56 +0800
Message-ID: <20260422000856.2362220-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

Fix two issues in the shmem buffer maple tree usage:

1) ublk_buf_cleanup() iterates the tree with mas_for_each() without
   holding rcu_read_lock or mas_lock, triggering a lockdep splat on
   CONFIG_PROVE_RCU kernels. Add mas_lock/unlock around the iteration.

2) __ublk_ctrl_unreg_buf() calls unpin_user_pages() under mas_lock
   (a spinlock). unpin_user_pages can be expensive for large buffers
   and may take additional locks if folio refcount drops to zero.
   Restructure to drop mas_lock before unpinning, re-acquiring it
   to continue iteration.

Both functions now use the same pattern: erase under lock, drop lock,
unpin and free, re-lock to continue. Extract ublk_unpin_range_pages()
helper to share the page unpinning loop.

Reported-by: Jens Axboe <axboe@kernel.dk>
Closes: https://lore.kernel.org/linux-block/0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk/
Cc: Liam R. Howlett <liam.howlett@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 63 +++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 49fb584e392b..0a92569c0c7d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5404,16 +5404,39 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	return ret;
 }
 
+static void ublk_unpin_range_pages(unsigned long base_pfn,
+				   unsigned long nr_pages)
+{
+#define UBLK_UNPIN_BATCH	32
+	struct page *pages[UBLK_UNPIN_BATCH];
+	unsigned long off;
+
+	for (off = 0; off < nr_pages; ) {
+		unsigned int batch = min_t(unsigned long,
+					   nr_pages - off, UBLK_UNPIN_BATCH);
+		unsigned int j;
+
+		for (j = 0; j < batch; j++)
+			pages[j] = pfn_to_page(base_pfn + off + j);
+		unpin_user_pages(pages, batch);
+		off += batch;
+	}
+}
+
+/*
+ * Drop mas_lock during iteration to avoid unpinning pages under spinlock.
+ * Safe because callers hold ub->mutex (via ublk_lock_buf_tree), preventing
+ * concurrent tree modifications.
+ */
 static int __ublk_ctrl_unreg_buf(struct ublk_device *ub, int buf_index)
 {
 	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
 	struct ublk_buf_range *range;
-	struct page *pages[32];
 	int ret = -ENOENT;
 
 	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
-		unsigned long base, nr, off;
+		unsigned long base, nr;
 
 		if (range->buf_index != buf_index)
 			continue;
@@ -5422,18 +5445,12 @@ static int __ublk_ctrl_unreg_buf(struct ublk_device *ub, int buf_index)
 		base = mas.index;
 		nr = mas.last - base + 1;
 		mas_erase(&mas);
+		mas_unlock(&mas);
 
-		for (off = 0; off < nr; ) {
-			unsigned int batch = min_t(unsigned long,
-						   nr - off, 32);
-			unsigned int j;
-
-			for (j = 0; j < batch; j++)
-				pages[j] = pfn_to_page(base + off + j);
-			unpin_user_pages(pages, batch);
-			off += batch;
-		}
+		ublk_unpin_range_pages(base, nr);
 		kfree(range);
+
+		mas_lock(&mas);
 	}
 	mas_unlock(&mas);
 
@@ -5463,29 +5480,27 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 	return ret;
 }
 
+/*
+ * Drop mas_lock during iteration to avoid unpinning pages under spinlock.
+ * Safe because this is called from device release with exclusive access.
+ */
 static void ublk_buf_cleanup(struct ublk_device *ub)
 {
 	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
 	struct ublk_buf_range *range;
-	struct page *pages[32];
 
+	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
 		unsigned long base = mas.index;
 		unsigned long nr = mas.last - base + 1;
-		unsigned long off;
 
-		for (off = 0; off < nr; ) {
-			unsigned int batch = min_t(unsigned long,
-						   nr - off, 32);
-			unsigned int j;
-
-			for (j = 0; j < batch; j++)
-				pages[j] = pfn_to_page(base + off + j);
-			unpin_user_pages(pages, batch);
-			off += batch;
-		}
+		mas_erase(&mas);
+		mas_unlock(&mas);
+		ublk_unpin_range_pages(base, nr);
 		kfree(range);
+		mas_lock(&mas);
 	}
+	mas_unlock(&mas);
 	mtree_destroy(&ub->buf_tree);
 	ida_destroy(&ub->buf_ida);
 }
-- 
2.53.0

