Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222024A7DE;
	Wed, 15 Jan 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952961; cv=none; b=pNfYWSA8nDQTmmckUtNWrTebrZ4dlugnI/Lw48AA3cuoxYNkv2sIX8dfXIsdO1cZm3lwUTl9tgdSxEVelMH2r3UVAYPI6hbKzV87NNbJNnpcixGzzWiTy1yYBetqQv55Iek9cLgt4SB5IKOTy342f1HNjYfMS3C17Gcydykvlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952961; c=relaxed/simple;
	bh=WUvPkyVBv96LfULoGZ1Agg2wHWHPrtbhtjA5jMSNBP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TO8eRkKPZhokutDSO3F3wT2a9PhAKlM2g58XBmybsLp+yuSTOuabMFBzH+njQREvv/A09dYz0hbuIVKSwqrZcriIYVc8Rw13zyQH0Dz2ofAWEdYuS0wi8HnFxQXZ5KbZHNbzOJccwfSJnrRPySAs/C+TkfZvB9mTV6XA++he4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVDe1LYz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVDe1LYz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso117916765ad.1;
        Wed, 15 Jan 2025 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736952959; x=1737557759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbg+TyN1xOymWN0VIVzEHJ4/G97vnEBKJetx0Q8YG8s=;
        b=jVDe1LYzXO0z64zkXfaGSMJlbYQVSk72B3YE7cm4XEaqDd8woT6pBa//REQbgkrS07
         ZPvGxHdcD0vNEqvy983dT1c+thSMvdFz5XfRsyWPUetKEuKCQds9G/mUfokBflXQWkpM
         2qAbEp+o/Dr2EsVPtMBLD59vwwxjiUkCVAmuBc2sK1OYqAAZn7Xca1WTwnCawGeSE06d
         a14L3il2e/5Qa5VYwAElfwg440hTbsZuy0QsPTOXR3K9mvGwdLwUkw3v2XHjJPqkRf+0
         bKRJ5gQbWhD/jd0OhfI7NsyEiRLIuSloBWsAq9XYa62QVxEqxqAEbOBZBlZKnyA0oq8c
         dozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952959; x=1737557759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbg+TyN1xOymWN0VIVzEHJ4/G97vnEBKJetx0Q8YG8s=;
        b=eTTmzOo7lFpyQkf7NvfB1mFbPG6OPnkAFWcG7tM0M8wJQyiRXX2hiAu7IpPMLhzCA3
         dYuoZinU/cVD0LDcJXozcPAb9ZKzyh2TGJfkKWeIA4s6KbrJiFnvjed4HJIsNeXLbjzq
         ZwQsvI/gc0tLqIhdz4CMLc8efSrTjC4+7fcejzWJmt5/sqAoWqe0CVOxggbQNs/l6Hla
         jaXnujliAN4ygrHpL6NL/TY88X+eJN+J6pWYbLITmDABhybDj1fmmFbmEQc1J1WkpXqG
         KwZ2fDn7a/oZX8deAB3nBzACSPkiRf1JlcCCnLQN5RCjLmeNOaNLK3ARRiA5dGL0LNX8
         pLdg==
X-Forwarded-Encrypted: i=1; AJvYcCVdewxpX0vdgFxnlKfp8DOGSPehAI4vGDl+WSApAKKASJmQL4k9ifzmvIJLHMgLM/eZgZHgV8YouEg/uw==@vger.kernel.org, AJvYcCVkOfRzopT86as9I8979AjDlfQtiNT+dd+RW4TsrdFz7seauEiC1VzYq2IvMfHRYbbXA2XCmw2aUiUYoSSq@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrDcdexbAU80qt0DeZv96o6S/q6YHmMgV33Hr9UMVGZ6vDR0Q
	GktZ+QvKFiqpRBioF2BlZnslZxe5yLjilR7J6TgwJLGuO0aLAa4I
X-Gm-Gg: ASbGncvOMFHgemZdz3k3mnmGOTiTUqOT4zSh71jEfx73N60L4jRnMBh4fM+2AhPxzux
	D/nH9UEXmDqXmoxYa7qAzHyz4F1C5Mfn9VEgcoQaD1elqknPsOob2zogNwpyKtM0yn9ZJBBPgWq
	ds748/T1I6zhBq7ZDwZQLsNgPic3WnBkkW4URCP8kTKIoojNr7xFMsaWhnkPaTby2FluObM6N8/
	EA9LVgF+KQ1tzlxZj1Q4Qes+qsgtGHDFRFubZMnGMj0lh09JzEmLmHSa6T2eqqiYICfiJo3nlmL
	m2O3quk=
X-Google-Smtp-Source: AGHT+IHtzs49z0o5VS9a2B7rMTbH6BwvfS9P+L21x7pc0IR1ps07RbSO6FVxQO6OKkYz98UzCBmF5w==
X-Received: by 2002:a17:902:d2d2:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-21a83f439b0mr451479285ad.5.1736952959369;
        Wed, 15 Jan 2025 06:55:59 -0800 (PST)
Received: from localhost.localdomain ([49.90.27.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21c21esm82758165ad.156.2025.01.15.06.55.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jan 2025 06:55:58 -0800 (PST)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] zram: cleanup in zram_read_from_zspool()
Date: Wed, 15 Jan 2025 22:55:45 +0800
Message-Id: <20250115145545.51561-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need a separate "if" branch to check whether size is
equal to PAGE_SIZE. So remove the above "if" branch and
move down 2 lines to cleanup code, no logic change.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 drivers/block/zram/zram_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7903a4da40ac..ad1fbe6d823d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1561,11 +1561,6 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	size = zram_get_obj_size(zram, index);
 
-	if (size != PAGE_SIZE) {
-		prio = zram_get_priority(zram, index);
-		zstrm = zcomp_stream_get(zram->comps[prio]);
-	}
-
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
 		dst = kmap_local_page(page);
@@ -1573,6 +1568,9 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		kunmap_local(dst);
 		ret = 0;
 	} else {
+		prio = zram_get_priority(zram, index);
+		zstrm = zcomp_stream_get(zram->comps[prio]);
+
 		dst = kmap_local_page(page);
 		ret = zcomp_decompress(zram->comps[prio], zstrm,
 				       src, size, dst);
-- 
2.45.0

