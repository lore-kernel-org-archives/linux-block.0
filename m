Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA376F1
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154172; cv=none; b=K7X+m/BMch0IItMf2oUiQU5EAsEiRWpQqdTvlFKA6Hp4J9LUwLmWX1ZcPULD4NRHZK/2i76Z5A9nWYysKtglaVx+BXtSJNBJub+oaAMINEN5oHAyaACVqAwfstJFBPYGlb9LBvkPE4k7J7S2WID1kSoahLy0xdfO8IcXWNnokhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154172; c=relaxed/simple;
	bh=FRBhLTt/FHOdPdldPK2JgCScJh/quKT94FOX0NLvGcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHLp4Hz9KX8vZjmqd9DBKQrvyc3DWP+BmhDUUIMy+h7NvNwCb183fCOmWIAjvDxdAbO+o4RuT2K6shSZcL5o7WPzaD4Gu+Ll0kZnkHXD7HYgcvVloNCC5hqwFMqQH5/Lq0AR2UuT23EegUDHKIN6eXsF7HHYMySKBBM3WN7MWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dOkrMjQP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOkrMjQP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso2907147a91.1
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154170; x=1715758970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=dOkrMjQPC8GkW9WsZ44muU5Wiz9dpsk+y4Dgw0h2n72qVYBqPYmhjwTuIrjGH1cgzd
         bXskbXyx0IYZnpX9EdjSjlRNh72n5h2YRSwgLT+neCyo3AHj36Rvg9iAPtMJedIB2Mpd
         0yqVRrAnq/kb5Cgjm5g/9bsddHxLjNWoRmRXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154170; x=1715758970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=p/h7PhRKrSB2ol5gEpJzbVhMsX0IA69sNexwyFwuS1PsJ70fpmPnyu0665x3bxaSCx
         4djUyDjc3Gdjs1bcpoARcqOg/KYXSvrKJk5HjQJmVlY97Ae8jgQtd8pseA7JoCpm0tja
         +Sxwt4v1FsWm2uead6uMsHAuUxclovqxxO58gLoZB3ULQQpE6JoLqhssUlSaFaahzBtu
         MbAKNkjRk/o/X+j12ud2J2+T6SHbTp1u/DGnHDHumRQfv6P6cCe3bCQ6XkdPYWz/VOKM
         lN6iyxSLWorx8AMfUkdc5VcAYHIVAokhjzUC71geMF2hhuRcRgAr1/LKY6+Ax8kYJPy5
         3MMg==
X-Forwarded-Encrypted: i=1; AJvYcCVHuNUk6SdJcMhSWv2KOnVuYY/IHHt9BeLGuNZZDu7tIoS9QBibXweM3DhVLpYVWs1Gxi+sik5fXni5EMCPCy2CANKnJkyB2Uu1qI4=
X-Gm-Message-State: AOJu0Yy//kii8O0gbITN8ALhA0vitEqfaz5yjMZh2E0L2aaVTUAxjShx
	iC81w8bBy5LHrxU1vI2qe/ZOxum/sF+JzThvfPnvAvyzkwjREomuYCQf6Mp+Eg==
X-Google-Smtp-Source: AGHT+IHVhKTM2v7Uz/Aq4g+yImMIqtZc4Gvz8s0tsH6+Eo+knHPIcdNtEwPD2ijl/sCOPSx9VMynkw==
X-Received: by 2002:a17:90a:d781:b0:2b4:fcfd:780e with SMTP id 98e67ed59e1d1-2b616bf08b5mr1618670a91.49.1715154170221;
        Wed, 08 May 2024 00:42:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 06/19] zram: pass estimated src size hint to zstd
Date: Wed,  8 May 2024 16:41:59 +0900
Message-ID: <20240508074223.652784-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram works with PAGE_SIZE buffers, so we always know exact
size of the source buffer and hence can pass estimated_src_size
to zstd_get_params().

This hint on x86_64, for example, reduces the size of the work
memory buffer from 1303520 bytes down to 90080 bytes. Given that
compression streams are per-CPU that's quite some memory saving.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 4da49626f110..4a7734aa1a8a 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -35,7 +35,7 @@ static void *zstd_create(void)
 		return NULL;
 
 	ctx->level = ZSTD_defaultCLevel();
-	params = zstd_get_params(ctx->level, 0);
+	params = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&params.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
@@ -65,7 +65,7 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

