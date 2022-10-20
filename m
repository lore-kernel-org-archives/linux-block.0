Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9348DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 15:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJTP1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiJTP1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 11:27:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCA1C7D49
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 08:27:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a10so35050430wrm.12
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX2t3qf8BSgHA3maXGdOtEQ+vTybs9QvWGjlXMhif64=;
        b=J+8zRhNje0WuDrO7hYWGXYXkaHtbAhTA4tAcwRVqCP/tELc+gu2AeNtLG909BDO4OO
         xDlbEUMcX5qWN6GWCvnkx3lrzQcGEdFx1K9EJ1dgxyC0LImUwC3kJ3ezqrNQiA1Plf6R
         Wd/OSHiFHAdL0BKFms+DbVELI4w6Sx0CROWhl6cLlC0/n5Gxq7jc8s3p9CVmLPw3DzpJ
         xzxteE17FdgtpJIdQlkGCEi7BSAVtC1qceWzXG2ABAE/icV1Al2vpBvHijJ9xaBUGK+B
         tlTMBiZtJaaIY+VaJ6ZTf4wtQECkhxehocmJ2GWhb0L2E/o3IzHufpHSWl0lhN4fSd8I
         sVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX2t3qf8BSgHA3maXGdOtEQ+vTybs9QvWGjlXMhif64=;
        b=IbJ6hkn8F9ZO8W8x9hMYEiIKEMDTiZrk2vzWgYuF78Tsr4uw4ytqaZu+7fXqOMWuAi
         6O0Vsei4qLOSPYY2ud0O2qurhdhQ3/9Nilg1vr5Tzmy8j9MhKOs+Ia0K3EKZrwVFXSK0
         cPcl6SCVWvHnGNh271UqjZKkjM03Xlu7meo6db7aiWwBcXxhlvx3A/g8WVP44nKvdkkr
         LZ3lM1leHYcysAeLEY2OMfiK8BhWod0ItDBx06iVYES8pRfCIdWHyuwRukQUdlQcreET
         BLNUCNBW1e42Pfgt2O1JzCkHXLGXidBeCtOxIEH9Xv0ex5dIiU/VHazIKZnqy+c5xz0N
         DC/A==
X-Gm-Message-State: ACrzQf3pJ7k4GLYHGb64Eb6JhqIVbbfJoyQos9bysgxvyT2RMugEVYgw
        bKIH91fvlq4xh/nEZTfuY0I2kA==
X-Google-Smtp-Source: AMsMyM7WRdXM+D5WPglh+i7wN8Ud5OuoW4CYJfhjuvZOnrNP5YT0EYo4lIjrfxriKc77YC+cPy3FMw==
X-Received: by 2002:a05:6000:1a85:b0:230:f238:a48c with SMTP id f5-20020a0560001a8500b00230f238a48cmr8740396wry.92.1666279615478;
        Thu, 20 Oct 2022 08:26:55 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003c409244bb0sm134337wmh.6.2022.10.20.08.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:26:55 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V4 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu, 20 Oct 2022 17:26:37 +0200
Message-Id: <20221020152643.21199-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221020152643.21199-1-paolo.valente@linaro.org>
References: <20221020152643.21199-1-paolo.valente@linaro.org>
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
index 99c01e184f1d..57de6a6a7f06 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5693,9 +5693,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5713,7 +5717,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

