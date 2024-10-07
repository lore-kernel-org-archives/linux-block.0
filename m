Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E931DE3C9;
	Mon,  7 Oct 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331147; cv=none; b=VJHHSVEjKTTHQZHS10y11KCCwAwLW5bWZ+0In+b+VoGfTjLjFJWqx/Wt+gJ01bPKgETeDWMFOZLH9nvdxcxICvfuCx73EPNq3TrfodgvbtsURhbl/DnWKhPCtmkTQz6vIDQnOPwgapcAfqYKQJLVjuOGirje6K5XDznxEwL0Ae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331147; c=relaxed/simple;
	bh=thj4QNuBVdpzhcgmQvEaHsmcDvDMvw/85JwoSS2cLeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2dBCxoCeNFR3zIb0WjviSKj5eXgmHFCbqsK4RS6k+RVJCcriJcgIHtu9UlHO4DYceNp3NunCdm0qvtIMdc5p4WYHBdUbAiM9594OOIWdmT8BwxjcSjRukNBR744Hv0GgBwybwANaeul97Ai6MiVPQ8odCa+RbL73gFtv/xaGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdnXBnEk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdnXBnEk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ba8d92af9so36427695ad.3;
        Mon, 07 Oct 2024 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728331146; x=1728935946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q+dBcOyu8eZIP4YqzCU9UrEsVgvXEVVe2L1QiBfl0g=;
        b=JdnXBnEkXZ+aTPeYgZ5pqri23lxuoBHx8kAI/GHGSkGl8E7GSyh7AEWjcww1Gbpxp0
         +T4vTP+G2x30pQ46nIFH42yu0XuueZMgJYiCOmt28/uvgTF9SBbJ7nO0ausQonSD+Gsy
         +Y1+VjaH+fApsPIF0Nuf5i2StgDiHTzV907E1sg1dEsHcdMK7IL1GNbYxtoPQFyW8XeI
         cNvinIymWzjJx4PWZSPZYmfiivfJQRPxkXCFA2XtjUX/whNAgTuUUDaZfp7LuFjd9Kx2
         8+4uWJtQH0b9oE2vXMV8ua90/4c7L/4zCkLPF3HUJ+1r5D7TTMfWzrrG3d/kozWnEt6Y
         Y+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728331146; x=1728935946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q+dBcOyu8eZIP4YqzCU9UrEsVgvXEVVe2L1QiBfl0g=;
        b=QD/i6ODom0djXgrDbF3jw0L7DLV41dsiVz6lrneBsQftQnzOlpZHcx7T//aBPXciqw
         t/1pqhd/xVJ0sMQt1gjpyzmzLl2SMwMwINbgy+YM5M3lfiOt2y47Fax4lJty1sJ9EUR0
         X6OeTV2jizMHt5Khdsirs3ADiVpU7cKViWtwvxXOcyGM9WNreJRieRicUr8qjfXwFkiX
         6Am9zLuGj0YTr1zBzlVEUCRrQt7Zvt6Q1AL9z0NgaQZ4gSHFAUgmPJJPFi8WnRegOhIO
         PrtDXX7rXOfxSCB5HXYjUUSRxAr3ayAQ3KmJrMotCLCBBu0OufWxek4blRZho4I3tWQr
         3J8A==
X-Forwarded-Encrypted: i=1; AJvYcCXFmNAXltuetedpahjfKkdCxB3pYT9juYr4xvqCDj14KlOblHbYqh+N2AzeOJuq+rviX6jQIAqOmE3zgw==@vger.kernel.org, AJvYcCXztsmEvnt7k/8WZPOc418DVfVQqXzGZscBTQN41VwmFhUr0WHwLeJHaa0NnenXy4yCTCxp8kLXS2dbzQb3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mdROMhXQYjC2rEWAn/htYJVyJB/gLb3p9kYrXdGkov8p70cO
	cozPpfCvmzSNyKSSWbWkxCJOxvx4DYKLNekZuDRFhFpwzaYeLmvZUOjo1g==
X-Google-Smtp-Source: AGHT+IGX/F+DnO0tHOPQwUZwPxvu+rEaI9Z+wzByionsw3dV+SsslOPnYa3tHfoUeylaQpkVJIIMDQ==
X-Received: by 2002:a17:902:c946:b0:20b:a9cd:3be5 with SMTP id d9443c01a7336-20bfdf7989emr202703185ad.15.1728331145708;
        Mon, 07 Oct 2024 12:59:05 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:11a4:8d8a:5733:98e8:c62d:29e6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cecf2sm43304685ad.104.2024.10.07.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:59:05 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: surajsonawane0215@gmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: [PATCH v2] block: Fix uninitialized symbol 'bio' in blk_rq_prep_clone
Date: Tue,  8 Oct 2024 01:28:36 +0530
Message-Id: <20241007195836.52576-1-surajsonawane0215@gmail.com>
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
V1 - https://lore.kernel.org/lkml/20241004100842.9052-1-surajsonawane0215@gmail.com/
V2 - Move bio_put(bio) into the bio_ctr error handling block, 
ensuring memory cleanup occurs only when the bio_ctr fail.

 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940..32f99116c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3167,8 +3167,10 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		if (!bio)
 			goto free_and_out;
 
-		if (bio_ctr && bio_ctr(bio, bio_src, data))
+		if (bio_ctr && bio_ctr(bio, bio_src, data)) {
+			bio_put(bio);
 			goto free_and_out;
+		}
 
 		if (rq->bio) {
 			rq->biotail->bi_next = bio;
@@ -3196,8 +3198,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	return 0;
 
 free_and_out:
-	if (bio)
-		bio_put(bio);
 	blk_rq_unprep_clone(rq);
 
 	return -ENOMEM;
-- 
2.34.1

