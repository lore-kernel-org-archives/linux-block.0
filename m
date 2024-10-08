Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791321D6DA3;
	Tue,  8 Oct 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389066; cv=none; b=kaBEAs9AN9jq+tcVZp3mPzpxoLkatrLOfNhC1jLkKcPS+/0ADhSJlPT2WuxyUrf2P13mc6ISW7R39hnhovdy3Oght1VBxaaAkbXzOjm5MA9ICl3Fftr9OSgWeVKkBZUS9o3L0y5J59yJ5nWsRF2W32uRpR64ASA0Zfkui2u60ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389066; c=relaxed/simple;
	bh=cUVvE9sl8RvLn/O2xSbEPHdPq9fU3BygCG17e3d9/xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIIo88gwTjXnH3IRCu4xHwrZEU58sLTpq2OK5jFCcBRQuE1RR77JKW1cx5bsvW3lTfzPybhP6nOCMPdzvEEw4NsI6WZbQ8FE9RzFzEPi0+FTx/l3N9MSR2wtxfIzYmVPw7TZyjHGci0h16hbINeiZJWHzVx4aoKsfLGnyAa/bHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsIFYBTp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsIFYBTp"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e28bb79a18so342677a91.3;
        Tue, 08 Oct 2024 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389065; x=1728993865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qopKjM/1jc2SDQBwCo8gCzqisi5ltm0kYKTquzKCO6o=;
        b=KsIFYBTpg/qhvu0MnatwgFd5kDnnCAmFOAvOhNQNcL2OsIIgyOgtQOhmB9nva8n6pC
         epaRVypWtk69Ens1uN3gG7kUrrCiX9fZ0jR6qfQWxmJVQqEgO2i/9dQLO3XeazMBieQ5
         XcJJs3gSGUgXADAw8/agl/WkWIQ6ydvIyOzg8zAeFTZGT80ZBc7fooyKheuX5getbgjX
         P4+CaZCMfI/k3DiaUi/fRQ92FKwQcJZaFBSdS6ZL/0uWLWnb1F5MQ1nrX/rJM/LGjhiz
         IGnnQgAyye71DbaF6Fo4YjuDz2BGnqsDzO0EJ9ONeeVYQSCOJwx2TGpXTXTE22x7hUVq
         ba6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389065; x=1728993865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qopKjM/1jc2SDQBwCo8gCzqisi5ltm0kYKTquzKCO6o=;
        b=EW++B/O3YwwTfHEL2JiLed1Hh8GskBMVTzJBH87vHAgTZJeW8N1cH4HZxvdcnv551L
         877fTUnWRd78iZh2B4F/Kn8Y/EG/Hu6D4G0BeN7UIJpAYN7j5pBO1krOnvmcydHhaI9H
         bsDu0ZOUag67WtJUfLYy2zV0EywMRbvKVQ4IbzXeJ20r1Kn+9B+zTboD7QnyOaxPxVpL
         8hRhJg4e4115qUtYA2an2exlOlmPKQ3zQom6j6MJV0tfUQImAmpAVe9lbsdYEtH4hbsE
         3ivUu9B2n7NEg+AIi0nM642/Knt0RBvLsmmsgtW+yk7vMALgu46ZztxCCsnY3VXYrnPL
         Wv3w==
X-Forwarded-Encrypted: i=1; AJvYcCWrkWRdchKCLgTBE0f339sQ6EWNrKfNO8ob55Wiz//0eVY9w5r7Ch/gd/ltYqoI+Nl1laWHZj5yYNPbPrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8ZQrQyVmER9mHmgSX4w17hsd5Nyj5KbUUpvUsEeyqfef/LGE
	jE1Gjv2gkiAHU++8lVCTeMih+Us5LZ+Mljape6wIMmxUKrD2w7BVfI+p7w==
X-Google-Smtp-Source: AGHT+IHpm4ERo2wIOCk5L6MyxXCIeS4pF5FlPQ0eQz8GFGoa6UpEHbp1SNeeS7h3smmRhHu5+rf6iA==
X-Received: by 2002:a17:90a:c7ce:b0:2e2:8995:dd1b with SMTP id 98e67ed59e1d1-2e28995de96mr1539204a91.3.1728389064513;
        Tue, 08 Oct 2024 05:04:24 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2405:204:22a9:cff2:530c:6e84:3e31:93ed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f6380sm7394232a91.40.2024.10.08.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:04:24 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: [PATCH v3] block: Fix uninitialized symbol 'bio' in blk_rq_prep_clone
Date: Tue,  8 Oct 2024 17:34:13 +0530
Message-Id: <20241008120413.16402-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004100842.9052-1-surajsonawane0215@gmail.com>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
to resolve the following error:
block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
V1 - Initialize 'bio' to NULL.
V2 - Move bio_put(bio) into the bio_ctr error handling block, 
ensuring memory cleanup occurs only when the bio_ctr fail.
V3 - Moved the bio declaration into the loop scope, eliminating
the need to set it to NULL at the end of the loop.

 block/blk-mq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940..27b22dbfc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3156,19 +3156,21 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		      int (*bio_ctr)(struct bio *, struct bio *, void *),
 		      void *data)
 {
-	struct bio *bio, *bio_src;
+	struct bio *bio_src;
 
 	if (!bs)
 		bs = &fs_bio_set;
 
 	__rq_for_each_bio(bio_src, rq_src) {
-		bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
+		struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
 				      bs);
 		if (!bio)
 			goto free_and_out;
 
-		if (bio_ctr && bio_ctr(bio, bio_src, data))
+		if (bio_ctr && bio_ctr(bio, bio_src, data)) {
+			bio_put(bio);
 			goto free_and_out;
+		}
 
 		if (rq->bio) {
 			rq->biotail->bi_next = bio;
@@ -3176,7 +3178,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		} else {
 			rq->bio = rq->biotail = bio;
 		}
-		bio = NULL;
 	}
 
 	/* Copy attributes of the original request to the clone request. */
@@ -3196,8 +3197,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	return 0;
 
 free_and_out:
-	if (bio)
-		bio_put(bio);
 	blk_rq_unprep_clone(rq);
 
 	return -ENOMEM;
-- 
2.34.1

