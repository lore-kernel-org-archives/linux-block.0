Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F390FA3740
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJ3KDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ3KDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5296BA0
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:03:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud5so22856347ejc.4
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dagqyailu11jgL84XY9XZ7ZO8PNuYsgn+9sY89yrA6U=;
        b=T9Fs+8e83L0bqfPmtM639a+YtCRBr5w4o65ZRTQeHdi6bOvQ2M+n9GYOuQdbiXrPx2
         AM10J7h1PtP7OamKIIoXg2/E8f+KqVpVdjkQ4ksPCyM0UH6cLHxTsLuK0nwWhzJUBzQ4
         m8r8BAzySbvyPVPufA8mmGAeTT688CWVKfHTy0lv43BgcLCQx7CkvFqULSHisNVXhcDZ
         gwDsKyBIXwXlEpf58IYHkos+NLInCv+yXoRsLyi3EwosNDDxFxPbnV+eyxja4CMvhyof
         XHAgfzscqrBXqmg28LYSe3ic1EgEYgadVLmeeKvS5/deKAD/pXnaLy5w0p0B2X64Mndh
         7eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dagqyailu11jgL84XY9XZ7ZO8PNuYsgn+9sY89yrA6U=;
        b=qT7EYXXgJFj/znVnaSWP0wQes/AXGc5uBMBCVQhRW/nQWrnOJy0PISWvo0COibZiGk
         xMhw2cP8AmPtmNrb16F+0PWSILQk7tCIIqUM+kdKbSlBu7BUT9tgtV2Ll0g96/RwH5K7
         aRj80KTlatX3XOo91/67K/2xpoamDESL+zYfDiocRrkj3BIfzXZvwJ1XNI8kcjeIE/ql
         XIEgl3TLYBlYMDVewtN+TmMMIDA7S8o4HXPOFCr7+amSl6YfEPX1ekYm0Bu4u3BEpUg5
         PAhC7AfOvdEqYYhc3UsJkYEMisq3w1vITyxRMcTMkgRyOcOCYw2mZXu4XbeFq/nSIEuM
         1PXw==
X-Gm-Message-State: ACrzQf3mQH5VGwzEeAbIqyrNCkf6I6X4Q5aDGhpbe9kg+NHy/TNCSlwp
        QLn5aqkeD4jEg7URuzJaURmYZbVHQyoY/A==
X-Google-Smtp-Source: AMsMyM6JhH0GebmdyqV1zMQdWueBXpI8e4sf8Rmo+d9zd2KAm/m5LgqKre84iBjX+YDXMMUqhGZgiw==
X-Received: by 2002:a17:906:7949:b0:7ac:9917:90b9 with SMTP id l9-20020a170906794900b007ac991790b9mr7337741ejo.536.1667124216223;
        Sun, 30 Oct 2022 03:03:36 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:35 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V5 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Sun, 30 Oct 2022 11:02:54 +0100
Message-Id: <20221030100300.3085-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221030100300.3085-1-paolo.valente@linaro.org>
References: <20221030100300.3085-1-paolo.valente@linaro.org>
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

