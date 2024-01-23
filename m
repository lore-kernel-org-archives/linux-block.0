Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8068005D
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031636; cv=none; b=Sf0yTNPJnQaRoQRR1UxsrxzEqMlMjUMKmWXfp/oaBq8fIeFOr0+ZjpEI48XSsrW+9sDtcb+2cWJVjTSb0ub1jMwU/DzTP60Wg113hn5IQPuVbZmXXkjGBVp4XuQb6Swy/0EZ77EFuZhzcZ7t8ixdBtn16iAGvsiiD2+8KVKWXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031636; c=relaxed/simple;
	bh=bmcTErcUzGsFmwKKq2XNbsNIv5eloCUHW5cDrCRoPtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU6B3KC90R5dfJnUd3B8r6Hvb3V222THw/bNCErCeHWAfVbJfs2Vvww3dQxWqpJOhcY7A2BrEveUmy120j86MZyclT4SIVy09k/sp0Zjwof++VP1iHVTDBl5Dzt4nB9fj1LHBkxBDgsVGPX9FSs+mIldyGCIikpHgfI2DO1nYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3HbjR2jR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3HbjR2jR"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bee9f626caso62181639f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031633; x=1706636433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QSidYI5kedHrpCI5ufZ8srx64p2MxR2IVg8u5MrqJU=;
        b=3HbjR2jRUSKldTYH625VK9lm+DRbU2usk/WSfoagOFw8cai2BOwLWoBfawM9lBAzmU
         gO+JOm3q1SL7t6DIFqEhiCw72EGK6PI6GHURbrzyvLmD/xqzZqCYPKp7pmqYuSjPxuKb
         Jpgz/xgdGzwK2hAiq04t9rSuljcNO4yFc6ruWeY3+9THiIsmCm8cPUG0X78v4zOxKFCW
         yuGbU1UaPVis85fKh9pX+RRRGdVoM5fDuI+qecBc+a3VmiGKtbE5PfDbMdpGwCUMK67l
         mOxxEx2J4+S/M3wgP4UG5nDUGSVt7tkIuhWO4dcEjU5AuwC7vBhMFU+7acWh7Luu3PkX
         3d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031633; x=1706636433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QSidYI5kedHrpCI5ufZ8srx64p2MxR2IVg8u5MrqJU=;
        b=qthNdhhQN0qiGhahLo1djtC+Qp+dlKC0ycUVHHj8cAbR88ZjwpTYm2c7Zf0ibheuM/
         cKI+Q8Tyjy6IqF+S/COrM/lmoUZq8wtCufRhOCMto8YZETl1+3SWW/NPVHOlAYM4hTrq
         JEk4BaVo3+dfCeIfYcbDPrq7xHx86XBcD8NjaTidc5kQw+UXQsU/1tgw5wN8InwIxujj
         C1ScmNecpPyWTsMyCuUMv2CxuhWH0/6NUnOgu7qnJbzkTwYP7IaKK3JHwBi2xVBSVwnF
         /5aReuWm3wZ+GNgZZepjknFhzb2X40LXGLzXXdATYNCklCpmdQrYMCYK9fntloW1Acms
         lMOQ==
X-Gm-Message-State: AOJu0YzTQmLS4FL2Iq+WrL+EeDwlU+Cwk8UE7/qKvA7bf1WisS1WZUVw
	NhOz/pRGoAWEw0+NV31iAmfHmgEBnGuiomfwUxrE9JdC2fWzqNiZpEx3TAmH0BoJoZDJXsa822+
	wPzA=
X-Google-Smtp-Source: AGHT+IEYpRc5/NOC5zFIUuxGkWellz09UjEjBd3qKwLOIv2vXVYafmnl7j7u+fWpxTmjo80yNx6pEA==
X-Received: by 2002:a05:6602:e04:b0:7bf:f20:2c78 with SMTP id gp4-20020a0566020e0400b007bf0f202c78mr9491462iob.1.1706031633444;
        Tue, 23 Jan 2024 09:40:33 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] block/bfq: pass in queue directly to bfq_insert_request()
Date: Tue, 23 Jan 2024 10:34:17 -0700
Message-ID: <20240123174021.1967461-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware queue isn't relevant, bfq only operates on the queue
itself. Pass in the queue directly rather than the hardware queue, as
that more clearly explains what is being operated on.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3cce6de464a7..7d08442474ec 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6236,10 +6236,9 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 
 static struct bfq_queue *bfq_init_rq(struct request *rq);
 
-static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void bfq_insert_request(struct request_queue *q, struct request *rq,
 			       blk_insert_t flags)
 {
-	struct request_queue *q = hctx->queue;
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
@@ -6301,7 +6300,7 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		bfq_insert_request(hctx, rq, flags);
+		bfq_insert_request(hctx->queue, rq, flags);
 	}
 }
 
-- 
2.43.0

