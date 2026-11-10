Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289729;
	b=nbQ9R6siZ0/jr7ylOBFMFkpEWqBzIcMWCCtwujbIrVug4R0maLtf+OozgB3cGBObCN7M
	 byi799Dkg4iaytgOk6YaMWLEQ5K35/Li2rUwcZtx7NNKU2sXdfpIQW/Q7ihga7ZDCcmeo
	 IboWRLPEC1sgtR2VdXQQwzXmTohnK3fioj4C/eQ9lR31PUkKikBgYJ5URX+M1a/g5bliW
	 0qzkxZAZEvd3rOVdihI42S62qqPMPcfMTYy4j9fqWjve8M3BhwfNIrfNTwE7LGoW8ec3Z
	 81OMvVAWYdQtL6S1xCbHv0sWk1m5mqZvlU0VJHWyI0OU+d3/0yYg+WOcn3Z5J8ufw7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=95H+FB1wx8Ke6Q9IRtMFfh2ammpGvU9RDrZEDD8q16o=;
	b=Jp6HB8OgB1yZXK2CwMSMMIutXb1jEnLd5yy8hY4hCD+Z/yCSlB5QxiwRu+sUbTBazonO
	 NL8MqOk/ehLl5jkipO7Bq3xMiddRvAac/ye4pdo2Fp8t/EEAoF1zPdjqO3+RjiwSHPEBQ
	 RFk8VVwr10dZJ+jHvgN1MhWwRHVKadFKNjlN6HFIUsz47YGIb7ZqgElVCdYEY+N2h5smj
	 H1coo2SGuLXYZ2WHBow5vEc2P8TsQJupsczvNLVFi7Ah+qCDDmtBCCS3lByPbSkE1OocE
	 CTVcref0qIajRG01oM0oMt8G5rLNJgFhCk9gw3aIXi7hd9hcKVk7S+mihfy5WD1kRQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V7MpvIUx;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54946606A325
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54946606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V7MpvIUx
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso845502a12.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289729; x=1794894529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95H+FB1wx8Ke6Q9IRtMFfh2ammpGvU9RDrZEDD8q16o=;
        b=V7MpvIUxCQm8/ZpQmxbWvqfDn2XVhBpp1GBCGmluIw5Y/yhofzE0jk7TZiNVsgb6fM
         e1WdvCfztegeMS3J6EEBON6XIfe8Y6lqjCfFYSEfisvKzhi7hNzVRQKVhnJ6hg1qeLb+
         l1hX7Yo4ayHaePJe5uJGmWO1G/ywod5/svwOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289729; x=1794894529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95H+FB1wx8Ke6Q9IRtMFfh2ammpGvU9RDrZEDD8q16o=;
        b=04vRuz7UK3ihhMX7bw175kTXfEVNHUftN1+RNAwvMipSXCyOufFEqtdIlDVYLRhCdS
         c8JYYbPGbSirMfGTb+BItlUxASH+uDL+lTQDNToeGNqHJ2brQmyfMxzEcZ2VXwsfxxF2
         fZt4WA0XAjpLVbcj15EnK8pbRpbHOrZdPCQ6+7AkLy+IMjcjseH7poiVkB22uyfQpyxp
         3R/h4mSs6KPGOqE6P6zOJwHUDryCFEnTrWEOCDBu+UknzhhgAr0GS5fDFFK7SCwW3Ozz
         +okbHdnJiDubqFqwQlWexGfw9HH2ccfNDOzN5aNUh/jT7EPq5mhX6yAiKPqdDOyB+yuo
         E4YQ==
X-Forwarded-Encrypted: i=1; AL+hErHQ6OwGLFqSxTqZRzKi3o+0KMXaVWpGasgnjO9G/BAR+QWixS8lo8caEuY+cVGDTPHt62OruJUv9JCrwA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vcMFM8a6J+LlGrmb+guHBxpnwndshQcrEzcODXHET1bGHT16x
	K4JGQaWJscfBAkCX/Igb3YODD/7eb5PyBLGb5k9Bxlieohbg6I/L3NcaAIJ4ow5iAw==
X-Gm-Gg: AYBFou2BiTHG9QHsvwWigB2IfoLuVKv8PNv+shTx5uv/x/05xH7HitVbuETpJ4YpQMP
	iKYJg+rm2aYhhf0JcGhQ/6E64+rvOWxfmm+gpn0PtewLSadQk0gFrev5GxZr/QwfvuwQEwjMmMa
	+HLS7CZD8ILRHB6i8AE+htFChHXVhX6TPkwZniVzXoqd3uokYyQwWklL3Pgmg1sEaY6u2j7DbIw
	c/Ue4by/YvPzvLcZD9YSoRvljUlOUsjV5sGJjgDFQQIDkW62DCOQ5jnF9fmkTVNXnMvarKwrZgJ
	XKt2wwSGFCcEyhlsNgrniVDm+tJq3mytkLAkXU7IAM8Qit7KED52LnWbkvk3ZDnj/qdDZ8jQnsq
	2iwliE73FoQIiq3/mPk6JHH9lPNU6mW2PQzvMrN2Zs+xSc2zd8DDqwUQ+8TKsghgjrmAHa+/l8L
	+8E/akNF2OdrZax9Wq8NsPgNE+QUhs/mOLAqCUsqbTvBhZAxVPC/ZyHZppEdeSD4snlXZcYghLq
	ZeKb1AhexasKY6am8SwGBRP3rWdj8RFCNTcslqwqsUf6zloVE0L6VebDdIhgeymrSuTp0jQCa+1
	5MsVNaexoDEUB2KQBHVqI9aN/+LsmIwr9DlgJeKrGGEY9g/ycXhGiZrKOAVMbjGLBXu250EKbqu
	+SAKIYNvTxaw1w/eDTFE=
X-Received: by 2002:a05:6a21:68b:b0:3e2:21c0:3dfa with SMTP id adf61e73a8af0-3f19058a5d9mr1355701637.66.1794289728711;
        Mon, 09 Nov 2026 21:48:48 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:48:48 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 01/11] zram: drop stale comment in write_incompressible_page()
Date: Tue, 10 Nov 2026 14:48:06 +0900
Message-ID: <20261110054836.1515030-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram doesn't do fast/slow-path handle allocation anymore, so
the comment in write_incompressible_page() is stale.  Drop it.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 632045b65bdb..380615b73446 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2271,11 +2271,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	unsigned long handle;
 	void *src;
 
-	/*
-	 * This function is called from preemptible context so we don't need
-	 * to do optimistic and fallback to pessimistic handle allocation,
-	 * like we do for compressible pages.
-	 */
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-- 
2.56.0.506.g506a7eabc5-goog

