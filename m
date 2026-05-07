Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F253CEBBC
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155862; cv=none; b=fsHCH/+OtjYwlACSr+fQnwT9kpDZM+ke9iooYmqprbtTeerQeezV9MFvqWLcXO8F8Cv/uqzDGUEU58bSTfGQ6jrTyXE0E0lH1muKo/IO+L2Zypitu2IYMM6JPjqCSYMB6+y3rXylfBXu2WQDoKchESUaqUHggl3FbiBp9v1OPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155862; c=relaxed/simple;
	bh=L9NspDv4xWTbZPaxXuRWdCqsU3+YxAazHqEVXozUlNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laBLpv/GNAQ0E2BqOZ9mBX0ReUYiePzJbVqFw0PSAwv2HgNSBfyQG6fN5IXfZuJ1QaUgp9NYvd/gR4ek4/cD6AP7YNhZJdkpuk/HtWJj9Ac+by/vXV3Fx/YsjP5FA+OoXyPYr1Y49hIIQZVoNCkkrMARaicq6RqYRJoqltIpgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYxGeH3M; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYxGeH3M"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so1061364e87.0
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778155859; x=1778760659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48uU9xtv7d3+vs1KsC1QUOPRH9hfwr96wjV+c6ANlc8=;
        b=GYxGeH3MSKc2KxVVk3GwYr2LB045kO7XLFVZYevVuSQlZqWZsEdqODFaYIRcsMNeMc
         nolMcW0/c6CR19SVVSN7aSyLqWTkvA4PugHSisdG47jyQdEmt8GLU9DYIQiotHZnnk50
         hb/r+/oD3yNE8vcvIMWIWCf82t1IJKgyp8CIfC7W3fwuZwklVq0oHp14KBO+NHcaztdo
         QY2/IkZ/dBuuGb6tL0u4xUhjY1Ffl5PxfGHskAajg9nb4gv9NjFa0HxuVOU6e5ARl4hT
         UuigHv0o12DTg0sEApvbwQtAPZhXFgz906aV8i84aMj7tZqt9GG1lSEZWH3yigbVkwXR
         7QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778155859; x=1778760659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48uU9xtv7d3+vs1KsC1QUOPRH9hfwr96wjV+c6ANlc8=;
        b=pGUiC8KBnZLh/Ya2uveGxu3La6XOxG9lRVcU0tV7HdFoFc6rg4UB5f32N0deaCRBs/
         vlyB90SWa0EKDyKUheAELbCu1U/YuA0N+tkKIpSKlZdW5S8AE7DJBTcHgQwcV8ci2Q1Q
         JwD4fzT78+VjITnMGH7h5zYz7UcJbM0XlscLQg6aqsEYT+o4MgYgKRZ1e+JrsUmT2AQr
         eB6v1EqUmiAoKyNvaYOiWF8mrCiP6WcUlQMSTlpGjkhqDoUefsvZn9/rgNJBlSefRV2z
         7P+l3xaF0n0Jj8fvnE3fPJZTOo5ti2hTCOPxGOenr4eLsYyXeZtIUnr4G0Ppsts1+Fir
         QkGA==
X-Gm-Message-State: AOJu0YzPgJA8wOzPZw5cu+4PnUAnhFjzqRHMiTC/F6OZn4wO59ZJLdU8
	uzyA1Bf8pvQOHxsjY3Me2lz7BzqZAyJWSpHagVQveOR6c/3HUHwsJEbk
X-Gm-Gg: AeBDiet+Laeg4WFfOnpNh5br45rk3etV/L9AkDKoVt572UcboUdr8UeW/e5DEX7/18c
	+yXMmooKmlSaFO5zRaXmxjGEJwLjku3Dta9NhKRYA5fX9P8MdVLyyZTAc8wB/bXPDofsUjoot7W
	PdoeZRYKA//rSbj6tja/CxIsAPfbPajO78r3pVt4bR2jErRW2IzKmPj8VRSXolhUkgvUkatxKFf
	QQdZx/vvyHM2z+n3edksfJwzemcSkQq0bVzx8WNDKbL4D87iVuppQ9xPD2IIxXP7mrn9YUMy2Dy
	eVE1hJ0pWY9guy5kBf955xi5yPAkYNUZPMA+5udeVZssgTQugEN+zcx3f1qJAjwcf9wjcoj5T9Z
	ix6U5I2XxIzLBwof0pXrwfNPcUtE4/0ioj7yY05D+ser3Q2jDWkZACBN7Hqdwn17TzIiA1mtrA5
	wsGijaGope8EvklUiQOmE+3mJISXFbeKIYPQroaY8L861uWlaePIylWqS5hxydprFpRZKTDdfHu
	oE=
X-Received: by 2002:a05:6512:3093:b0:5a8:74c3:5d9b with SMTP id 2adb3069b0e04-5a887a9bce7mr2451206e87.0.1778155858669;
        Thu, 07 May 2026 05:10:58 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393610bb2adsm53902041fa.16.2026.05.07.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:10:58 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] block: blk-merge: Replace == false comparisons with !
Date: Thu,  7 May 2026 15:10:56 +0300
Message-ID: <20260507121056.25801-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel coding style prefers the negation operator '!' over explicit
comparison against 'false'. Replace four such comparisons in
ll_new_hw_segment(), ll_merge_requests_fn(), and blk_rq_merge_ok().

Also fix a typo in a comment: "occured" -> "occurred".

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 block/blk-merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b2..427b77219a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -403,7 +403,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 	 * there may either be too many discontiguous vectors for the max
 	 * segments limit, or contain virtual boundary gaps without having a
 	 * valid block sized split. A zero byte result means one of those
-	 * conditions occured.
+	 * conditions occurred.
 	 */
 	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
 	if (!bytes)
@@ -547,7 +547,7 @@ static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 	if (!blk_cgroup_mergeable(req, bio))
 		goto no_merge;
 
-	if (blk_integrity_merge_bio(req->q, req, bio) == false)
+	if (!blk_integrity_merge_bio(req->q, req, bio))
 		goto no_merge;
 
 	/* discard request merge won't add new segment */
@@ -649,7 +649,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (!blk_cgroup_mergeable(req, next->bio))
 		return 0;
 
-	if (blk_integrity_merge_rq(q, req, next) == false)
+	if (!blk_integrity_merge_rq(q, req, next))
 		return 0;
 
 	if (!bio_crypt_ctx_merge_rq(req, next))
@@ -905,7 +905,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 	if (!blk_cgroup_mergeable(rq, bio))
 		return false;
-	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
+	if (!blk_integrity_merge_bio(rq->q, rq, bio))
 		return false;
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
@@ -915,7 +915,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 	if (rq->bio->bi_ioprio != bio->bi_ioprio)
 		return false;
-	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
+	if (!blk_atomic_write_mergeable_rq_bio(rq, bio))
 		return false;
 
 	return true;
-- 
2.54.0.windows.1

