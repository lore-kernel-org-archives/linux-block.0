Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AC25DAEF
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196331; cv=none; b=nLHYIUr5Z5ABu4NLR9obbOyRqLD9n8yMty7x0tRqVn3zslHnMvEunlmUD/+WDT46X3ZQ437gjmXxaXr01Tl/WOj2psHgnMc62IKYK4wR1LekmDLjSF4r0wTQwFZNyU6+/FJG46ugb6/Kj4Ql4MlVFl8cDvxToIaWioEjNOWOHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196331; c=relaxed/simple;
	bh=Beq6p0A0Aj03j7AtotcrQhblg6FIC8rtviizuSi6oIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UcuDP97P4QAZszjaE8TTKu/zaTHLF8x3ZIYnd18OfwpkpNjvZUHcE9FtLHar8B12Jk5E+YCSL2Zc7MTtow7HlsyPOreVMUJBUao14lqeNuNhE/nVLjTfOP+lkn1D04deX69Fvj3ikjo4kkGZNxj9ZCbNVLb1swU6iNCraZzBEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMIaZK4m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMIaZK4m"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so46506175e9.1
        for <linux-block@vger.kernel.org>; Wed, 09 Apr 2025 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744196326; x=1744801126; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiF3hItZ0UAK/f8Cj3X61O/0nheHKx3BwiQHqAtvtCQ=;
        b=KMIaZK4m2AB+tusrYpYso1uIarovmI17rvC5mYPkUTH2fA3gKybefldLMpqUbuuqHQ
         t+k/BH8dVdTIBQUl+jfluK45wdrdc9luf5lRBzt1v4PxUlEPTv3YxE2HMsagh/h7jaDY
         vl3K6BclRbmdSU5BbmJu4hoUDL4CAnmsrO2X3DtvbuHeTTbo8vCG4V0zG5x6PDTjmAhP
         ms1C7HIP2SqAUiw9BH3PgzGGeKdjK0MEDV6YdixiR3p24RtZGoYbTacQVcW2/B/97PpY
         dgu4FUJnHGafQXZc6iAYkHNMhrpBOt8epHuOc9iK57LaG1LSqShoSCoFe3n/xqSR3OL2
         6p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196326; x=1744801126;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiF3hItZ0UAK/f8Cj3X61O/0nheHKx3BwiQHqAtvtCQ=;
        b=i2xvy8ICPDu5HqxjFvhtBvRqYwYlqgeKwScW2Cpc19dDBvDfOSCKCyFA7aCe9AESVR
         MaGk6PLBnH8tPNrtX9sCSWmLv1M159kqSoQv0llf9fklbtDbS1WOT9R607HUfdQRK8wH
         I1IuSq2/cZFu40uozca5rYPUMpUE86k10/31jnXRRide8qqwhCABP3cfgOfvUwKEZ7wM
         aO5EyYP4zLWS4WtPVDWQOQIsW1Y9LI6TP1WORBwfXaBj5Dgi/9pvaQ78h5NPsDiaol5+
         aLO1Ymm2NoGyL9cUNrH8hbddYfWqfbz4qYN3IdltJGSDwNXk9UzF62hC5Qp6XCub9FfS
         cmEA==
X-Forwarded-Encrypted: i=1; AJvYcCWV2KYzyPQgoGPa9pEzPFhsTWJea2sMzzhk0fsMSxLrGoIKTCLGNvYMADM1HercefqlZsLUoKMpKHNFkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjL8xGOU307m70nZvrNCOPAcCYNpdwNRafMD7qYO7r5Rm0DNPU
	SAh4+msXfrfpKKaJ7M9Uxt8xa4CElQczEx3ekNI/s77UOtCBXeUcvXpxrrr+Hnc=
X-Gm-Gg: ASbGncv51qBhTaRKOFpmEB+ZkreOVkVZpjdv0RVmuwumfREHytztpgfuHbvh26VcCQ9
	PF7etN09sZp+6qY+VjlA9/mCkbl3mMRtQKeHv09jevvbZ38SMby0hZ3FMrZsYGOk+ugfxLgo8AD
	vorXaONeMRl5vJtXrEOYqYe+/5+0f4TLoGKjU9lGCrp5UDdantZZXhhESBdSEX6wAetIwcmKYYO
	rBmhmuQQF9gfxW7RsWvsfPD6Kx4kEPkewGeF8fOzv6Qm2uxIxTCL47/fh95P0hi6vLTnSK6ZkSv
	kRHS0SKnBxyY+kXIfsOZYswVg1PoW38RaCYs7JO5Vg6zsQ==
X-Google-Smtp-Source: AGHT+IFqdSFJblVZ7boxxxINoAK4ozoRnpThv+xWoaahnbfo9IExrYdlTmE3N6jSm+EyLm0u1m1MSw==
X-Received: by 2002:a5d:6d86:0:b0:39c:310a:f87e with SMTP id ffacd0b85a97d-39d87aa837dmr2381147f8f.16.1744196326323;
        Wed, 09 Apr 2025 03:58:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d89378daasm1308967f8f.38.2025.04.09.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:58:45 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:58:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] zram: Fix uninitialized variable in
 zram_writeback_slots()
Message-ID: <02b8e156-e04f-4ab3-9322-b740c1f95284@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret" variable is only initialized on errors and not on success.
Initialize it to zero.

Fixes: 4529d2d13fd1 ("zram: modernize writeback interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2133488dbfd4..94e6e9b80bf0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -741,7 +741,7 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 	struct zram_pp_slot *pps;
 	struct bio_vec bio_vec;
 	struct bio bio;
-	int ret, err;
+	int ret = 0, err;
 	u32 index;
 
 	page = alloc_page(GFP_KERNEL);
-- 
2.47.2

