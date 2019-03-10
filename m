Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CBC43381
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28953206DF
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/K3M0uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfCJSNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:13:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33238 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCJSMJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id c13so12356691wmb.0
        for <linux-block@vger.kernel.org>; Sun, 10 Mar 2019 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY00KoFWeTwZXwxCAxRn3goBCIvGzbExPxId3YVmDAI=;
        b=L/K3M0uYUBbqVjojJG+/UOlGrYywm685K9LWp12a8TuqJIqoSV9LLER2Wga7GgCP7I
         iLpBKDlCtw3K61Com+z0O7IohUEHMADZL7UXzXZBeB1TeJrdg+Tka1GCJtth0+Jfyrkd
         Xx2hwFjuBCEcpmNp25XaJYpqayHDsPz0uFYJjnYXz+edXJ6OPiRS4jMUxzjnLyzCJf38
         qPygtOV/g1r6s4Zb74dgntggVsXMO56V4XgIM9C9UNW3AtvMiA3Sx+yFh4aZ3mXL84a3
         +KKFqe8g/6za9sI5EJdlC9fp5WCjhN+1GM9ZU4lA1dXghb5JW4Prwru/RAswNQZMISDB
         7Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY00KoFWeTwZXwxCAxRn3goBCIvGzbExPxId3YVmDAI=;
        b=TWeVJy/rt0QEJRQt7Sr0swkj6hw18cQIxF81WwJODgFx8I8bky/GomcH/xA3/KftHI
         /n5r9Mj1cFg0lQW0WQmmh00XSMCs2Q0pXx/vv8sOk4HiDM3txwvVbW1n6/K92+eLD8u8
         eRnPXtzopGOd3unhI1tVhv9Fl2o9M0UWKsN5InkjCLb4hjT+Q39bIgFCj0vIUCSTyQ/A
         nMQjb2W7UdGN5RUhscYcI61skGrDy+XWRlFqwKBNvBLPL3iCmvUNSta1uU+sWGVTl9jR
         yaq5FhCVLwRB6zWHgbVluA2Z+AjjwFKF9VMSK5z70yAXEvPtU7Z9LE0Wrdvx9XiBLK0I
         l33A==
X-Gm-Message-State: APjAAAWClQYq1yDTg/dxCwu3Uu66v95K7WaLqWpm7SjXPZCL7OGWJCyU
        xJFzjiREdPVF9EhXNl05Z1zM3A==
X-Google-Smtp-Source: APXvYqyegrGTC3Qv7pIi+9NXnVoA9xCsLONvHfMKrXPEzvPOJ/shMfZR3xCW2+Z/8yST3dNomBL3og==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr8875305wmj.77.1552241527459;
        Sun, 10 Mar 2019 11:12:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:06 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 1/9] block, bfq: increase idling for weight-raised queues
Date:   Sun, 10 Mar 2019 19:11:29 +0100
Message-Id: <20190310181137.2604-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
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

