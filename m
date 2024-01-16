Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A61CF8A
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="owIvX4xs"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso69759039f.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424301; x=1706029101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDwQsQA3hkrp55OhYNyh1i/vP5KE9MQ17MazH2WqV6M=;
        b=owIvX4xsq6op9rGtK0gbPBaGCx72hC8obEhkR2q17l2KwHJfZtN/JivmRL/pVEBv3e
         zwA+nUSqbrDt46Z+KQMEgRNsZDbqkd8ngRukYyHwLgQbamg7cDvKruEF3ZemrE+5YUx6
         t2JYJegZBvjUC5iLVVLh+Ajy9D3vpeq1YUYO0NbSjEb7GrTgXe6JRGm4GoXiRhnf3FNJ
         EFRpHFWmpKPnM8666cFFIb637NiAiTiWTgVZrBcPfN/9hygzX+BW6S91/WW3BIvR0R0S
         UylryzP3ipKxiAGDVIRBKdaFnG6+EaidZmHptQ/z44qrcYI3dUO0nN6759wTx892syQt
         nVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424301; x=1706029101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDwQsQA3hkrp55OhYNyh1i/vP5KE9MQ17MazH2WqV6M=;
        b=fDQ11EpDuJTSZZFOVEN9uH3E3qJ6iQPJFulBV0ht6P6xIMC70oNa7Tj2e5aEWejKtN
         yisR7pU8JcOjc1qV1F8C/vkwEjWsfDzSrdSHeB/m8cmcei+bgoT2GF61jAYDoRUGP0cn
         OkFXws2YRtMxNiGWtTwlP2ZXMYoUfTAtSD89S3ZYURfuiluvZK5QLOVoZVe0dGVC6Aww
         JgaAd+vX+aabZJ9Ys6z6s2gvr1/1mIK/JT0FGgZk6T3rxVpSQQfrGHY1cws/yyP9FZ3Q
         UW0psPd1tlZqxyd2fiD58CHGuCe+VXd24YquYAdQV6MvWorGtmMDDpJNY0s300vKamjD
         OfIg==
X-Gm-Message-State: AOJu0YzB5O5/S1bkX6ozLIjhwhDNdLQlbK2i3/0YTuDJH6bqIrRKGJ3k
	Myoamz5DU7546m3tcLm+MTU03Oz70x3HXZis1HY97kKaoweKBQ==
X-Google-Smtp-Source: AGHT+IFiJXR7sSD2hYGXtzufxPNLROXFEsJvNVZ72a2vQhxn8SnCuGx1RmLXQunSsXEFHq/pqLCKdw==
X-Received: by 2002:a05:6602:1799:b0:7bf:f20:2c78 with SMTP id y25-20020a056602179900b007bf0f202c78mr12414747iox.1.1705424301644;
        Tue, 16 Jan 2024 08:58:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a02a60e000000b0046ea43e4d0csm71744jam.168.2024.01.16.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org,
	joshi.k@samsung.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] block: cache current nsec time in struct blk_plug
Date: Tue, 16 Jan 2024 09:54:23 -0700
Message-ID: <20240116165814.236767-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116165814.236767-1-axboe@kernel.dk>
References: <20240116165814.236767-1-axboe@kernel.dk>
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
happen anyway. It's also worth nothing that the above testing doesn't
enable any of the higher cost CPU items on the block layer side, like
wbt, cgroups, iocost, etc, which all would add additional time querying.
IOW, results would likely look even better in comparison with those
enabled, as distros would do.

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
index 2f9ceea0e23b..2d5c94e99792 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -942,6 +942,7 @@ struct blk_plug {
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
+	u64 cur_ktime;
 	unsigned short nr_ios;
 
 	unsigned short rq_count;
@@ -977,7 +978,19 @@ long nr_blockdev_pages(void);
 
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
 #else /* CONFIG_BLOCK */
 struct blk_plug {
-- 
2.43.0

