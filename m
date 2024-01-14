Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80BEAF7
	for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcWL9Gtj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33674f60184so7981012f8f.1
        for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705259466; x=1705864266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Dz+w1ljPnhEj+evuWGjvhQ1hDgsSqucK91qkafk99Q=;
        b=hcWL9GtjcfjvujY+1UCZo1is/I/mtyqqvt2K6pqdQuYwN9BSy/zA5ZyTjji97H7C/X
         NwKU9zV4tNpCiWr4GqiyU3h+UoYLh6HQQPDdT6wkouzjR/rEZloRukpWBPvTvpI/DVBL
         XTXLozBe3+KjoVII+VQ/m9mDS0wZ8w8tg7a5h3r/uQpGhl1Ep8ki2ck5wVbRrDc7wuon
         Tjy+dcd2cFhzXQ80OHuwwOUeY/7/96pHQiBdIlbp5vCKedw/RipF7HRo3qdru8Mxwzb8
         KgvPnN0QmeOSBMq2ob6aI/55XCSWOtmDIQYYYz5jSc79MzBPStyWSM4ztemm1gOy9xtN
         1RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705259466; x=1705864266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Dz+w1ljPnhEj+evuWGjvhQ1hDgsSqucK91qkafk99Q=;
        b=c3AC81F9NEeJVIRfilMMu+ThL0f9vn3irXpsuPuSAbgeY5+jSpTlRSL1PAzoYwxoZ2
         i1odiKM35PPshgQ9WZo1VLaf9nOitLPa7wUL2MvRROiI/1FZuYllDWgspKZH9h8uLetC
         38aGGEkf7yxBpP9+t9xOpmylzUs3qfjhrMtKY4J++R22Qa54G6bpdKKMSxMKBGhC4dOa
         pwokoVg/TUiagaU3FIqowjEXhSeMaVKNGpFRViFZClSDoxw5xob3AFYtJJ5OyIpwIsKf
         hgwC0Oq2QqXn6t6n7H7C29VVD+lvfxiIR0ZcNNEOXzJ4XREBJTiS0P6GyI5Rx7Tj51CH
         f5gA==
X-Gm-Message-State: AOJu0YxNIlDsS5V6SMfsHchGnXwRlIjfPUAMP01CZWsdJHYamoUQEUAx
	YRLtu8OFSE0iFNZ3qwPIW0g=
X-Google-Smtp-Source: AGHT+IHuDctOs6/5Oyxen4ZHgt05yX68pYKRelCyF0FAzV07vB07hyugwY9oDrGImsb1YYDOcfVxVA==
X-Received: by 2002:a05:600c:4e89:b0:40d:530d:e1d0 with SMTP id f9-20020a05600c4e8900b0040d530de1d0mr2236448wmq.179.1705259465365;
        Sun, 14 Jan 2024 11:11:05 -0800 (PST)
Received: from vega.home ([2a00:23c8:1885:3701:6438:b7d0:8388:3e7f])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040e47dc2e8fsm13365595wmq.6.2024.01.14.11.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 11:11:05 -0800 (PST)
From: Nicky Chorley <ndchorley@gmail.com>
To: tj@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Nicky Chorley <ndchorley@gmail.com>
Subject: [PATCH] block: Correct a documentation comment in blk-cgroup.c
Date: Sun, 14 Jan 2024 19:10:56 +0000
Message-Id: <20240114191056.6992-1-ndchorley@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 99e603874366
("blk-cgroup: pass a gendisk to the blkg allocation helpers") changed
blkg_alloc() to take a struct gendisk instead of a struct request_queue,
but the documentation comment still referred to q.

So, update that comment to refer to disk instead and fix a typo.

Signed-off-by: Nicky Chorley <ndchorley@gmail.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e303fd317313..ff93c385ba5a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -300,7 +300,7 @@ static inline struct blkcg *blkcg_parent(struct blkcg *blkcg)
  * @disk: gendisk the new blkg is associated with
  * @gfp_mask: allocation mask to use
  *
- * Allocate a new blkg assocating @blkcg and @q.
+ * Allocate a new blkg associating @blkcg and @disk.
  */
 static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 				   gfp_t gfp_mask)
-- 
2.35.3

