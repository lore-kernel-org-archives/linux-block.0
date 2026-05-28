Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873817B425
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936541; cv=none; b=BKqDUjCf1GBdVudC+K7OUzM4OVxmeOKNsxfNvTerjTBgEoTY1nBqHYQy73L4Jj/rvdN5tmzu99/xpguJpDWV/S/fR42oHiqhRsCiifSYqQ5WRf7QXVLJ36U/Vx1rq0v487k7JAdTuvOed+kgBVaG/2AMXKPf5KDrbwGdwK+skWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936541; c=relaxed/simple;
	bh=tYP7A1cG5Idkt7RgPNKfx9ASoxRRbHTZbBSShzPi2BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxbCOmFzA6uLahqJRcYBAA2fzM4ecoJYeWPJd5tOSPQ//S/c8ap2+0ZOgM0rwM5LlxJMU0V9aTEPorrYkabaZ5CyvPyaTCMNU8uNRNAnDkkO7a8pz99BdyqZXMKP+moSbHNVJ6/f75+D9MYgWV8DEMOHAET3Tc5jMV5NFgA3mF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFPR7jhB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFPR7jhB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so4257357b3a.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 19:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936539; x=1780541339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRCtt7LbB+SSV6LJlNZfwK4a+gaxuGAqxV4IOSE6198=;
        b=jFPR7jhBAHuPCZJsw+290vszneqIPW1G8aQ6UcIaYwxqHg2PulHlbXECahcJ1p8vLI
         hwEoyED9Czqu/nJMLAP/JU4hn1NWx7ut9roltZRHzPaa5DdpeC1H98u1yxjhtafA83Kr
         jt6H3f2ys8KR+2H3b3AbQH20cjhwM+N8Lzvu+rJCiIvZ3eG2+m1yACHUBDdb0w4uMA8e
         obPT6ACNPu8IDXVNHMqq9efTHXi2f8aqNhDRjh2m6KfIpYyDg/yS0Uv+IbmEe/+DrNJS
         YbovK0yOMFoJg6o6HIpYr1fIDvCdV13Wl1e9+qXYj0UDfAsSfQDNnntF+KRTIoG/8ZYp
         tD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936539; x=1780541339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRCtt7LbB+SSV6LJlNZfwK4a+gaxuGAqxV4IOSE6198=;
        b=cYLlXXADOv1+8D0HMPRfZHdu+RebUmzIR03AJH+qhmrHsXNNTkbYOYbn4QgCM/OVCx
         2LRHQaTQu1B0El58YSz4vDApoiUJbDvV6f8yPcpJRbGBGMQS//MX2tJNTiUFVDb5hoch
         AoakOrdjXRFbetmhaMvMXGbgMGbCwcopiQsKXrLBAfCaiVRcPNdbQf0CxsNS+dDyjfPy
         k7nPCK33bJOUYOKQmLK5Wn6eFLG1F5dtYYNxea36J4j//+VQDrcrQvO97mjAvkXF8ora
         QAakNmUNgeyQqavF/2dkuI0Fbfo6RBwGRFnaBRNLf7h9OU/89loYb77KATw56cd9HIrW
         uR9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/cwzUJACE2i0djWVFhOsP9OvMCpbrjZZXtGh/7LczUuk1q78EMV83WeszC6gSg7HpELJb8mGZcBozo/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxASfrmuAH2UlPUmS7kJb1zlXHimDpIqvEMukghxrYKiaN5Jg1x
	//fPWVGiAVLIZ/IUSjoaGsnF8XWDIQ1j4XjpSPF2tfXK+juTPzi6lyQr
X-Gm-Gg: Acq92OHnebjjlNe3O+BAXUkByvyOGnU+gzp2wjH/l+qDIcZ1LKBf9r7i9ys1XxXiRX7
	kJzWOteKbfVIk28cbYuARjOOGwBUJUE5EKVIaJuY7cZPZR8z6lnZnUpRiPp9Ok5Ui83/4X4huHW
	+eo/NbRrqx4xfBwTBcy0jTxFTMiGHLAWh1NewnHblqoszA5ELJ0MEaFl4w88UI2oumB5ttvQAHV
	zet7LzOrTI0EaCIkFzTY1kOsZ94tsfCjAHXtr+auhXwRZVgNlJJh/h3qesYru1b9Srnyknvnu+j
	y8uiVCh4dPBFlPYd9jU5IcW7vfAc3MG4q1SRJ0HkFbVpnzrnIBrg4m3CMzXINX6x/VRVCm0bDVB
	GfzdBDzhqMS1eLY6TAAZAqAjno/rKmRgC6S3qVsHJ1p/T+wE2t/1Yh8+f5DtrSiw+Juo4H7Qlav
	4G1kWUXhie3FLCWr9+nGQV8IBH/DNc9i3qMQdTJ3mlD9/8
X-Received: by 2002:a05:6a00:cc3:b0:82f:8696:5a75 with SMTP id d2e1a72fcca58-8415f66d98bmr25732951b3a.28.1779936538776;
        Wed, 27 May 2026 19:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm366877b3a.4.2026.05.27.19.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:48:58 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Thu, 28 May 2026 10:48:45 +0800
Subject: [PATCH v3 2/2] zram: drop unused bio parameter from write helpers
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-zram-v3-2-cab86eef8764@gmail.com>
References: <20260528-zram-v3-0-cab86eef8764@gmail.com>
In-Reply-To: <20260528-zram-v3-0-cab86eef8764@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779936530; l=2072;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=tYP7A1cG5Idkt7RgPNKfx9ASoxRRbHTZbBSShzPi2BY=;
 b=WvOxxhTWOQZ0Yi6BKmdrNNVLoeyNrSBLlOQFAQZmliPst4oSeJu5PmPvbZkCbV22dwIAslJsy
 19Hz8Yf/4tjCiI+KF2iqOv5oC/O2lF3YZmkbnllf0Fq2fhIawrNP7PU
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

After the previous fix, zram_bvec_write_partial() always passes NULL
to zram_read_page() and no longer needs the parent bio.  Mirror the
read side (zram_bvec_read_partial() has not taken a bio since commit
4e3c87b9421d ("zram: fix synchronous reads")) and drop the parameter
from zram_bvec_write_partial() and zram_bvec_write().

No functional change.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b23a8bbb687c..66347915a2cc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2325,7 +2325,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
  * This is a partial IO. Read the full page before writing the changes.
  */
 static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
-				   u32 index, int offset, struct bio *bio)
+				   u32 index, int offset)
 {
 	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
@@ -2343,10 +2343,10 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 }
 
 static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-			   u32 index, int offset, struct bio *bio)
+			   u32 index, int offset)
 {
 	if (is_partial_io(bvec))
-		return zram_bvec_write_partial(zram, bvec, index, offset, bio);
+		return zram_bvec_write_partial(zram, bvec, index, offset);
 	return zram_write_page(zram, bvec->bv_page, index);
 }
 
@@ -2743,7 +2743,7 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 
 		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
+		if (zram_bvec_write(zram, &bv, index, offset) < 0) {
 			atomic64_inc(&zram->stats.failed_writes);
 			bio->bi_status = BLK_STS_IOERR;
 			break;

-- 
2.30.2

