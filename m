Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3737FBA1
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031202; cv=none; b=PjYjHN7vzSmmFi0SzRmHK2NFrUTdFxKuXUbOyBiul+jxUMUFc+x3CF73Vo2NhV4RvjISaLX/24kEsWcYnlGY2c6OwPVEtcueZG+C+WDHYoOJzu7cR3zIIjqfnBxj7gWyTWW679MWYVWXPUAbSDfr1YPxnk81V4qoX3jqgAzZen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031202; c=relaxed/simple;
	bh=xTeZ1MtdqkFINZNWvPzMmND18TlLFbX8py4lgGaKItg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDl5eg7a0omJh1u6Z87ZvI/kx3ilD36SwVCKR6lPlQOar/p0iR2adtfiFsJ1gvEm4r7B5bpRyO01cJIHCiEb8DsMQ4RAL6uktKU8AItHN0p80jpR8p5oYA+3B+EGx9okraEip0rT+fZ1zQih3pmw3jVPUhLLAwfa15kd5H6PuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BLJZjmMg; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BLJZjmMg"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso56467339f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031199; x=1706635999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x81FZEO1B1ujEbVMMlyBpMIKlpsHmPREgp0HyEDYxfk=;
        b=BLJZjmMgGeK44Hrn7Qj39PvnibOCiDMuR1GSkOsuOzJ/24I/JKiwClWH3lhgdOSY+i
         sPpxjG0DOokusYp6r5hSRz0eQ3Bt7sTLU6iBt1quuzLtgyMcPg4y3YPDukoxRDxbR+ul
         zK6dUMPki1k8bc71QXiFOaUBq5xu+nQCGgFDqkHGvCvT9Xa2tlv3rImyNE/P2cVr/cNq
         E6KlvCqIBNqtryGTvTVgv/mVGnH1VF061lvXlnpMoQ/pNoNqocCCL9Jem/eHlFu6bUHm
         3b62SfN14n1Nb1tzhkiuzFQ39iGTZFkjLNx5XihFmkJo4aS1KsEaMCgqsWTXt6TWonV+
         D+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031199; x=1706635999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x81FZEO1B1ujEbVMMlyBpMIKlpsHmPREgp0HyEDYxfk=;
        b=M7DYv7o4CgJTiqnmBn2b1etBlsHIcQk4bj7Wd1a7yeZR7TTARkaS/2Qkkp1OyHc6Vz
         VBWaf/bCPnhrQTT4UnX7ELC3NE2H+tfBsZQDJlXUHypRIAozKGTGj5kH7W9Bz3cli4D8
         03vRoAAFkIigWQRCWnN1reTL0MNhoop6tFUA3PCgTwxiZulDUy3bftGgiNxs/ybF81eQ
         zh8eu1IDxycZ08WKMQpGZt/g4qozu4Olyci90ZkXeS+Xahhll1Y3cfM8MZks/jm/6kYm
         vAwsBAMNq1iRzgWNph6ylOdQ540SLSqG4mRxCUVM9Et8z/IINvVFKGiDokgLYItPOOkx
         w4oA==
X-Gm-Message-State: AOJu0YzbBghzDEyH/kWZRjzln2nmHoZIIHgstx3bABY4oRe0oCXkF8C+
	OlycwtfEoPkTA//5hQfJJLeRVMj2G5ekjg9PvZfeVFBBuCpQcRnLu75d1m6KSgFR8WCLIxzM0Ke
	E1ms=
X-Google-Smtp-Source: AGHT+IFmaRaZCkFqboHS5XbolfwX29kx1gKmj7iYQJkVTWhdorjmZvcbsYeRSijv7C3poMrtKNhl9g==
X-Received: by 2002:a05:6602:e04:b0:7bf:f20:2c78 with SMTP id gp4-20020a0566020e0400b007bf0f202c78mr9470495iob.1.1706031199556;
        Tue, 23 Jan 2024 09:33:19 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/6] block: cache current nsec time in struct blk_plug
Date: Tue, 23 Jan 2024 10:30:35 -0700
Message-ID: <20240123173310.1966157-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123173310.1966157-1-axboe@kernel.dk>
References: <20240123173310.1966157-1-axboe@kernel.dk>
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
index 40d3d7da39a4..d59610483619 100644
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
 
 static inline ktime_t blk_time_get(void)
-- 
2.43.0

