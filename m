Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5C1DDC14
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227988; cv=none; b=GUrXYTgmMPn0m1k2S7HvubD4tfbYVlS+1QY8JAnM77HIqPdtK7V8ZYqWPqNxcZ4SLj6DcI6gus0ttMEzpgRRfCZtfCs5Vi92g+kcGpWhSg2Mw59XQMnYRu3c9A2DnLg+bBArqFACznz/F1ZCn0igJCjqpVPS2CAO65gU5qIUXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227988; c=relaxed/simple;
	bh=n9Imun7lFdzH3n76Y/xW6eOk4MzmS6i8pe2+V22yAWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJRhfBMusguNfH+xjH7Hss/C+ZVk7hnzQ/q4gO2XIZI8SJu79cBG4I0GfCHAFt2x0toESoNiXkWazHrnu200PKMxZYTcgTU7an3SIuYE13pNtoXP5MmftRtoKRWo11WzIUoVvdgL8IT0UH3/cal5rqgxxEk+4aUYkQpFXuxwqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa7scZAJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa7scZAJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21288d3b387so11422395ad.1
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732227985; x=1732832785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnUtikKG6kYaTFvoCtF8la8TvUYmRutVMcxq2kAfDzs=;
        b=Wa7scZAJpNYRElA1e3jjDUJSDTsTHQzPRD1epciI2TAwI3Jya/pOPfm3Kk/S/NcGnk
         zD4J6MKeyqbNwyIN1aZt/ykHV1g69nc1oSMvU9fYqtErh7eG5cqGbtl3iL4bNga6UQ3m
         RhRCzNzbzuj1ciTTK07r2fWxbLMLEbTqDfYJhM/350P0KGnFOehsPMHhy8QV5r7uumcu
         +vCxNGnRp363W1P9JMGfw9lUenfjZI7v/LMY2EUjA9/vSTvuVtUMYQ3Bv0rFmVJ3uID4
         V78Xhny0rMs+i8ZW/K9pcg9/zuNUU0Oiu2RUWm06T48P1XUwdi9GN4XaXakOoKMsHz7V
         c9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227985; x=1732832785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnUtikKG6kYaTFvoCtF8la8TvUYmRutVMcxq2kAfDzs=;
        b=CxVWI9BY6expvXp4tzV+w/PTrvNpVCk3upEUIhWCxbGgV1mWYYALQLwQeaNH5ekm0j
         T0AKzcBrlZfdwkwrJjPHfWaltU02V3mbJ6d2FHpPxI2Zvne//TiZnJp7WLaQERfFUeez
         bZhiHde7oY4NLJSo48KM0BZ0t0YcXGe2P+rf7Qu6sk4DPyp8g9p5Lwc+Khobu5UwBPXY
         mYEGfIPCBSjbUSLTxq7IWdnHzJjpOfJZYcTVPgPmd1WudlDpEVdzLPC7ZOl/SL6Wapg4
         sjuobT63K535kR8gsuxz2mxIAQcsYfxg0qdykNMilTDF10SfZc36FeHrUPkYAwQfN1Ij
         7Edg==
X-Forwarded-Encrypted: i=1; AJvYcCWIWXVoxf2VhRG3YYkWWcH41bGjjeeoeHA2zGVZ5Bj5w977Bj61u3ve9a25QOBnVxJcdnCCAjm5ib5lng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaPktzzAXoEVerqT7uXmYxddVIG4opxPhiuWfrFfYm9YL3Udz
	gOFcCbiYarPJqIz7HLFKOjqkzHRpdlXhIUg+skOCuzXRwCHLCvuL
X-Gm-Gg: ASbGncs5KYRE2dk8hJ+9H1dZhZXbGT7+g4jt65F01HSbK70kJ3e/G2tPkSk0bveWofX
	oEA1x3uL7RJ7tAhPHhWyUnsXcx+oi+cCY2lPiLZZBNujTMsoR72M6FtLjBYorRHfu0dqlUPOZiH
	KzsQujRzH0Sdt5JJ9WeVQHO9q66qx4M/3e+zTfMKpL5TNu6FwGRRkVpYMcjvmtoUmytNiBuIL5O
	c/YcM6Q9yllDjEuxQU4XyDlllUoUf0nokkHl8GXrq3kkIZkqHc8dLehcuZG2DGFvcVPrY1q
X-Google-Smtp-Source: AGHT+IFYXTSN4Arskmw5br0QxBuvikrOLITGUKeWiVS90/P9GJacujBndu+rNI50ulwvEXnP/KRJnA==
X-Received: by 2002:a17:902:f646:b0:20c:b9ca:c12d with SMTP id d9443c01a7336-2129f6807d4mr7603135ad.38.1732227985525;
        Thu, 21 Nov 2024 14:26:25 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:9d64:b0ba:faf2:680e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba22f4sm3334745ad.100.2024.11.21.14.26.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Nov 2024 14:26:25 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: axboe@kernel.dk,
	bala.seshasayee@linux.intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	surenb@google.com,
	terrelln@fb.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	zhengtangquan@oppo.com,
	zhouchengming@bytedance.com
Subject: [PATCH RFC v3 3/4] zram: backend_zstd: Adjust estimated_src_size to accommodate multi-page compression
Date: Fri, 22 Nov 2024 11:25:20 +1300
Message-Id: <20241121222521.83458-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241121222521.83458-1-21cnbao@gmail.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

If we continue using PAGE_SIZE as the estimated_src_size, we won't
benefit from the reduced CPU usage and improved compression ratio
brought by larger block compression.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/block/zram/backend_zstd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..e126615eeff2 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -70,12 +70,12 @@ static int zstd_setup_params(struct zcomp_params *params)
 	if (params->level == ZCOMP_PARAM_NO_LEVEL)
 		params->level = zstd_default_clevel();
 
-	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
+	zp->cprm = zstd_get_params(params->level, ZCOMP_MULTI_PAGES_SIZE);
 
 	zp->custom_mem.customAlloc = zstd_custom_alloc;
 	zp->custom_mem.customFree = zstd_custom_free;
 
-	prm = zstd_get_cparams(params->level, PAGE_SIZE,
+	prm = zstd_get_cparams(params->level, ZCOMP_MULTI_PAGES_SIZE,
 			       params->dict_sz);
 
 	zp->cdict = zstd_create_cdict_byreference(params->dict,
@@ -137,7 +137,7 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 
 	ctx->context = zctx;
 	if (params->dict_sz == 0) {
-		prm = zstd_get_params(params->level, PAGE_SIZE);
+		prm = zstd_get_params(params->level, ZCOMP_MULTI_PAGES_SIZE);
 		sz = zstd_cctx_workspace_bound(&prm.cParams);
 		zctx->cctx_mem = vzalloc(sz);
 		if (!zctx->cctx_mem)
-- 
2.39.3 (Apple Git-146)

