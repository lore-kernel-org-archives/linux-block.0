Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13E86277
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962616; cv=none; b=JN6ratbR0snoxtPGWTlmMx0bN/A8Qv5uXuZ1tmdt38fT9VMU8FY8em+H/b3R5l3DhC+oxnn4V133CSYhVKefrhAc48wRPGJFngG+X8GyyLLv3y+C+Ie+5Q2Tdu43ewhmBYIr17F/R6nqIgFyftF/eipnoDWFEcNe45GFyiSJPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962616; c=relaxed/simple;
	bh=RZSOVPlhbcDsE0eC/0+ARl+Y4zL4GleNla8AyPtn2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTVmolU06PjSqXeAGX+keFxLWx8V+/5zaObUJ99o+Qf7QZICnmTgrhRT7HJo53vwHvRLUmWjYfhwoH1lg2PNJzVCqUJ7E2FdL5Z0vNmHtXXWa7OMUehpbmrkvF472a8ymA3+hYqtobk18CFM1Q+POai20MSPNxUNzn9bgB2GyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DTBAmwSp; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DTBAmwSp"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82cdb749598so48258839f.1
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727962611; x=1728567411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQNQQf3nV4sV7k40ZpaubDkS0LPWbRyCMa+MHVBW8jU=;
        b=DTBAmwSpftj57vuuytmjxJfA1nS14y1O78f5F93eOI86Sv2k6FU5waWoEpdyt6v+tO
         mpDIgq+V1xNfrwYh6leE11UwzRMXvFav32mXRq+Tg+aMjhXu5M6V9V5/9fJ4ryGjBALU
         EtEJSmhtunAWVJA7biXJQew5RUwg569JZmiyTU88MdwSi3cdBE//WjqwdIRPsLfCQ8wb
         sEmregdYUiNkHykPbMkn625JYjljm50SoFzLTjJ4WiW/9wNI0lPcrBqW9iDzHIw7kG7N
         YJ9/NUgZxCky/udekFouq/mY/r229dKnHepQ0mzmRk51hXtFg7ska411SeaoqDpIzDqT
         a2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962611; x=1728567411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQNQQf3nV4sV7k40ZpaubDkS0LPWbRyCMa+MHVBW8jU=;
        b=ifi6vG7d1J05O5uOpftJKPE85JhKn0QtBUF2nPTOqswD0xStS9Le2UboZaFmqr/y9c
         1O7EzlSQg05kGi2yidNhUkiuZvGS1dOCBwWpLJ7kYmppyp+ocGq+i2W5m/W4ffBXvu+A
         UwNVNiR1iVRGtsK+7O5DAx5EUvKujF6r3c+luzUYjdUYGJiGgbOUYetEX/PnTOKtSvyp
         19xhJYPQn7jMH7H1qs76cgXGC/q7HtBd+Ax6teaVNnNTCB7eu6OcAoxt8Xty6ACONqYO
         XDSzrPfNIwfMyNY+Fm1V8uflNYawPWNszdTKj1Ly51hXaIuYbOGip7hdgFDaH0MSwBCR
         F7Yg==
X-Gm-Message-State: AOJu0YwAWx5gd5VrsetYCJt4esO5Hi78XqOqni64nCYg2BO6poARgX99
	kavvU9bW6YWLmT9TyocjJFavXj51bLYBdWe3caS0OGM7XOoyI/Fp8h9uAaXh5+6idOBa8inyR9C
	ldq0dfg==
X-Google-Smtp-Source: AGHT+IHQjvZJKw2jk+qfOzNmd7TiUDLjKJcED2fmVz1xCj4xa6IcopdsqjuVJibikMH7jzlSM4B1kg==
X-Received: by 2002:a05:6602:1509:b0:82c:bdec:1c0e with SMTP id ca18e2360f4ac-834d83b644cmr622256139f.2.1727962610853;
        Thu, 03 Oct 2024 06:36:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55a63fd5sm274128173.100.2024.10.03.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:36:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: remove 'req->part' check for stats accounting
Date: Thu,  3 Oct 2024 07:35:32 -0600
Message-ID: <20241003133646.167231-2-axboe@kernel.dk>
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

If RQF_IO_STAT is set, then accounting is enabled. There's no need to
further gate this on req->part being set or not, RQF_IO_STAT should
never be set if accounting is not being done for this request.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee6cde39e52b..f21bd390e07b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -92,7 +92,7 @@ static bool blk_mq_check_inflight(struct request *rq, void *priv)
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part && blk_do_io_stat(rq) &&
+	if (blk_do_io_stat(rq) &&
 	    (!bdev_is_partition(mi->part) || rq->part == mi->part) &&
 	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
@@ -762,7 +762,7 @@ EXPORT_SYMBOL(blk_dump_rq_flags);
 
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
-	if (req->part && blk_do_io_stat(req)) {
+	if (blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
@@ -980,8 +980,7 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 	 * normal IO on queueing nor completion.  Accounting the
 	 * containing request is enough.
 	 */
-	if (blk_do_io_stat(req) && req->part &&
-	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
+	if (blk_do_io_stat(req) && !(req->rq_flags & RQF_FLUSH_SEQ)) {
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
-- 
2.45.2

