Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923FC43217
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 09:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJDJnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJDJnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 05:43:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00334DB78
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 02:40:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z23so10880529ejw.12
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lkj24CwnqblrU2r7BP9tYzNtlqxQyj6cU7dT5FOgpSw=;
        b=GMFbjSxm9o1TQamkt1NbybYxlFvue+3r266VqXcJfN6PdccRZvTT25BUA0sx0RIvrN
         D3xSAlTqHaPSGUS4BavTR6i5tvrtHLmwm2Q3BJG45EJgATv7eKfh+GecaFT/3YbCbfGd
         q4bwAUsX9YeRwxM8jPbBWaJzwhbyQojNDhuZfB/lnlcI3Iyr85Wr3FzhqM59hpioueOx
         xEUiNDmyGsEKoGzO/skMGT1k7rxanGOiAi8rDHwLZxXZbmTeBsgavCPkD9I7fpN54WVw
         wXpfDECndz0rfteQw5GHbTbxnv4Iy99uPtFp2Si76qmUVzX3ZYjc1aGKDEftu+SvWFPm
         C0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lkj24CwnqblrU2r7BP9tYzNtlqxQyj6cU7dT5FOgpSw=;
        b=hL7FCXP4kcGRfUOhO/30uY9IQgg+Vevg9gOftz7AIsJWJcciy27xlQ9WRi8jOC2fuv
         TdOhOBgBq1SLQQxx2/rVqnjUnF/J6odTQtzpdnpiocffS8hpHqHTF1ruZ7OUFpOjRJnq
         +WRJvl9RQdqV3IZwOOKopbIClf8QNVGNGDxvvphnXJZUkbvoMGAko0UEbfzytvbtI/pB
         p9v3jMzB4m8bjqmHXJkfWZhQ4s2iHFzBLI7a+9SeEy40hrvif5Xvj6+qpFRJwOwe7mYx
         pmhPa+hfExyFylgpMzdi+jdlYgesL+tUztbE+kjs1AVwH1uVupsEi7h1qu2hLCs7UFFt
         p+uQ==
X-Gm-Message-State: ACrzQf0iXXoMM6hPy4kyPgRJSij6ruA901pNIqLIroxBdDaYIB1sN6vw
        By2fnIBmFDrFfxiYHPQIkXe85A==
X-Google-Smtp-Source: AMsMyM780m0v4fpvF9zALrlRv0AoXqheCq3eP6aMp5XLnmEJF6Yh+7mR2S5FvmcYSYlyorkVSXV+MA==
X-Received: by 2002:a17:906:8a5a:b0:781:6a01:5ccc with SMTP id gx26-20020a1709068a5a00b007816a015cccmr18201757ejc.118.1664876425650;
        Tue, 04 Oct 2022 02:40:25 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:25 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue,  4 Oct 2022 11:40:10 +0200
Message-Id: <20221004094010.80090-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004094010.80090-1-paolo.valente@linaro.org>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Upon the invocation of its dispatch function, BFQ returns the next I/O
request of the in-service bfq_queue, unless some exception holds. One
such exception is that there is some underutilized actuator, different
from the actuator for which the in-service queue contains I/O, and
that some other bfq_queue happens to contain I/O for such an
actuator. In this case, the next I/O request of the latter bfq_queue,
and not of the in-service bfq_queue, is returned (I/O is injected from
that bfq_queue). To find such an actuator, a linear scan, in
increasing index order, is performed among actuators.

Performing a linear scan entails a prioritization among actuators: an
underutilized actuator may be considered for injection only if all
actuators with a lower index are currently fully utilized, or if there
is no pending I/O for any lower-index actuator that happens to be
underutilized.

This commits breaks this prioritization and tends to distribute
injection uniformly across actuators. This is obtained by adding the
following condition to the linear scan: even if an actuator A is
underutilized, A is however skipped if its load is higher than that of
the next actuator.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4deb0f6c751e..074b6ae77242 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4800,17 +4800,25 @@ struct bfq_queue *bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
 
 /*
  * Perform a linear scan of each actuator, until an actuator is found
- * for which the following two conditions hold: the load of the
- * actuator is below the threshold (see comments on actuator_load_threshold
- * for details), and there is a queue that contains I/O for that
- * actuator. On success, return that queue.
+ * for which the following three conditions hold: the load of the
+ * actuator is below the threshold (see comments on
+ * actuator_load_threshold for details) and lower than that of the
+ * next actuator (comments on this extra condition below), and there
+ * is a queue that contains I/O for that actuator. On success, return
+ * that queue.
+ *
+ * Performing a plain linear scan entails a prioritization among
+ * actuators. The extra condition above breaks this prioritization and
+ * tends to distribute injection uniformly across actuators.
  */
 struct bfq_queue *bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 {
 	int i;
 
 	for (i = 0 ; i < bfqd->num_ia_ranges; i++)
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_ia_ranges - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

