Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D197CC352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiLFQcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiLFQcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 11:32:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A912DAB3
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 08:32:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a16so21031436edb.9
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+Enp7nAGlczQKFp4sfBPb0S8VcxSEtdQmec8ifM620=;
        b=dHq6w6MdHXuZa0BNLNoce/JJVVsspza/0/BWLQv++R57TIQeitP1xEdpf/NTdiMdCG
         klO0ujdk43/AlmSB2SLE2MfojfvHAnI0UPtqLj2/WGL8HOyD2Mo0R1/qHvF5a6EErBku
         kkAG24eY3mHijp4Da+NlxThERs8ulNYCnMkrCSHaUKN5AEgubmI03NC8Oo0/1udUfLLi
         /fyzfBOW4oqsSPMAWQk3Ml8vymLw9gyZx4ewbRUBiCTb851wYKuifpCFjpPHaj0OB3wF
         DoyfMcrnD2qQtyRkHiV8sGNt2X/oG2sQYlF5immDjOg3R1gRlUR/Gzn73dDo6h9ayJhC
         l35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+Enp7nAGlczQKFp4sfBPb0S8VcxSEtdQmec8ifM620=;
        b=Km6LPGIGKoSSvlmcN6vVB58cfUM4EBxdNaBeoLJ5+M+yZkBhghIY9qsQl/gdFeGfNA
         H73xY2Vwv+e3xisV6oUDWNbN3TiTCAA3mso3uyOZVYDcEVxdGZGpCw1fyYUAY589Zikt
         /lNpF1Wqt8HJGKFGgAxnHMLeuXWqauhtIrvzw3Q1jcAbTI6y+yNOHRo1bko9zwriMRJm
         XFI4KT+yGcf02C5+QYXCSr5HRT/MH3k0H9Bvk1MKMmDxVqfMP/fMG6Vac0i1mgQqHVJw
         aZCOjFdSUpyLu1VfBGFOR5a7khdhgGKE7oDwzbwzzsQSQP11CBSog6HTsj8b7ILXxRvc
         jKKA==
X-Gm-Message-State: ANoB5png0KvOdomOOotKpinSFXHumS6A7h0HlrxCIbn+rfRgoLLuDLOe
        bLWFQj/WES1OmiVnupTlNTcQpw==
X-Google-Smtp-Source: AA0mqf7kqhjvEII3bXQLDoHl+F8NrI7R/099iOocvV78Pm+jYu8QvIH+Pw9Z06dkAfypVXMLgeRo8A==
X-Received: by 2002:a05:6402:528d:b0:468:dc9:ec08 with SMTP id en13-20020a056402528d00b004680dc9ec08mr2734474edb.17.1670344332483;
        Tue, 06 Dec 2022 08:32:12 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id t5-20020a056402020500b0046ac460da13sm1170104edv.53.2022.12.06.08.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 08:32:12 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V8 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Tue,  6 Dec 2022 17:31:57 +0100
Message-Id: <20221206163203.30071-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206163203.30071-1-paolo.valente@linaro.org>
References: <20221206163203.30071-1-paolo.valente@linaro.org>
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
index 16dbf52ce74b..456b5f5c24fd 100644
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

