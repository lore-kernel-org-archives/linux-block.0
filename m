Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD6C3DA7D
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiL2Uhs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiL2Uho (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E215814
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 12:37:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so47345904eji.5
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu2Bp3avWp+ua5WBjxSJKabJBT3O2LRwTKJPgSSWaGY=;
        b=J61TpuOQz0dlHt7rlxRtCP3uv1Z8FPHT2neu1sGs3/sq/Sv6Puad8p18yVZRtiCySC
         P+5ra7/JjBLOUFnhfawToplWhlYfJ8QGciLeikBwvOMu7KTD8WMERoM8XmlAUwVDpivF
         shOYpP/LBhdwZjd00IGK5Yhe8oPvwVSyCyozWS3jY+Td5ICDl1SqzZO+Qz5b0yAcmP8c
         MxpfpKCBKGR9sFCvSKeGMs81mcxikzqsLgDLoo518XRWjB0GxCUr9k6sI+DDvi2s5V8V
         jI9XpaAY82xoGOckYYs1a7EVlz95wz9QV0obpUiVIl4/iTTv7WyMUwyLMzqYatof1M7v
         JXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qu2Bp3avWp+ua5WBjxSJKabJBT3O2LRwTKJPgSSWaGY=;
        b=WLHoEVebx9RTLApZ7iC8dIiBfmuBNk3v/wJwIxD5nQGZalC3vGMGdaFl5qRLjx818h
         iowVcXtm6zTKjbSuM2Ab52if4UbvvMkWM5+OL6kLx04j+rLNOdbwban1mymfUJ9g6amP
         ZK0Jhv7JbNU9UhtE15g5UwtM5Jseb+ueZICGtI3QfddWHvA9r33OT831HgKZh8dkJTe7
         z/lk3Cysb3nIr2QB9y8YW/GpEyEsJcTT46tvmyT7Ush7+7IMJbA2cAt+xfCxY5oApyPE
         1ut7AAk23rltL9DRtWc0nimeWRLDN4gYjgYu3RD1aJJzUs/jqbrxQzB+bcL6RNZHzGPS
         PlLw==
X-Gm-Message-State: AFqh2kpEneH85VjRlvEmDwvER5w6nSMCV+rst7c7VoBplZ73VDckfas3
        an603E1Eby4omL8631IVAQbvww==
X-Google-Smtp-Source: AMrXdXszrXhse4Qz9szBouzaMHX25dA7rFzloIJ6HotOtL7+h55wT0KSklGyBnryLrvdlaPDavKAZw==
X-Received: by 2002:a17:906:1519:b0:803:4426:d31d with SMTP id b25-20020a170906151900b008034426d31dmr23462289ejd.11.1672346261060;
        Thu, 29 Dec 2022 12:37:41 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:40 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu, 29 Dec 2022 21:37:01 +0100
Message-Id: <20221229203707.68458-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221229203707.68458-1-paolo.valente@linaro.org>
References: <20221229203707.68458-1-paolo.valente@linaro.org>
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 801fd66df651..54d629639c1b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5647,9 +5647,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5667,7 +5671,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

