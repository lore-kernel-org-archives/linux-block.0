Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB11D435C;
	Tue, 19 Nov 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034721; cv=none; b=oOuPRPgMZ8+EQtkafN1DSyOqUwZazeBc39G9ah/4CuvyLzkTz0S3l5mZHb83PQrvwOCYjH8gT6F8wRDrSqgi7woHK/JX/m3rkeSfqmjc4biy0OF1kQl5cjNJnTldugL+ROFzKTjpsQIgfrNGZLJPKC8a25MIsBG36iQ8ZASpI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034721; c=relaxed/simple;
	bh=8ZZAjEe2oidrH5ViMWS900el+u7tKEKI536VEFp5r8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQbHM3b2WiXGH6XrE40wrz5FgQ5pgZRTb5gqGIJ1oihnPqjQv7KF1ctaWlpE9DaRGYz6MjGhLi5HZnSrbdNHlSC+2+5D1ghVKe4wmHBLp2Y7NrGkTb13bx5HkI81IArPvDN8MuuflH7jrpNyf+Db5re7QYZZOJARcUhd+RDkVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoKHa8Ux; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoKHa8Ux"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso2272121b3a.3;
        Tue, 19 Nov 2024 08:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732034719; x=1732639519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99My6hnm/xq4qHzcMigG8ENPGdlWBw4DXu5XylnhePU=;
        b=EoKHa8UxYGvmL1C33677A+ZTMliG/3VqO70k1bc9DuvQmrC4lkLMJ/pPaIqgKkldTj
         jnx3IX25j/M1Zw9bwkZ5rBRV5JVME7Ytm7byLspNAUj6ZENl819mY6ydIb16QzsqfDqw
         HPTm/39l0IwHPtRoXWXJfDGsi9UJhzz8MDx/5UBerkibAxBzKV9+Ats+RIqEED2ycVF1
         64VnfFSJlGhvEp9gSOiC39i++dGdJxquIAjrfsW0yTFSOVrtmojv96WiK+APAHLX5jIW
         foafzKxcexN7hgO7xMOS0U2Ut/BhWCknGWDMiHUrchFGE8wTU6jhuAXDB7g1czRF0ibP
         Qqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034719; x=1732639519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99My6hnm/xq4qHzcMigG8ENPGdlWBw4DXu5XylnhePU=;
        b=ba1hfXnEkDrlHmBa/zYeMnt1aw+AePJy5gAosBEy9FrSr2DjA53tCvw9aYVH/aFUGY
         0K8w8pgTWcbIoTBL+Imwmo8IdT85DNfVmvyA9z2q14TqiVc88ukM4cNyqSyO29wDxPTO
         kuzYy7yMyMCMuCO9NaMa7pgA5TyA+gjotBgkssiDmpaWsY80M7xcTpguByZ3C5XQNSFx
         fEbdZsrIntRgWAaw4NrXwqroX1EttKbJS3krE9ROcr/7UuiIHMnr+izURQ/G5T9N9vRC
         +lKg5weE/1ZYze1EyvBBSBaCXFBD29wl27/OaYDz69MTKQnc1QbPq6GLSFljXmle/nuP
         Cfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVaF5qZwMcpF+DmRAcSrgflXUsxE4E6XbfJQt/ZCXQ+viIV6ciq/RzvqRJmvhB4OquqdybZZ8NpDtn5eBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxm/4ZoYMLgMVwxlCqJtzsWihdDyn/ONLsUHXE1kjExfI9Ezq
	V1bJ34Ga5lLp5lRwdt+4kX0vTDl/dUErpkjWIhYOmVCbTD1qzPyH
X-Google-Smtp-Source: AGHT+IFguSvc12BAGyOWftFOCJU/No/eAOkPR0RIRPTvrXX311dvzFofcrnwQM/TV8njGsHVtHkl8w==
X-Received: by 2002:a05:6a00:1307:b0:71e:a3:935b with SMTP id d2e1a72fcca58-72476cf6e21mr21939752b3a.25.1732034719171;
        Tue, 19 Nov 2024 08:45:19 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:11a2:6510:4555:ca08:e78d:a9df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0ba2sm8596992b3a.128.2024.11.19.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:45:18 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	hare@suse.de,
	kbusch@kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH v5] block: blk-mq: fix uninit-value in blk_rq_prep_clone and refactor
Date: Tue, 19 Nov 2024 22:14:12 +0530
Message-Id: <20241119164412.37609-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the `smatch` tool:

block/blk-mq.c:3314 blk_rq_prep_clone() error: uninitialized
symbol 'bio'.

This patch refactors `blk_rq_prep_clone()` to improve code
readability and ensure safety by addressing potential misuse of
the `bio` variable:

- Move the bio_put(bio); call to the bio_ctr error handling block,
  which is the only place where it can be triggered.
- Move the bio variable into the __rq_for_each_bio loop scope.
  This change removes the need to set bio to NULL at the loop's 
  end.

discussion on why bio remains uninitialized:
https://lore.kernel.org/lkml/20241004141037.43277-1-surajsonawane0215@gmail.com

Summary of above discussion:
- I pointed out that `bio` can remain uninitialized if the 
  allocation with `bio_alloc_clone` fails.
- Keith Busch explained that `bio` is initialized to `NULL` when 
  `bio_alloc_clone()` fails, preventing uninitialized usage.
- John Garry questioned whether `rq_src->bio` being `NULL` could 
  leave `bio` uninitialized. Keith clarified that in such cases, 
  `bio` is not referenced, so it does not need initialization.
- Christoph Hellwig recommended code improvements:
 - move the bio_put to the bio_ctr error handling, which is the only
   case where it can happen
 - move the bio variable into the __rq_for_each_bio scope, which
   also removed the need to zero it at the end of the loop

These changes enhance code clarity, address static analysis tool
warnings, and make the function more maintainable.

thread of previous version patch discussion:
https://lore.kernel.org/lkml/20241004100842.9052-1-surajsonawane0215@gmail.com

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1 - Initialize 'bio' to NULL.
V2 - Move bio_put(bio) into the bio_ctr error handling block,
     ensuring memory cleanup occurs only when the bio_ctr fail.
V3 - Move the bio declaration into the loop scope, eliminating
     the need to set it to NULL at the end of the loop.
V4 - Adjust position of arguments of bio_alloc_clone.
V5 - Add commit log properly and change sign-off name from
     SurajSonawane2415 to Suraj Sonawane (used real name).

 block/blk-mq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 270cfd9fc..abdf44736 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3273,19 +3273,21 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		      int (*bio_ctr)(struct bio *, struct bio *, void *),
 		      void *data)
 {
-	struct bio *bio, *bio_src;
+	struct bio *bio_src;
 
 	if (!bs)
 		bs = &fs_bio_set;
 
 	__rq_for_each_bio(bio_src, rq_src) {
-		bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
-				      bs);
+		struct bio *bio	 = bio_alloc_clone(rq->q->disk->part0, bio_src,
+					gfp_mask, bs);
 		if (!bio)
 			goto free_and_out;
 
-		if (bio_ctr && bio_ctr(bio, bio_src, data))
+		if (bio_ctr && bio_ctr(bio, bio_src, data)) {
+			bio_put(bio);
 			goto free_and_out;
+		}
 
 		if (rq->bio) {
 			rq->biotail->bi_next = bio;
@@ -3293,7 +3295,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		} else {
 			rq->bio = rq->biotail = bio;
 		}
-		bio = NULL;
 	}
 
 	/* Copy attributes of the original request to the clone request. */
@@ -3311,8 +3312,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	return 0;
 
 free_and_out:
-	if (bio)
-		bio_put(bio);
 	blk_rq_unprep_clone(rq);
 
 	return -ENOMEM;
-- 
2.34.1

