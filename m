Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44153B9D93
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218622; cv=none; b=HnMlgdco/rZsJG/3EPNIuTGoiipMbDvMleZmLCveZgysQuk87uY7Y7Z11/bcl7vml7Ikt1RLi7hxJvc0ncI5+0G8HgKvTDkOUCiDkRy/vuwtP/KRkGY4mkh4eeahAPx71PI316e5dWQlgxJHYQHDEwTMFmSEWjMe53qdCyL7lGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218622; c=relaxed/simple;
	bh=EULpBClfsFSIbBOZvrrYphqf1B7AmoonrHQdK4PsPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0TcQpf2rYVpDEAhfMouq4a7ekE/uzq59k2BuMtMM4FIFgSzJcFqbo/T0Uh6wVIdsK+jHfYlMOwGgC4O6Ua6rZ/f16cTcaUHzksMqTsjP1vtAji+SvmGH0ftsm2nhrqThtXeU8Q+UUC4LJXe4ntXt98XNb90kcs8zl4HOBeiFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LCAwzg6R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCAwzg6R"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adbfab4501so62426705ad.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218620; x=1773823420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gbLLG6edQ0IM8f9elrHyPvt9TZ4LSyReKqdPmz9Fwc=;
        b=LCAwzg6RNdqOwUDgRM0adD82dOmgNIJWqe2JxTTz4Ysi4WOb6Oj4q8Sz0DZ3hVeHSp
         X6QqDeBqqyMu4sjIqNXQWMbCzfEjBxkNJFEMQ1CK58a5UIis7dBaXgoByP+tMaD8ma0s
         YetyxLfjZqAOfiIZAc9zcHRDhz82WjfDxP3a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218620; x=1773823420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gbLLG6edQ0IM8f9elrHyPvt9TZ4LSyReKqdPmz9Fwc=;
        b=e4c2Cy/JOKITpkjixVd4YmipfAjUKf6lAWLES+rrCr3bvBuo578bnO5/mVgiNiZL0E
         SKZvRQP64Qus3CAq5lTvKxgTjZSgc9B2v5UxRVERpSq0bcUy44VI25vk1j2+3ABTIkUp
         Hvi5PvnvuV3RsQjshp4FjkXbOYBW5lPgrlUNdjZTjIrEos1Dzy9wsnzGI2E4IdGQLo2L
         9wV3pMfL2YNMzG4gOZZ5WCXs61xnsO8vw6crjulR7qmbxAHXqkZakCPoTCjNXtk9r3Qz
         eHM2A80x1mI+rr0Bq+hlZdmWQwkffPo9c+ZxvYNSSsnwOaAJiEPuWHPAMxAKXgDNYoU4
         gsbg==
X-Forwarded-Encrypted: i=1; AJvYcCXBNdTH5pigR1B7gKM5gQPKe20cimJK0ddy+VS+Axt6zMN6xYqoPsT70U870R+kxnt0p3ZkOh7XflrB2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YynjWDTbTsYOCNaJXhHwVFr/uKLIIEKXk69HNhHAzf6hi4PTNvu
	ZL8VYsjy/YEktMVuKfRqjmilVR44FnqJs787nsHKuwa6Z8itPjQP8j1dD/idjV0XVQ==
X-Gm-Gg: ATEYQzzEp9dRwNUoqJFNpDWVMkIQec9ZE1Ri6fdgOtoZuzgxAgfbu4d83XTTjhphGjb
	gcXf34ldzHRKWPAqY1hEd7huJDizh6repEkCHglcUYusYt9ZCSwi6jH3jlnCi6MVVHZCvXSftGo
	O/B+jVoO8VqkO/LXfIOCizX9JPtbEn3Sylne9g+Jyo803DEiTBKFMChgfciK+rF+DSuuQwcJkD9
	YxyeUub3eNBLxccRFG6wqE7mBrjo8k9wmGn6AceLe1UDA6cEtPoVhvPGmDQgecwhyUk0FU5UHEA
	Za1jMGeoy1zwNervBGUWolHcXh6b0h0ZxfxlURcSHhyAE0dBy5g4J6nXx7Yud/LSOKwuvT+37EV
	X7aPOT6IqXrxtJindmfNjsU6UPa8fsoHbUkI8Fxwicr9WV0HtpNYLLvSnU5Yt+iB6kKU259+gSW
	XkKaYVydVeCXehzZ8sIOQvFvajnhLpn2PXa4soG1WhDL94BdCEiUDe+MssmAxCWqOe7jXcDwflk
	M0HmZKPESz4RA==
X-Received: by 2002:a17:903:2288:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2aeae95b193mr19030295ad.55.1773218620088;
        Wed, 11 Mar 2026 01:43:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 6/6] zram: unify and harden algo/priority params handling
Date: Wed, 11 Mar 2026 17:42:49 +0900
Message-ID: <20260311084312.1766036-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311084312.1766036-1-senozhatsky@chromium.org>
References: <20260311084312.1766036-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have two functions that accept algo= and priority=
params - algorithm_params_store() and recompress_store().
This patch unifies and hardens handling of those
parameters.

There are 4 possible cases:

- only priority= provided [recommended]
  We need to verify that provided priority value is
  within permitted range for each particular function.

- both algo= and priority= provided
  We cannot prioritize one over another.  All we should
  do is to verify that zram is configured in the way
  that user-space expects it to be.  Namely that zram
  indeed has compressor algo= setup at given priority=.

- only algo= provided [not recommended]
  We should lookup priority in compressors list.

- none provided [not recommended]
  Just use function's defaults.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 106 +++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 40 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 02fb70f35ae8..676b1602d817 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1635,6 +1635,37 @@ static void zram_debugfs_register(struct zram *zram) {};
 static void zram_debugfs_unregister(struct zram *zram) {};
 #endif
 
+/* Only algo parameter given, lookup by algo name */
+static int lookup_algo_priority(struct zram *zram, const char *algo,
+				u32 min_prio)
+{
+	s32 prio;
+
+	for (prio = min_prio; prio < ZRAM_MAX_COMPS; prio++) {
+		if (!zram->comp_algs[prio])
+			continue;
+
+		if (!strcmp(zram->comp_algs[prio], algo))
+			return prio;
+	}
+
+	return -EINVAL;
+}
+
+/* Both algo and priority parameters given, validate them */
+static int validate_algo_priority(struct zram *zram, const char *algo, u32 prio)
+{
+	if (prio >= ZRAM_MAX_COMPS)
+		return -EINVAL;
+	/* No algo at given priority */
+	if (!zram->comp_algs[prio])
+		return -EINVAL;
+	/* A different algo at given priority */
+	if (strcmp(zram->comp_algs[prio], algo))
+		return -EINVAL;
+	return 0;
+}
+
 static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 {
 	zram->comp_algs[prio] = alg;
@@ -1707,6 +1738,7 @@ static ssize_t algorithm_params_store(struct device *dev,
 	char *args, *param, *val, *algo = NULL, *dict_path = NULL;
 	struct deflate_params deflate_params;
 	struct zram *zram = dev_to_zram(dev);
+	bool prio_param = false;
 	int ret;
 
 	deflate_params.winbits = ZCOMP_PARAM_NOT_SET;
@@ -1719,6 +1751,7 @@ static ssize_t algorithm_params_store(struct device *dev,
 			return -EINVAL;
 
 		if (!strcmp(param, "priority")) {
+			prio_param = true;
 			ret = kstrtoint(val, 10, &prio);
 			if (ret)
 				return ret;
@@ -1754,24 +1787,22 @@ static ssize_t algorithm_params_store(struct device *dev,
 	if (init_done(zram))
 		return -EBUSY;
 
-	/* Lookup priority by algorithm name */
-	if (algo) {
-		s32 p;
-
-		prio = -EINVAL;
-		for (p = ZRAM_PRIMARY_COMP; p < ZRAM_MAX_COMPS; p++) {
-			if (!zram->comp_algs[p])
-				continue;
+	if (prio_param) {
+		if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
+			return -EINVAL;
+	}
 
-			if (!strcmp(zram->comp_algs[p], algo)) {
-				prio = p;
-				break;
-			}
-		}
+	if (algo && prio_param) {
+		ret = validate_algo_priority(zram, algo, prio);
+		if (ret)
+			return ret;
 	}
 
-	if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
-		return -EINVAL;
+	if (algo && !prio_param) {
+		prio = lookup_algo_priority(zram, algo, ZRAM_PRIMARY_COMP);
+		if (prio < 0)
+			return -EINVAL;
+	}
 
 	ret = comp_params_store(zram, prio, level, dict_path, &deflate_params);
 	return ret ? ret : len;
@@ -2407,9 +2438,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	void *src;
 	int ret = 0;
 
-	if (!zram->comps[prio])
-		return -EINVAL;
-
 	handle_old = get_slot_handle(zram, index);
 	if (!handle_old)
 		return -EINVAL;
@@ -2511,10 +2539,11 @@ static ssize_t recompress_store(struct device *dev,
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
 	struct zram_pp_ctl *ctl = NULL;
-	u32 prio = ZRAM_SECONDARY_COMP;
-	struct zram_pp_slot *pps;
+	s32 prio = ZRAM_SECONDARY_COMP;
 	u32 mode = 0, threshold = 0;
+	struct zram_pp_slot *pps;
 	struct page *page = NULL;
+	bool prio_param = false;
 	ssize_t ret;
 
 	args = skip_spaces(buf);
@@ -2562,7 +2591,8 @@ static ssize_t recompress_store(struct device *dev,
 		}
 
 		if (!strcmp(param, "priority")) {
-			ret = kstrtouint(val, 10, &prio);
+			prio_param = true;
+			ret = kstrtoint(val, 10, &prio);
 			if (ret)
 				return ret;
 			continue;
@@ -2576,30 +2606,26 @@ static ssize_t recompress_store(struct device *dev,
 	if (!init_done(zram))
 		return -EINVAL;
 
-	if (algo) {
-		bool found = false;
-
-		for (; prio < ZRAM_MAX_COMPS; prio++) {
-			if (!zram->comp_algs[prio])
-				continue;
-
-			if (!strcmp(zram->comp_algs[prio], algo)) {
-				found = true;
-				break;
-			}
-		}
+	if (prio_param) {
+		if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
+			return -EINVAL;
+	}
 
-		if (!found) {
-			ret = -EINVAL;
-			goto out;
-		}
+	if (algo && prio_param) {
+		ret = validate_algo_priority(zram, algo, prio);
+		if (ret)
+			return ret;
 	}
 
-	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS) {
-		ret = -EINVAL;
-		goto out;
+	if (algo && !prio_param) {
+		prio = lookup_algo_priority(zram, algo, ZRAM_SECONDARY_COMP);
+		if (prio < 0)
+			return -EINVAL;
 	}
 
+	if (!zram->comps[prio])
+		return -EINVAL;
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.53.0.473.g4a7958ca14-goog

