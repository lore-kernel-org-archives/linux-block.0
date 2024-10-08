Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7120CCE2;
	Tue,  8 Oct 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410213; cv=none; b=skptBxl2r9XXaTysfrc8WUanWq6wfw1zPevcouphP0JbWD9MepzrS5JxnBhfGeMxX6dtIqkaxWcrrjb2UvxdqdndhLn0wg84UP87s8mT14WfESbUtK9lV+RI7E/GZKe3YLyb66vPdqy2b1+AI12+TgJiyqXc75ibHldzIgV8Sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410213; c=relaxed/simple;
	bh=U7qfuMadL1/bOrsH6gnS6J46RyeQ1JjT5yevQB56uZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmgMyP+h+ESnAlSJhhdj+91YQRp/g0+Cm8HmT2Kg8mGofqL2pYRIhYyXv497YNsVdlRMg94++qNiC72eGO7ZDR5Wp0L4Jy9bxzD+mT6dD0t9dtP9yj9d+LqzBqd50IJucrFvz4PKwqdmGqCb/T0LQ6wbcO5lLoCLAUdUdq4FxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7HkOQwT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7HkOQwT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c58e5e800so420905ad.1;
        Tue, 08 Oct 2024 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728410211; x=1729015011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8a4Q5G12BXAMQ3G6wl/bOgUHbWzrhRiGaPzx6IjtXg=;
        b=b7HkOQwTRKoFtbxP2bC/4g+NM6qv1In/HQCEo64yzYUdDuR1DCCh8gHHzWk56581Ef
         AULwRdrg6wfWk5i70q0XSkvNSIp7p33KduFVBZgeNrMN9WaeM2i8Tsc/9hRtqs+vFVck
         4KLbma0Ebn55USq9GQ9W/4IJ1ayfBw6JxnrpCqpimfgP313QkriOdxXzCqTtMGHqyHcs
         xBl4AmcqKvjNnx+UsLFbDYtZbilyeLXmSlHdu+qWEvlEFDrSITcojx0zRtKIxPx4ujmW
         R67mDJlWPgb3M9bPnzaprO4QdqIoce3PtMV1fqi65it5HQC8wIk6zGOK671/Fd/XkemQ
         ykyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410211; x=1729015011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8a4Q5G12BXAMQ3G6wl/bOgUHbWzrhRiGaPzx6IjtXg=;
        b=hjv+5RpfZ4fjKRUBNK7GSxBlT+FF22y+nlttod6i2ID7Fo7CRgQOV9UGogJaeFMEFR
         mOF+Fq+qonO9aKuuo8bUnjQV8N+/byjV4tQi7v0Hs+n2zH8NkZi9rJCXfL/EugK9Sml2
         6VSlJbT3JRX7q69Bo80ImP5d44Bu/GP/Uiao5m1OxOYOfRMmpKDjw3Yi4MJxXeeqw3xU
         FUzVXhVxvgC1FTDl/Lb36gWDiJvonivWYh1Cf3SmKHGQJsRxXTGa7nCC+41iaILLDC+M
         P2hgSS3PfNCUHXw0JZ72v/QqTtSKNdK0wA5uNnzKGhKRCu1clvCKu+gDAclXgxC+oijS
         nGWw==
X-Forwarded-Encrypted: i=1; AJvYcCX/AJdaB+vtGXTQlCUDXjDIKsE2BxtDvNvKRw8kr2zaUEo09WbfZeo+Z25uHjI/BqK72ggK0QhVp4ktCRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8CkYCXBhlura+wrNhcraA+/+X7kCjSwwRDVP3QdXfJ5gqBzb
	lkuFKnHk7FWi2vBNQhHpZucLqBxMf6qN2hArXVIDFjdzbraVP2fn
X-Google-Smtp-Source: AGHT+IGjaaQ3CqEaZx2NKh8Lx4iKNsOeY12LCVD2v1TscKrjsSIIjH41qU3QE5go7mdXLEB4lNQApQ==
X-Received: by 2002:a17:902:d48f:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-20c5ffe3f21mr9568255ad.17.1728410211353;
        Tue, 08 Oct 2024 10:56:51 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:11a4:8d8a:4707:c409:b6dc:a15d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af9f7sm58401785ad.13.2024.10.08.10.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:56:51 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: [PATCH v4] block: Fix uninitialized symbol 'bio' in blk_rq_prep_clone
Date: Tue,  8 Oct 2024 23:22:15 +0530
Message-Id: <20241008175215.23975-1-surajsonawane0215@gmail.com>
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
V4 - Adjusted position of arguments of bio_alloc_clone.

 block/blk-mq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940..89c9a6c4d 100644
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
-				      bs);
+		struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src,
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

