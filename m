Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129852F28EF
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797261; cv=none; b=E4PSjXDxyvi8QqfDG+CU4M5r7VxoK3UHnoDpbLJif8EgetzXYRabuNZi3NmCQ3n1wlwjQtC529vwVOttGGYHZvZSQqP3xl3VMjtODkW0WM2FmSJokP4j7UBTGnSiyPlvBvovbz2sT0vSNVI1Qrd68QMoiklFkgGYwKxH4erIhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797261; c=relaxed/simple;
	bh=M4NcAMNdRfN7Xt9x5oF1s3PQb07UktRGrwZu7+yxoxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxG7kISH/lZTG4Xt8jLqT51lR3YRaROBU36J/J2kFqWZG08xN/frySX1JEX/vbuddkXM2tujlgupRWWffmhXZ+84XQFO7sXC9XqP3kwSFnZnNFFhy0A8fskO1e3o/jkMgZW7gNbZbY77nCAE7P6OLND+nZ06dAb6mt2PRL9n+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nl6y5+B/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nl6y5+B/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34585428e33so2752586a91.3
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797258; x=1764402058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgbFFpUkfI22QXU79O82s8Mc2xvY4Nv+z0knw2TCbpE=;
        b=Nl6y5+B/WymHcsX89hKKDKjS9uj4il9DheYH7TTFELBByM7rfVBHJypYdfhH+EQVYd
         JdWBIMzzjt6sZAnXaBPQkVrc32ZR9WFe9rLWa51LLiE50qQi5J8jXlOB8AY4YQgtjgLF
         ql7jWA/SeelQ3f4zYX7c0pU7I3yEok2tWWSdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797258; x=1764402058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OgbFFpUkfI22QXU79O82s8Mc2xvY4Nv+z0knw2TCbpE=;
        b=GapSdf0HSeKbNndy+GnhkR28TT/SEQMI6cXbYc+FT7LT60zCXcxoETL9S0hgZNmHkm
         Wcy0U/+ib9rQsztRct9Y5CZHqzUQGKlKaKFOKA1+tkwcSfoMqvjoT/VVLId45RUWDMfA
         8pSL8m3Pyl0tpTVHOoB/KIhXCkBYinf5hXKCuQC44CQAyXenZ/peB/SWV41N0B1vW4TL
         b060Z+/oco43WMqj2UZHQ6CNNXWEcXRQEXl32TRIgLaEv/Kebwk9Buv863AURO4Wl7ia
         hzryk1TUf2AuEsLcFAWOa2ggPR/lh18CxPSRzDk7I6dfSyysbUsH2lYYOFMwh9UgFPrU
         edfw==
X-Forwarded-Encrypted: i=1; AJvYcCWiwzlCdEp25dZK70LRgU5CBWfsAylpnt2cC6Z6gZv4fv+g8R456FIvvkB6p+pWmmprBbHjIDARVv3ZrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ljv0TLKiTVD1ij+xy9nnycFXSz/bzbSmx75hS7y23cOlNYMV
	ekK0U98Z9qVOG+Yj9IrJfZIk/qgQQ14hO9uaVwa7JvH+h/PDeFFsELMJ/Am7mJKfHg==
X-Gm-Gg: ASbGncuUs9BaKOjDUOjErJuzChFidJaA4gfAyLpQ0ztNvVNG+t2+m1Dslx0lhkIUdQI
	YND3F/UXECQNfAhMPZBOr8LXxJ3bQvZiVZuCLdZjILINbZHB3pr5MU6dpQJ5n357qRRhjyrtX5P
	g+zDaVweEj9QVBPDueF2wGmvApDgcZG5AqaU+YadSlPCsxlIIyrcHi+PaXiWmpHA0fLFC+32joV
	Ghup4jmJU++xwkktAmPmfTCGNOjZBi+vxNHkoHhPzjToWkfPq0GZJ60LxbHlaTAywPolxg2Qvis
	VwwNhKtcFBIY9z7cAQ6WXcjrlNQjXFGIGHRsRm26O6hqmeGPkY5ySUh22F2+KgKvkCZ4Hv40riu
	AEuKznz+X0gXPGGsRoFLnz9T6l6GPgOgNlmj1n+jYAMCVq7wcwDepAwhu941lTofKanBeD17DDy
	3LUTstmg0VeGyW5EAqLj0uCB/WjzLyzM/RDlXjM+Qiwc0ZlN9DqFkIDQEQTdd3BONZT2y3+OuYe
	g==
X-Google-Smtp-Source: AGHT+IHHl8vDZNN4ihdi/Rw6H5hLCSLd9BU7mCbrs0a2xeos0HXBVBYR3WSbjHwRbViXwwzjKXzfdA==
X-Received: by 2002:a17:90b:3d90:b0:33e:2d0f:4793 with SMTP id 98e67ed59e1d1-34733e4c735mr5306539a91.11.1763797258406;
        Fri, 21 Nov 2025 23:40:58 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:40:58 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv6 4/6] zram: drop wb_limit_lock
Date: Sat, 22 Nov 2025 16:40:27 +0900
Message-ID: <20251122074029.3948921-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need wb_limit_lock.  Writeback limit setters take an
exclusive write zram init_lock, while wb_limit modifications
happen only from a single task and under zram read init_lock.
No concurrent wb_limit modifications are possible (we permit
only one post-processing task at a time).  Add lockdep
assertions to wb_limit mutators.

While at it, fixup coding styles.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 22 +++++-----------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8dd733707a40..806497225603 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -532,9 +532,7 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 		return ret;
 
 	down_write(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
-	spin_unlock(&zram->wb_limit_lock);
 	up_write(&zram->init_lock);
 	ret = len;
 
@@ -549,9 +547,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	val = zram->wb_limit_enable;
-	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
 	return sysfs_emit(buf, "%d\n", val);
@@ -569,9 +565,7 @@ static ssize_t writeback_limit_store(struct device *dev,
 		return ret;
 
 	down_write(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
-	spin_unlock(&zram->wb_limit_lock);
 	up_write(&zram->init_lock);
 	ret = len;
 
@@ -579,15 +573,13 @@ static ssize_t writeback_limit_store(struct device *dev,
 }
 
 static ssize_t writeback_limit_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	u64 val;
 	struct zram *zram = dev_to_zram(dev);
 
 	down_read(&zram->init_lock);
-	spin_lock(&zram->wb_limit_lock);
 	val = zram->bd_wb_limit;
-	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
 	return sysfs_emit(buf, "%llu\n", val);
@@ -869,18 +861,18 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 
 static void zram_account_writeback_rollback(struct zram *zram)
 {
-	spin_lock(&zram->wb_limit_lock);
+	lockdep_assert_held_read(&zram->init_lock);
+
 	if (zram->wb_limit_enable)
 		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
-	spin_unlock(&zram->wb_limit_lock);
 }
 
 static void zram_account_writeback_submit(struct zram *zram)
 {
-	spin_lock(&zram->wb_limit_lock);
+	lockdep_assert_held_read(&zram->init_lock);
+
 	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
 		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-	spin_unlock(&zram->wb_limit_lock);
 }
 
 static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
@@ -1005,13 +997,10 @@ static int zram_writeback_slots(struct zram *zram,
 	u32 index = 0;
 
 	while ((pps = select_pp_slot(ctl))) {
-		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
-			spin_unlock(&zram->wb_limit_lock);
 			ret = -EIO;
 			break;
 		}
-		spin_unlock(&zram->wb_limit_lock);
 
 		while (!req) {
 			req = zram_select_idle_req(wb_ctl);
@@ -2962,7 +2951,6 @@ static int zram_add(void)
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
 	zram->wb_batch_size = 32;
-	spin_lock_init(&zram->wb_limit_lock);
 #endif
 
 	/* gendisk structure */
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 1a647f42c1a4..c6d94501376c 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -127,7 +127,6 @@ struct zram {
 	bool claim; /* Protected by disk->open_mutex */
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
-	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u32 wb_batch_size;
 	u64 bd_wb_limit;
-- 
2.52.0.460.gd25c4c69ec-goog

