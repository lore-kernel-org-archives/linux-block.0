Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C942E8DD
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836350; cv=none; b=Wm5/7iV62fFo6LQpVy9Iq+bSz0OzAljJjrHIafYjgJJpm9peYCgNlKfFnV9tbMjhXzdpYmMq43xGo7edz1zYdKOfPyRraVxh+xb18r9kAzKhNuQUUVMoKyJ1xwjRYAJgqy0HI9qlVkwkHtlSxqkthCnpBxl4dJ7dMB22t+TusI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836350; c=relaxed/simple;
	bh=SXp/5/NEZwyQ2T6u0pa5PIg41eZcqZD/pweYtKijIkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLMqfJs03F0dCcnJbI+IDLZ8zdIqDNoXIvWF67QEsR37irSDJpzCSk/XaVS+O4ehho627ksN/XyXaXaot+QyBvDWBojgeGYWDs7ZlJyokgGTDsGaRxRdV/+xLP6Xz5Y4ftAS9E2StSt4oORjOZugqV2hjYyyLB7hf7IHaIjbGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZixILjc5; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZixILjc5"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so3729478a91.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836343; x=1786441143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u40wfBemGswFY3vLVA1SulOXv0qgjlAi2ZUYZH01yXg=;
        b=ZixILjc5o/OUubjHNpA6St5uqS/UzJfIifVJsjlOu+jfFTefWYZrYufHkcgu/YZaCb
         xyXhl9c88joS33CpxPY5uRRctQ7PLCkVWXfg3mLdRxTaJXB7g+ukg/v8YngGW6bXuNuH
         fsYMlb+zUa8MqkvY/WOP39XkSn+yAYHnHCDxZV/mRT05hFv1j0FHbsZ1yuYtObq6txJA
         I9qkdJCxl3ZYk3GGz4R682SnIFKuFy8ShC93E/2aRkOJaC+MMD4wgxh82mdCnMd3N50f
         aEyS2ik5jviiCRYHwjABzHJbihQ55l4qVcxwUU9ByBdT/p03kWRYGBQeJUi1Oh5K4jmc
         hwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836343; x=1786441143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u40wfBemGswFY3vLVA1SulOXv0qgjlAi2ZUYZH01yXg=;
        b=Pz33+UaySMnDN5UcNy876LaFtgHgXLMJDZtEhVRroO8UQoMKOeNUbN6wgPv0CTsH6r
         ou1hEkF3OjVMLni21YkytV0Vn/k6i35kcDBnJvYlBfVBmsCkTX5rmRdHH7Awhs09C+wM
         5QidmXDS/SHTrzgRX8wU//1sLQ6QKE4+M6tYll9KL9MUi/PSX1eNBXOD2lcHRdkNZyBG
         4LrGoXPIDRTLisdCNDc9pU0QbKNMMIRYK4Tzh0RVYk3UUwNhx+jg6iNTcIN+peCuvvTL
         hZWGkNgA3PQdwy2N+aD5BifuwTT6jC14fRNCCXF5Qw7xXYjEHWhDO4O3u2sKWihLNBR3
         WpOw==
X-Forwarded-Encrypted: i=1; AHgh+RqwodUUK5KKvlYScpEzrDdoX6OSbJaNKzexREEHQDh8FsV3+DmmDIXr4pglpk01zGrnaH5CGN3hzUaFbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WtqdjwKK3afIE26gjNzA6v2msyJV8lYGXtRH+efrAwoTaXuN
	sJKo0K2dwu1nODzT1OJR33p0ieJTxtkswXmc4+nw+EwiQgEqIe9i00DcDYFCqkMavMs87Q==
X-Gm-Gg: AR+sD12mBfZEa3HK1Wk93INpOh8bRgLTtkFz60vj7w/3iuVfYJcc38p4UKZV3xoCBs8
	QOu4Dv5ltHAEHuLQswHZy/7HeYWAmSe10W5r+jRTEhtti4b3QvuSF/44QR8YcpjtNIkBb6tLdtK
	CsVEQAdGK1uxywph0JhA3dw6KNwQYcswbkRhykjjWotXxqxtP2OafNVkaZsoK4CRlJspDWpBAFe
	PHNOkE0ST9XZdI5/J1BdfQaLEVcF6hHhxhl757yjHbj9k8vSJ5ug/9WfcAxcL4KjXO9oiQlFHGI
	iGhSOWldKCRi/4U9dFaZl+MILBsS7+uRO8eBdREQfg2RNn8Fkgan/M8k8uhhgyyFGppRMx3ihqG
	LP1ZgTjTkXKz4tYvmm+vi+aBRmiycUeTONA/XJjRZ3E4/9a2hopXddrGDMBZSaF9yiru7ra3uHI
	jNObXUqjOKugjZ8UhAkGHWvG8SVkIDKbKrfNS37YMU8/PoU+leqpUp5XQndMtUdGolEUzlLoOy7
	zVJqBxs+FprTCqnz9YQPAWmcGAgyK/CuA==
X-Received: by 2002:a17:90b:48c9:b0:38e:2fa0:491b with SMTP id 98e67ed59e1d1-38fbc511d3amr11525510a91.31.1785836342997;
        Tue, 04 Aug 2026 02:39:02 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm1042633a91.16.2026.08.04.02.39.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:39:02 -0700 (PDT)
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
Subject: [PATCH v6 1/5] zram: do not release zstd global params from error paths
Date: Tue,  4 Aug 2026 17:38:37 +0800
Message-ID: <20260804093841.67920-2-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260804093841.67920-1-haoqinhuang7@gmail.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260804093841.67920-1-haoqinhuang7@gmail.com>
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

