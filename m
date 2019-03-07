Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36EDC43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF392085A
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z75T8hDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCGQ0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:26:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52176 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfCGQ0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 11:26:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id n19so9840626wmi.1
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY00KoFWeTwZXwxCAxRn3goBCIvGzbExPxId3YVmDAI=;
        b=Z75T8hDpDi1+Pm2Su4PJKBxlbasjZjnSzjQhz6b470S0GFTTqJjFMS5NDxj7nS8LFE
         EJI/QQEJkG9kYknYgewNVTSsJ/HWO7vg9FxArz4inYurRrFOqySHiTUyNqILlvVb30vi
         sTOvXKmbe/sKdF1RarTKbSacGJHh8/XkrV0pvDu9XQGVRkAlc5ZNLBS2Lpa8NjUjEt+k
         iKHuxgZcj/U26ihOAHhUWWoBwC2O6hr3ZclZUCeVrHLQXuU46Q2WUL/jnaFZysIyQ6xS
         /Zy1PPDhalZ499zka/rYiXT90YBa6BrMCDipljv/JTNym10GlCxj39gRoaNPamySrQpu
         DbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY00KoFWeTwZXwxCAxRn3goBCIvGzbExPxId3YVmDAI=;
        b=sVUwKpk750JZcbCrtVBUg52ct2C6oPVG6mfwdKW33fHT/aoVlnjjM3wG4NO03Y6Aoe
         8zAvuI8tiDgw62BJRmvQjkHZZP4t0EJNSc3jVd4T6AVnabZIbH8Dep8YxtpKCqAJMlEH
         7AoaaOMstViTT4Vloa2tGY2phR8ufqY8MKwMStiMfYeSnKwG/vuYyBHI3a6UtEQvzFxJ
         0Yi3pvldBs4LiERqk36HKUNk1LOjVW0n20NIcN/GMYox5X8H07/tqMVdMmRG8OyI1re/
         dwA1svJi7Wmx7nkCFggd7RVTo/y/L8aNcZ729+wh71s+WhcRoPNdW3yoZeb8Dq2jIGGl
         Zpkw==
X-Gm-Message-State: APjAAAUBKjFmnvy6qdRokKJtYliRg6A3Wjf/mR+FMbz4ohYrSSxnh1NK
        0dxcZKCFrQc626gNL6hZyH8GhA==
X-Google-Smtp-Source: APXvYqwreVUTbda8ram5neCUVwW28gXm/sA8BYFuv/NZ2S00BCW2WSG6qhCFY1qHXhUMx3S40kpIIg==
X-Received: by 2002:a1c:9c0e:: with SMTP id f14mr6529463wme.78.1551975972267;
        Thu, 07 Mar 2019 08:26:12 -0800 (PST)
Received: from localhost.localdomain (146-241-117-61.dyn.eolo.it. [146.241.117.61])
        by smtp.gmail.com with ESMTPSA id o127sm5801797wmo.20.2019.03.07.08.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:26:11 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 1/8] block, bfq: increase idling for weight-raised queues
Date:   Thu,  7 Mar 2019 17:25:47 +0100
Message-Id: <20190307162554.77205-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307162554.77205-1-paolo.valente@linaro.org>
References: <20190307162554.77205-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a sync bfq_queue has a higher weight than some other queue, and
remains temporarily empty while in service, then, to preserve the
bandwidth share of the queue, it is necessary to plug I/O dispatching
until a new request arrives for the queue. In addition, a timeout
needs to be set, to avoid waiting for ever if the process associated
with the queue has actually finished its I/O.

Even with the above timeout, the device is however not fed with new
I/O for a while, if the process has finished its I/O. If this happens
often, then throughput drops and latencies grow. For this reason, the
timeout is kept rather low: 8 ms is the current default.

Unfortunately, such a low value may cause, on the opposite end, a
violation of bandwidth guarantees for a process that happens to issue
new I/O too late. The higher the system load, the higher the
probability that this happens to some process. This is a problem in
scenarios where service guarantees matter more than throughput. One
important case are weight-raised queues, which need to be granted a
very high fraction of the bandwidth.

To address this issue, this commit lower-bounds the plugging timeout
for weight-raised queues to 20 ms. This simple change provides
relevant benefits. For example, on a PLEXTOR PX-256M5S, with which
gnome-terminal starts in 0.6 seconds if there is no other I/O in
progress, the same applications starts in
- 0.8 seconds, instead of 1.2 seconds, if ten files are being read
  sequentially in parallel
- 1 second, instead of 2 seconds, if, in parallel, five files are
  being read sequentially, and five more files are being written
  sequentially

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4c592496a16a..eb658de3cc40 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2545,6 +2545,8 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 	if (BFQQ_SEEKY(bfqq) && bfqq->wr_coeff == 1 &&
 	    bfq_symmetric_scenario(bfqd))
 		sl = min_t(u64, sl, BFQ_MIN_TT);
+	else if (bfqq->wr_coeff > 1)
+		sl = max_t(u32, sl, 20ULL * NSEC_PER_MSEC);
 
 	bfqd->last_idling_start = ktime_get();
 	hrtimer_start(&bfqd->idle_slice_timer, ns_to_ktime(sl),
-- 
2.20.1

