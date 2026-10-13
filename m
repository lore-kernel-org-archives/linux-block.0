Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6247126B
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863560; cv=none; b=XgzpQmF4fqQ6lmXcpggyxmOu0y6ldu+wUR3w0TPxvBVSi38/4FUp56ZmFvKt5mE9R1HBpRAlVsJszhlO2ar2xzhKshLgey/CDJX1a+ff6n7qNX+y4n6HASUinELWAkD/UBEt+0E9S9+56JWC2Rg915k6QfPAV5KlJJ//turQFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863560; c=relaxed/simple;
	bh=WM4lFwvGqps2g+q1xzEMDJrH/29eFD9ivS4Bs/OF4oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/jxadW1j4xiU4FUUcVkwRvNMNxCtT2zDp7fndCUhZYt63li5YuJmXqcjE9RvZOpXb3FTQlG4A7HK+qmN+W17DMFhcyPqeC18abkNMRiUuJ01Ze5KTcWVgw2KXDmQFG/kqEGVWxi0386oBhBFTbQdU/UdkQLAQhgncoIqRO3Ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M5GbqB9F; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5GbqB9F"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-88b8f0a1bcdso1934695b3a.3
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863558; x=1792468358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pCFwH738tBTVDAaZQU9JfFW8ZV79GtE0C0hDEYSYlFc=;
        b=M5GbqB9FOderIpZSqZt9U2TuZ/sEgVuIHxEJTZaXh0orsRlLhZbs8brkc2yHedeYl/
         5jeJaiGA7kJlCqQza7piFXOhxc83gbP2vxgfqXh82pxIPO9WZ/BAA/ZhEDSYuqemp5Bz
         BzDQsEI1iiyzv5UpTqC9C81DJBK31yzLXycBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863558; x=1792468358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pCFwH738tBTVDAaZQU9JfFW8ZV79GtE0C0hDEYSYlFc=;
        b=eDb/O9pHi6haSKk2xOJnltfc36lOEXJXyj9kPOMMYXlk8nZNEFbbNLCJDAepO97hW5
         QDYNFU7rI1ceNj2Ljww+Eavbm3cO9P7YdDb/V20Be+uP5PmRHGbTCEAiw0id0Hrk+LSB
         n01AemJvRNgNn8cLv5x8zux2reTEDNJQYnqRXDv7+XfsJBDqvNX0Gbql0kbOf77JoPra
         jaTi3CruBhXDKZd15qgHYgMWvO3k5eOhOpEAhov2uWYwFnyztC3BAXlxupJ2jfjpqlQl
         PbYVewFGGbhV7OJVR7kwjHoVtSPcFLsDBzfBgoES5/9OYkZARBEpVwxruBJ1U+NvhJ3X
         HEPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjYfYminIHWSn12+CVrosj4U90LZU4YEl6hJi+QRrlGarAF2MnoEfZR+zTLMHBCqQkB1SiZoynT2h8mQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIiLncIVDBlCMZkb3URyCodI1zBCxYtzgFuxGcoMPMHAah9GuFc
	fbe7YcL288delxSm3mLZs+FP9aRQRQFVut2O/iiDvfWxOOVx7kMwDs3dalSmk3HJyA==
X-Gm-Gg: AYBFou3MyFUeB1P2EXTvg54ElkoDB+//f7n3Jc3FzwDJ9wkNQBgo53KX3f3N7PpjKRo
	pYifWWxSWMZHs/kWbvrdK1aCGBsl2wy+F5OITlxHYR4B4BbqZGwiOV5QJKBXD3iBXBiA635ECxt
	dYqdILsRtxp7pPdoaLmrfBXZzgDCkP3mC5C8O0UigCSdSuMW4ylGfibJIrQt7URUrVSe4eVHX9I
	3g7Mas9bc55w3Rm/PWbY/pa7Am81CDrb0JEwH3YEcJY438uzZYQbYxsLdzVB0ui18kUvnrmsm4v
	JSb5FgQACP0ELPc41xAfF/Ii5l0IL3LKeOlIFwZAVMjbKE07LSb72WLqxgndJmealqygzd9cEms
	YhsFmz8zf+PYPmPEZxGntOzTBduaaHR9BVPf6LVsfZfKi5cvHPWpf3ayLWdYqIoUimK9crnOyF2
	k8LYPk5yIEb4ngKyWrGoXAGCpfUXxltitAmHpcULfJcDCXh5YAJMLkqKaFZniaVLWKFd3Gbbnx5
	raXgnNpMDMPihRkEsoSvmcBHFrKahcJ1GSt2cLN07c109a6uZF0HfyyEcEHqA==
X-Received: by 2002:a05:6a00:1a8d:b0:86f:394c:5c68 with SMTP id d2e1a72fcca58-897c7010529mr9961975b3a.13.1791863558349;
        Mon, 12 Oct 2026 20:52:38 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 11/11] zram: use a singleton compression context for recompression
Date: Tue, 13 Oct 2026 12:50:58 +0900
Message-ID: <20261013035201.2809924-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
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
instead of per-CPU streams, which saves N - 1 compression contexts
and 2 * PAGE_SIZE buffers.

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
index da122bf4dd15..39d1f9384939 100644
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
 
@@ -274,22 +279,25 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
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
 
@@ -302,10 +310,12 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
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
@@ -315,7 +325,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
+static int zcomp_init(struct zcomp *comp, struct zcomp_params *params,
+		      bool recomp)
 {
 	int ret, cpu;
 
@@ -324,10 +335,28 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
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
@@ -339,7 +368,6 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	for_each_possible_cpu(cpu) {
 		struct zcomp_dstrm *zstrm = per_cpu_ptr(comp->dstream, cpu);
 
-		mutex_init(&per_cpu_ptr(comp->cstream, cpu)->lock);
 		init_rwsem(&zstrm->lock);
 		mutex_init(&zstrm->excl_lock);
 	}
@@ -351,6 +379,10 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	return 0;
 
 cleanup:
+	if (comp->recomp_cstream) {
+		zcomp_cstrm_free(comp, comp->recomp_cstream);
+		kfree(comp->recomp_cstream);
+	}
 	comp->ops->release_params(comp->params);
 	free_percpu(comp->dstream);
 	free_percpu(comp->cstream);
@@ -360,13 +392,18 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
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
@@ -389,7 +426,7 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = zcomp_init(comp, params);
+	error = zcomp_init(comp, params, recomp);
 	if (error) {
 		kfree(comp);
 		return ERR_PTR(error);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index bf41b27958c4..924c4185abe9 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -39,7 +39,8 @@ struct zcomp_params {
 /*
  * Run-time driver context - scratch buffers, etc. It is modified during
  * request execution (compression/decompression), cannot be shared, so
- * it's in per-CPU area.
+ * it's in per-CPU area (except for recompression, which uses a single
+ * per-device compression stream).
  */
 struct zcomp_ctx {
 	void *context;
@@ -94,8 +95,9 @@ struct zcomp_ops {
 
 /* dynamic per-device compression frontend */
 struct zcomp {
-	struct zcomp_cstrm __percpu *cstream;
 	struct zcomp_dstrm __percpu *dstream;
+	struct zcomp_cstrm __percpu *cstream;
+	struct zcomp_cstrm *recomp_cstream;
 	const struct zcomp_ops *ops;
 	struct zcomp_params *params;
 	struct hlist_node node;
@@ -106,7 +108,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf, ssize_t at);
 const char *zcomp_lookup_backend_name(const char *comp);
 
-struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
+struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params,
+			   bool recomp);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a34859ff0461..ad244624d4a5 100644
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
2.56.0.385.gd3acb90ef8-goog

