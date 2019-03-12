Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D8C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7807D2147C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxSGFbhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfCLJAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40522 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfCLJAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so564426wri.7
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPxdu4FfztX2fjTuYHQF2xv6a9EM4Wt9HqApVzFZrNQ=;
        b=nxSGFbhgUV0GSjJ9o0aDkRUnhb7rF4cJZtG3yJI9SPaZe2touaWmq6dTzIQY4cRU5+
         M7c7dYRu+uAfqfNYcdYt9snPLYlW8d7Y9FDxZNoAUq193PlzQyJBqYdKkoGkR5xLeWpd
         wwyU9CrT9T4ZqluwiVHQGN0Susi9hncsYO3TS9lR+fv5qvLyDtapVYBQ7ItRP1j86pWY
         /5gbuYUSKD+RkoG1EduH4lBiCwb6lpIsAHe7mPJvj4d/j+EwwlMuhlqIAVILdaq2TN/I
         j/1IhcQT57Tj4Zu5ODQPBcj2ndBq6dU7vAsvwfG1LpPKyhnqsdJV0MlQSVzMs2GWttMC
         SxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPxdu4FfztX2fjTuYHQF2xv6a9EM4Wt9HqApVzFZrNQ=;
        b=B+XbPLcponSHnogVUe5tXly+NTWMfxsOvbdLqf2y3uJB3kWJfoGE+jmfNiHRU6Nocx
         zL1x6NGUCKxHowZjnvrt5Xehn+AoceRL1tb+Coq13+kSpdSmZ1iD4Wpk1T5YtNSHqSaQ
         vTchNNcYP9iekSG3mqrasHR27DnUHkYAios0tsGXyncACJptNxux1JyCKDx8GfXe9i5C
         oltrqegtSRNQnMQti+Xr7NzwGQyNPZEFlWZTMTr3eFqingYuu8Nfv1Cow4LEujFvkQXx
         AqNIp8ZeTM8npF44a1ec+Y6qOYAE8xqfjf+fhNZJtFBxQbxkjNsEI0y2n8fRUaONYE+g
         oiJw==
X-Gm-Message-State: APjAAAVOsINSuaELyOTvJQXMrH1mfB8F5TApVs7gdULwuEzA4k6wZEtQ
        GHP3YjhuaiSDJstOGorLJRz+AA==
X-Google-Smtp-Source: APXvYqyKWP8lF9pFQ0dLb8HO7lbor9P7IFQ0hqr4pM3qiOTw9FiJNUIz/DbqEYEjIIernPF2ufnULw==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr10000720wrr.160.1552381203408;
        Tue, 12 Mar 2019 02:00:03 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:02 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 1/9] block, bfq: increase idling for weight-raised queues
Date:   Tue, 12 Mar 2019 09:59:27 +0100
Message-Id: <20190312085935.11340-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
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

