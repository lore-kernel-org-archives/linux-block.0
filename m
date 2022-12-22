Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC3C4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 15:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiLVPWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiLVPWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 10:22:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11462B617
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id tz12so5637587ejc.9
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9prY/JmhXfW74Kc/vxfSBhm8Ub6K/Is1u+4OJkmvt/8=;
        b=hn93Pgz0XGh9MuNVPN+nzpVDPXpHL5yvrKu+5qfdESeOWYAgFtg2OyzNkpMs94WgiC
         WMcuI8NUgowcSYw8age6bQ0bWNXmSyGTV+eZ6HiVpQL+pml4aNDIHk2YaF2BF5F1iOy7
         Fu7u19coZWI858vbn7ivpXUZJ3RJ5+GxBBmGH9rdQySqE7HjqDAellNQA23zT0HBwS0V
         zBgTSwHwe8Ze2//HnKD0YdvLE8jdG6zz/xaG4sMRMe2QC6k0QMvGwdOWVowZK+/HLZFf
         v3HBQ7xGpNNxiOlTWsLbFkN78Cjm6XzForEUYxd8jFmRxWLTrqoafNBLhFqQ7Fkqb64j
         L2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9prY/JmhXfW74Kc/vxfSBhm8Ub6K/Is1u+4OJkmvt/8=;
        b=6bv4hVY56jGrsth3vQM69+0BQ6+mCZXRt14BATEgms6WYYYfCz3JxMgnAM3yIZyX3U
         roJ2sGaruoQRMU3gblNSPReQQrwYQsNIy+HA2+odKwTllfFhJyfcDh6nr3ajaWHwkkDZ
         voVhY/UV7QWukw62MG8SCDUOxK/OCti/lBOmlOb1cvCuXdU79TUU/YCdVd2OASO6VDMh
         +y3bWlnvyrijk8Nfa27eHWgVNPWT6DjHYauUWqwFb8YNZCOquUAygVunNO28TRg37GQg
         AuAYc3sNRxnzOOG9unZ11dipf03vQUqxjxZzhjvZufk/yGsR1qMDEQwyTGYtHdTR9d30
         u6Lw==
X-Gm-Message-State: AFqh2krBUoJ/57zXEDI3rjJgyy7L7tkC4THhziRuvDM4zjAwvWPSD77+
        YKG7RYR/jSj5gJ7QdfBce/RN/w==
X-Google-Smtp-Source: AMrXdXtiCefgdm83WdC0rb7pqHzl4oPGMfPQ11wwOpD/6NtJMaG4smOj62xiA0Bxqekt7g5Zpu9J1Q==
X-Received: by 2002:a17:906:8384:b0:838:9aba:6a06 with SMTP id p4-20020a170906838400b008389aba6a06mr4955351ejx.39.1671722532278;
        Thu, 22 Dec 2022 07:22:12 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007c08439161dsm355670ejo.50.2022.12.22.07.22.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:22:11 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V12 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu, 22 Dec 2022 16:21:57 +0100
Message-Id: <20221222152157.61789-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222152157.61789-1-paolo.valente@linaro.org>
References: <20221222152157.61789-1-paolo.valente@linaro.org>
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 132c5874eefc..f69dfa659e34 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4771,10 +4771,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
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
@@ -4782,7 +4788,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
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

