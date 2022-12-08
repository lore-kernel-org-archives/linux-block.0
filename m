Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA8FC4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 10:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiLHKtp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLHKsu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 05:48:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3E51C30
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 02:44:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i15so1536320edf.2
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOY4Ejzg/9nAKzPYo9tETGRaOoSPvAWifxplSzBGXYw=;
        b=cDvtWPvf3S8NQ0fSkfns/Z6fkpvUbHGNiMlgP5rHJmAIJJ3gdhSwr+Ct+fE6bKpMyH
         Kyowaj7BdY6BUilN+ffaZ4FZr/895aMTTysEHE517g0mCsydJxDpfHxD9/gN9fpwmHHY
         o+vfejQrND/Vc2WPHgebfl+3y0sLQHLoW+kaR+PRnkEL2cnIpjpneq9jEDLcvYLcl4X9
         kwiMJAQI1/WsxSUi1sGBOgRdwADaoQQpKB6Lm8f7Lp8iCMrTd24/rsv04FdEM30l/Gba
         QZCZtWtShZLblG4OfO9JO2qGGQc7en+24D3ol/7+Fme1C+wxJqzYNEDswr2uO/J8WMZz
         2w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOY4Ejzg/9nAKzPYo9tETGRaOoSPvAWifxplSzBGXYw=;
        b=6MFq1xk8A/sOCD5KkEGckEFgp8y3DJbjfeAQEJDscx/9Z6jpxEE8ibo7tJ7hiX7RHl
         88mzCBx81rmRffbUjIbh5KdLhQWu4KUi5alM432oL2s/p0E3sf31tEwFFSQi7l/OTX0V
         /CKWEAYXAMs0aNwzQJ17Ae8XAVQbTe6wK+tITDBil6Z1uK3DfLN0vvE2UgLPJWo2vVbb
         0QpMue8Roei1MLKgZbJ4fKrh0LVzNKygmAHujPHiWSa/uYvLF7oqbNDSqQ6cgV25s/Jn
         GjC9093Wg5dmM0+iRkLgovOe92FOcsVc/4k0Ut7i2E7u2H0GjXDomVDduBiYMiF1H5sl
         uwtQ==
X-Gm-Message-State: ANoB5pkyAYTJXd974Xt2gXRTeY6mcfO8ZIf4oi7ygDlWTxRROJCeIXlY
        rCMqPp7s8ympNYYBhJ3UQuPN4w==
X-Google-Smtp-Source: AA0mqf5DbytpsRHY37Acv77YDMF7k+SRvEDaeQeJULi7KDFF/PCAnkZWmS7C0RPVZkyH2ROxgNsXHg==
X-Received: by 2002:a05:6402:2946:b0:468:febe:ebab with SMTP id ed6-20020a056402294600b00468febeebabmr37209892edb.337.1670496245540;
        Thu, 08 Dec 2022 02:44:05 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9544193ejc.210.2022.12.08.02.44.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:44:05 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V9 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu,  8 Dec 2022 11:43:51 +0100
Message-Id: <20221208104351.35038-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221208104351.35038-1-paolo.valente@linaro.org>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
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
index 16230a9cf794..016b1b73aeb2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4831,10 +4831,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
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
 static struct bfq_queue *
 bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
@@ -4842,7 +4848,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 	int i;
 
 	for (i = 0 ; i < bfqd->num_actuators; i++) {
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_actuators - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

