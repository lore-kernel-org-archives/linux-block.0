Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F63DDDBE
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295549; cv=none; b=sfEMABnrvb0x+kEuy/bIwshQi7sUdqXQVJcJD+NRDPMVr4UhszJbqs3gxIaF3kCRuCP//+iAaxe5R+wzIidZ3aqVnlogZiva2YsRBhs0F83o70tWs9YMJ82MzBpwS9ysAH7xA71/W6WuTAWOBnWHOWbLB1gFoaScmYib9ldEWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295549; c=relaxed/simple;
	bh=IMwXcOIFbaTba9duylEhRaH0+iChQsLlcede3lTgSF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX5EkXGHL9kFarNHtdQJ1NCa1fQilRRn8bAtucxwBTU29AUs/+R8+bR01krW/cXHqdEMsvwg9HQk8Ejcdv13V/1OGoeN5sL+0h7Y6bkuKqc3k37EE1rzLW33yW3FqjXiBhi9KaEOyBuvMMcIdDZ1fNtxhXWyLYH8pMc8Zu3jv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kep02YzY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kep02YzY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e5fb79ce82so5001095ad.0
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295547; x=1792900347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M55JStFe4+ywWFb/Lnl0qjUNokQckie0nywOU4qhi9c=;
        b=kep02YzYJO0Cd30vCzdL3FrJ048+oBE8NvG3qtNe+AuxVmxSNoSaE8iCHDqGg2rCvS
         ciNiJyQ781cIYscihRYlgt1RHc0IxPjnJLgDrrhxMOLanQh6hDswIM565k2bDoHIgOeW
         Q9/KPeSmvl9p+CI3c7DMf2CbieNqRi3WorPH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295547; x=1792900347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M55JStFe4+ywWFb/Lnl0qjUNokQckie0nywOU4qhi9c=;
        b=yiM6sefHr548hd/hDFM8yeSYDGNn1l9dC0Rb/oPvtwOf6pueAkM4ZIKj0PE5i/d0Xk
         R/JFsaZvNVbB6k4oGC4lDQ5ARvMF5Fx0UNU2TII3UlddpIVpIl9GOqorn8707YMAlcJ1
         ySW77C91osSPV6cHBvv4/TO3gx/8ZNO5VZulSOivzJYEsjNSCcbyHKOKvFQ7lcX6r9hh
         8WNupoOj9wdm9ClTQVu5sy7j/ktU1y1GziMK5nxk0klyrC/qoUFo3pBpmvR5494dClig
         iNu5WBp9VA3PoXDzjwRpI3PrwMN4RKghSSIKA6Y+FWoecL649uHwpLPSG54HkBgFAyk5
         AG9w==
X-Forwarded-Encrypted: i=1; AKwUvBxDHO3UKGS8GJy1AwF/Sl/rKeYw9RO+AwVZlnYKGYFOmssM477YrrYZdvQ9FBg/S+MRV9Cxzs0HmCZB6A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2uZau4IODhWYMRBmQ0iECtBdxzsa/02LSnXHceWZsbHiUjd8u
	X58EmxuFBs+rWelUrxzmCCkRrfXFvS301y8h9k9IKw7KRSCZQaEhof67QsJRc9+X2Q==
X-Gm-Gg: AYBFou3kxI5/CD1dpD0F7hnDU/BzSrszdqiTuUVC07C/JMMZmefmx4jCsXdohF3/BCz
	jeJuvTCgSkAhJJJrgvi9+fzjKFQ1IrfoHQixx38IQbPSo8OUaHCtXaxtXUcNld4c2psXqQrDVDO
	i9M1TpJPsVUckCtIwL2so6VYjxFmvcyOoS464+As+zZuVLN7KSAxL0T474XBiD8nP304SznkPYf
	KoJ1xp6mQVcerz93QlKxjfhXUROP1WzxKyshXnMoYXdyESdmBuhqVYEV4YUeBjnhtIcM7sIx6/x
	9VSSlptECY3Ir1xMsjJXzPTIs4cD2iXk3OeEp43fpk9tjPT1mhZA7Ouu2KLdyKbUxcOwYu+BlOw
	YmRcDr6UFNnXQ0MA0Bi52+vXe6+duXT9UzJuiuCXmIi7GMYy9ui02ex58146VK0Lpjzeg5AHNNg
	02gs8rzI1bZr5Amet6a31E+ssDcOUVF+wssWTDCDiAAjpJ7VLnBXt2/lb1OIGpj9fM0h2jYPdml
	WTqXo29mAnNLV/BwS8Gjos6GyLLkX2j77kr1RgE8MU185ARWNHE2NeqbN0nQ4c=
X-Received: by 2002:a17:90b:28ce:b0:3ac:d17c:2a70 with SMTP id 98e67ed59e1d1-3acef5dcc7dmr3685875a91.62.1792295546657;
        Sat, 17 Oct 2026 20:52:26 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:52:24 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 13/13] zram: use a singleton compression context for recompression
Date: Sun, 18 Oct 2026 12:51:15 +0900
Message-ID: <20261018035125.3120704-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secondary compressors are only used by recompress_store(), which is
serialized under zram->dev_lock, so we only ever use one secondary
compressor at a time, yet we still allocate them on each CPU, which is
just a plain memory wastage.  However, we do need per-CPU decompressors
in order to support concurrent reads.

Now that Read and Write contexts are split, we can allocate just a
single compression stream (recomp_cstream) for secondary algorithms
instead of per-CPU streams, avoiding unused per-CPU compression
contexts and 2 * PAGE_SIZE buffers.

For example, on an 8-CPU x86_64 system (4K PAGE_SIZE), this saves:
- zstd (level 3, default):        ~700 KB (~100 KB/CPU)
- zstd (levels 12-22, no dict):   ~1.91 MB (~280 KB/CPU)
- zstd (levels 14-22, 110K dict): ~5.33 MB (~780 KB/CPU, lazy)
- deflate (winbits=-11, default): ~1.04 MB (~152 KB/CPU)
- deflate (winbits=15):           ~1.86 MB (~272 KB/CPU)
- lz4hc:                          ~1.84 MB (~269 KB/CPU)

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 75 ++++++++++++++++++++++++++---------
 drivers/block/zram/zcomp.h    |  9 +++--
 drivers/block/zram/zram_drv.c |  5 ++-
 3 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index c6d2fd23c6f6..ce94dd96cc98 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -151,6 +151,11 @@ ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at)
 
 struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp)
 {
+	if (comp->recomp_cstream) {
+		mutex_lock(&comp->recomp_cstream->lock);
+		return comp->recomp_cstream;
+	}
+
 	for (;;) {
 		struct zcomp_cstrm *zstrm = raw_cpu_ptr(comp->cstream);
 
@@ -326,22 +331,25 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
-	struct zcomp_cstrm *cstrm;
+	struct zcomp_cstrm *cstrm = NULL;
 	struct zcomp_dstrm *dstrm;
 	int ret;
 
-	cstrm = per_cpu_ptr(comp->cstream, cpu);
-	ret = zcomp_cstrm_init(comp, cstrm);
-	if (ret) {
-		pr_err("Can't allocate a compression stream\n");
-		return ret;
+	if (comp->cstream) {
+		cstrm = per_cpu_ptr(comp->cstream, cpu);
+		ret = zcomp_cstrm_init(comp, cstrm);
+		if (ret) {
+			pr_err("Can't allocate a compression stream\n");
+			return ret;
+		}
 	}
 
 	dstrm = per_cpu_ptr(comp->dstream, cpu);
 	ret = zcomp_dstrm_init(comp, dstrm);
 	if (ret) {
 		pr_err("Can't allocate a decompression stream\n");
-		zcomp_cstrm_free(comp, cstrm);
+		if (cstrm)
+			zcomp_cstrm_free(comp, cstrm);
 		return ret;
 	}
 
@@ -354,10 +362,12 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	struct zcomp_cstrm *cstrm;
 	struct zcomp_dstrm *dstrm;
 
-	cstrm = per_cpu_ptr(comp->cstream, cpu);
-	mutex_lock(&cstrm->lock);
-	zcomp_cstrm_free(comp, cstrm);
-	mutex_unlock(&cstrm->lock);
+	if (comp->cstream) {
+		cstrm = per_cpu_ptr(comp->cstream, cpu);
+		mutex_lock(&cstrm->lock);
+		zcomp_cstrm_free(comp, cstrm);
+		mutex_unlock(&cstrm->lock);
+	}
 
 	dstrm = per_cpu_ptr(comp->dstream, cpu);
 	down_write(&dstrm->lock);
@@ -367,7 +377,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
+static int zcomp_init(struct zcomp *comp, struct zcomp_params *params,
+		      bool recomp)
 {
 	int ret, cpu;
 
@@ -376,10 +387,28 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	if (ret)
 		goto cleanup;
 
-	comp->cstream = alloc_percpu(struct zcomp_cstrm);
-	if (!comp->cstream) {
-		ret = -ENOMEM;
-		goto cleanup;
+	if (recomp) {
+		comp->recomp_cstream = kzalloc_obj(*comp->recomp_cstream);
+		if (!comp->recomp_cstream) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		mutex_init(&comp->recomp_cstream->lock);
+		ret = zcomp_cstrm_init(comp, comp->recomp_cstream);
+		if (ret) {
+			/* zcomp_cstrm_init() cleans up after itself */
+			kfree(comp->recomp_cstream);
+			comp->recomp_cstream = NULL;
+			goto cleanup;
+		}
+	} else {
+		comp->cstream = alloc_percpu(struct zcomp_cstrm);
+		if (!comp->cstream) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		for_each_possible_cpu(cpu)
+			mutex_init(&per_cpu_ptr(comp->cstream, cpu)->lock);
 	}
 
 	comp->dstream = alloc_percpu(struct zcomp_dstrm);
@@ -393,7 +422,6 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	for_each_possible_cpu(cpu) {
 		struct zcomp_dstrm *zstrm = per_cpu_ptr(comp->dstream, cpu);
 
-		mutex_init(&per_cpu_ptr(comp->cstream, cpu)->lock);
 		init_rwsem(&zstrm->lock);
 		mutex_init(&zstrm->excl_lock);
 	}
@@ -405,6 +433,10 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	return 0;
 
 cleanup:
+	if (comp->recomp_cstream) {
+		zcomp_cstrm_free(comp, comp->recomp_cstream);
+		kfree(comp->recomp_cstream);
+	}
 	comp->ops->release_params(comp->params);
 	free_percpu(comp->dstream);
 	free_percpu(comp->cstream);
@@ -414,13 +446,18 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 void zcomp_destroy(struct zcomp *comp)
 {
 	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
+	if (comp->recomp_cstream) {
+		zcomp_cstrm_free(comp, comp->recomp_cstream);
+		kfree(comp->recomp_cstream);
+	}
 	comp->ops->release_params(comp->params);
 	free_percpu(comp->dstream);
 	free_percpu(comp->cstream);
 	kfree(comp);
 }
 
-struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
+struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params,
+			   bool recomp)
 {
 	struct zcomp *comp;
 	int error;
@@ -443,7 +480,7 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = zcomp_init(comp, params);
+	error = zcomp_init(comp, params, recomp);
 	if (error) {
 		kfree(comp);
 		return ERR_PTR(error);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index ca1ebc70ad0a..39efefc43a13 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -40,7 +40,8 @@ struct zcomp_params {
 /*
  * Run-time driver context - scratch buffers, etc. It is modified during
  * request execution (compression/decompression), cannot be shared, so
- * it's in per-CPU area.
+ * it's in per-CPU area (except for recompression, which uses a single
+ * per-device compression stream).
  */
 struct zcomp_ctx {
 	void *context;
@@ -95,9 +96,10 @@ struct zcomp_ops {
 
 /* dynamic per-device compression frontend */
 struct zcomp {
-	struct zcomp_cstrm __percpu *cstream;
 	struct zcomp_dstrm __percpu *dstream;
 	wait_queue_head_t dstrm_waitq;
+	struct zcomp_cstrm __percpu *cstream;
+	struct zcomp_cstrm *recomp_cstream;
 	const struct zcomp_ops *ops;
 	struct zcomp_params *params;
 	struct hlist_node node;
@@ -108,7 +110,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at);
 const char *zcomp_lookup_backend_name(const char *comp);
 
-struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
+struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params,
+			   bool recomp);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 52341f05da83..079f3723db31 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2526,7 +2526,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	}
 
 	/*
-	 * We are holding per-CPU stream mutex and entry lock so better
+	 * We are holding compression stream mutex and entry lock so better
 	 * avoid direct reclaim.  Allocation error is not fatal since
 	 * we still have the old object in the mem_pool.
 	 *
@@ -2928,7 +2928,8 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 			continue;
 
 		comp = zcomp_create(zram->comp_algs[prio],
-				    &zram->params[prio]);
+				    &zram->params[prio],
+				    prio != ZRAM_PRIMARY_COMP);
 		if (IS_ERR(comp)) {
 			pr_err("Cannot initialise %s compressing backend\n",
 			       zram->comp_algs[prio]);
-- 
2.56.0.176.g3575e65682-goog

