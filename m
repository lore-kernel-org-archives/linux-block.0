Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5308433A0
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620622; cv=none; b=bm1ojHefkXfAK2QqXlLWW8I4VmYHCt7XX9RvrCxBojL9Ji61tT4rVnZ36RQrSG163FYCZdxqEaqagc/M/liSmHAzsSbFbg/4xB1pQ9zFOXr2VOj55Kv3iB160+/T7f+GV6xLHDB0cvQQ4FrPRP/UP7ZJct+Hxupe7KKH8Z4wxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620622; c=relaxed/simple;
	bh=eA/H0JjZIi16i3hB1JBivKY43jyl+6t7aDUpWUSlrUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4x1C7qzIctOucjgU2VT2slklTu6dX/q/8UOL1Rw1iG/2PZBucKLtKapl5E67LIjiRjL75GmANIoe4G5QSLoJKreQswZ57SLdv26BFd3IxGVRtagM8XDlobfdhUOybylcR5EKKYvSVXPnskuutZsTgTN5IYeY9WFnAwVY8Kq1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvJPDUpF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvJPDUpF"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso461678a12.3
        for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760620620; x=1761225420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1MfRk6r556ZbNsjPPtcCWZtiAMFkNsr0vVSVYA67QY=;
        b=DvJPDUpFCQ7s2j1/R518nCANsBs+Us/ps7T8m9KAQE2pMIKfbT985+KLRJ42brSm4w
         elbLAva93WA6+/6kjdYiNxhIyG6Fn0ZXdL8atP/C7h2LXFJeMZupjRMI2c56tvi8uo9X
         k4QSPMgHU+m+ooHCaL8c//ipKP6OWQVhE8/IFFCqaZ8aj6GKLcsiSOo0am/QVXOVN+1T
         yW6EY2/MLPEDqyOZ5i8Af6DeP0E1EKaEXbLBnlBzOcN0smidAeBl27YePAnZd3dHtG3D
         WQ6b6DKBTEgizukrRscujrVz83CP1gH36Y8rpFZ2MDVQ/fYmsKZDhvUndyPoOJGo2M1n
         8D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760620620; x=1761225420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1MfRk6r556ZbNsjPPtcCWZtiAMFkNsr0vVSVYA67QY=;
        b=gZKFEdlMkjqqHfQ478bY7/BhneLz1pYpylVBAsHvnIujaOW/D2Jq5B20Q46Qc1D46D
         /wKyYX9J9vVmEzdnrciDuxg6H2ZWA8FORmVw9fmUnb9oyXc7ouZR0iba6wIEH9CU3xuX
         vVWgf2FcHVAKGCo2X76wuBMr0nLeDAg7AgYXGwOfNhGEmHUzUy7ZDgDmpGV0D3e+gMbe
         YUdvGc0kEk8upSPLH1ghprhgHkY4YgR7r/rW2ePfBY2LGKLFjjx/dZx/DnPQ1lM+yoFG
         MOUUJOO31s5Jc6xeSIoahEGblf03At8QGqF+LFDszLnmjs3z+zbfFjEFQ1fHu5Qgaglx
         Ye7Q==
X-Gm-Message-State: AOJu0YzmfpFpxFUsQLN0MYWhvViFqolmTMDciB0eeFal4G3JJCh1PTW6
	runpV2BEtA3lOuDsZoKNjHG1bxfJ3BY5jBG1NUAV19VRONId9hv+EeSj
X-Gm-Gg: ASbGncsVumHkG0RQUDgSmjnbKFZqgI2ZtU59c1NEyX9FC6mHvB7rINoDvcIUhOrsLVJ
	R+fRoR8iAIITN2xIhZxh4GE3Tq6dyWH3rTdee1VeJ3PDrfWY3Q5BjAmL5xdfhB3pNAKnwJ3ArRp
	gE12qGbktcMpdnn+w1mgEOINwbVgxTY5RXy92keiC4mduHc/NFcZxNF5HQKDFnDbotdK4Ka3OBv
	neGoJF8vqNIrWzA9CIoOzy0KDOI9SkGYIQAD4Nk6Axjpm8WRjFHr7Kbb71kHsAEOc9yOEHwi7px
	tL7imdj/B5woJdAhXurgVi/XxVUotbjQzXYxPIjTNp6zjBLDY7PhrRaLZ8Ot9/qhQyr1aCcqq6d
	deLbbO4lAS/ImEzAkVH6CQpI9N9Db1LVpJoGKCFOO+alMjJ0U9X9754gm/bGnCTUWPIkgAbMsV3
	uV6T6SL1bPd42hxdbRGCC4Sdf+vQ==
X-Google-Smtp-Source: AGHT+IGpJWJBke8Eix07HeJb4e0916GUKsSHOfEgzOggrPloynIzFzloH8zDLF10ETHTTnAow8JnOg==
X-Received: by 2002:a17:902:ce11:b0:27a:6c30:49c with SMTP id d9443c01a7336-2902739a207mr450211305ad.27.1760620619817;
        Thu, 16 Oct 2025 06:16:59 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6522fc6sm1942340a91.2.2025.10.16.06.16.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 06:16:59 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	yukuai3@huawei.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block: Remove redundant hctx pointer dereferencing operation
Date: Thu, 16 Oct 2025 21:16:51 +0800
Message-ID: <20251016131651.83182-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

The {*q = hctx->queue} statement in the dd_insert_requestfunction is
redundant. This patch removes the operation and modifies the function's
formal parameters accordingly. To maintain code formatting consistency,
similar modifications are applied to bfq_insert_request. Changing both
functions' parameters to request_queue also improves logical consistency.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 block/bfq-iosched.c | 5 ++---
 block/mq-deadline.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50e51047e1fe..b0e2fe645c3e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6233,10 +6233,9 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 
 static struct bfq_queue *bfq_init_rq(struct request *rq);
 
-static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void bfq_insert_request(struct request_queue *q, struct request *rq,
 			       blk_insert_t flags)
 {
-	struct request_queue *q = hctx->queue;
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
@@ -6298,7 +6297,7 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		bfq_insert_request(hctx, rq, flags);
+		bfq_insert_request(hctx->queue, rq, flags);
 	}
 }
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..86b888681552 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -646,10 +646,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 /*
  * add rq to rbtree and fifo
  */
-static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void dd_insert_request(struct request_queue *q, struct request *rq,
 			      blk_insert_t flags, struct list_head *free)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
 	u16 ioprio = req_get_ioprio(rq);
@@ -707,7 +706,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags, &free);
+		dd_insert_request(q, rq, flags, &free);
 	}
 	spin_unlock(&dd->lock);
 
-- 
2.50.1 (Apple Git-155)

