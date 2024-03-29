Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDE3BBE7
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705258; cv=none; b=lcogfPbNT8D78UYKEqgoDYa9QsUkZjNg37iTlbcYWIJaLBHmg0TP7PwwK5EIn3oX3zF/HQW5bN1Hy7gmaCUwlEchKnHdSQ9LIomokTmh+5dKXLfKxacnMBjsLKVHrcogmVDwuMUWEMtDqfax/JxwVQvl98xxb2q/jgJU4B7JE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705258; c=relaxed/simple;
	bh=2HdMA2GVi4vvBuZqc7GAV19/6biZzG2XxYPUOtB9kRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJbqnKb9nU85QtteXFyiJUo0SVyxbJ5bLmkN2RejvihTHVpPQRQWK3celwVGThWknIdT1po10upXfywUww5iIB2jHJnC8tLnpw0SBmJCFMXmh1LCMKbn9FN4ZRRBOaKAWE5D6X0t5BiTsIhZimyKSMgFo3lQ/5ejl1yyfjZqTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JWhPEvOl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWhPEvOl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0b213efa3so16862065ad.0
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711705256; x=1712310056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzKyNHk5YN39zEK5kgu7WDIZLg9yL65BlTGSnWRCjJs=;
        b=JWhPEvOlCw6tOH5y/YiJBXkikpaAB3Ng4uf/eBDyu4l6G2BmFV4uP6w+DmGxpMOnHx
         hBD9t7qjM4N+ggnUnBUCgdR7cMuocAyyzk/5KzaUmaF0tJ5F6ELLuyuBA8V7SrVlaI4V
         3lf5DDdhH+gQRZP0CEMtv/cK3o6NKeOlD7SN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705256; x=1712310056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzKyNHk5YN39zEK5kgu7WDIZLg9yL65BlTGSnWRCjJs=;
        b=IYtpAGDmjl03bLk+Wh67qYiivtjSBtOOss1qBnXic6U1h0oqEt0i1ieATjdeDB+WAE
         UOzBHDpHRmE4+sMFpNH6VKD7evWkhDDR7z+yfJ+DTc7wsKxE2gFk+FJkor5W7EWOIM1W
         6PzQZXhPkWjHHXvjjiHmTmW5+qQseyQcYwqnp28KL20lT5QIbFaq+0eU6BcWKdluwyj5
         /fEvegKL1SMyYNZ9zpoLnP7ZGCMzcLwuPkkZPAttNqYHecpNDTyEx1vepk9zbWEcw3rz
         uQJovOD5ahak5J6yS5CHw1ZtNmhQ216/tMvLLBi/WiQkrl/Phe1lRkHikFWGC4l19Ub6
         PyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnPaVB9db1FM7DqvrtFhap1yCPLocJ8Jp6WapopV4Lw72LHMxSkfc/0hS7IiYi9EeTKoUPqNJAs8oSzlThqizHtwuhAPv/1Psu0SQ=
X-Gm-Message-State: AOJu0YxD0eHSfvugSYpz9uI1gPOLE4VVWKNKCx8+cR9+1gJGbjzljjUU
	13kYVT4Mb7ORumzlMDAkWgd2GwUAJN1JS8qEj5/v0QEIVDlp/AhMeQvx3TE3Og==
X-Google-Smtp-Source: AGHT+IEAoJmQJQFXz2QVZ4UibB4fev1lwxr2gnC9WVva0sEsNWFbD9aC5yO424w2M93S6TXMTV31ZA==
X-Received: by 2002:a17:902:9a0c:b0:1e0:342b:af6f with SMTP id v12-20020a1709029a0c00b001e0342baf6fmr1818929plp.16.1711705256212;
        Fri, 29 Mar 2024 02:40:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:91ca:ac62:b18d:2b7])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001e0c5be4e2esm3065460plg.48.2024.03.29.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:40:55 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] zram: add max_pages param to recompression
Date: Fri, 29 Mar 2024 18:39:41 +0900
Message-ID: <20240329094050.2815699-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce "max_pages" param to recompress device attribute
which sets an upper limit on the number of entries (pages)
zram attempts to recompress (in this particular recompression
call). S/W recompression can be quite expensive so limiting
the number of pages recompress touches can be quite helpful.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  5 ++++
 drivers/block/zram/zram_drv.c               | 31 +++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index ee2b0030d416..091e8bb38887 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -466,6 +466,11 @@ of equal or greater size:::
 	#recompress idle pages larger than 2000 bytes
 	echo "type=idle threshold=2000" > /sys/block/zramX/recompress
 
+It is also possible to limit the number of pages zram re-compression will
+attempt to recompress:::
+
+	echo "type=huge_idle max_pages=42" > /sys/block/zramX/recompress
+
 Recompression of idle pages requires memory tracking.
 
 During re-compression for every page, that matches re-compression criteria,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..4cf38f7d3e0a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1568,7 +1568,8 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  * Corresponding ZRAM slot should be locked.
  */
 static int zram_recompress(struct zram *zram, u32 index, struct page *page,
-			   u32 threshold, u32 prio, u32 prio_max)
+			   u64 *num_recomp_pages, u32 threshold, u32 prio,
+			   u32 prio_max)
 {
 	struct zcomp_strm *zstrm = NULL;
 	unsigned long handle_old;
@@ -1645,6 +1646,15 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	if (!zstrm)
 		return 0;
 
+	/*
+	 * Decrement the limit (if set) on pages we can recompress, even
+	 * when current recompression was unsuccessful or did not compress
+	 * the page below the threshold, because we still spent resources
+	 * on it.
+	 */
+	if (*num_recomp_pages)
+		*num_recomp_pages -= 1;
+
 	if (class_index_new >= class_index_old) {
 		/*
 		 * Secondary algorithms failed to re-compress the page
@@ -1710,6 +1720,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	char *args, *param, *val, *algo = NULL;
+	u64 num_recomp_pages = ULLONG_MAX;
 	u32 mode = 0, threshold = 0;
 	unsigned long index;
 	struct page *page;
@@ -1732,6 +1743,17 @@ static ssize_t recompress_store(struct device *dev,
 			continue;
 		}
 
+		if (!strcmp(param, "max_pages")) {
+			/*
+			 * Limit the number of entries (pages) we attempt to
+			 * recompress.
+			 */
+			ret = kstrtoull(val, 10, &num_recomp_pages);
+			if (ret)
+				return ret;
+			continue;
+		}
+
 		if (!strcmp(param, "threshold")) {
 			/*
 			 * We will re-compress only idle objects equal or
@@ -1788,6 +1810,9 @@ static ssize_t recompress_store(struct device *dev,
 	for (index = 0; index < nr_pages; index++) {
 		int err = 0;
 
+		if (!num_recomp_pages)
+			break;
+
 		zram_slot_lock(zram, index);
 
 		if (!zram_allocated(zram, index))
@@ -1807,8 +1832,8 @@ static ssize_t recompress_store(struct device *dev,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
-		err = zram_recompress(zram, index, page, threshold,
-				      prio, prio_max);
+		err = zram_recompress(zram, index, page, &num_recomp_pages,
+				      threshold, prio, prio_max);
 next:
 		zram_slot_unlock(zram, index);
 		if (err) {
-- 
2.44.0.478.gd926399ef9-goog

