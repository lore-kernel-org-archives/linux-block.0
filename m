Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FB2E3F8
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605833; cv=none; b=tFQpZbeDYbrMyElmC9SxszQvnVzIOmDRr5oFzW4Sx5BrxMfmWHsPJfSOH9Y4oVgCsW6LOCMk4V5A0aEOYBYcGS0V+BPBGPIeSWFZ8Kj1o1SocZHR2rDO/tLiOJ1cr9FEJvXzXwFOgwUa2uJ8NV7GXNULHUMzrgF7H8dbLSdMFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605833; c=relaxed/simple;
	bh=+mtYadm3M+ilgJiBZY+vUq8IU5xjNYe+J28FqoPsnj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9HBruxgI0A5IhSqApTTBuDcZQpMb3wFTk56oQoANInPahqDb+78b7pmdzKAoSi8erQ7O/v73AO5x1c8LNNDpHiEk4DBdomO4Bu+bZFpL2NBsxqGOuQNjNeX4BhxbvGc9uPpzQYSysBSP4nccsfBPqxYzlRCqNu5G+upecsnf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CPQ1aONl; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CPQ1aONl"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bee01886baso50332239f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705605829; x=1706210629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl7xBNgNabyen0blKRPhiVPUOU+ukJNqSOFOnGFVt7U=;
        b=CPQ1aONlkJl5kMNKdcnDcpnZdqDs5Vh7Vh8vpwPM02R+faACbfNSIjUq6el8RpdRNh
         uuq6wDT6mH3ed4KxVNuO5Sp8gn3p8Zi6k6oWyRtBwph2yUgZsbwhpjKvW0cyiUZLea84
         V3HxS4XoweIUu3oQQuK/Q19N7o7iMMjAXdL1U3RN47z3F3cERl9b/rF+AeIOYHDhjzWC
         XWYSAMTCZ8INdY18H3pMjuaFvzuwho1Z8CQofbLwrg9A9szjGuj4k+WboA2nVsB+I1q5
         4xJ69MwzaT/6vl8DjrLQjTeBPDuUcKqQBTMb+CS6vru/Uvl23QciuiEXBP1Yrv9JuMI8
         KM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605829; x=1706210629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl7xBNgNabyen0blKRPhiVPUOU+ukJNqSOFOnGFVt7U=;
        b=XQJsIdW0zeKd3LSvtdaSHPsWEhz4dgD7Fjy19BHobEkQWILK7YbJU+3HDArTyA+4vo
         iRGLlzlW8cFFVrnYST+iE94cR9Kvs4qyiDj8yWxHnwUQNZCcuB/AgxZ8xinFdI6apY8L
         nLe051Imz5iMjuudzxvIFckqoBUl2GSKH1VR++aVTCam5H4P+yi6RV9UMqtC3JAzlNWk
         adFqgLxUXEAzsykIHuHmy72eGFCO1bz2jEUf8urSaqIE8yV9YvUOBFs4DJEaTvR/jr+p
         Yg9gIT6/XYRhs4PMgYH5GDoRqEyfH8Rqcyg0hkUbpqAuv6C0DBw7rzRmlXBeY0w0JFxa
         Ts5g==
X-Gm-Message-State: AOJu0YxjB72loldMklx11S8AszdnNAcoBez0gNrb58g8kNzOkz1HRlix
	QDww2vw7X7wn6/LZ0kriolZ/eQcSfadw/AIw1Oy+Yo9xAnS/sqC1O70xtWEWxIf6/wjY+CqyS/S
	yhsc=
X-Google-Smtp-Source: AGHT+IEH7pCx5Oo1v/Im3VilHn0TAfTpltlALsNiDAiqbGs1IJrB+cCCM0eC/rPdapRquUhgT16V2Q==
X-Received: by 2002:a6b:5a0d:0:b0:7bf:35d5:bd21 with SMTP id o13-20020a6b5a0d000000b007bf35d5bd21mr356065iob.1.1705605829454;
        Thu, 18 Jan 2024 11:23:49 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm1155588jab.40.2024.01.18.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:23:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] block: move cgroup time handling code into blkdev.h
Date: Thu, 18 Jan 2024 12:20:52 -0700
Message-ID: <20240118192343.953539-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118192343.953539-1-axboe@kernel.dk>
References: <20240118192343.953539-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for moving time keeping into blkdev.h, move the cgroup
related code for timestamps in here too. This will help avoid a circular
dependency.

Leave struct bio_issue in blk_types.h as it's a proper time definition.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 42 --------------------------------------
 include/linux/blkdev.h    | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f288c94374b3..1c07848dea7e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -206,52 +206,10 @@ static inline bool blk_path_error(blk_status_t error)
 	return true;
 }
 
-/*
- * From most significant bit:
- * 1 bit: reserved for other usage, see below
- * 12 bits: original size of bio
- * 51 bits: issue time of bio
- */
-#define BIO_ISSUE_RES_BITS      1
-#define BIO_ISSUE_SIZE_BITS     12
-#define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
-#define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BITS)
-#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
-#define BIO_ISSUE_SIZE_MASK     \
-	(((1ULL << BIO_ISSUE_SIZE_BITS) - 1) << BIO_ISSUE_SIZE_SHIFT)
-#define BIO_ISSUE_RES_MASK      (~((1ULL << BIO_ISSUE_RES_SHIFT) - 1))
-
-/* Reserved bit for blk-throtl */
-#define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
-
 struct bio_issue {
 	u64 value;
 };
 
-static inline u64 __bio_issue_time(u64 time)
-{
-	return time & BIO_ISSUE_TIME_MASK;
-}
-
-static inline u64 bio_issue_time(struct bio_issue *issue)
-{
-	return __bio_issue_time(issue->value);
-}
-
-static inline sector_t bio_issue_size(struct bio_issue *issue)
-{
-	return ((issue->value & BIO_ISSUE_SIZE_MASK) >> BIO_ISSUE_SIZE_SHIFT);
-}
-
-static inline void bio_issue_init(struct bio_issue *issue,
-				       sector_t size)
-{
-	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
-	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
-			(ktime_get_ns() & BIO_ISSUE_TIME_MASK) |
-			((u64)size << BIO_ISSUE_SIZE_SHIFT));
-}
-
 typedef __u32 __bitwise blk_opf_t;
 
 typedef unsigned int blk_qc_t;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e72213..da0f7e1caa5a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -974,6 +974,49 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
+
+/*
+ * From most significant bit:
+ * 1 bit: reserved for other usage, see below
+ * 12 bits: original size of bio
+ * 51 bits: issue time of bio
+ */
+#define BIO_ISSUE_RES_BITS      1
+#define BIO_ISSUE_SIZE_BITS     12
+#define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
+#define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BITS)
+#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
+#define BIO_ISSUE_SIZE_MASK     \
+	(((1ULL << BIO_ISSUE_SIZE_BITS) - 1) << BIO_ISSUE_SIZE_SHIFT)
+#define BIO_ISSUE_RES_MASK      (~((1ULL << BIO_ISSUE_RES_SHIFT) - 1))
+
+/* Reserved bit for blk-throtl */
+#define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
+
+static inline u64 __bio_issue_time(u64 time)
+{
+	return time & BIO_ISSUE_TIME_MASK;
+}
+
+static inline u64 bio_issue_time(struct bio_issue *issue)
+{
+	return __bio_issue_time(issue->value);
+}
+
+static inline sector_t bio_issue_size(struct bio_issue *issue)
+{
+	return ((issue->value & BIO_ISSUE_SIZE_MASK) >> BIO_ISSUE_SIZE_SHIFT);
+}
+
+static inline void bio_issue_init(struct bio_issue *issue,
+				       sector_t size)
+{
+	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
+	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
+			(ktime_get_ns() & BIO_ISSUE_TIME_MASK) |
+			((u64)size << BIO_ISSUE_SIZE_SHIFT));
+}
+
 #else /* CONFIG_BLOCK */
 struct blk_plug {
 };
-- 
2.43.0

