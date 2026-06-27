Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C322C0261
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782543806; cv=none; b=WlM/XqycgQdiZfhIN461zfmo7k31Bluprh2HQINYwKKq3zgre4ZQLZ7Bi4VoopbqgIpX/1+rnGVDK+yslVDZ/FL3/orKmJa7pMmX6yn25sLRCmWDdJ33hs4iSf9S2mIrn2oOCq+eVijxhHczc3ScI4sb5dESxUlxwJ5KPprTjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782543806; c=relaxed/simple;
	bh=roBNc2sQN3ldHuLOLGDe6TaQysJmJwxZKM2xHYz9Ky0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4+EXPEBq+d1rNhlKpbRBogdgjzJBfAP1LE/xhDHzITFnoxkKz36QsqtyRmK+lZ5Lgs33B201lz5b9WdYA1N7mKY2k4McW6MzN8APt3O0DSg4xdo9bH4D1uMZVcqPf/cS3ufch9Uz4Zi/HAcR+9xlmu0sWcj8pjDApvOGANd6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJGjghdv; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJGjghdv"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-37df0b86a82so1618819a91.0
        for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782543804; x=1783148604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQn/a3TS5gmFPjuhsccSa1AXinLOkLgHR/IoZKvOu0=;
        b=BJGjghdv68Q/BUx3gz9pO+FwMcVzzKeV3Z1p8KzZrYWZQJVngRQxlKdkSYKnRRqz4B
         J5SpWdgigb7FHZY1CPSmGu/uDVYVATcH0xba22XWxJmMYLpqXATGsSwyoM/EXFR3Ib1i
         9trAbee17sbuutD8/uCDL4D4z5W5WJkR+2UzBHB58bvdsqJCXp7uBKOCol0r/hbWSj43
         srBAHrgJe0pB4ja5RltKqizJAXDfCC959vUOU3bZmQE8EIXcb46uartXUFxzMXpC90wh
         a4+Petke9IHiAeUqhxP1oEBREgYOqOGR2vExeZW7k5svoNjEoGOUMpZvm80vePmpTKXL
         WdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782543804; x=1783148604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eQn/a3TS5gmFPjuhsccSa1AXinLOkLgHR/IoZKvOu0=;
        b=s4tLUZfpaQWHwk6Z17YdG4LTgR9RygLTXy7cTCBo4odTvLu4//SWfoxqPnCl7Ehwvk
         En8IeNqTyGZFpCiiJdEkSmVsFz76eiEzsuNOnbpbsS0EAeR3khI16+Y1OhTVIggtvV75
         W+UnFGg2U0kVsIjz+G/dGcYl2CpMzI47NXuW6Mc6eNTG3O63xj9HXenb3E76V/Kajmdw
         EihYx4Wi1rhfL21e+RlDD605sNsojesaqgPKNZciJfFSrMl93XkavhCq99hR2CxzSn3l
         eKOh2Ve0/miyD+vcFnis2cTRMnykViAzeY6yiQrCZFBQknpQ5W7m7/GQUbeQ5yMpVJju
         fdfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrcb8SesnJUzIWoDeP7LAHlRBGnDfi2aE1WjVdcVUV9V9KGNGsqt/Jcw6eoZpAABwPEzZIlkmjbenBfVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX27DRvGv2uw1f/CmsnMG23x6huDse6v8xZfPpPDCnK7ZhiEJT
	dNvStv5Kn4ARrAfRIzztgLn5OzDntocMHqGozbVovAz2IjR97zwiCrN1
X-Gm-Gg: AfdE7clTW2PXtyIhgnVoKD7HL38NN0kZVYQI2Ns53H4Smk9/aO2ML2bOZQ1ji8W7Ash
	dsXxJZQXIz/Tb+HBmSb5RUyToWgaEeAIA3nEIyjyGc8VmFLGTz5YofJA0M2r4Vjf9ZahqlY/hYD
	77EGtOlvvA8LLhpHfmT1jLAjtBmZHtQ9WjvODSIYxox+QQmOeshc0IMztzkQGfWqqJGVAc7q4xg
	OmssN0lWLuM8rpJWM98nVeedLw1ZF7+uixYqiYh6PKqYemSwmF/BfMYJ8Z81+TJnI0kfYFkWY9k
	kUDkyTwzFLkOWzPME7xvJDTyoZ0/q1LxfS8uOswOGyXWT6EjyMSoG+yPm1slurMUVMLCcui6NAi
	2+pb+oM9aY1SyBWM9JbsKBnbvttJQh44AaazltAahtV5qeenTyjU41ICG1JdOyywAjyVm53CgE6
	rTS4a161aY8UAVgdeyBKr9AVQmDLX+vdXu2nGKex8TPxi7yDy9UM7RcEA8MA==
X-Received: by 2002:a17:902:d484:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2c9994c0b4amr20237805ad.30.1782543804035;
        Sat, 27 Jun 2026 00:03:24 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:71bb:5f2e:c181:eb3e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f65088cesm51596995ad.80.2026.06.27.00.03.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 00:03:23 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk,
	terrelln@fb.com,
	dsterba@suse.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	haoqinhuang7@gmail.com,
	rongwei.wrw@gmail.com,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH 1/3] zram: fix zstd dict use-after-free on per-CPU error path
Date: Sat, 27 Jun 2026 15:02:14 +0800
Message-ID: <20260627070216.13511-1-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

zstd_setup_params() creates global cdict and ddict stored in
params->drv_data, shared across all per-CPU contexts. When a
per-CPU zstd_create() failed, its error path called
zstd_release_params() which freed those shared objects while
other per-CPU contexts might already hold references to them.

Remove the premature zstd_release_params() from the per-CPU
error path, the global cdict/ddict are properly released later
by zstd_release_params(), called from zcomp_init()'s cleanup
or from zcomp_destroy().

Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")
Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Reviewed-by: Rongwei Wang <zigiwang@tencent.com>
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

