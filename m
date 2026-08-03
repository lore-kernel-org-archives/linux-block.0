Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5240F757
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766407; cv=none; b=ZwrWSwX5QCAfx9lREUY3bracvxCgModbj+g4WrQl+1zEniY2++gxhOkM4ZQcir9kuHguaw8A1cXhcGwfUQqg+fP1x++h5iRgq4MGaKX9urLbOWQR8t2f6ovt8+5Iz4/aPArt+cTYgI9GPcLE/MaKp/FKlfW2jNVZU6eljUaDgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766407; c=relaxed/simple;
	bh=SXp/5/NEZwyQ2T6u0pa5PIg41eZcqZD/pweYtKijIkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRc5FqLqDTVYHMfmF0BccB5uuhA9Ev6zv4G2PHnaPfBOHpFeyq91/gSLHi6i0VxhdEOpoLqe/A74DjGcgGFZNF+VobXodcRXyU6Cp6JSrCKa07uRuc4mGJAYr+5EL+zd2lRXBWXoni+vh3LqUcLfJjbGJocNmAd2QURFc+2zLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGGhO4e3; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGGhO4e3"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc6bb7476dso4922985ad.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766405; x=1786371205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u40wfBemGswFY3vLVA1SulOXv0qgjlAi2ZUYZH01yXg=;
        b=UGGhO4e3FLuJaWaVXL3qg9GXTr2Lo0y+6EHe0EqbGl1yuDT6ipHhUq5qJx92ncCe9f
         oQtgw+A/zFSN7uiOTav+FndFUn+hqpkC0BWG0oKJ3mqETKN5qLPGN/hA5ioGoP6nWn+Y
         XTBwF5LzDa1DOL1Kw1XVTE5gXt3b7vPqrzYJ9x5azdyT/o7NEPMkZeAoCsRtkgONVFHR
         LIDn6jhCao6/xkdn1qE7yZugQJNBkxY58Jl2XHswmAKKdkewvf5d/HlaxC+7gg81FF5p
         h8lmCJnKqlMGWkExheMJEUm3vTjvno9XZTFIZK65TReNV6SH1OiQeN8hM8CMl1V6yI/l
         AJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766405; x=1786371205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u40wfBemGswFY3vLVA1SulOXv0qgjlAi2ZUYZH01yXg=;
        b=eadRk8f1hkbJ3c1hanPWy8I169Odonlg+U5mfz+hTi7lpYb0waKSeBwNG7ZUKXEs1j
         iOu7UB5/nAQZCB3FaayVhmv5jHFlvMDhHX5p+dmxxvWTcR0/FXh9KZMfFkGbDTglMaRT
         Ri2g6GEBETW2KJuLmZvkVZl+h2HRyHR93kRhzSYkSblOqfQZd6LhCtI5OlkFhuUPygPk
         0RivZuXwFt6RWvEh5o4kihFgh52Y7Hs6NXG/0BWFVAJykfv48IeyCjbYAGIPZPdWnNyQ
         zbzMueOba54YWIDX31YkQiDFOB4ABCKvpfyfEbQo9xYLqE9af662facYsdzTVco0C+2v
         f1mg==
X-Forwarded-Encrypted: i=1; AHgh+Rpi6HQdCMuRDWlBPHRPZrdeG7EArjlwx2+4z/SsP39FHPBRLAlw0hYWE7SMaHnawEwTz+CkBMsi3ggN4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuP3t4CqM1dTw1o6fEARN23P+q8Q4HqXrMwOPywUsEMa/v2Ev3
	MmCzMfKZcWyVqw40lgUQOJDK2VJYpTnzLhkdOrDwTzZ/GnY9IDuteUU/
X-Gm-Gg: AR+sD10JE8LGhuiuainLbJba/Jgnuk8c8KHYw1HYzL44updeDGmilHg0L01WXsGGqr1
	lefhdLKL5xoT9NKnbZTL8YscP4wrrC08DH263eaFBBHazoPvk97UN2UcJD5X+y7ftYdD60/gKkq
	ASq8k5nSFeA/VOA+YGujqPc0kwwe7Q2m8c3gQFLvJGMDVWw+S3kOceQN7e6rYH04ChNu5L9Xlrz
	lrr8bITr4Ikj17AHyaPN1sE1GFT8UYZQqjIVGFKaNkHwAyJ1L09H8W8MQYzhexSR/dTPqS+sWv1
	1abUBQ+fbu3j8HlE2UEAn+82LXaA+qhx2v9m1BMAT6xAk2IiPlE8AcRT3ux0y7SnjUWj3zMYUSc
	bWNkdj3gWQkmNjp0gDVylOyORg6ScmXlPsPR/LNcY8UG5FD/kVwdOtJo1p19cEQL1GOfZ5RC2ZW
	cj+QuV0EQ4mVMaYRNfkick+tUMT52FnSX8SX9zLttXP7WSH/5DWVsm601lnfe3zm7+XVCldqKKd
	mdmd5E/3EfMurZlTrVhSSE8BrR7gW1XHJqT5LoG1Zmn
X-Received: by 2002:a05:6a00:338c:b0:848:7bcf:9a9a with SMTP id d2e1a72fcca58-84ee4811e12mr8876358b3a.1.1785766405283;
        Mon, 03 Aug 2026 07:13:25 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:cd52:f161:9c8a:ee77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebeasm3818360b3a.30.2026.08.03.07.13.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 07:13:23 -0700 (PDT)
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
Subject: [PATCH v5 1/4] zram: do not release zstd global params from error paths
Date: Mon,  3 Aug 2026 22:12:53 +0800
Message-ID: <20260803141256.60599-2-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260803141256.60599-1-haoqinhuang7@gmail.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
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
those globally-shared objects. This is a layering violation: a
per-CPU callback should only clean up its own context, not release
resources owned by the compression lifecycle.

zstd_setup_params() called zstd_release_params() on its own error
path as well, but zcomp_init() already calls release_params() when
setup fails, so this is redundant.

Remove zstd_release_params() from both error paths.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_zstd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index d00b548056dc..5fabc3e7e975 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -85,7 +85,6 @@ static int zstd_setup_params(struct zcomp_params *params)
 	return 0;
 
 error:
-	zstd_release_params(params);
 	return -EINVAL;
 }
 
@@ -161,7 +160,6 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 	return 0;
 
 error:
-	zstd_release_params(params);
 	zstd_destroy(ctx);
 	return -EINVAL;
 }
-- 
2.43.7

