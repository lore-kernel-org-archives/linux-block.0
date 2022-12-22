Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7442C001B2
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 15:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiLVPWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiLVPWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 10:22:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB42B26D
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m19so3348335edj.8
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtH7LxX060k0vsDW/XqMPuFbAPOrnd2PVUVe5DSzj+4=;
        b=SyZ8248IKsxyP4QBOJWJXbUJ6RYDjgmX0jjU+b4JD0NbiHxDy3zTpRuhlPfRRZ3vR7
         XUEKgXp2SW1iiPmamluGV5f+F4q4ognbBcWUxjzaYBmlebqf3/QGeyBSOxRDT8uLi/bq
         HRXbvNaY7GVnt+KoA2dzIGe+divX5xcIG011pCEEmr30J68/jPDBEUnDWT+VluWAr32N
         tSg0LiaRRGxKpsYbxBLWYFXHRhq2v4+pKchZk8RPDlZ13wzz80sEW6b1ub6TRH8kA7ZQ
         kptaNfcJs6WST7cVL+FQUOf0mOSWktM/eXFzQJRBUpnJrT1NGUq0OnkfkIpCiU41MumX
         L9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtH7LxX060k0vsDW/XqMPuFbAPOrnd2PVUVe5DSzj+4=;
        b=C6aoM85Ndxhk+w9MEjnCo4BsHl6LOwyz/pzhvQ973ZoIDGVacx0IhRauSq7H91ZsHy
         gR/SzK1sgqDMi38FlCe8FH+RJrBz1xSOG8Z58ywLu05ZoXmKWZmcWnKRzSZxZbM3H/39
         XFis/R9xSupx7MJTuJfnnd1x4YJQMKCMVM9mzuyIrWDiZdUXN3yDwEwxU53Y19GSkKq/
         AiMbEByY0/p/xz80LeEjRexmkJxtA//EE/EmXNFar68uEqc0Y+T5aGyy78mUlGTuL4Gv
         zYgvKNH5aaolu8aCZAJlYS//FW45qGlohFxmy/bJ0U0biLCwSCC+VO81FQl9mH0MYw7K
         5+DQ==
X-Gm-Message-State: AFqh2koXibt3o0LujuERI/z09rP/o1Buaf+j8zG65khJnBuTcnLYPmfi
        DuCLtEdiDC9J+ZC7sghiV9RLzA==
X-Google-Smtp-Source: AMrXdXvXeolkOtf31taEI2hlKfRyGEJ2Z5AswZy2mKZttJpeYh/Dt0BFiDDagIt0SZNVvqGJwe3Y3Q==
X-Received: by 2002:a05:6402:1caa:b0:46f:a73d:367c with SMTP id cz10-20020a0564021caa00b0046fa73d367cmr5096496edb.34.1671722526567;
        Thu, 22 Dec 2022 07:22:06 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007c08439161dsm355670ejo.50.2022.12.22.07.22.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:22:06 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V12 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu, 22 Dec 2022 16:21:51 +0100
Message-Id: <20221222152157.61789-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222152157.61789-1-paolo.valente@linaro.org>
References: <20221222152157.61789-1-paolo.valente@linaro.org>
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
index e889d50147e8..437744147829 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5651,9 +5651,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5671,7 +5675,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

