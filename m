Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76842E627
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605839; cv=none; b=KS6+A97KvBTNJkVGMbJfZRo/DlKchGPyYi3bdIVzoijEnMOStMac9BlwU0FKA0BhqrhmxtwwXGBgdiZ+9zD4yarOtFoXt/o4CJYgYUhhgE2wW9PMJARxjkEsEPqmsZtQGRdcR7x81hupKeW2UClKMbWRX4UaHQlMJ1OzvIGKQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605839; c=relaxed/simple;
	bh=2+jD+dAJoAmbHwxBuTYGGTBTalKI4J0VNuRxTZdHS8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnqLyItaCsQZ1RQ5dzGT/rhOuDRs6ug1hALha6DPXRQ3E4z9ZfXIK6kWrwR32wE3oLQ0L+kZYLcl6/K1PlDI0gGq3yzICZESsiMo3Ewtgo18ZI0ge2BibQPr1HHDdW8LHphIycjXWrlSjnleHJrdweR0ikaNAau+3S/YqKCfDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=znUPn2pt; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="znUPn2pt"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bee01886baso50334339f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705605836; x=1706210636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nj3hM/YCE8GL2EPHEiO+vgsWtZQHNFa8Pn/Qr89Xv4=;
        b=znUPn2ptXByBw1llgLnJH6lqGkjzvTtwGisvrbTpEZVAFB8GJc63NSveh7p50UKBCg
         tPGmGUVX0OvI2c1s1khM3iEJbIVLY/LPWGlhObQ+sMeLx0JDnmTZc0ws4YA7q9oyJtSK
         RYI+lx1waI36glizHvF8uVoQZ4JlplpwNa32qdowX/81322Wz58K9F3fB08SQMnH7t3i
         dZjp11mjGzfbjHQuoFikGXLf5sz/xBT9B3mEXagtmjOuf+MJbMkSLDiEORL6I8fWAaEG
         bryWYfrxWHFQHB4Vjdugd6jD64lmp3zLxMdMT0phOcTW9+v6ViuXVIA/p1XAvk5AXFLm
         eZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605836; x=1706210636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nj3hM/YCE8GL2EPHEiO+vgsWtZQHNFa8Pn/Qr89Xv4=;
        b=sKJyKrlHERBIw6LEFlZkpTLxqmf3GvLG909XZVnLZCyKZrPLVyVDt+UC0T8jgRGL9g
         zDLbWvl7Vi2E4DLWNyP1H6mndbWbE9kmo63TOGptDCtcz5+hDd7Ciitux5I2cUJ6kJHo
         jg00deLAs9ZQ8Dv3bpIKK/8qyogkGSJSgXqoMk3s72FfUbWWD5HlOcDA9lnEm/2B+G1X
         hRUNC9rLMOvM/nsHWtqMNZ7x7+i6bXy4IAbUYixebU/WimihCVcOj6XePIv5AiGPr5Fq
         425r9XXQs/cBgcXicBW/E5zuoHSID+yNXYOYs3YQnYimf6ZXgvs7f9iFNU+VoU7ykZ3J
         vI8Q==
X-Gm-Message-State: AOJu0YyKt3A0zj5V3oCWCzGrR0QTwfPxP03Oh3wA0R0e3V/c0qIUm1is
	uojwZS0LZWMJoE1rkAmPwFgaxe2vrvGBGJdIklfRbw91sQmDFEHEhYqWsDXnHvJcIVHUtsGNvSP
	nao8=
X-Google-Smtp-Source: AGHT+IF1anoSzGVCxZcjPLBRNSHXUgU8I9ZMamuJQPllV3EA5BAUnIZAf+W145BYkoaZWcXxvDU5Gw==
X-Received: by 2002:a6b:5a0d:0:b0:7bf:35d5:bd21 with SMTP id o13-20020a6b5a0d000000b007bf35d5bd21mr356474iob.1.1705605836686;
        Thu, 18 Jan 2024 11:23:56 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm1155588jab.40.2024.01.18.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:23:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] block: shrink plug->{nr_ios, rq_count} to unsigned char
Date: Thu, 18 Jan 2024 12:20:56 -0700
Message-ID: <20240118192343.953539-6-axboe@kernel.dk>
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

We never use more than 64 max in here, we can change them from unsigned
short to just a byte. Add a BUILD_BUG_ON() check, in case the max plug
count changes in the future.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 4 ++--
 block/blk-mq.c         | 2 ++
 include/linux/blkdev.h | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 71c6614a97fe..dd593008511c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1063,7 +1063,7 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
-void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
+void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned char nr_ios)
 {
 	struct task_struct *tsk = current;
 
@@ -1076,7 +1076,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->cur_ktime = 0;
 	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
-	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
+	plug->nr_ios = min_t(unsigned char, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aff9e9492f59..a9b4a66e1e13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1283,6 +1283,8 @@ EXPORT_SYMBOL(blk_mq_start_request);
  */
 static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 {
+	BUILD_BUG_ON(2 * BLK_MAX_REQUEST_COUNT > U8_MAX);
+
 	if (plug->multiple_queues)
 		return BLK_MAX_REQUEST_COUNT * 2;
 	return BLK_MAX_REQUEST_COUNT;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 518c77d1f0c3..80da19cb3b39 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -944,9 +944,9 @@ struct blk_plug {
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
 	u64 cur_ktime;
-	unsigned short nr_ios;
+	unsigned char nr_ios;
 
-	unsigned short rq_count;
+	unsigned char rq_count;
 
 	bool multiple_queues;
 	bool has_elevator;
@@ -964,7 +964,7 @@ struct blk_plug_cb {
 extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
 					     void *data, int size);
 extern void blk_start_plug(struct blk_plug *);
-extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
+extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned char);
 extern void blk_finish_plug(struct blk_plug *);
 
 void __blk_flush_plug(struct blk_plug *plug, bool from_schedule);
@@ -1055,7 +1055,7 @@ struct blk_plug {
 };
 
 static inline void blk_start_plug_nr_ios(struct blk_plug *plug,
-					 unsigned short nr_ios)
+					 unsigned char nr_ios)
 {
 }
 
-- 
2.43.0

