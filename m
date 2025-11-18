Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5553054D6
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451031; cv=none; b=oRu6faLpepJfx2JUlZ2MMQkD+ptyHGVya/I2ImtXzerv6qgEkLxjntG6ySbIAheIrN9OrYTSAXK83j3bzgBDkRVHExxfcUhHiYrxnJHarCFq1ssh0S8QwyrAApKSkZOX8VdcNVDJy6VbmdyBHCQMI13UHWZKvbea36hiNfHbwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451031; c=relaxed/simple;
	bh=83Tb0fnS8qFAanAr2oHDxC3ExyzkwPCMehzRY3O07yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deKixkRV+JH+IrotO+bA3k7A7REz3SP5ldPFZ9aUK6t9LJ3YfsQZzV1IYsYiBX9XHQNsaUc1xA9YkjFDlZUL1ag30BxmuSYJawmguaL7x0O8HsbhTHzfxYB6hLBlA4Tj+MUwKKzUbsI8CCO+LINREBghA0WqllTFxWMd5tt0zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QLhmx3tl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLhmx3tl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2980d9b7df5so54373985ad.3
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763451030; x=1764055830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spTZ0mW8CsK7UvPfRSf8MeqzEHevliS4YgLZ2IGrH9o=;
        b=QLhmx3tlk+Ugapp+9raLzh8dW82alag814+KEwq10D/r7kel7p+0ghoRvjiIddv3rg
         t68W7Z3SSbAFeI8oiI0sovUSBzOycA2KCNDhoWJnwUieOmxdjEM+abJlii1xXKSYs734
         +b5uVCSAUkqNSbgBxoGlB6A9PTEbng4kOQbos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451030; x=1764055830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spTZ0mW8CsK7UvPfRSf8MeqzEHevliS4YgLZ2IGrH9o=;
        b=jTVLn/vcFfo1r5UMU0ROvJG6/ySgSG7UDTjkgdy6TM1uq1MRrNvralGTcQ2p6iuOHL
         KTivyux0w0Z41b1pCozw7MR5wuCiS145yGKh9FLcMQasixwCw5R+sVN54N7dgIXnZLe/
         M5qdQ5HTlmeOOqC0NKLyt7SjHRIzWB5A6lOFW/pUkGKtLesVpHspdg4YhYNF4cb9lBZW
         EAAil3WdAEyKd0E5CQ4ApaO1/+H5Bv7fpMAGl75jcCfaSdlOU2GLHseUNsk2/tK+3ZJJ
         yrKX75ul+jB08Q1QHRMgT5qDsEIMRJIvTqQqRX/N3+qpyzOWoLqULIk7yP201eg5IySM
         iQkg==
X-Forwarded-Encrypted: i=1; AJvYcCXhdoxWZ7cDw9yR9IS7M/0DmrYeQxs3n/cXfRumXjgxVorV4n3w3Jdw9H4AEJq7I5M5wBFaoN6KhXkq+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUV/1zzDfY13nvI2RijgbxBFk7KjG+acPOnFMTj/Yq/ZzWYwY
	NPQifexPHwxXCw99wGyjkFsANw9HtfrLwVZREKw49x3+e/rUzrv5sUte3LiZlupqxg==
X-Gm-Gg: ASbGncvrWCDT2wsKgh4p4zHkweC4x97L1Hl8AuugLLy+MTlx6qAI13RdekOQVf/VKTm
	7/f+TVyZxioui/gjWVpJ205np6ofia9m/tHypvVuRivCtcV/LePO9toOvjAYgZEhSfi0u+jLq1s
	04pGqp2JAmiM5eAEwRWmRXmBzfyxNLlw4f6BsNoG855zm/lKUnych1i5ugAfHcr213QefWwpM3i
	4sb4OdpokON3HmjI30NUm3Dn1WmTTz0VcVzM/jjYBlbZr5m/PdZ4wSVFVxtnNTc8Bjejrq4OXWs
	4U4t+Sl3gGV4Q1TqdClptMv02JxGJ+p8lSm0IuSkKPMwbutju+QEsVvlA+otGsZCHm2/LbY9NMc
	CJymDw7+F+UWF/QxN+UjRBBPi74HpmYqiw4uZsEE94nKmpjBV5xH9o8uZ/3DjsDFtr9c12Mmud2
	1YLnXbnvWR4ZdoT8FF0ZFqYG3ke6kZ7njn4SnkTw==
X-Google-Smtp-Source: AGHT+IHfTiRsjOnMwAynan9LOvPqDmjC2nm6QOrpvZK/BiOoKhMq5MVjGe3vyD/jJGgU5d35MZnMsQ==
X-Received: by 2002:a17:903:19c3:b0:295:551b:4654 with SMTP id d9443c01a7336-2986a6ec988mr179562065ad.23.1763451029659;
        Mon, 17 Nov 2025 23:30:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568ccsm163926215ad.50.2025.11.17.23.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:30:29 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 6/6] zram: read slot block idx under slot lock
Date: Tue, 18 Nov 2025 16:30:00 +0900
Message-ID: <20251118073000.1928107-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251118073000.1928107-1-senozhatsky@chromium.org>
References: <20251118073000.1928107-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read slot's block id under slot-lock.  We release the
slot-lock for bdev read so, technically, slot still can
get freed in the meantime, but at least we will read
bdev block (page) that holds previous know slot data,
not from slot->handle bdev block, which can be anything
at that point.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 93365811781b..77d0e636e053 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1980,14 +1980,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
+		unsigned long blk_idx = zram_get_handle(zram, index);
+
 		/*
 		 * The slot should be unlocked before reading from the backing
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
-
-		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
-				     parent);
+		ret = read_from_bdev(zram, page, blk_idx, parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.52.0.rc1.455.g30608eb744-goog

