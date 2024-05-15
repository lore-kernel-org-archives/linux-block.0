Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742D56B79
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757433; cv=none; b=ddnO6sJwZWdlVBMXJbZMXNEQnF4ENkiZkY09mP2Zza7myt5w60whZo9VUu9KuMHZggDs9bZ4IyxQPmTHULKIxMcOdg7xedMN0ssazGfBLwTLRvocDF2vuQPkiefxvSRv7/8SuRBzfk05Uyc9t09dqpMeUvmqrlDHMa+wPriao74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757433; c=relaxed/simple;
	bh=NfNIjYe0R8m8g+PZ0SlYD1aU6GoRy1xQlpR4Iu21ap4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBFOjIOgPSkes+a5gROXPkEd7mi+7xJaZ/vaKfg98e2jb2KwhKBuXRMZfGFOgqJdLPfOmQ5i/gC6NcIIw8z/kUJ0dO/C5JHeREwga20yxO9PHG6K+ERKqBdcZnS04Us+qz3GQoU50/VVa7MxKtperBUWSmmamdaZ3cjoJh98Pso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CN5XvkMc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CN5XvkMc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f0537e39b3so37033765ad.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757431; x=1716362231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKysrwqZlMwVUU8fiuTWrWkRyKYxV6Zxfm3TNnO+6jg=;
        b=CN5XvkMcvsVZxxf/c50nuKiByew5wDs3YGQ6sG59SAfQ+WqRBaSSgVOkXyaA1t7TED
         rrvS5DwDzzubQ6VDyEvHG36glPUI//4McE/8PspWacnWMiQgSW2ZuEgj/O6CKZW+bg6/
         WE64SRs9ojutSPlsnVY5+y63jm0r3KUASLlXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757431; x=1716362231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKysrwqZlMwVUU8fiuTWrWkRyKYxV6Zxfm3TNnO+6jg=;
        b=Ac520WSDr4mjn/Tg7m7Yu/v8PPwfY09fse7xjjhaSHMv+a0DxrkA2XIAD198f7P4JF
         jG25monYNrAHXazsaHzOdbedjFcm3QAgHbC3qDlcvFl3Xi2aST9dWLoQ3EeaxhjJU7Xp
         yR4ZeGH28U1aZK5/AveVpYhqkk10y5gEgu7tidasNvH6u5V+z+W8DSUdfP66cL6uW3Mt
         91xUhY1LZn0yx2lTgjRsXixrOQBt2/3PnzWWnvmqqeflefQOfS62hto9+MqLjZkLAXpT
         5EHF2Brv8IjffyDKQ//UnmKMgJLSyW9DYIapIr7inWNkaiC0XNyiFRKHeE2PjHOF5WQG
         JWdA==
X-Forwarded-Encrypted: i=1; AJvYcCX6QiUHWnLjq0xskuZBAcq8pZUCVZVrmYtvI7S6QNXDTlJl0NUK9vj5pBxfCHf1R+jal8jZm3ytG65OGuJKd5cbmVsthPifmzPCg/w=
X-Gm-Message-State: AOJu0Yz8RQk5n6Vpes+crGU3p4DwZj3Hm3WcmM0ATb90Kg/yK1Iy15w3
	CXHaTF8lQFGUUS8eallE2ED2sbcCYoZinrRKxnwB6OxDdqbSVazdkai7iN7IQQ==
X-Google-Smtp-Source: AGHT+IGDnOeAF1FL804TtRjppmHScnFvlydpSaTIsnO+VLF+Nn6sN4yHuLdVS3qjMSH7/M91C1F0BQ==
X-Received: by 2002:a17:902:c145:b0:1ec:659c:95fb with SMTP id d9443c01a7336-1ef43e25e5cmr138560735ad.32.1715757431472;
        Wed, 15 May 2024 00:17:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:11 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 06/21] zram: pass estimated src size hint to zstd
Date: Wed, 15 May 2024 16:12:43 +0900
Message-ID: <20240515071645.1788128-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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
index bfe836844232..f930e9828be2 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -35,7 +35,7 @@ static void *zstd_create(void)
 		return NULL;
 
 	ctx->level = zstd_default_clevel();
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

