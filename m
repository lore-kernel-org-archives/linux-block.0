Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2519B3ED
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962616; cv=none; b=f6tjQXkjCm4csVYrML+dEiAjoJu2xbP3aT+5ThPDLVk0jT0lW1AuAhTY5AJSjbDM4rAi1+XP8k5zjygla3BRrfgdLU8mew0pYqyM4gKm9d6OmTJ7Te8Y5hRtvASqyd8DTxiKFCfmdscUM6OHZ2fVxMLhJa2u2ybmdDzdMYLWg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962616; c=relaxed/simple;
	bh=gqGk1l0IgEUvuszEn2vhaOjtZw/YxyiYXk0N4msjj10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUnvI9jTuyBAhi6jV6Z9Qn0gJWm9sVGsKHLZhESK4lK0iOrmTLwyeKDIFREdupvvnz9UQBx9CA+7HOpTv7cSOI89tA61TRYjzdaJZAPgjpQNtJ4HnWvUJdBGbfLvcrJWZzqfNWBfShl0oLnMvyMaTniPLS9AFVkNv8Bs2Fx3BPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FFtN9oeh; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FFtN9oeh"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82cd869453eso39354339f.0
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727962613; x=1728567413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMdIJC4NqrLb7Lo66MHixxVJSZ8GKxe604OIz/xFcLg=;
        b=FFtN9oeh5PGQpbbL5bto2I1WD/bSAql6Hk1vP3odWoDcVLQdksyn1f9VbPutgQ/yLG
         y52Wz0rqT2GUFSpyt2dtD4KacaJH0NFK0ua6o6sxU+pZ2j+N/DVLwIKpQC+JtO3yFwLQ
         BdSZl49Ir+9MRSgt7xWO2ZfXx1jx49Lvdl9TOVZYyQfZUENbNpBPB1Zlc3bUisUXsuUL
         wR44/rZzLf8lZ38QC5Fa5aVlB1T5Uj0u/PSGSjTilUiMDOAjNvF8WtN53rymVZgScrgH
         khKmtR/QggiIght/+Jf8M9espYcMZ/bbHe+jT2vylUlPsOHrWp5K0xAg+Md7r9hKJKKT
         hw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962613; x=1728567413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMdIJC4NqrLb7Lo66MHixxVJSZ8GKxe604OIz/xFcLg=;
        b=BslLaRIv//WcnmLvrQriJ5tdPz0OhfztXsRr8c2d4Jefl2PIpNlmYS4IEjgMDAwEp/
         evtrURHRhNtAY1zc/0DoFZdtgmS9OfaVjT3jRv4WobotDCfxbIyNjlkOBVeYORUcFNY/
         Nw7SUz90Kxla3aRrZGpgDj3zQix0vIe5WgUCFcIQSoXoMbnX86nQWUr4/iFH5Wt/4O4F
         Oq4oG+wpXA4nlWdMqz+2a50TAlG/7tohY3ZBOwe+qxG+mhazNtDwbwhF8r3PAh1sIiPn
         J5RmjRHEfUWLoMm8sknQTsOz6JvZcFKVXm1fn7l+RUGHxFsl61vNMYxnYRooS8nULV2q
         shmw==
X-Gm-Message-State: AOJu0YxsvA1rgMRcBvhfMKiTZQyGcTZZfQGEA9Ef1y7xZZ6aEu80ypWT
	pWUau+ftWJXTV52IAH1xdKM1JHkz/s5j9uaXUSf6E6yjxkuEwPnsxMIxEHLYgl/thZCiUeqx+4G
	zMPQN9A==
X-Google-Smtp-Source: AGHT+IEV/o1XiT42T3ODR2wQbYCxXkpHJVSrYqE4coV5x8wF44SboIY3DUCuogebppNDfDri4iUCDg==
X-Received: by 2002:a05:6e02:b2f:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a365954820mr56241175ab.24.1727962613189;
        Thu, 03 Oct 2024 06:36:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55a63fd5sm274128173.100.2024.10.03.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:36:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: kill blk_do_io_stat() helper
Date: Thu,  3 Oct 2024 07:35:33 -0600
Message-ID: <20241003133646.167231-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003133646.167231-1-axboe@kernel.dk>
References: <20241003133646.167231-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's now just checking whether or not RQF_IO_STAT is set, so let's get
rid of it and just open-code the specific flag that is being checked.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c | 13 ++++++-------
 block/blk-mq.c    |  6 +++---
 block/blk.h       | 11 -----------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ad763ec313b6..8b9a9646aed8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -797,7 +797,7 @@ static inline void blk_update_mixed_merge(struct request *req,
 
 static void blk_account_io_merge_request(struct request *req)
 {
-	if (blk_do_io_stat(req)) {
+	if (req->rq_flags & RQF_IO_STAT) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
 		part_stat_local_dec(req->part,
@@ -1005,12 +1005,11 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 
 static void blk_account_io_merge_bio(struct request *req)
 {
-	if (!blk_do_io_stat(req))
-		return;
-
-	part_stat_lock();
-	part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
-	part_stat_unlock();
+	if (req->rq_flags & RQF_IO_STAT) {
+		part_stat_lock();
+		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		part_stat_unlock();
+	}
 }
 
 enum bio_merge_status bio_attempt_back_merge(struct request *req,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f21bd390e07b..8e75e3471ea5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -92,7 +92,7 @@ static bool blk_mq_check_inflight(struct request *rq, void *priv)
 {
 	struct mq_inflight *mi = priv;
 
-	if (blk_do_io_stat(rq) &&
+	if (rq->rq_flags & RQF_IO_STAT &&
 	    (!bdev_is_partition(mi->part) || rq->part == mi->part) &&
 	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
@@ -762,7 +762,7 @@ EXPORT_SYMBOL(blk_dump_rq_flags);
 
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
-	if (blk_do_io_stat(req)) {
+	if (req->rq_flags & RQF_IO_STAT) {
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
@@ -980,7 +980,7 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 	 * normal IO on queueing nor completion.  Accounting the
 	 * containing request is enough.
 	 */
-	if (blk_do_io_stat(req) && !(req->rq_flags & RQF_FLUSH_SEQ)) {
+	if ((req->rq_flags & (RQF_IO_STAT|RQF_FLUSH_SEQ)) == RQF_IO_STAT) {
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
diff --git a/block/blk.h b/block/blk.h
index 84178e535533..ea926d685e92 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -405,17 +405,6 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 		struct queue_limits *lim);
 int blk_dev_init(void);
 
-/*
- * Contribute to IO statistics IFF:
- *
- *	a) it's attached to a gendisk, and
- *	b) the queue had IO stats enabled when this request was started
- */
-static inline bool blk_do_io_stat(struct request *rq)
-{
-	return rq->rq_flags & RQF_IO_STAT;
-}
-
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
 unsigned int part_in_flight(struct block_device *part);
 
-- 
2.45.2

