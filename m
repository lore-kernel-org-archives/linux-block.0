Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4B3A5E6B
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652143; cv=none; b=LOJXuZoYRmVQlB6cijq6ot2sfygcWPPzVkgBlG19bhwCjlotRF3ewJ3oB+dzjrNzsz0T+R9ih70FE3nxsyXQGk4EtNweYViYULQiT4trKyUz6XEJY1zMB/yDNYVAIWCxbUWma5VNmAoevEZJnGR/joTuFfINB2T3/mLGAG+1G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652143; c=relaxed/simple;
	bh=y+gm9Kdn13Kq1FR94zZcC/GIw4xAbbRNUeEu8hUgXDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWzSdoKHIkBl5AjdAbMoJwkl+AJpaQQMA0LViGQG0NYbOsnOxHI03GGgqpBAC4+P//WaLvs/Mk4BpjsOLOKMsWdcB7FznUuX3tuSiTpePIw6E9hVhIj0CoPpxaH+S+cwrSrLLYrhhQHyCHIBBAh1A/h3gtbsM1M71/oUwyVKVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FsL92oxF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FsL92oxF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1279979b3a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652141; x=1764256941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNBO1q43Z4HLMo3u95PxV7vGEr2bqJ5I/H/pDo2xib0=;
        b=FsL92oxFlAkFyG1yYpdi5f7rwrv94UkVJ5KsBnfNqYgljA0aIRi4Z4gqVeawSVsSGy
         TiroerSCAfQgvBT6oDFPKV8QbvBg2XKCqDNfRmQhLhyQSLmrcFJr3SQAtXX3VrE7q6uT
         KpuHf6QusGD3ZKN8wvYT3XMbNIFqMMqsza8o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652141; x=1764256941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNBO1q43Z4HLMo3u95PxV7vGEr2bqJ5I/H/pDo2xib0=;
        b=drzpExTRUlMpydo8VqdVvI0gFDRms+Iq391jUW3ibOTeKta7PZ8Lr9pHfZjDGZ/Agm
         895NRRVDe3jO8djSaNlBINe/MWAHB7FUm+pil+n0oMQOlzuX5ijKCoZXBIC14y0+kfxk
         2Lp2qq62eKkd1OFoSiczC4V4Ligo0POnrx1pDKy0NX1oLGY9aZeSM0zfBnyneoHEQZ/Q
         uHhlVtOo1n0lu6dGql+MBjB6pspDnP6U6WC9eCPix0raI9RCvhdqFpvzil3KJx+G6nBP
         yoiZIxqbeylwb7v8ADqwHdRjWkW/zUK/7xSKsoJjtdshCJiyQ2mzAwz4jOmEXGrCVwGQ
         lVUg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ94IncJUDUD0GRbDY08C00R4J79l8L0tlXS/wOfiepJc4q9zP9CWNuHKQX5pcdFDwTry4nSGAhqNigA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxv1FhNp8FrGxx4QiTzhaVNLmU+xah+r9DAG9Cpsv/7dOpg9C
	nQUbK7AjIXeYZCXlFOof5EMfyQsONv8wAP/B1SdFfwkzes7xuCDPzXUjZrL3QECTOQ==
X-Gm-Gg: ASbGncsqCNFRXY+SIic5plf5QR3gQAfo6phV2chXw+JQWkApv7kFwFyj72OogccC5J3
	WeA4/9/RzyxkaT5s/US5oaGkt/3Dr73IZOG/y4ZBE/Fh05AHneKeWLU14y6lDW0NPA95AVy4L0Y
	XQU1jKwKjBB3q55vcMbRh+sjlUM5FAhcb4Kzit2AR2f9hnKaZ3Iikd7hmtkh/ZC2s93qqVQcQVV
	2s0m/ASpBbhXMKXLOuztbj1SvimmC645vKjuHDpY5+bfJhSORV7yg2dBZYuceXTBJlbf+KTV/FO
	PojVrIwvPZXXmvwsrOeH7CAolZxYAyJ4BJaRe4W1g5Upv8knv6qPxq7TRZLhpqhyx7BdmeT5h3r
	laxWx5S76uiBCzJfS4rOONif9KB2fvN8FvyzCvsI3aZ1go1bcoeibzcwDu8gCIsZEDy1hyVJVmX
	ea7pvXQREHm2osLaf4vh02kJA6NVqBARFk7NKgeg==
X-Google-Smtp-Source: AGHT+IGM/LtK9fM0SsN5LsA6eyPljhRQtoqszEcAtB8Xy29m8uMD4FUL1K10u/XIZzdHc9yqVpK3Kw==
X-Received: by 2002:a05:6a00:3926:b0:7aa:2d04:ccf6 with SMTP id d2e1a72fcca58-7c3f211a3femr4367565b3a.0.1763652141473;
        Thu, 20 Nov 2025 07:22:21 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:21 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCHv5 6/6] zram: read slot block idx under slot lock
Date: Fri, 21 Nov 2025 00:21:26 +0900
Message-ID: <20251120152126.3126298-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120152126.3126298-1-senozhatsky@chromium.org>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read slot's block id under slot-lock.  We release the
slot-lock for bdev read so, technically, slot still can
get freed in the meantime, but at least we will read
bdev block (page) that holds previous know slot data,
not from slot->handle bdev block, which can be anything
at that point.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ecbd9b25dfed..1f2867cd587e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1994,14 +1994,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
+		unsigned long blk_idx = zram_get_handle(zram, index);
+
 		/*
 		 * The slot should be unlocked before reading from the backing
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
-
-		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
-				     parent);
+		ret = read_from_bdev(zram, page, blk_idx, parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.52.0.rc1.455.g30608eb744-goog

