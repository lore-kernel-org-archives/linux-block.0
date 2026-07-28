Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EA41D4FD
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231003; cv=none; b=KSlNsajzclasoByokY4/68swU5mC3m/xsAvKCv63K/n43GXan7daXDhWxHLvqek5lwPiyAQDlObZJFaSiU0PoHXXHSsXTi3gwjNSbzaB2rwKKeN3AEOzfyuoTRFYMGpQDTh1+Ta/oM3B1A5NBgeEEM6WW5Hru50Jy4ykRTh7P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231003; c=relaxed/simple;
	bh=sUk8xvbVWwJWHjObCRgvbH27eEGL67yojoKdQ3lqHqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAYRtjQCIMz+f9acTylpylJ1ex0zzJAI0gmxrh5orG15wR3mTFXD+lnRS9ejZRn4YcqtQWJBxPkxNx0ejIKBrvA2gya7T4Ls98z3rHWhi/C9kW9pa9qmxdGu/dx3TYa0g1JptNrJpZymCUp7nFGWfNiCrbj0Hz6OyHxaGAiGm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQUvibdS; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQUvibdS"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf41b07aceso22712225ad.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231001; x=1785835801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMEMXNUMt5tIg4Lx7Edra+Fh/rYWldPNGAdzVoCdzX4=;
        b=IQUvibdSFUSZsG8pAyhxrOthu+GeTO6ieaIayCS+hDi1QDOMHckW+5kSrIUooPXHnh
         fC+NiH/n5lCjVFP2giufRFOtLc5E1M1GqanQEIqtzDz9V5D7SLo4opEu7Z4yKvZDaqgt
         eFrCew6Xg6A9sd+mqYMWcjx90dbOkizvl3Pbz3snCNPuiDLCQ4Cezbt6O0mjHN63hSY6
         duMQJ+Ab9TCZAkqlX6EY+rzRpAo6MUijwccMzYRTQOnGRLrHv0vqFAmN0j/a54ecJkAQ
         GieQsbn0V4mLIqhto+oLumegRtn62ui4r7miTC1KRZkg3oUDyhfME4/RoeFZnn2oJSbu
         kmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231001; x=1785835801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMEMXNUMt5tIg4Lx7Edra+Fh/rYWldPNGAdzVoCdzX4=;
        b=gpZHpXS9PYV15oP3Ohh7nMep8ElOn1jc8q/clv8+3fcZkqmboklG/sZQ3dGat/Nr1P
         iNnVFmQI0CC2e8eeCht4hpCQiO8dQIqkLRfx3rRDVMfRxEjYc3pobDFzS8yv2zjVS2vj
         FnqpbtJggSAeW3cRZnRHM/ac1r9y3C4J6KgdDrmUaBbKWagfMwCU2iIrw/6Gin1LobGD
         lJ1kGKuShvV1SilfOkqJVax0yRNMEIedVN9XjL7XrFhxbd9sIDgKYF1E0Z1dBR755qvr
         FVHznucn7d5JcUPhPtQG8NogNXiQteL67M+sNdiTho5RR6EP0QcxXrcRySF8Jf/F/sT2
         Lfkw==
X-Forwarded-Encrypted: i=1; AHgh+RpZtlnIAHKS2SQYtfgeW6d562iMZnlHeTagV70bIa1XFUfIsoe672cStZ6DFRf/nD0y/ew3Mg4PPN+8sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKf8OrYXxZxAk+pu46UaktTMhkb8/jkmeMQe+D0pRnlx3d8JHI
	H63BwXH0LRKhMR57/ahIHFDKmNCI3mTks2ePEmdPWAMrjmNo8Gs+tgnJ
X-Gm-Gg: AR+sD109X6djmcRHAxvyWWbmx3ERBZkKa0AOy4Gip8qI74bVI2X479EOlBsR7jNrTFe
	j1B0zyhomYwXPl1E01DIuGjfprxHqDqVdR58G5VGKGt/1ANvfB6kZLzqqsEYMg32Qf4YBuqLKsi
	IoP4Vf1CRh+CaEybh2i+WY37NZigMR6qHrgq7wTJ1AdrvHXvvE1vEOqGzAG6vRctmFEAOw9Z6TN
	mPkFEcEuwzuvl8jG+m+8w68fjJdFfO56MaZLjzB3JTt4sTBOWcwDkdLoCBuNHrTCHbCYHHWysUi
	uCCNdKuZHTouXiNtBm7FTGyM3Kwur76CIdWjTccZ1IkgdkdSJUyfxmuLBgA+A0yDUONMNBXedL7
	dcpnMbTnKHr3ZjQV+rqd1etF3mK3QTMrhfmsVYdurme000XK4RksauJvc1lV22QCTJ37FY/rraC
	sIZQnwpEMSmVw/f+Me4bDYpXvpu3RCb3v9hdIfki4qRcOaPosuYL6CatJ7LA==
X-Received: by 2002:a17:902:f64e:b0:2cf:b23d:79c with SMTP id d9443c01a7336-2d015ed00f6mr17607115ad.43.1785231001174;
        Tue, 28 Jul 2026 02:30:01 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4b01sm49151225ad.71.2026.07.28.02.29.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:30:00 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in per-CPU error path
Date: Tue, 28 Jul 2026 17:29:31 +0800
Message-ID: <20260728092935.31139-1-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260627070216.13511-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

zstd_setup_params() creates global cdict and ddict stored in
params->drv_data, shared across all per-CPU contexts. The per-CPU
zstd_create() error path called zstd_release_params(), which freed
those globally-shared objects. While the drv_data=NULL guard in
zstd_release_params() prevents a double-free on the init failure
path, this is still a layering violation: a per-CPU callback should
only clean up its own context, not release resources owned by the
compression lifecycle (zcomp_init / zcomp_destroy).

Fix by removing zstd_release_params() from the per-CPU error path
and replacing it with only zstd_destroy(), which properly cleans
up the per-CPU context without touching the global params->drv_data.

Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")
Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_zstd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index d00b548056dc..2584f47c9b3c 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -161,7 +161,6 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 	return 0;
 
 error:
-	zstd_release_params(params);
 	zstd_destroy(ctx);
 	return -EINVAL;
 }
-- 
2.43.7

