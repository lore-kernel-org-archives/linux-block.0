Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65442BEFF8
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349520; cv=none; b=Qi7Evum8fGI7CMFiLh8UVALPPIqy4iw1UnLYoUdiFWFIwDbLMyiRiIO+ZGtylFL30ZzqtoKOSYIsAGPCHmcay7s7/MWkKcgosVyOQ1AuiN2ad+Huvr6o6ysTiJ2bGL4GbGzFzsvdEuaJ6AzloQLI8oqjqjqwfaxtZJB+b/E13PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349520; c=relaxed/simple;
	bh=jIuVKnMI5f+KBNBr3xFJ3AQA8W3E14UBBUW+/pHhV5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO8KVWpUURPDz0Al8R3Tam0zFVIx7xHIy1NNhNWs1iTtW/zKC91oYKNcamsUaapsrVdE+WoZChAk8GsfQueMrqBBOgSC3IpwhMPgND7CosN7XDQOA+ejQDjWbeBEdfFHfxpORlzB5Di53WW0TULmMDzibtxkY12xTZ+gUizlYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JQZtF1rl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JQZtF1rl"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1743499b3a.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764349518; x=1764954318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4R9Zx2dBq+xNldpFByBb2oFsVP5vQZDFMwFExGQQ4E=;
        b=JQZtF1rl0HbCxpICCyH/DFlhoGJB//GOf/n93QMQkU3EWrzeBgpIWTM1LywbbkEjvt
         kVacDJTKTAD+19HQbejPQL2AmH4oTGRLqd3oflCJlSDHHe1Fi2T1oyHDYKmBiuJv+Kok
         SXSoRP4gV3Xw0EzhNCT6uNuGfW2lzAj+IkY2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349518; x=1764954318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4R9Zx2dBq+xNldpFByBb2oFsVP5vQZDFMwFExGQQ4E=;
        b=SdImr1DB50IGrnmGX+exBXYJODUUHSfwePJax+N6L89G3Q/z4pNwX4oL1UfWjLTfnv
         sgTs5eoMb8l2vQt3r5CDJmq3ltly/rdrEZdmE1uLnmYRL4LqT8H0uedZcX/zGI90KoYf
         FqwIY0oQoCxY1j4n1SJcSPGSweCgsQluoJRW41XI5dV8ofXkrfPFbvjRjiC2gmmgTUue
         dONPzJUe06FYQeTh51vp4RGYMlz6SJsucF5bR49huyoDOzMDHqJRQhwxGIuX8LibBZk4
         NXIUiZENBX9H0h55F00104dbTgCoiLDevbfp2SeIKMud8PW3QOksg75dAZV/mcVn0YmV
         o6qg==
X-Forwarded-Encrypted: i=1; AJvYcCWcjfA/6r8490AvzetZMzTTE/84VBUkzd0WLCwZP9Ng4SnLFmbv/sgefWGCXrJE4iqESfgYY0yIBOE7rA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXCfiytkQJ//I6ootEOUP6dIe6unL+o0IHw72cvbVOqOS8ehj
	qW80xeYyiQDN+nf1h91b8ZV1gztb1Yb0bSmobWAPT+3tZfdVeDbBdpATtA7pA7Yxeg==
X-Gm-Gg: ASbGncupU7OODReGeATeDPUH6h566htd5D1fdLbBdMCuQiqfwv32ITkBRO9ugoHJWcI
	LKqBb/Vh8RqtpQd9Tb9QlsQfD7agSKyX+522Fmj+TDmgRjN0zwOnjbOcL+2fCNPSSD2MLkwCcmG
	4I2rJI9cHQwirVTJscA9u+risEgfwx7ehLPLNEaxQMdiLtxC2TIx+JaP/Z13hKt6cO9KGjf6B/+
	I++S0oMkmtQNNZcVN27v5Skb423w6czKUAoExAE+RM6mfXQDwwOd7WO0FiJ5ZqMQnA3JvcV/T4a
	WWijblwGLu+VqQHaUgnVylm5YjhdvPbOaj0JJT3RbyRgqIEMUZ/Abs+GuYMRwPMW4wi//MTKtRN
	6cBp8fgjUV0ItcP+5J+99qN7cpW1foICR1IUrkPipiYo0Y+3NOOgSbDEwcudDK4emml1ob6YAqC
	XhbybkTc1FIz6e34T6zMXjOXFIXBDeD/0UnW2in3X2gOL5+gdAoMioqFsF9XJprrafOQMikpFJ1
	wqRi2CldRo7
X-Google-Smtp-Source: AGHT+IGdVsnWm7yn6FnlL/WMYyZNJHjQgbCSuAYTrw9LhC4iG3CiNM48M8ucj2AnGiKhtxjrJAli3g==
X-Received: by 2002:a05:6a00:2d9b:b0:7a9:e786:bdaf with SMTP id d2e1a72fcca58-7ca879f2d5emr17491122b3a.14.1764349517859;
        Fri, 28 Nov 2025 09:05:17 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:5b9f:6c7b:4d09:6126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c5e611sm5568242b3a.6.2025.11.28.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:05:17 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] zram: rename zram_free_page()
Date: Sat, 29 Nov 2025 02:04:42 +0900
Message-ID: <20251128170442.2988502-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
In-Reply-To: <20251128170442.2988502-1-senozhatsky@chromium.org>
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
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
index eef6c0a675b5..d8054b3cafaa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -56,7 +56,7 @@ static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
 
-static void zram_free_page(struct zram *zram, size_t index);
+static void zram_slot_free(struct zram *zram, u32 index);
 static int zram_read_from_zspool_raw(struct zram *zram, struct page *page,
 				     u32 index);
 
@@ -927,7 +927,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	prio = zram_get_priority(zram, index);
 	huge = zram_test_flag(zram, index, ZRAM_HUGE);
 
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_flag(zram, index, ZRAM_WB);
 	if (huge)
 		zram_set_flag(zram, index, ZRAM_HUGE);
@@ -1966,7 +1966,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
-		zram_free_page(zram, index);
+		zram_slot_free(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
@@ -1998,7 +1998,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void zram_free_page(struct zram *zram, size_t index)
+static void zram_slot_free(struct zram *zram, u32 index)
 {
 	unsigned long handle;
 
@@ -2197,7 +2197,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 				  u32 index)
 {
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_flag(zram, index, ZRAM_SAME);
 	zram_set_handle(zram, index, fill);
 	zram_slot_unlock(zram, index);
@@ -2235,7 +2235,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	kunmap_local(src);
 
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, PAGE_SIZE);
@@ -2300,7 +2300,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zstrm);
 
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
@@ -2522,7 +2522,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
 	zcomp_stream_put(zstrm);
 
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_set_handle(zram, index, handle_new);
 	zram_set_obj_size(zram, index, comp_len_new);
 	zram_set_priority(zram, index, prio);
@@ -2725,7 +2725,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 
 	while (n >= PAGE_SIZE) {
 		zram_slot_lock(zram, index);
-		zram_free_page(zram, index);
+		zram_slot_free(zram, index);
 		zram_slot_unlock(zram, index);
 		atomic64_inc(&zram->stats.notify_free);
 		index++;
@@ -2833,7 +2833,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 		return;
 	}
 
-	zram_free_page(zram, index);
+	zram_slot_free(zram, index);
 	zram_slot_unlock(zram, index);
 }
 
-- 
2.52.0.487.g5c8c507ade-goog

