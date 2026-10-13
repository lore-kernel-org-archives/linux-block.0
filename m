Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87A47F3CF
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863542; cv=none; b=WLaBzM1M4eJ5+snWL6GgbSj22gzcUvHvywc/viR+3vHVV3w+JRlXumoZ5kbpgTNaJXZMw9r4hgW94JQK9tUj/UO2PIOdgLPpWcUttF4j+0//6BSarovQukFNfc0C35q9kxiqWUTJzMq15IpVskVahA+ftXqC6TeUhWjra4IBL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863542; c=relaxed/simple;
	bh=ht0tf3GrkoJb7bJOWHKnFQtgQ+++VueB10f0Y6JzUEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPE+9t2XC1PZT+BqrG96gZ6cMhsQ+8qZSb2LMdnVV1EH15XGZcy8bOYhmLi34QclNBflCeG4wz9yeaDAByAV4TDP6TetNIWFGpXzJXMtruD2AqIWEL2u2FsEN8K9SR1KTrnJ62s8w6rjedg+OwBVQkjwnp/0XxOHo3uC7yxRHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cYl1Z/bl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cYl1Z/bl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-88a627ce016so686559b3a.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863540; x=1792468340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYDIjpQnxgkFqNZQW2yn2pS6XpW/Xbtk8d0QrpCAmj8=;
        b=cYl1Z/bl5gOolk/YY4PBoKzyk/QzkS+MsQsvWMhq1OohvhwtbpP6fUSZfBYga5+3V6
         p7TloqgikOQqOtMzby+TKs/i0R6vkKoTdNOWUDWR2ecXuDa+tIUGN0/yWzQpCp3vjdu9
         3GiCrLSHRM8XCp/0OC+7tQkpZCrii2ydp7mCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863540; x=1792468340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYDIjpQnxgkFqNZQW2yn2pS6XpW/Xbtk8d0QrpCAmj8=;
        b=aO/TCmYdPR7IpdM4bd9AMq5cgbE07INi1qh0yoEGx26z6hnOLmnxp0zjgwQprnkwNi
         gz6+/S+dO6Xv0KsDzKE4us87cAHT7UgUHmK7R3FNLC5BfDUSvE9JVx0i9Ea2/QfEryQl
         vkZvTOjdaAOMnvz5IqIiMBpkaf5N3Pklc1EZgSWz0pWpICACh1Gxgs/I59nip7zbHfrD
         X4UQwIY7uiQIqJns6llSfNHnikdJ9HlHpZ2nvjM7sCbJKCZMdOHAweImd69/bbHU+oQf
         mtb1egl8yCdj4Zn/Wa67uPXd0grsAI1wDv4Xqy5alRhcfqbFGusS70Gq0c27Ji/v3HYe
         QuBg==
X-Forwarded-Encrypted: i=1; AKwUvBysEIHLClt6+eSY92PBBAkhxTTGCP5qanRjRTYtXp4hSIWhGexvs8IIJZLmuEZ3vws6Jzill6bCLdd7lA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKVQbiJ+IQVxhT0xtg4poBuzkk0wZia5u2qPHnxUiTOolWNUWWx
	mu/rNqYWesTvxClN/oahQ4soTFWsVFo7q38Cpo8NEyChAfPuu0I1nkE1atHgjQS4dQ==
X-Gm-Gg: AYBFou0V5JsIYDS5kUNMXJmn9j3W2LVbLWCCW27na0zI+gc+yGcw4KieTZqFMwcAi93
	D2EoyUCbe0laY2Usz1upHoxNRq54kx6nO8oQ4TbVuk9c7J/rGEqjhi6EGeribeZe6fUJbsTTWma
	JMbeUCetLVjTCIWskX1LZEhvzH6yC+J5xdqE94+nxzC0Y3bk4dt4MT37UEeQPCKuhLEk72+LoKv
	mY1hhqQUsBJ4ZelJko6HduVDPM7wudbkiw35Hn3cjy6WLMrR/YaA4ZmPf4UsqFVQwE4K9J4v2i0
	FEDar3qEJeaogzgsAymk5JXeEH48KToXqFr/K7KB3Iy9PXj2J7V0Qy3nUAOQc624LC9xelJJBrJ
	5RyHYz/a9hHMD5bAfiaLLEQ5jR69vWpjFVL/WUZf+jEABY4xqVZSnJy9Phq8KRUhnnd6zh+yUEe
	oS+CkTq545Qs7hQufhVbnIUJ25XutBT0rtfufWRwVet9NuVIEy/hIiQgDRKyX3qD1Nb2XBA6eCj
	Yd4Edic8CAEFW6ncjKx6tP3N/kmaO3BY7fW3dBZnfaW7A3nKnOkD/uwTaTFkQ==
X-Received: by 2002:a05:6a00:1803:b0:881:ac65:715c with SMTP id d2e1a72fcca58-897c653b391mr9755218b3a.10.1791863540508;
        Mon, 12 Oct 2026 20:52:20 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 04/11] zram: lz4hc: pre-initialize dictionary stream in setup_params
Date: Tue, 13 Oct 2026 12:50:51 +0900
Message-ID: <20261013035201.2809924-5-senozhatsky@chromium.org>
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

Pre-initialize the dictionary stream once in lz4hc_setup_params(), store
it in params->drv_data, and memcpy() it into the per-CPU stream before
LZ4_compress_HC_continue(), matching backend_lz4.  This avoids resetting
and hashing the dictionary on every page compression.

This also rejects dictionaries larger than 64 KB at device init time
(matching backend_lz4), instead of failing every page compression with
-EINVAL.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 31 +++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 5c009835a684..f3656c27af21 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -18,10 +18,20 @@ struct lz4hc_ctx {
 
 static void lz4hc_release_params(struct zcomp_params *params)
 {
+	LZ4_streamHC_t *dict_stream = params->drv_data;
+
+	params->drv_data = NULL;
+	if (!dict_stream)
+		return;
+
+	vfree(dict_stream);
 }
 
 static int lz4hc_setup_params(struct zcomp_params *params)
 {
+	LZ4_streamHC_t *dict_stream;
+	int ret;
+
 	if (params->level == ZCOMP_PARAM_NOT_SET) {
 		params->level = LZ4HC_DEFAULT_CLEVEL;
 	} else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
@@ -35,6 +45,21 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 		return -EINVAL;
 	}
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
+	dict_stream = vzalloc(sizeof(*dict_stream));
+	if (!dict_stream)
+		return -ENOMEM;
+
+	LZ4_resetStreamHC(dict_stream, params->level);
+	ret = LZ4_loadDictHC(dict_stream, params->dict, params->dict_sz);
+	if (ret != params->dict_sz) {
+		vfree(dict_stream);
+		return -EINVAL;
+	}
+	params->drv_data = dict_stream;
+
 	return 0;
 }
 
@@ -93,11 +118,7 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 				      zctx->mem);
 	} else {
 		/* Cstrm needs to be reset */
-		LZ4_resetStreamHC(zctx->cstrm, params->level);
-		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
-				     params->dict_sz);
-		if (ret != params->dict_sz)
-			return -EINVAL;
+		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
 		ret = LZ4_compress_HC_continue(zctx->cstrm, req->src, req->dst,
 					       req->src_len, req->dst_len);
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

