Received: from mail-qk1-f229.google.com (mail-qk1-f229.google.com [209.85.222.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC41DFFD
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=beWcLfUJy0LV6cA1ovDO4vHWRtVyuobiNLmBoD5mdCCqIhorIv6qihdOdbXZbKuFdneL9IIO2wQJZjcRTeSO7abfc+PYqBAzMcOOV8WHYLqv/+kf+DcHlmVD4w14sU1zuoGuzJmJdrdleKA0wDoQ3u2JYN9EaaTcbqkmjedG9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=1m8EvyXDwfnBtO4rKSJxv1p1kVYtxq+BhiSXNiIuIFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hfp67HRLnrKAIxrgA0DVGYNz0NeL7ZELQPQKKJr0tBuk0PfGGiHlNdmM3CW67/ow/KiXctfqlrUM+RgQojKcpHH0J5Dda6sCDBjXHAX1pwIUvvqRZnXBRuwkpHlIe16coKYH85JQln1yrAdagb55g94jJ+ESjR/Dc+LQfDla3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AjwV1PEY; arc=none smtp.client-ip=209.85.222.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AjwV1PEY"
Received: by mail-qk1-f229.google.com with SMTP id af79cd13be357-8b2df1e0c10so109124985a.0
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLmTlnuPqHH6b8/uqO7lFBozYXk9kulItImdN914sps=;
        b=AjwV1PEYCUMrcRrMXXX7CSjXLyq/7Cj2m+OKXHjC7fIObSwcRE2fTS4xCpQ8BuGWZe
         f0yJ7PgQPrUKTWa62gKHUls9dWJvqFXKXnDizP4GeU0h7xHnXbvKuHI+K7RV8XFfjjWm
         2EKnutONnce/D54HoRPLUMc0NqIj3JOqiLnhzl8ww1a5ownoLwmbuys9nfXRBr0dWX1y
         X1rfdVWrVZ7vB3Bq3keRB7vA6WwXsLhW6+kmS/y5kLCdu3Ciw8ae2OE0sSIzmC7WMS9s
         ATRh9fI8/rhS6Or07I+6Ne1xcrS1nFvJwCAmr1fusfjKTRYpi/YPjaNhO5yEpwlStKPK
         AbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLmTlnuPqHH6b8/uqO7lFBozYXk9kulItImdN914sps=;
        b=I8LSYhOrwvOJlZDli1xMEZUH3t8mAuFvB59RcCN4CEZPGE1IRYgFnjV8OUH2qpTknl
         TlpdsS1PR+uqFttqxIgN3RQFX81Ht0ItJVAUNU05QWY+IVCiBEUAnPqKydQSCOGIF2GF
         NASm0DP9W6lhlcXG20aUfaANigNq2c03qulIUT0bnNlJZPDuwHAXSE4XZ0DGi79gwrPg
         GvxO5sAhaz5OPC+VJ825hKftGHD0FEsRM6hJ5U1T/JBoG3LxNBDUV7o49H8AuEG7bwll
         wacFZPE2f6vZld9vD31lCKJONKXbHqx/diXZ5klRSJpxyUuqfDmqshV3a8r4QmTT0YGh
         RXkA==
X-Gm-Message-State: AOJu0YzeXSkpT+rpXURGm1ri6nrzloEomqg1ZkltGY5Xj2kX7btbKVCf
	tAD2PN/nXHZn79y1gsiTJw4eg/XgdmzqbiLO36fkO2Yu0p858kFKD+AFj9it0kcEGqW/I3mvK+B
	9MqmzOjQonIZxIOjHrBjq/MMckt782csOlF6xKKyQDyL2kTtX1O62
X-Gm-Gg: AY/fxX7C+8LvkY5vQRwpdua6DxTi36FvX0EnSGIpmsYl6KG5UNh0TwdYDH69/sLtNXH
	7s8g7Y9Qj65u9hPGMZ/KZjVpiqE7wvW/rFZgjVUmh2q9XDzzVCyKeLaz+vgd0wQujazvuGTskMK
	W6dJJSZyAao0gMEIoB5slV3RrwNBp0o+zizZG3Jc87KLmoRrZ+HC+ozb17s+418VE+e6hd1mjgE
	9XLw/SJKhf4cupXgexM4WMXQ/7AplYYA4qMHoDtsQHWhX8+z7nkF3k4N6FHhpNbk2MReQ1CozrL
	s4R4jhOyJunXGAw4/p5q6JX2/vKUKCbI2jfom54RGY01xBWclFiOpE/JkIvJ9P+PJOdSsTWfSbr
	sXe9BO4fCcfNtkjn0RwULxKEKwWs=
X-Google-Smtp-Source: AGHT+IEww8Xn6us3eOELOJf2dWwwlAwsZJ+WOpO1sBLgJOCvWnuS6p6k5sw8+fQPVGcQ83L4wdZsBp1KT178
X-Received: by 2002:a05:6214:3009:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-8887e15808fmr208544136d6.6.1765949713446;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88993b13d22sm19235286d6.4.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 486FF3401D2;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 45A06E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 08/20] ublk: add ublk_copy_user_bvec() helper
Date: Tue, 16 Dec 2025 22:34:42 -0700
Message-ID: <20251217053455.281509-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor a helper function ublk_copy_user_bvec() out of
ublk_copy_user_pages(). It will be used for copying integrity data too.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d3652ceba96d..0499add560b5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -987,10 +987,39 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
+static bool ublk_copy_user_bvec(struct bio_vec bv, unsigned *offset,
+				struct iov_iter *uiter, int dir, size_t *done)
+{
+	unsigned len;
+	void *bv_buf;
+	size_t copied;
+
+	if (*offset >= bv.bv_len) {
+		*offset -= bv.bv_len;
+		return true;
+	}
+
+	len = bv.bv_len - *offset;
+	bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + *offset;
+	if (dir == ITER_DEST)
+		copied = copy_to_iter(bv_buf, len, uiter);
+	else
+		copied = copy_from_iter(bv_buf, len, uiter);
+
+	kunmap_local(bv_buf);
+
+	*done += copied;
+	if (copied < len)
+		return false;
+
+	*offset = 0;
+	return true;
+}
+
 /*
  * Copy data between request pages and io_iter, and 'offset'
  * is the start point of linear offset of request.
  */
 static size_t ublk_copy_user_pages(const struct request *req,
@@ -999,33 +1028,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	size_t done = 0;
 
 	rq_for_each_segment(bv, req, iter) {
-		unsigned len;
-		void *bv_buf;
-		size_t copied;
-
-		if (offset >= bv.bv_len) {
-			offset -= bv.bv_len;
-			continue;
-		}
-
-		len = bv.bv_len - offset;
-		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
-		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, len, uiter);
-		else
-			copied = copy_from_iter(bv_buf, len, uiter);
-
-		kunmap_local(bv_buf);
-
-		done += copied;
-		if (copied < len)
+		if (!ublk_copy_user_bvec(bv, &offset, uiter, dir, &done))
 			break;
-
-		offset = 0;
 	}
 	return done;
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
-- 
2.45.2

