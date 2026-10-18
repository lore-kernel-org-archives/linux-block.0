Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74DB2C237C
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295511; cv=none; b=PUU7S8CwuCSye12HW8My0qtLAZzSFLTfcGTLN649p2SBesZ1Rr/uOTA9a6eEeknrdJ4fSCT6vRuwhO6M4yd9ViXo4vqLkApdKtga1cJs5ocyHxXMnZ9hg3ognZKkRTTOxT3CGAeCJxepDsEMfVwINqGRE0iSpCg/R19P6tLRcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295511; c=relaxed/simple;
	bh=PUxxPD1wuEBxM5xa6ka6AAqGMT/BH6aQ0O/i7rf9wr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyH/P1/SqET7Nl8Vd3exHSdxGCXgKdU/frStFu3eUSMia8EvtYwNgTpmwYdDChnxO2x9plHejh0zCaVtqVO/1tLPDrU0YMPQKwaYaiINEOQVL0Hz/XwU/V+dQ171yVMJjmZO7MmO4uaD3yfJUuBdDpI5PvoQeX7Br11kGnxDNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P3QkOk2N; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3QkOk2N"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1430776a91.1
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295509; x=1792900309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtS1/0M01UFrLXwpgPFi8UFASC0cpcznpCMgk29ij1I=;
        b=P3QkOk2N1lD63bxT2xSk4iO1hPIRIf779xXh1NC644KCYj7ZBgXZ0TqlkpLEtgC0QC
         nXUcEFJl6/PaHUERs4hLncLui0bw0KchYO71T4kXygt14/kEKtd+fJ+3qW/C2szupDXJ
         eT/QL8zKUzfoTl3SJ6YFDDSWNU9n0RPOT5gIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295509; x=1792900309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtS1/0M01UFrLXwpgPFi8UFASC0cpcznpCMgk29ij1I=;
        b=fbhMV40nGqjGrDgeA4Zx+19LmCmE2WnlDgX1prlw4OBwoXZnSevaPiwOizDlB3gd10
         GlwLDPWZh+a4AbnZMuL9qTCHNECrc/KhE2Z0QrNhETT0LsMRkLfcrAf0EIDbA3qvKQva
         k0E++ooHS4pblur3LuI7yt6QuREnjJs4I8ki/S8UnMeqUXO0vSRyDpcIQ/gVqEK6JqWM
         PaEfUIakplJPVOXEeyhyVuZO06kbHe7XGbG0bRATp9KGaVvJXyVKWGRStO8IJs/8miY1
         fjGbFTxs1mqCZTNdhVZWFdDAlZwAkOqCbCSIydFmXbCpNvTV1Pu/e7cN+OJiTZI+7yJc
         58aQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLLcHkQkYpDjVNDSEIrYGdFOtpyVdGW/9IsyRmQiLbfrWB7dhqwFmx0tKiLpp1uPebROIAAcbEptz4ZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKse/P2UqmoYTHACR6zJQVwKJ1/XvBEFlh/EonjryRkwXaGMZeV
	19j6PK5p2/On2TmNeg43JLHFcGP4cUCAAy7M7IUTw6LgJZOc623r+EPaHfjWhfd87Q==
X-Gm-Gg: AYBFou0kuOUmcKJ2RnKJL5qHI1T6guZ2mL+bOwMpY8FDkEgjfvo5EsIJ1C2+xaWii8P
	X8mxlKSruYavTN0E3Rxo6thL/g/6g2sO5ocPEEpoY/N6FU0NGCkjCvWsjIujTlMrJoZvPKSaOR1
	rYtVIIL3h35udtrj0J8GJ00rfsV4YOq+gXDE336S+gG7V+DJomoozNJofPVeqa3XoYf3TcSzfxe
	DT+nVa8HpwSX1fCRpXaR/lbaXkfmhd13BFPJDmm2EFsIqOL9McoEsXEuDT3UzkGLTlUq5z1GzfY
	pvHR4AisqEHz9SRzm0CetZ3bmi/HTXH4kto0zisS4O4afOtayBRjpij6CQsoGnLYbD+1ImblQni
	LhZbiBSo8qKWfdsBYM1k0Gq0UCeDOufLSc3/4fo/IBnRyt1Ar0WDza5BmkmqrEKDgNvNqujCXCL
	zbrafs6qRbONauFE/E2/Cxv2C4mknUSDVwEMY3lW09tzI8l5G9jafIuL29MmL8QR646O/QmZgpm
	GSFb9pFajZJ98V58M0Bm0X6SteuGIhTsAw4OpbULoAWUy4loRyo+3PWpzrNNwI=
X-Received: by 2002:a17:90b:4406:b0:3a0:295e:6e61 with SMTP id 98e67ed59e1d1-3aceefbf3c8mr2482928a91.12.1792295509334;
        Sat, 17 Oct 2026 20:51:49 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:51:47 -0700 (PDT)
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
Subject: [PATCH v5 04/13] zram: lz4hc: pre-initialize dictionary stream in setup_params
Date: Sun, 18 Oct 2026 12:51:06 +0900
Message-ID: <20261018035125.3120704-5-senozhatsky@chromium.org>
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
2.56.0.176.g3575e65682-goog

