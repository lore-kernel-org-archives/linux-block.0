Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE841B598
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W+GxuwJB"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2041426d274so1728364fac.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705355928; x=1705960728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9Fy06bnQuFSMtFjWOW5Sl26tKwg2DINRjTsQuochcU=;
        b=W+GxuwJBna3K8kAF6Cz9DwRz+D54aKkNtA/P6bzg1kd9O4fGWjIAfYj93dQ3hv05zo
         PX7iIbq352UKOdm/Vf9VUX/PuOXSjR1oxzza1bsUQHv4F1M282F2z4tGnDkfe8B4UQmT
         b7qwtIltbYuX3k3kQfkecqOWh/mX8LfFhbmpWWOyNKQTR1/av2zYtNkcrQOKGDpjW1v5
         KF5MWkmfZ2hOiG15TApkse8VzNcE/QJjax1UPaFNqDilqJ0UJn3Mh7NmnjD7NjAG1kT1
         4h9irmhoDWh2UrtaShi6MUw4LoFWRbKXwycQJAi0MRPmhB96X30ev6kIZmtLCGWNuiSU
         8ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355928; x=1705960728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9Fy06bnQuFSMtFjWOW5Sl26tKwg2DINRjTsQuochcU=;
        b=txMSYc9K07/9k7w/C7aVOQXWMAFdtUDqiuD25XKgavmbgxUnLzczwQt5IenpF+sIQt
         t7XZt3uQ7zMkovK+IgcPwnzrNXmQUmgW/3fbqlzlqg94dgZlFxiXEVBwImGp02sdEgbH
         28RRQaq5znUA5h3kXD3Z58TtTO1rqB/27wzcmfwSnOcf+e/essMkbeyGYV+JNxAt4reA
         yvQj1l27LGqOwdQm8Fg4ChfP+HUqgnRqQpswwNA1aSMnkWH6FUx31XMeh+4ePIS+M56e
         uf4swFKPLFcKl4sgoy6qwPRjVATBc+hpMWXSbQ39YeILC7UwMiCWOAXJmisdwkVbZcHM
         xPfQ==
X-Gm-Message-State: AOJu0YxvtTQUf7heTJguziemXcq5QzUZbLbscxkBsE9OZ4VGPm7vksff
	gbvPdm/4Wqp3h5fjmfQ4PudHFGpWJfcE4KQz6/cUE8VYLBuBEw==
X-Google-Smtp-Source: AGHT+IE35ud/UeryH16wHKzk2kgCrF+D1rKnUPye525Z+JODr9cvxj9PG+W4/HYTAiTktmwRHZxACw==
X-Received: by 2002:a05:6359:4127:b0:175:dae3:e564 with SMTP id kh39-20020a056359412700b00175dae3e564mr5613609rwc.2.1705355927722;
        Mon, 15 Jan 2024 13:58:47 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o6-20020a056a001b4600b006d98505dacasm8072764pfv.132.2024.01.15.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:58:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Date: Mon, 15 Jan 2024 14:53:55 -0700
Message-ID: <20240115215840.54432-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115215840.54432-1-axboe@kernel.dk>
References: <20240115215840.54432-1-axboe@kernel.dk>
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

IOPS=115.57M, BW=56.43GiB/s, IOS/call=32/32
IOPS=115.61M, BW=56.45GiB/s, IOS/call=32/32
IOPS=115.54M, BW=56.41GiB/s, IOS/call=32/31
IOPS=115.51M, BW=56.40GiB/s, IOS/call=31/31
IOPS=115.59M, BW=56.44GiB/s, IOS/call=32/32
IOPS=115.08M, BW=56.19GiB/s, IOS/call=31/31

which is more than a 6% improvement in performance. Looking at perf diff,
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
 include/linux/blkdev.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 2f9ceea0e23b..23c237b22071 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -942,6 +942,7 @@ struct blk_plug {
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
+	u64 cur_ktime;
 	unsigned short nr_ios;
 
 	unsigned short rq_count;
@@ -977,7 +978,15 @@ long nr_blockdev_pages(void);
 
 static inline u64 blk_time_get_ns(void)
 {
-	return ktime_get_ns();
+	struct blk_plug *plug = current->plug;
+
+	if (!plug)
+		return ktime_get_ns();
+	if (!(plug->cur_ktime & 1ULL)) {
+		plug->cur_ktime = ktime_get_ns();
+		plug->cur_ktime |= 1ULL;
+	}
+	return plug->cur_ktime;
 }
 #else /* CONFIG_BLOCK */
 struct blk_plug {
-- 
2.43.0

