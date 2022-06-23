Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF741C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 15:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiFWPyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiFWPx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 11:53:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E162DD6C
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:53:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so28575616wra.4
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzWkSdITxtKnuLuZL/Fv67AsU2AcECJXh+BQCDnwU0M=;
        b=QjCRDVEecT4fKPe08R9H3SnfHguAeQ0sfPjqNoFw1jNO21QGhoXTXhCWNFzso1F9/W
         lT4vPdhfruLPa+wRrFodYrqSuexHG87/0L4ycTyJmo61Mr7vmCf7w9uGPv17ga3Q9Fbl
         L0gTT1VJfrFbOVXTKRHQsTJlg2r07DGfOn4BHBhb3vevXaPHs8pu4grEIQdhnkgY3ixG
         1sEEzASz+FG1D5dVae7ReYlb4eRIdvtbFeFvxC1raox2+bvEmfW54qfP+fYJCzRk1HtR
         dpe1CJlASnfmjqo6GdoEJ3NQNOWfSKzjsgMg52mMGUJUEuZ7h2zGccLb1e/bjYtsMu3V
         pN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzWkSdITxtKnuLuZL/Fv67AsU2AcECJXh+BQCDnwU0M=;
        b=ksmpavboEMXJ2kExZ9mwDT3TvaVezJDTJCJqQfAGhcRjAPr6jRqOXsldRnXSZvU5jJ
         hlOKp0AWYnsOfZWHREQ9IHe7XcOTWZaOiRBMgu/b2TraPzJYbaOkDvE9t8ihQkTB5rK+
         bHit8dhMyJXtvzDtUPXiqyoa4QYs3SP4e37tDb0oGjWdeJiziAxW8pBUxFT2kwo+gBrh
         PgjteK0nhILy+8HfaUrMoWFCiRzIl6LyNZDctVMSTwb280MDCtdhiLVgMfWtKaorbqxa
         G5MBmK4jHw6pgcaO6NvPbrdOUNkAgKSs9ObWJIX0raDndcOWakRgC3SnA3YsvTK1xCOl
         Xivg==
X-Gm-Message-State: AJIora+8blvICKCSK6uFVBN3yA2W7t16s4NaRtOEXUHSZW63j3yVwymx
        Ml3MeFvwGQYjHdvxov0Z9LCo6w==
X-Google-Smtp-Source: AGRyM1uPP+8LNOjo6dYC2uhTTph4CWTUWdFGOV9OIlsAc02wQb1TWjMdfga7aPdMgqj7aahLlJSMpw==
X-Received: by 2002:a05:6000:381:b0:21b:9a20:6543 with SMTP id u1-20020a056000038100b0021b9a206543mr9166495wrf.127.1655999636670;
        Thu, 23 Jun 2022 08:53:56 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.53.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:53:56 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu, 23 Jun 2022 17:53:29 +0200
Message-Id: <20220623155335.6147-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220623155335.6147-1-paolo.valente@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
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
index 98e0c454f5bc..52fc3930b889 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5695,9 +5695,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5715,7 +5719,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

