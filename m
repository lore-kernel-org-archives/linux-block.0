Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534642943E
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U0ERhN3a"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35d374bebe3so2556285ab.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704988950; x=1705593750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb8RmmOQHMK3RGx2kZv4ToZcis6slj97jx6CHPGBmCY=;
        b=U0ERhN3avCH+rshDGVc5xjBMYPjQrmgC/ke3+qA4KBblGYMoExebynzpInjGgY4hoi
         ukwHDRV6CFZfldW4aTjgT3twYosq8TV/sEfmaAI8wub8vfO/Zffu+rXjcQL2aGbwjeM8
         CzXcyKniBvgcrKsrzS5HJpJ2wYzTf7zBFjfrpptycaiZWqHHS4Slr0IousKRV2ZqKy27
         FB7epBogHyiHTYp8GSnux/IAYGsNHBBiEhdbStvLzgJkYaIq3RJ4iGBfdo1SAaxjVCo3
         lAcatOxAWsy9f7JiJLuVQVD792fN/jKzZsSfJGjhcM3B4ov/reKOCVraoxmfZ/adzW9v
         xjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988950; x=1705593750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wb8RmmOQHMK3RGx2kZv4ToZcis6slj97jx6CHPGBmCY=;
        b=ZrLwsG59NNngc6rLhBbgbuDqqokmO7RLVmg9bTb15oO28EgaDRntDxJzy9Y+35hHu0
         Uxs9ffWAr/LMX7JiHdtA+d9OfgMLThwyhS+rB3jlEi6cwFVv719hlmjThzA4Mk/OGXW7
         sBHHVHYsI1Sm+9tyPFZQ88xR2gH7WbVKqYA8GKLTuDxFRThLLJ2vu5Rajh6vUM4MjtW7
         1hL6JD6p0zL4u/Qp/ntoNB9JFuyx7y5FMGxSiWgOfJjoMXcgbRUXvfJH8oEebc+N+hFz
         0A2ivAImmJwwsubvLDwAu9j9beotgt3CS6S2nyShjAeTMzmE4+dz/Cx39+joMzXhHmBR
         yUIw==
X-Gm-Message-State: AOJu0YznzG1ufb9eGj9gyNj2E0RSxQf7Szo2de7kEP1uEd7gv0oXsppO
	tjp1miLmsXgB/8cY4EhN8n3WtHevDsvrdflBc01s4s1RFDsxaw==
X-Google-Smtp-Source: AGHT+IF/BsaTJI9Ykrr2nPEOWTxMD881gwF89roTIL5hEccg+HH+/3RETmhusbyuqQbOIm++qYNTQg==
X-Received: by 2002:a6b:dc18:0:b0:7be:e376:fc44 with SMTP id s24-20020a6bdc18000000b007bee376fc44mr2976530ioc.2.1704988950527;
        Thu, 11 Jan 2024 08:02:30 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cl15-20020a0566383d0f00b0046e564817c1sm285450jab.33.2024.01.11.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:02:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block/integrity: make profile optional
Date: Thu, 11 Jan 2024 09:00:19 -0700
Message-ID: <20240111160226.1936351-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111160226.1936351-1-axboe@kernel.dk>
References: <20240111160226.1936351-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If no profile is given, we set a 'nop' profile. But we already check for
a NULL profile in most spots, so let's get rid of this wasted code. It's
also considerably faster to check for a NULL handler rather than have an
indirect call into a dummy function.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-integrity.c | 24 +-----------------------
 block/blk-mq.c        |  8 +++++---
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d4e9b4556d14..a1ea1794c7c8 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -326,28 +326,6 @@ const struct attribute_group blk_integrity_attr_group = {
 	.attrs = integrity_attrs,
 };
 
-static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
-{
-	return BLK_STS_OK;
-}
-
-static void blk_integrity_nop_prepare(struct request *rq)
-{
-}
-
-static void blk_integrity_nop_complete(struct request *rq,
-		unsigned int nr_bytes)
-{
-}
-
-static const struct blk_integrity_profile nop_profile = {
-	.name = "nop",
-	.generate_fn = blk_integrity_nop_fn,
-	.verify_fn = blk_integrity_nop_fn,
-	.prepare_fn = blk_integrity_nop_prepare,
-	.complete_fn = blk_integrity_nop_complete,
-};
-
 /**
  * blk_integrity_register - Register a gendisk as being integrity-capable
  * @disk:	struct gendisk pointer to make integrity-aware
@@ -367,7 +345,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 		template->flags;
 	bi->interval_exp = template->interval_exp ? :
 		ilog2(queue_logical_block_size(disk->queue));
-	bi->profile = template->profile ? template->profile : &nop_profile;
+	bi->profile = template->profile;
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 421db29535ba..37268656aae9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -834,7 +834,8 @@ static void blk_complete_request(struct request *req)
 		return;
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ)
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
+	    req->q->integrity.profile->complete_fn)
 		req->q->integrity.profile->complete_fn(req, total_bytes);
 #endif
 
@@ -905,7 +906,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
-	    error == BLK_STS_OK)
+	    error == BLK_STS_OK && req->q->integrity.profile->complete_fn)
 		req->q->integrity.profile->complete_fn(req, nr_bytes);
 #endif
 
@@ -1268,7 +1269,8 @@ void blk_mq_start_request(struct request *rq)
 	rq->mq_hctx->tags->rqs[rq->tag] = rq;
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
+	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE &&
+	    q->integrity.profile->prepare_fn)
 		q->integrity.profile->prepare_fn(rq);
 #endif
 	if (rq->bio && rq->bio->bi_opf & REQ_POLLED)
-- 
2.43.0

