Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8680045
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031198; cv=none; b=An0pvCmdkWYajriTwzz3tugRJvecV+l/tASXE7yl796k88jqp/TOUciZDnK8YMY296TJLpME0uqsrH25d94UbRV5NK1waBdCdUfTnV0Tl9FPFx5vvFJrN4/dOQHyOPKqZJ1cGDYpqEPgHC2KATmGNlm2rJVyjs+NJXXvCKbpi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031198; c=relaxed/simple;
	bh=+mtYadm3M+ilgJiBZY+vUq8IU5xjNYe+J28FqoPsnj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N63iue3Y5D0K/PxNHpeowWvctjf1b/ghL3L8JwLcAbtC2mFiNgbi/qtTR7uC0QEFlxb+n821jZSotCjQNrK/jZZbuPRHkGUq4Pb/Z6ilVTWwa0gI5kke53fK0KRRdCZU25/StCVihztKWNvOu0bhsg/ZAsSb6uI8gI51lTbcyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aT9eV3uk; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aT9eV3uk"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bed82030faso59609039f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031196; x=1706635996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl7xBNgNabyen0blKRPhiVPUOU+ukJNqSOFOnGFVt7U=;
        b=aT9eV3ukMh5DAxR6ZhVn/P/FnDOUAJeoGq3HR+WxjOAnPZlJVO0Biny+h/oxOWb+Pf
         a2gVHuM/oXDTe477XvTTugibWbQvwIF+DLrudxIdFy0jRmIa0i3QmEGH6sqJwqqB24BL
         uln5287LLbqOq9IM1Ofh60I1CkTjjOhXh8uzd1cuZIq6QktEHw1iWZPIfk++QC0zu2PH
         xQYNLMt3YJ7MEmuCYyD4PaXM1vMDYJpDjewWaIPkzjMLvRBAGGKAqNm2C45KPA0iuasB
         8o1mBHviMX+LvAdeVW63GDenWzx5zyZMKL/n+LFk1TPTYsDErdTShrlrJWVkGQCrC6qv
         zd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031196; x=1706635996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl7xBNgNabyen0blKRPhiVPUOU+ukJNqSOFOnGFVt7U=;
        b=duS+dCpIBYPTELkcgZafTInlTgKWyQuvkezio9TokfCPVC9u9+H3qblSImtctzSYwb
         UjBu6w9njPkEgyFrAWTgRADZzxuOFFPTcmir/cuA2m1dJ5W5/q4RUMP/9wYy5WEHFBkT
         qbq2F39aBOBcbE7FuVdY+C+lgS76dvSS/uu366kiqwdASY/Semy+2G1pE5txkYjDXv0+
         IvZP/AcgE1FHpOfMIyYh3Gz23ZxsQ69jRmM8mBPl0RmF6U79y1HNujhj80+yW2kcByHc
         2Qn98vgeD5Az1x14q9sa+gRi/IZZHIKjHgiA47+btzuRTtlI2JE/mHigpAkHr+ga6N+7
         jsgA==
X-Gm-Message-State: AOJu0YxGc3n1CDnYdegCLiQbF1WXXKPfAB+c+oOoMAiuLTVJXBnTpLPg
	VpVXs5RQOvc1koopcdGPOIgejNX63VdPR9xaAf9oO0Vb4p0fCEw3Gt54JPC2+N3v6ycQjTSuOTH
	6ZSg=
X-Google-Smtp-Source: AGHT+IErkVziVzfS6ew5ABzlNQMgAkQebrYZQOZ0J5XKlYRQmU4xtW+E+YhbZYSnceYH94OnLb0Vag==
X-Received: by 2002:a5d:8e0b:0:b0:7bf:4758:2a12 with SMTP id e11-20020a5d8e0b000000b007bf47582a12mr10047616iod.0.1706031195647;
        Tue, 23 Jan 2024 09:33:15 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] block: move cgroup time handling code into blkdev.h
Date: Tue, 23 Jan 2024 10:30:33 -0700
Message-ID: <20240123173310.1966157-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123173310.1966157-1-axboe@kernel.dk>
References: <20240123173310.1966157-1-axboe@kernel.dk>
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

