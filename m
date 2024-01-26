Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607824B23
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305116; cv=none; b=l4467YHx4HY5f3W+7yVsHjhxm6Cm0+AHt/cfTx8syWpkpSF86UaONFZJiTF+VVSBcLoARilHzTbFzBRBPQiJn4EpbYH9zhwDhcFQ8DKvZBBPfbg4WkM1OUcC7MmNnL9mAqpR7VckcCwD7fygYqaPWbx9cfrSCesiRtPE4IpscA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305116; c=relaxed/simple;
	bh=BppLfqTIUIAcV77FhmprqGx8Zf2hKtirQj68wn3Z7Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deM3EEojj9SzayKL/94aHThpC1LVXWBAjdJh/cr2JVZdn2tUFybbfpdUWo0NNqdj/+hYRiMDFMuKrI+1UKuTuwcXe098Q/fVYOUq9ujMYHdTipgm6H02V45Q9wqe3Wr4cxtxfvEcq0Fs4QqVQ4OEsmeykxIymekgC2vt/oSAR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DSN6BfGA; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DSN6BfGA"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bed82030faso13777539f.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 13:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706305112; x=1706909912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnADpnrlRvkAxElk+T6bZ95hCVvXW4jaBrhlK8+qsE8=;
        b=DSN6BfGAn6EiQ9o6QIf9fDWDdGeLfXAvSCHjZSc1EdwlC5kR5gRiRrM8ht3bll2y33
         stWHVqHlEbF/Hk0qfZp3Znf9REvUENGAu7YLmC0h3a474noxo/TGoTjBAEfWWHnfJ93o
         obxMtoHeHyeAYhOZ4cP+ve5ZkqHSp8VZh2AIXeYeUgwq2Qo0WvKVGXZYgPNEn0vH8XUt
         vwJft33pU5sr8P4juCdcYDInoPa+5A5c5Rsefgz2ijW7iSmFTNmK+lQJJQLbluOg6aq7
         Lk7mao7znFcc8NHwDpv+4V42mEkwbpDdocp9eXwPfcy1UGWWY6gJq/zGkMpZIV8JXTR0
         owaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305112; x=1706909912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnADpnrlRvkAxElk+T6bZ95hCVvXW4jaBrhlK8+qsE8=;
        b=e6QOeC5Lp32hxWvkjK8DZJ05rzc1Uqgjs/15SZs5oJthQRv+hC/9LLaFc7kVIUoklK
         WXw2rp5F4kBZRUKrxG7DBDe0sxEjl/XAh6ItdXXPBghiHE77yUhRtAdMj7LXJSyJLh/+
         tEGidnsvHODYsKBv89YDqAG9e8uRGRfW04DCPpTsme5LJsd+XU84EzUBVrAFJgXqx419
         sEu9i3aTrnuo4/Pobbia10F0oIInEHWTR6QG9fRt0sUXKSvei4GCHW4qKyXxjCWXUzf3
         IXfDWF+QUMuEjtZxL2pU4Q+H5pHjv3iOmPOKyRA76/RMA39u2GJyb7Zdi/6CyJ6DFQ8E
         BkHQ==
X-Gm-Message-State: AOJu0YzCjrnwq474L3mXQqE4HseTKzXpNXbMlWUMieAOCi1R18L5GZfP
	qOPaEbQVeDaRrB7D3VUeREc+n6xfa+5KhnCwn8KSE7j5w5whwvb/JoRA7kPMzE2cLDp/56+U/ue
	rtWw=
X-Google-Smtp-Source: AGHT+IGycPG8i0J6gvUuo+IO3F81Cz7WCj6NeGClDI8PqPrqwUAvAMkgOjOAT25/QdD90Dc8rNBTRw==
X-Received: by 2002:a6b:a02:0:b0:7bf:b9e0:c7c3 with SMTP id z2-20020a6b0a02000000b007bfb9e0c7c3mr915252ioi.2.1706305111949;
        Fri, 26 Jan 2024 13:38:31 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a029a04000000b0046f34484578sm471788jal.126.2024.01.26.13.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:38:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: move cgroup time handling code into blk.h
Date: Fri, 26 Jan 2024 14:30:31 -0700
Message-ID: <20240126213827.2757115-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126213827.2757115-1-axboe@kernel.dk>
References: <20240126213827.2757115-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for moving time keeping into blk.h, move the cgroup
related code for timestamps in here too. This will help avoid a circular
dependency, and also moves it into a more appropriate header as this one
is private to the block layer code.

Leave struct bio_issue in blk_types.h as it's a proper time definition.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.h        |  1 +
 block/blk.h               | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h | 42 ---------------------------------------
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index b927a4a0ad03..78b74106bf10 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -19,6 +19,7 @@
 #include <linux/kthread.h>
 #include <linux/blk-mq.h>
 #include <linux/llist.h>
+#include "blk.h"
 
 struct blkcg_gq;
 struct blkg_policy_data;
diff --git a/block/blk.h b/block/blk.h
index 1ef920f72e0f..620e3a035da1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -516,4 +516,46 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
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
 #endif /* BLK_INTERNAL_H */
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
-- 
2.43.0

