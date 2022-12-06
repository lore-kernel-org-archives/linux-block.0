Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FBC3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiLFIQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiLFIQE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 03:16:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915D1743D
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 00:16:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so4434355ejh.0
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 00:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImsIGbtS7K4eRO9+kEH+W1Wsc4a1+MpOkb6mhTvwHcY=;
        b=LOCPHLMXwcs4XzqQFNlU7NqgqlVH99G0Kr5CE/Anfz6qgX7QDZmp4Xx8e9DkY8B2mU
         IWKQ4lOfo3iABTF8w5oHOu/DBdsi/6f49J2xQhbVRAnoRMG2Lb83i4ifp5WCGzU10QrJ
         BU4/0xSRLUYajoSY75AnkeOATXgkvtQdFHBVmNxnZ25cEhIzDQEpZ+VfPbw0l2r7u8Oz
         AgdotD4+LMdAW9EQEPO6iapd40iGqFcK9St6kKJJJO5dM3DHHiXq26t5Z4YqDzBHFidj
         GmxkX00z2H7Kh2amWyaXZ8eRtvguEAJQonPnJtGVps6lukSKN0OVp0jxt85eJJk67anV
         snOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImsIGbtS7K4eRO9+kEH+W1Wsc4a1+MpOkb6mhTvwHcY=;
        b=6YwSRxsDG1V4hyCUikDodINihAvEX/nyYJiv0gDhbzLiN9vq50VQ+UPf3/9nDKLad+
         P9Drvf+7Ps5MF0Y69Z8ZCX863aVBOPTdnpPyYCRJGgFwP4xg8Ecnje8Mj3VOry2VELY9
         SCw5xRD8YNdh36FI7YTflOGErjK4Lq7Ic/KC6nW+mzoR4qPMUoh0uBpILQqJ7CwHBQL9
         J3KDWjUmph0e3/5S+8nTsEthjUrPOh42LqH6+77PteQrVGfEO/ZGbcm3rNihf2J4Q6mn
         zpbgIPEt+H/WnVhVx0+K01tglAo88NJGi+JzMWdPjI0j6NTWsb/M0xmd0tl9nbrXu8NP
         sbZw==
X-Gm-Message-State: ANoB5plI7BDxSCNmuafWmxC029jffCYPfoiDgOad0Tz9+BVOJ7/Y792D
        +mJ9OMTDtPy/pByy7ByvZ4O0yQ==
X-Google-Smtp-Source: AA0mqf73EGwpI4LALaoGasuN4EZ88xWdgPzOnBN/80ljBrrKb3xvXwaclajqUAx1l4N8E13SJG5srQ==
X-Received: by 2002:a17:906:b08b:b0:78d:e608:f064 with SMTP id x11-20020a170906b08b00b0078de608f064mr72162075ejy.34.1670314559943;
        Tue, 06 Dec 2022 00:15:59 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm7161944ejw.148.2022.12.06.00.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:15:59 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V7 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Tue,  6 Dec 2022 09:15:45 +0100
Message-Id: <20221206081551.28257-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206081551.28257-1-paolo.valente@linaro.org>
References: <20221206081551.28257-1-paolo.valente@linaro.org>
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
index 127aeecaf903..03cea06fa9d4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5708,9 +5708,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5728,7 +5732,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

