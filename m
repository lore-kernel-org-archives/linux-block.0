Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91B24B20
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305118; cv=none; b=gxBUPUZT730qo/KBsNgaHdJgPhAQdmkAAd4WbD4idEAZavsZR4/kItVc40esUkU76Vy2RfseYPA66OjWoS9PdqAPhn10+6nN+DhEUf8sm6c/7HUVxZl5gyjVmsKYQnqh/ijE6+6JoLYERy7eY7XOw6MGZoJMTsbtZJRqnTCqZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305118; c=relaxed/simple;
	bh=oNSRfvL538GzIBzKBlHszo9PbeR+CDrnExjMEyUELH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b742Q6IRqRK6oXSDeYZYuwqT3Ulj9BX0hcSsJ8uxlrlwXc60X8o15mlw0Mv6CoTDNglt5zjqO4hnGbx1F0j7DEcw1bOlWQXNhkAn2zoI6Kb7/siFbV80jQKHKfT8O8TNd8GrDGFTYoWgCZOR1jfV8wEpu5JJLiSbvlnzDGSumrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nZOB0RmY; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nZOB0RmY"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso13042939f.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706305115; x=1706909915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDk0YsdpBtyFP4o00bqufxnHQRLTRO82Ylw8HFnti3A=;
        b=nZOB0RmYGD5oHxbVwH9sBWdc0CUvn+f/nSX90w9py1KetDtxtwEctmRoIyGyDDgwp1
         pTpnR3ZL/XGJr79wghbOWAKuLhVGtw9YVVjIzJ1qsnrNIv3e2w85pXVMvLzoV088WR0s
         l/wdE1YIGci4ugZ5N+pytdVNCaS/KM4PS+FJhBQ11dZqsGgxIBz4OoKnrhOv4izBrqEa
         FRsNutyYAKe6C8TgkpFl1hRcG+1WthiXXA4xqEbWJJIFCtebkB8/rA1rZ9lyUbVw6A5+
         ZIbHlePw8raQ+3xMDuEJZe5sQ6tbmhHzUYS0aMVDqS5xc6eJwZD9P0ABKccDRJLy/UQv
         QkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305115; x=1706909915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDk0YsdpBtyFP4o00bqufxnHQRLTRO82Ylw8HFnti3A=;
        b=xIT4PEub950FoF09eAHN4fOjR0XK7riSMtzcn553Ls0o7jUuH2SGDwjE3iwjNyy7hi
         o6yTe2L9ua3duUGoPggHEeAAQEVf2UW6ODznsJ75ZHzpYdN4KSsMU9C7R4rTVaXJvrRr
         GwGowX3onN4pky/HxBblVn+e9Froa+LeDVwf+qh8HQcqTFntfK4PeWtLppqse2fvDzeG
         AEfxIltiXirrvjrVjyMFyj3/mJYR0poObac0s8Gx53iFY3HfcK6EY9S4wta7IIgEGi/H
         GzlzjSnJ5RCW4U5oFa43oJ6qzbJJrqFHhHeVZV3P1QBWErnbdPerw2Sdr23uW+th7LAY
         EXAw==
X-Gm-Message-State: AOJu0Ywo+eh/m/Tn3SEy2oYLXb7pyL7YdbRK0iDvmvF4OtkAKqnY06eD
	XpxG8mM6bcWbXqiBJVjwe0ykbSNUwrCVrZUFPmkGHtiDKYm0Hqk2s6nskBx5nozo9GgJvAtwYiC
	O8No=
X-Google-Smtp-Source: AGHT+IHcj086MUhPccEVdsQq+xVIwzCPEwCbonbkYnVWX9Un4tK1Wf2VKMwjuz8FSwanTQtz8K6rRQ==
X-Received: by 2002:a5d:9c57:0:b0:7bf:b770:d4ed with SMTP id 23-20020a5d9c57000000b007bfb770d4edmr904269iof.0.1706305114854;
        Fri, 26 Jan 2024 13:38:34 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a029a04000000b0046f34484578sm471788jal.126.2024.01.26.13.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:38:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/4] block: cache current nsec time in struct blk_plug
Date: Fri, 26 Jan 2024 14:30:33 -0700
Message-ID: <20240126213827.2757115-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126213827.2757115-1-axboe@kernel.dk>
References: <20240126213827.2757115-1-axboe@kernel.dk>
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
 block/blk.h            | 14 +++++++++++++-
 include/linux/blkdev.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

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
diff --git a/block/blk.h b/block/blk.h
index 79ae533cdf02..14bbc4b780f2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -519,7 +519,19 @@ static inline int req_ref_read(struct request *req)
 
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
 
 static inline ktime_t blk_time_get(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e72213..996d2ad756ff 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -942,6 +942,7 @@ struct blk_plug {
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
+	u64 cur_ktime;
 	unsigned short nr_ios;
 
 	unsigned short rq_count;
-- 
2.43.0

