Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14B2F3617
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582501; cv=none; b=EZMNHGcTO5nc08dGULoG6AdHT8/8gPAZswbb+PE+yN1aZNKVbfarnOhGw3uHVm/dj06s4AO5UQNErOkwgQwo+ok+rj2idAU9twONxz9Cc/Ms/R/Kb4C2p6z7mbqchVaKXhXf/9UWGPo1VlXFJtZra09O0rKMXlwNmIAnvQvHqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582501; c=relaxed/simple;
	bh=xlsl7fcFBFTHsBmJdkpI7L599I938927GYF6kB/g+60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH9oGstPbmEc9pl+nvkOet1KQb6tGk0555RtFLnBoh5OpzHlTio98tdrtIgGidL3HHw41sxgM96vLqGReMCA4PzuVw4lSBsUfLdcxFnMSXwW8CaYnIf5z80NPFACoeB5KFjCSd0iVCyM50AahWe318JZKYn1PpbDV68bz+gwucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KCSo5w5p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KCSo5w5p"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so3676285b3a.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764582499; x=1765187299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=906KZFo6t+2ci7ZTeYqhBL02BUrFYEeLcrZCiOSXlDQ=;
        b=KCSo5w5p2+5E3ePWRmV71XYVhEewvQuAx/iLkMdWYQNSUz4aNScRPUTkxAWUikgybT
         Fh9Jftr1BNnWJJctiNkIbJEJMedKjLviwz8Yhuq62nTAmdvevwin3DIYFZgwQdsfZore
         2nol+eiPeGBUzAUFF5SRgBcj++wXVlqe60YWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582499; x=1765187299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=906KZFo6t+2ci7ZTeYqhBL02BUrFYEeLcrZCiOSXlDQ=;
        b=IkrMqSr0WuIvsGh8nAqCbYJIAeRl9MXJ0ebxG/kYYsUPCWRkNDtaPKF7TbuUDpn2Nf
         b3gD6qV5O36POeB+aCI+z2T2SeEkecRjWmk7OtO7BUw5wPteSZVQcuAIgiI0BnsbJZe+
         kBSB6k+Cj7tvu+bKLwVWRmSV5CLqQaH898Y+j6BiSjWGxdBBaBiRWIIIVk4TzOYGmzwv
         L276E7XO0tJT0OfMkFyZSgfOeZHS3PMm7RMGrnjcNM4aBuWcAm1Rx4VzxLxuXI1UfLY5
         RzboMK3s142aRXwmG/uehRIq2C+T4+Rr3LBxZ16UFyYp7P331CDzgZbY3wIxH3bHEPk2
         bu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3I6JkAlNFT0CD1MT14W2MfYbVmqs4/7uuVkIV6PnzMc+BnK+JPU4FIFjrrYbUc72F8sCSYOkxceZkhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQy7VejB+MjAvbVqLuw78zTQ5a9EAqxJIv2wUhLSvwsebZ/42
	sfP7ZTNGD6XxBDxHmzkjZrFJw9xCBAAhtKIG+aX0jMZHiDUKUEVFOKtZaX6OjPD7kQ==
X-Gm-Gg: ASbGncsRAzaOf1Shqf0ag0Th3giVCjcZAOui3O2RkybBNS8minA4KweKA3fC3CwV+Ax
	WFlAhwhn9uQ2mIR6YWXIDm/PFp9aBmWQSBN79HW8klDL8EumYA5hlxsEn1d2x90ZaiXCJm0gyhg
	mB/xvxJhE8IGm3uw35GJyuFhuqbqfPDh5YqW2b1JxzYRU6bqzxotilyAlb7QMPdWdLRSKy4YsUn
	CGIdh+2nMkZqrl2UtkMf4W5ldGOc5IvE8fkE28pWdhSh5CfR4/MBLTVxxWfxxkufTmAMN5KE8La
	h+4UYZJxOQ7JpwzremVnsZpT6tgBqykTmQ+eO7dwJC19EzhahmL2zL2EeizpxcnwzmAkrNhCAr/
	9dMd9zPJi0Jx6YmOdgFB+qTIzCKvP3awIXfBeunX2+7885OxY30QpN3sH/LMivXvBFmSAsDggRs
	79TS121OrflvBD1RPL4cAY/MW7wstcMDnKT7irRSxvKvEF8yWuievumWTrQ9AAwdY4WD/W9o+dP
	w==
X-Google-Smtp-Source: AGHT+IG5hlJsokfKmtpNDiN4BN25b26b4ht4eT8qU8v1pYMGVVntb+93khKGuBzf5xFszcfk+RGLmg==
X-Received: by 2002:a05:6a00:9508:b0:7aa:9ca5:da9c with SMTP id d2e1a72fcca58-7c58e50cc8dmr37751171b3a.22.1764582499116;
        Mon, 01 Dec 2025 01:48:19 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db577sm12882074b3a.31.2025.12.01.01.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:48:18 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 5/7] zram: rename zram_free_page()
Date: Mon,  1 Dec 2025 18:47:52 +0900
Message-ID: <20251201094754.4149975-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
In-Reply-To: <20251201094754.4149975-1-senozhatsky@chromium.org>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't free page in zram_free_page(), not all slots even
have any memory associated with them (e.g. ZRAM_SAME).  We
free the slot (or reset it), rename the function accordingly.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1a0f550219b1..615756d5d05d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -56,7 +56,7 @@ static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
 
-static void zram_free_page(struct zram *zram, size_t index);
+static void zram_slot_free(struct zram *zram, u32 index);
 #define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
 
 static void zram_slot_lock_init(struct zram *zram, u32 index)
@@ -984,7 +984,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		huge = zram_test_flag(zram, index, ZRAM_HUGE);
 	}
 
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_flag(zram, index, ZRAM_WB);
 	zram_set_handle(zram, index, req->blk_idx);
 
@@ -2025,7 +2025,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
-		zram_free_page(zram, index);
+		zram_slot_free(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
@@ -2057,7 +2057,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void zram_free_page(struct zram *zram, size_t index)
+static void zram_slot_free(struct zram *zram, u32 index)
 {
 	unsigned long handle;
 
@@ -2256,7 +2256,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 				  u32 index)
 {
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_flag(zram, index, ZRAM_SAME);
 	zram_set_handle(zram, index, fill);
 	zram_slot_unlock(zram, index);
@@ -2294,7 +2294,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	kunmap_local(src);
 
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, PAGE_SIZE);
@@ -2359,7 +2359,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zstrm);
 
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
@@ -2581,7 +2581,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
 	zcomp_stream_put(zstrm);
 
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_handle(zram, index, handle_new);
 	zram_set_obj_size(zram, index, comp_len_new);
 	zram_set_priority(zram, index, prio);
@@ -2784,7 +2784,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 
 	while (n >= PAGE_SIZE) {
 		zram_slot_lock(zram, index);
-		zram_free_page(zram, index);
+		zram_slot_free(zram, index);
 		zram_slot_unlock(zram, index);
 		atomic64_inc(&zram->stats.notify_free);
 		index++;
@@ -2892,7 +2892,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 		return;
 	}
 
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_slot_unlock(zram, index);
 }
 
-- 
2.52.0.487.g5c8c507ade-goog

