Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE86EB47
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193435; cv=none; b=lHJdVLW2ZZ13lKi8tCYzzW4tj9EhZkAlu5gXuQRRcgGZqC4rwLjtUNqwxkCD+mJsMche1PUUzCvRDysjFuzm8cKdFTvzZbiMI7Gh7sqn4OxeTkTOR0ZHlhsnMVd9xJOr/gF8hg6BfEsSV6H2grcTr13w9jT+8eEooQNA98lBBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193435; c=relaxed/simple;
	bh=0MaLjPvVAK/Cs5uLyHsHrUqQa22L5UcKTRzT/Bd+/TE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkIwB6DGC1/Kdd53L5LBu3IJLlHgnHkn96Tp2sGv+zZxNx55kDAWpRLQ16vdhLqJjN1RbRANX9vT91eGndfGxL8jPPoe03l0Wktwv6L69ZXz2W1IL/aBz6CouspYc+VUx+6Ze71a5ZRRRB+pl1WddK/Belbui6XHsCeDms4Cgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzuRf5mY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzuRf5mY"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf338e1438so8395841fa.0
        for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 06:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193432; x=1706798232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMZtopgbN/6mQ0cUEkngEk6XwZC8BFLt+hjmWJEWvjI=;
        b=AzuRf5mYFkYYq1KgoxCGLREJC+z+q5yoKObRTy4qqG1+Ilb6SPtsJmIdCXAVW2tACu
         J+sHv9yPU8mIQW6MVx7BBlzIrFIYiwHTlhyHUjQ6dprMdk3Mvdo+neSOZz/Wndztfj4v
         fuSddKt7uXW6mqgrRGisDV5M97tqIqky7xkFVl+KMCauTrMKNholsqX106C8hAvWw6Xw
         tgknanGLdGIa94Lj3Hsnd7jWZPER3Zx3NV7gTXxTwm4ag2Zjn+8Htow9O9/K3D2+LDuD
         bT6Mclt+v/l+ky3sPPKuvT7OYJxp//CacJ7sUfxOB0TojgDB61U9li7Beb/fVQ8GtV0G
         gYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193432; x=1706798232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMZtopgbN/6mQ0cUEkngEk6XwZC8BFLt+hjmWJEWvjI=;
        b=mspVtnwOmWS21t1opzJ/MN+jVGSOLOx44Gh0Lw/77yjPhA30377eU8FBBpvOTk29u1
         pkI0Q4N2roELF2fQ65CBqJ1L3P21OuuuPlMmmOveD0oYkys7LOkkcYkxx16VQ+u7WUYL
         oiqyg/vIF0A0mv49bxW5psLKI8Ev493vJlyf78Vk+l0p+9piMp3ec92W/R1K4qyBhV90
         x9RZzIrw6TTKnooIEYMZovcuHZvc49o4ySgAQ38ZuRygc0aIlhHZp42z9pEb+R6sQmKD
         pY76loD62l0w+U4/lmYlB4rpCAghpmC6X4oCXRkYcIdqgqekGX7rXKkSsTu/qWB0bgPM
         n+Ig==
X-Gm-Message-State: AOJu0Yzsdnn39B5mNhOItSqoudRMGwHmnb6A/3Q1UzgbCnUmDBhzi0yQ
	c/LCYVNvMOV7Qny9M4lP9DD9pj9e4lCTGrBZI8jPUUfVVwxwz5mULZ76Te3yH4o=
X-Google-Smtp-Source: AGHT+IG8fvrFL4nSLXe+ci61toej0QyVWsGZLLzDkrvRpvcBhGeNxbHJDgzn0gMd+tOrjICpC3tOsw==
X-Received: by 2002:a2e:bcc7:0:b0:2cc:78b7:1ef0 with SMTP id z7-20020a2ebcc7000000b002cc78b71ef0mr979999ljp.4.1706193431959;
        Thu, 25 Jan 2024 06:37:11 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:11 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 15:37:09 +0100
Subject: [PATCH 5/7] mmc: omap: Map the virtual page for PIO
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-proper-kmap-v1-5-ba953c1ac3f9@linaro.org>
References: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
In-Reply-To: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use kmap_local_page() instead of sg_virt() to obtain a page
from the scatterlist: sg_virt() will not perform bounce
buffering if the page happens to be located in high memory,
which the driver may or may not be using.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/omap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 9fb8995b43a1..3e36480b22ad 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -659,7 +659,7 @@ mmc_omap_sg_to_buf(struct mmc_omap_host *host)
 
 	sg = host->data->sg + host->sg_idx;
 	host->buffer_bytes_left = sg->length;
-	host->buffer = sg_virt(sg);
+	host->buffer = kmap_local_page(sg_page(sg));
 	if (host->buffer_bytes_left > host->total_bytes_left)
 		host->buffer_bytes_left = host->total_bytes_left;
 }
@@ -691,6 +691,11 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	nwords = DIV_ROUND_UP(n, 2);
 
 	host->buffer_bytes_left -= n;
+	if (host->buffer_bytes_left == 0) {
+		kunmap_local(host->buffer);
+		host->buffer = NULL;
+	}
+
 	host->total_bytes_left -= n;
 	host->data->bytes_xfered += n;
 

-- 
2.34.1

