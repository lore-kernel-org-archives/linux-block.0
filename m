Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A0CC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 09:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiJDJSw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJDJSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 05:18:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6E2CCBE
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 02:18:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y8so17972378edc.10
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AzWkSdITxtKnuLuZL/Fv67AsU2AcECJXh+BQCDnwU0M=;
        b=R1WsysQpp1XjY1hKBR2Azzh1fVo3f/EmWQLdkwHjkBHKQZOf74dane/5wo0i6wmOPo
         pI/FdK+V971lMuG0lLi1tWwonbWQxe8nZtLguXspi3VpWNkBE1iHNHH1cg4hhGWkMxQc
         YxWWIccMe6AGiXZiq1RfnBW8jdGEDO2AC0lLCl6Z9We9dT1cW977gk7TA6giYHFdIosk
         22mAxXAChlDWxRjxIwVrc4+vdGjLK5jqPvi2Utbu8gPrEVZO/MK9eqjoux5+oIeHJBDy
         IEd+gk1fdE6372K7dib8SD90RR9bstjIjU9nSkcjYznNc8/yF4UjftLIm9ir5vi7QDEr
         tCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AzWkSdITxtKnuLuZL/Fv67AsU2AcECJXh+BQCDnwU0M=;
        b=2x7FIY4nunm2IVAlFbgfbp2FP0rSmAkbAnl8RfcQ9FpZw+FgcTRPZrEY6ZaNyiHo+2
         mUDoL5+w8Zs9FzuIaQI3gvVXtz6F0UJ1Ta9fNkWY9ODe8L79vZzTHeTyP1nMH6NSdZ+B
         yb806bXPrZBJzLfqXI5izmaCLJi0tE3VurC9gZNrGTlWzTv0qmx29nhMK8UukrujgtRm
         lXQFMptJdhtNgupgEUxfGgGnfnzQSG1C8bT7JTbuJT+6q+K11uajmslGHV6ex2bu30AQ
         deOz/jGQ3BIWd62Z22NJuwTa1QozAXKKeRALtO4K4wqu0zm0Gz4t0ZpcOtbtjsLje6Jk
         z2YA==
X-Gm-Message-State: ACrzQf3PfAcJiUfRKii2J6gq93dVUvMmJCs5kKrDGM2i/4ByO7Xlb++e
        S5LnTAJ8NcIqYBQJrxlvyvLaXg==
X-Google-Smtp-Source: AMsMyM6dKnUCGvwoWlCYAfVGgDu0N/K3fUhrVqWWqWjqBLpEOae0rO8Aiz/gWmXOOPuAYq2x84ZkeA==
X-Received: by 2002:a05:6402:90e:b0:443:ec4b:2b03 with SMTP id g14-20020a056402090e00b00443ec4b2b03mr22297858edz.71.1664875126683;
        Tue, 04 Oct 2022 02:18:46 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:46 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Tue,  4 Oct 2022 11:18:10 +0200
Message-Id: <20221004091816.79799-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004091816.79799-1-paolo.valente@linaro.org>
References: <20221004091816.79799-1-paolo.valente@linaro.org>
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

