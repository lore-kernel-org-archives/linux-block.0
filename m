Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842F36F8E7
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379995; cv=none; b=HyyrKeUTnoJVqM8JwO4hThgXXFBcIsGO084/WIOPgWbysfbwOo6DskZHJppoP8IsKkijcKSkqDGWn3MgmqkqqeukDIDdX/tfVUP0fJQgdyLTDyS8m/xRKe3vykbOBREsREH43IdmwC0t87t88s1gaoyLQ3TzSx1S0caWRoulNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379995; c=relaxed/simple;
	bh=JHpJYTLLB2ZMJKT2oo9BGd65bnXRYxol6hW4wZLX1bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjYRuTykpmx2cXb+e2vSHYmjlhXgJ4SzR0d0e+ZYZdskEKX3JD0Cm84R3Kocg1tHLl2EGzq0V7avEQQTf/Wxr/TiMY03t33LqvuvclW0VaZ9PEuKIGwt7u5aBnOFGdbRnqJ0QsfZV+TND3DNcZoo2WtbB3kUEpsdce8bJx2w8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cURExX7J; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cURExX7J"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso6012375ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785379994; x=1785984794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cs489M3XU7xPRIbALvrKU2CC1mfn9Hj5q9oo8bImFmY=;
        b=cURExX7JoZdSifWWTld8CIVD8lfM3e2n3R5Z6h4YP2+dJKiiYAzq74X0s6n+NQpVSr
         UeeeeHIn/wVmscRPuQlOkXKkBT6wUOxuGfLpvObbtZSOONwxo9Kd4R1uDZxv1VZWKg8f
         0B+LB/+4iNAZ+6QwPZvbtqe9QHsUPlT+NhebonTmYkFXAzyZCRd2O300KbH1pHgP1vdI
         fQetens4gePhKOBWZgPWClpqy8+pT6kMCYwm2pWUvRGzO4hQ15rLeV4/LkiKe7fFVct6
         B4oxmbQ2RT7TuqkLs1u6k5DpHTOMhaW1SZt7sCGakjN14+pD4wjbpMV2CIpuyimNV2x6
         p9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379994; x=1785984794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cs489M3XU7xPRIbALvrKU2CC1mfn9Hj5q9oo8bImFmY=;
        b=N6RS5FQMqpRLP6Zm1okHm+paiS8Y5debCIxjAuW8SgZuGt+KCdGTAAkE41nfKGm6qp
         Mero4C2ejU9B+GxuSEVsr1uJLq+Lwbbq+XFjEo0v3BAdYAU9IB3AcZBS1OXUjDKwSjlq
         aIKjm7DSxb2bvu5wl7adwYkubr1Q+JVC+KAVIbtz9yM1xF3GMfhVcJw20TPy2g16uiuH
         t7gFEtfzUVPcfO7zm+Pz9oEaBYwd8w/Gv+lhEejbO/0TgYx88/MDnyUGu5vXEjuhItTF
         IYul7dfc40AW7xm+65czA8GTFtfkWnXJTDdxQe8wxY1TViWFTi9WbxnIfLcYYPBh0DRJ
         IvHw==
X-Forwarded-Encrypted: i=1; AHgh+RoQMDAHauz6u10F0j6md2YOyDgaV0IXfknsH6++/z7VdvR8Tj2TqV9GEtLf9JXF1CnZoCfrSzAeiZcp4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxldjTAU9FEqbI2+H0rNH9l9QQjdoFU+UonVzMOSmda4j35WGOV
	zJZhK6h8puv2FMPMtYbcms2UBLhbUyQ7Ga91IHCcxxnlhKfKyDRNlQXnOVaBN4M5tts=
X-Gm-Gg: AR+sD12pA5PLvEdmqMVj9B0alIKz12SmNdiyZdaJxSlD9PoMIjQ9qYyrtXGw1enkHEs
	96RGpFDpyvjuaesZt6LohpbfkBNk8bPzt0zoPVuwajiTvpGCsXqncekjJf3OQJNp19vD4B5g7i1
	QmIUzCmFpQK1jHOjKRb5dcSWqNSs4EyqtAiwL5HCwfwMKrHQHH8pUTcg9gG5BfCbETdzzYxScmf
	wTNnfcLNYoi2KY3YIq9xcG1z0abvEaqddYf1YJCj3y3Co9wgjFOICW32pe7/9D+se0srU1FLKyJ
	p9uE3GDrqTkztmZ2zFNY+cVnL6ILfo6pUzqz2dSuunC2w1wsgjNBky37xpHRE17XeDHczC011jP
	SOKW+OJxJnuGr1rpvRg2TDRgMFBqWg1kSj9vbMg0ee/muEnHwry60NXAwrrtYlOLsqIaEVqqavT
	93bT+mntgoSjTBLt/+TqcAKOTzdvHrlZ3xnXju9IJ9bmdJG+UIETf7Y9v2mnpyaS9BCn4I367Ia
	veDPzhdzsrHs21mLyxMzbEm4hj5r2tsJA==
X-Received: by 2002:a17:903:904:b0:2cb:2b84:f431 with SMTP id d9443c01a7336-2d035d2f310mr8304695ad.47.1785379993733;
        Wed, 29 Jul 2026 19:53:13 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm18656485ad.69.2026.07.29.19.53.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:53:13 -0700 (PDT)
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
Subject: [PATCH v3 1/5] zram: do not release zstd params in per-CPU error path
Date: Thu, 30 Jul 2026 10:52:36 +0800
Message-ID: <20260730025240.17724-2-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730025240.17724-1-haoqinhuang7@gmail.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com>
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

Remove zstd_release_params() from the per-CPU error path and call
only zstd_destroy(), which properly cleans up the per-CPU context
without touching the global params->drv_data.

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

