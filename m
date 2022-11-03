Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262FC4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 16:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKCQ0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiKCQ0l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 12:26:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48841B7A8
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 09:26:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f27so6766557eje.1
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dagqyailu11jgL84XY9XZ7ZO8PNuYsgn+9sY89yrA6U=;
        b=LTAk00JKMzujkqfnmS4n9C6M13K25xOsrBRjq085Po13w45O05m+2mOaTyaTAncLa4
         9UJHyBnVz4LyjvxyQohcwXvLNOR/tdMD4gf6fytlKhPPnW0hTdvcpfLRDEGFfqWgckMx
         FRqY92WYCYPB15vGa059T08AvblXfJMFvjSm6y8gBIJzymJ3TZA74PorpnEdVClbYd6j
         6poPVxGvZ0nzRNJ4+YFpdHIlIqPfAB/2uD1Hog0APR78a6WgUgb5LBh/AEvX73XNU+8i
         cvwcocZ4FLnQtduM2rUuoGJw6SfINmcKgLlp/bdvO9FdJE/aZcFn+Ztvdbe/SmLee88l
         aXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dagqyailu11jgL84XY9XZ7ZO8PNuYsgn+9sY89yrA6U=;
        b=w9EWjlwRE/PyScizPEJbGQLsv7reotFgIzOPbNo/VjZAUNIBC+uy6/6Gfx1fV5/vrn
         ACaegAD/Q/1b2y54P4exCNh1VQWOgsjWAevA9W83jwFB559teSN7SbEIp4VDc+emHcii
         Zra+NM/MlazYvjOn5g7ENZDscqzBm25DXTTrDhVEqV19c31qJr7ZmtwiW0TGnX5ZjPx2
         T+zPOSs7y+tjO0ChCuULJUBOfxGFpx1M3LsoW2WcHpjC8uM/fXN7x+2rRkUqIhJQIjYl
         9tf6YsznhIp/eF3FvA+sFM7exDE7Ze/JKrKK4SNunoEF01fuABbwje1EHrUYhgJm027m
         nsNA==
X-Gm-Message-State: ACrzQf1yf9LMrNlxdqjkYslOOY2dtOxcJ5fXW0wsSDoSGOHvczu6O6Rl
        qZn8uRXUBnqjSnTnvKcJswi7MQ==
X-Google-Smtp-Source: AMsMyM52suLzoMN0evTzK6mrWpxg3OuEgpjgpro7ex4kLERSX6Qm1nHeBC5HMTdkHLBlRh7OZdXUHw==
X-Received: by 2002:a17:906:9750:b0:798:9ccc:845d with SMTP id o16-20020a170906975000b007989ccc845dmr30400772ejy.760.1667492798403;
        Thu, 03 Nov 2022 09:26:38 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0078116c361d9sm702507ejc.10.2022.11.03.09.26.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:26:37 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V6 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu,  3 Nov 2022 17:26:17 +0100
Message-Id: <20221103162623.10286-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103162623.10286-1-paolo.valente@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If queues associated with different actuators are merged, then control
is lost on each actuator. Therefore some actuator may be
underutilized, and throughput may decrease. This problem cannot occur
with basic queue merging, because the latter is triggered by spatial
locality, and sectors for different actuators are not close to each
other. Yet it may happen with stable merging. To address this issue,
this commit prevents stable merging from occurring among queues
associated with different actuators.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5c69394bbb65..ec4b0e70265f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5705,9 +5705,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 	 * it has been set already, but too long ago, then move it
 	 * forward to bfqq. Finally, move also if bfqq belongs to a
 	 * different group than last_bfqq_created, or if bfqq has a
-	 * different ioprio or ioprio_class. If none of these
-	 * conditions holds true, then try an early stable merge or
-	 * schedule a delayed stable merge.
+	 * different ioprio, ioprio_class or actuator_idx. If none of
+	 * these conditions holds true, then try an early stable merge
+	 * or schedule a delayed stable merge. As for the condition on
+	 * actuator_idx, the reason is that, if queues associated with
+	 * different actuators are merged, then control is lost on
+	 * each actuator. Therefore some actuator may be
+	 * underutilized, and throughput may decrease.
 	 *
 	 * A delayed merge is scheduled (instead of performing an
 	 * early merge), in case bfqq might soon prove to be more
@@ -5725,7 +5729,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			bfqq->creation_time) ||
 		bfqq->entity.parent != last_bfqq_created->entity.parent ||
 		bfqq->ioprio != last_bfqq_created->ioprio ||
-		bfqq->ioprio_class != last_bfqq_created->ioprio_class)
+		bfqq->ioprio_class != last_bfqq_created->ioprio_class ||
+		bfqq->actuator_idx != last_bfqq_created->actuator_idx)
 		*source_bfqq = bfqq;
 	else if (time_after_eq(last_bfqq_created->creation_time +
 				 bfqd->bfq_burst_interval,
-- 
2.20.1

