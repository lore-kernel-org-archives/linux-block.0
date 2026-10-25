Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894733;
	b=gdZ5xnejT78VTuBWeTDO2lULEP99u5BTgEaI59P7ozM8AfrAe19j4c8EMB/HfaJR5l/q
	 IA1g9A0pfdGKK8Y/ZDV+5oXwXi0+VLomh9u6nSdlh9FtHympjkix87IrJWLQo0gODKXlB
	 3iyB3zrDIIS2gdCOMjml8cz5D4F8BJLEWcm3RZ4l74YVQIBkRxerdgJSR5wXuUsdYqsrn
	 0A3/qoZl9L1hLwg4q087b9hKNkwaplCqFSYvA5SuTzhSOd5ZWWgMVek8thBJVJ5j5m7RP
	 WfwYh79gEZpFSB0AslfIxz62Dt8yhq70cP1eQdwNWVh1CvUHn/HJ90xEILa2yvzBEcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NnTIHT+TXV1eKkVYDiQUUSu10XDJ/e0uYyNb5Fs1tYM=;
	b=SN3vyOUFuH/9RvdC5ewEtIBd3V2gaUsL1hLaB28XO8Ur1pg/jEXFJvN39NCvjoZOUbD4
	 x0lmFMHbe1pbxhxQAhljbmFBPER0BUdgx6tAbB9cNLR2dSAthuubEIUinC0Kb6rI3K+03
	 rycadlChXK2DABIOdgHF64srWoZmG7c7haahxrCFHw7ggfwRy+F1Tz+S08K2/ExfGUvG2
	 SWG9J9lSx3w8aFe/usMoBBprvuYmgSKFWPYRwDoy3c3JPj0P6FxTfqquMcBDYKSv/JqA5
	 eX+HV6nJEi9EFcOTcKRXPOMj61r7ZHqv77cqgmED+J9m5y/P4EpKsv2WXX6IeLbYgBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DzC6fXyh;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CC606A32E
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7CC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DzC6fXyh
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-156cbe59622so1271710c88.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894732; x=1793499532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnTIHT+TXV1eKkVYDiQUUSu10XDJ/e0uYyNb5Fs1tYM=;
        b=DzC6fXyhaOySYAvED9PkWySLle2vpEEhY7yVDpuTzevNQKn2qqaEfj5kA6aU3VtLs6
         LK0RpRV3SzvxKD+HeaTHkJZE5R/544dmXn4MMbUMS5FOrdxGxkfdZSD6+uukYrFN6dq+
         Fa+oVFPFcpEjmVgOBZ0PFvFLp3+BXOhApfZws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894732; x=1793499532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NnTIHT+TXV1eKkVYDiQUUSu10XDJ/e0uYyNb5Fs1tYM=;
        b=X6hXPDQ2n0u8ukcLDi4vft8QG7FyqAVbDnizsBg0AftAtzvm5F6EHSAwOSEjzrqz1j
         vZMX2O0RG9pCttKNFirt8/m7ybKlNbdLrxfLn+Vco3nukbr/pvYfcJjcZxSZmlO53tOU
         MyN4onqo+9lNHCyp6Pv73tR2nQTHjYbCo9UpO04jBrMldNb+jvXeXcGv01V74bPTBRoC
         TrnA713XV0iDp2gwjwSCCLzdhVKT6toPIcvukUkonTf3qG33BMlsNJagXI+/MSK8+Ewd
         5rXutBMCzmqiHBhsK4/LM1DKqC6svkpjlIQxh0m6BtSsfDEWUeRKTvRwAagrc65ZEm0d
         ooqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXyNxWKtoLT+r0SPPEPZVwMxz2Q76BAPxbMZJzOzKYpDBNuGOADYyLFSA6A0q+Fpep+fmK82DHwRaRzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI/qQFhMSK400GbjuaQ4RrT3rSsrhQZo/KU7DZqBkehj37t0ZUN
	yTOpagvicomH4hI9kztYBUgD9b0gjNKhb5U6qmRRH0+qbU8RQ8QudZjIlru+GAvRpg==
X-Gm-Gg: AYBFou36C2wjDhIWcOxAiqqvu1pDIQ4WjrTpoJ9BM3QoXeAfdw8LIbdqS8y9/Auw1K/
	kU762YESa85pC8BOxYwSfBIAXI3rg3wJ97z1cnudQre1eIKQCQHPt6JlqfSfR6CV6wN9fFjly5V
	8H8IoeyGdsIdwnFJP88yl3Jhl+TyEXTr5n+/A3c4qZAIhxpjEsDEiQTHdc9O1rFB2APMjrwqwZ1
	ueBvtISsWFNlVEkfxI/w2kxXU+xTwY7R0g6ognjJUA9AlTC1sw/7nQmx2xw3tcr5cd30Qa0IP6x
	aY8yxN+xPQQeEUyMOBDiiuKt85rAKBpdScGSy8KVHpy91r5peQdoZgQ/4meSTcDD8zAvbsbSjSf
	zKq0D+YfMGN3XxX4Q/cEIcYtOdJzggaBybRnsWeWZG+91wVOAcVbiREAgM1OHIrYu/mDa8G/0rt
	tXsUKFjVkbKe3s+OWzeh6fQwDrPAJYfQrOxW3j5gLFL8WqL2LGv6AIsTZJoBRGIbS1eJkAbeg2B
	CuRC7VPZ6BdFQSLjtgjIsXdtLaTEbY6QX9L4m7MzQv00QJxsPiepie+bC5yPMs/kBHpXuOXwbGq
	s1O3W8sli6pqSJ8rTeDFH3McD2zDXyS/oxlt1Q/xrolS
X-Received: by 2002:a05:701b:4306:20b0:184:1898:add2 with SMTP id a92af1059eb24-19935625958mr3965718c88.26.1792894732162;
        Sat, 24 Oct 2026 19:18:52 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:18:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v7 03/15] zram: reset writeback state in zram_reset_device()
Date: Sun, 25 Oct 2026 11:18:19 +0900
Message-ID: <20261025021839.1542805-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset all writeback state to its initial defaults on device reset.
We used to keep writeback related data in zram->stats, which
zram_reset_device() clears, but commit 1d69a3f8ae77 ("zram: idle
writeback fixes and cleanup") moved it (along with the newly added
wb_limit_enable) to struct zram, after which neither of them was
reset anymore.  wb_batch_size and compressed_wb, which were added
later, are not reset either.

The patch is more about just being pedantic.

Acked-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 593fa4ae47c4..0e1aa0da11aa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -694,6 +694,7 @@ static void reset_bdev(struct zram *zram)
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
+	zram->nr_pages = 0;
 }
 
 static ssize_t backing_dev_show(struct device *dev,
@@ -2881,6 +2882,12 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+#ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_limit_enable = false;
+	zram->bd_wb_limit = 0;
+	zram->wb_batch_size = 32;
+	zram->compressed_wb = false;
+#endif
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.56.0.257.gf7497c7d27-goog

