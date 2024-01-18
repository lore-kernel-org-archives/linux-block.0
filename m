Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B232E3F8
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605836; cv=none; b=k6dswxdjLx06qEf3r2bOT/wCY0orV+k6PgPevegvJL1e419wCBp2WvLf+RgLVwfG6GhByUbUwlEuLtMwUTB84fIdHubTBevi/zRzlH2QP2o/L28Mx6DucAQ23ncvAGLV+oC0mzPs1BGwdimfcXPoJx/vsydMVs3YcGKetliZU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605836; c=relaxed/simple;
	bh=KrkEwpyLUCm9K4yMuhSJJ1LIar/4ExZN2t7cEh8dOaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqflI3r0tmK8sFpkKcM83BwHrIKkxHkagNlZAXzDI4NFUs9GBBcKqXhXhOOYsywTBjmPo1xB5dgzsVXxeeWHwrc3coth6CJs8Qrn+QQu15qtPZozSDFdjTZz+1ZosaBktz7JbVHCnmj1JntpkS/T9b//Ldfstz1fNBpCRJxlQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EzfO7iJ1; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EzfO7iJ1"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso84041539f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705605833; x=1706210633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrTfITcy5xm7tHNgS6AMID6p74u6gKo/HsHWXAFrnLE=;
        b=EzfO7iJ1jz1JsVABPv2W4vCUBvL/TVuK7AUsnoX+2nDCbdCsWmz8TfLx6hInYQbMdk
         bshouqdYM9AxlDhij7hRQIRx0E5RWQfhKwDxmshp23/A/DGc+Lk/SZMTO66uUXb+GoUU
         YrogHtTNJYQBrz6pJrn0okIQmsfvTAgalKASKDNGI5aL15ulipkTq/6qKYaCXQhy9u6q
         RMdosKfZitGsQDAyCcRAcrIS5cykaP1v91JfYPE95ztUG88AJ9P3NRplOgcPcHF0f+ew
         dHdhUN/BQlnXCdaj4mRatBD0sQA52mkMsUH6jWpljfVMTj3hdR4p4QbduT7RfpSZF5ti
         rzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605833; x=1706210633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrTfITcy5xm7tHNgS6AMID6p74u6gKo/HsHWXAFrnLE=;
        b=nG6H7Oyj3Z+JPxQuFEJKSzOr6nqXOYufAhaf2dqPppPzyRCodWxK1Wga6kt31E3vll
         d2pah6PcXMEJX9sc8PXM6dIDxW95brFLWimVhW/YotDsrxG821e33LwryW4lAePKoLjf
         F2jwtYFv0cWNpj77TX7oJNpdNdUch4WzvW4N3/5sv8yDr8kI+SI45WxRUtAEPcyNZoMo
         qmWNUsj4wDgzz4m9c4jw0rlbuHgo/b8r4uuHp3tXHOxL0yKxXOm5KCFD6NoClufbV24h
         2cY1yj+458qdK8MCxSMGPmm4qWcbRSbL9v5Q4UkJNmxkKuI+oNkVY6JpNiHTevCpKr/n
         Rkiw==
X-Gm-Message-State: AOJu0Yx94LYKCz5BoaHIHs1hkK7LCIfQucKs0c+8v28ASpHtfC4OXRvY
	uroCpu0froP/s7RQQDmpgehlVu8yM5XBfjvLLli3p5HH8kN1uaX6CsRUhIPsIh8UVFvQptQauVG
	umFo=
X-Google-Smtp-Source: AGHT+IEj7AdGjD3oJmEkC4C7/AzOt4kWeP1z4BO5i9CLAZ/qEk3IZjUQ0FAnadthY5x2gVas15hmYQ==
X-Received: by 2002:a05:6602:1233:b0:7bc:207d:5178 with SMTP id z19-20020a056602123300b007bc207d5178mr2700865iot.2.1705605832939;
        Thu, 18 Jan 2024 11:23:52 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm1155588jab.40.2024.01.18.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:23:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/6] block: cache current nsec time in struct blk_plug
Date: Thu, 18 Jan 2024 12:20:54 -0700
Message-ID: <20240118192343.953539-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118192343.953539-1-axboe@kernel.dk>
References: <20240118192343.953539-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Querying the current time is the most costly thing we do in the block
layer per IO, and depending on kernel config settings, we may do it
many times per IO.

None of the callers actually need nsec granularity. Take advantage of
that by caching the current time in the plug, with the assumption here
being that any time checking will be temporally close enough that the
slight loss of precision doesn't matter.

If the block plug gets flushed, eg on preempt or schedule out, then
we invalidate the cached clock.

On a basic peak IOPS test case with iostats enabled, this changes
the performance from:

IOPS=108.41M, BW=52.93GiB/s, IOS/call=31/31
IOPS=108.43M, BW=52.94GiB/s, IOS/call=32/32
IOPS=108.29M, BW=52.88GiB/s, IOS/call=31/32
IOPS=108.35M, BW=52.91GiB/s, IOS/call=32/32
IOPS=108.42M, BW=52.94GiB/s, IOS/call=31/31
IOPS=108.40M, BW=52.93GiB/s, IOS/call=32/32
IOPS=108.31M, BW=52.89GiB/s, IOS/call=32/31

to

IOPS=118.79M, BW=58.00GiB/s, IOS/call=31/32
IOPS=118.62M, BW=57.92GiB/s, IOS/call=31/31
IOPS=118.80M, BW=58.01GiB/s, IOS/call=32/31
IOPS=118.78M, BW=58.00GiB/s, IOS/call=32/32
IOPS=118.69M, BW=57.95GiB/s, IOS/call=32/31
IOPS=118.62M, BW=57.92GiB/s, IOS/call=32/31
IOPS=118.63M, BW=57.92GiB/s, IOS/call=31/32

which is more than a 9% improvement in performance. Looking at perf diff,
we can see a huge reduction in time overhead:

    10.55%     -9.88%  [kernel.vmlinux]  [k] read_tsc
     1.31%     -1.22%  [kernel.vmlinux]  [k] ktime_get

Note that since this relies on blk_plug for the caching, it's only
applicable to the issue side. But this is where most of the time calls
happen anyway. On the completion side, cached time stamping is done with
struct io_comp patch, as long as the driver supports it.

It's also worth noting that the above testing doesn't enable any of the
higher cost CPU items on the block layer side, like wbt, cgroups,
iocost, etc, which all would add additional time querying and hence
overhead. IOW, results would likely look even better in comparison with
those enabled, as distros would do.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  1 +
 include/linux/blkdev.h | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 11342af420d0..cc4db4d92c75 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1073,6 +1073,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	if (tsk->plug)
 		return;
 
+	plug->cur_ktime = 0;
 	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4495de020d9a..26226afaeb91 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -943,6 +943,7 @@ struct blk_plug {
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
+	u64 cur_ktime;
 	unsigned short nr_ios;
 
 	unsigned short rq_count;
@@ -978,7 +979,19 @@ long nr_blockdev_pages(void);
 
 static inline u64 blk_time_get_ns(void)
 {
-	return ktime_get_ns();
+	struct blk_plug *plug = current->plug;
+
+	if (!plug)
+		return ktime_get_ns();
+
+	/*
+	 * 0 could very well be a valid time, but rather than flag "this is
+	 * a valid timestamp" separately, just accept that we'll do an extra
+	 * ktime_get_ns() if we just happen to get 0 as the current time.
+	 */
+	if (!plug->cur_ktime)
+		plug->cur_ktime = ktime_get_ns();
+	return plug->cur_ktime;
 }
 
 /*
-- 
2.43.0

