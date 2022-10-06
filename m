Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F0C433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 12:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJFMWa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJFMWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 08:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3079C2D1
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyLNJ3Q8dO/0vKh1HIe/nO5H/c5qCfiPxqiFfqkNSWk=;
        b=Nvu4gBW8IJT2GEmzDa2wquyRnb7JUblknkfAqa7lZlQhWWAIc9JF0yx5ZfkryWIxxYzIk2
        p2XEje2j3sWADdjDv72QuYKoi0icUrTQc4/yvI2Tw6ZRcPuW5boNDzbPAhkaaUGSsgl2NU
        R5oxelXQYEDSVfWZnt6fGEUY74LmHXI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-wPQLPaueOVObPIXSXhCrjA-1; Thu, 06 Oct 2022 08:22:18 -0400
X-MC-Unique: wPQLPaueOVObPIXSXhCrjA-1
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a1c3502000000b003b535aacc0bso2517923wma.2
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 05:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyLNJ3Q8dO/0vKh1HIe/nO5H/c5qCfiPxqiFfqkNSWk=;
        b=8EGqExFl2Qbg2dAfxK3CK0eut1V0j/OxiDZc76qNm3YOM8i/xFoWXy0WTEajbXSOse
         aR3/ZcVyriX4Nr7mCwsqS7rLjDMARSZ0W52E70uK6a9187dmsxV6g+CRX7nKaWb9+qBJ
         LlJYd2+EaUDGVGiJ6s/0TbaV+1MKQcZk9q3Y+9PUs90HvyJ88rvNQwIP0oK/ViLCi0cP
         tYlCnq4UP1hzhnGP4ClCb49VFNluVRzCD93YU4Qbdbhxo5SrFX9oc9+InUBtCH5ZR8Xm
         Ap335A3xONbA20FjJ6MWl53PN/hfM+9Tzo+urdbJWIgqvT6b3tm2U4XeHRQBCZwQE9m9
         F0Iw==
X-Gm-Message-State: ACrzQf02B2zhHiAvUeymp71jaIw7VvP3e2MbzCehevXPm2YHFF+I0fdM
        /J9ohEgz34pkk6Cy8DHRwY2AYRiQY/YD1xguWxRimRUMxX23UaRJK3PIkMefcXsbpaho2PSXCzp
        UoY5io8g+QyNlWVjRTmMTb4uw+GB8rlMzsrMkiQ9NHuoL2xkydl03ez1c3B2xVcSW4q0yxKyWVk
        o=
X-Received: by 2002:a7b:cb56:0:b0:3b3:4ad8:9e31 with SMTP id v22-20020a7bcb56000000b003b34ad89e31mr3011946wmj.87.1665058936903;
        Thu, 06 Oct 2022 05:22:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qWsAUUYKzD5ctEpWK6L/j4O461FW/w/5nPtaXdKtNtdlZORmxI4PlTdF8RnFxVcoKWbiuLg==
X-Received: by 2002:a7b:cb56:0:b0:3b3:4ad8:9e31 with SMTP id v22-20020a7bcb56000000b003b34ad89e31mr3011921wmj.87.1665058936626;
        Thu, 06 Oct 2022 05:22:16 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 4/4] blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()
Date:   Thu,  6 Oct 2022 13:21:12 +0100
Message-Id: <20221006122112.663119-5-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_hctx_next_cpu() implements a form of cpumask_next_and_wrap() using
cpumask_next_and_cpu() and blk_mq_first_mapped_cpu():

[    5.398453] WARNING: CPU: 3 PID: 162 at include/linux/cpumask.h:110 __blk_mq_delay_run_hw_queue+0x16b/0x180
[    5.399317] Modules linked in:
[    5.399646] CPU: 3 PID: 162 Comm: ssh-keygen Tainted: G                 N 6.0.0-rc4-00004-g93003cb24006 #55
[    5.400135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    5.405430] Call Trace:
[    5.406152]  <TASK>
[    5.406452]  blk_mq_sched_insert_requests+0x67/0x150
[    5.406759]  blk_mq_flush_plug_list+0xd0/0x280
[    5.406987]  ? bit_wait+0x60/0x60
[    5.407317]  __blk_flush_plug+0xdb/0x120
[    5.407561]  ? bit_wait+0x60/0x60
[    5.407765]  io_schedule_prepare+0x38/0x40
[...]

This triggers a warning when next_cpu == nr_cpu_ids - 1, so rewrite it
using cpumask_next_and_wrap() directly. The backwards-going goto can be
removed, as the cpumask_next*() operation already ANDs hctx->cpumask and
cpu_online_mask, which implies checking for an online CPU.

No change in behaviour intended.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 block/blk-mq.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c96c8c4f751b..1520794dd9ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2038,42 +2038,29 @@ static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
  */
 static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 {
-	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
 	if (hctx->queue->nr_hw_queues == 1)
 		return WORK_CPU_UNBOUND;
 
-	if (--hctx->next_cpu_batch <= 0) {
-select_cpu:
-		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
-				cpu_online_mask);
-		if (next_cpu >= nr_cpu_ids)
-			next_cpu = blk_mq_first_mapped_cpu(hctx);
+	if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu))
+		return next_cpu;
+
+	next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask, next_cpu, false);
+	if (next_cpu < nr_cpu_ids) {
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
+		hctx->next_cpu = next_cpu;
+		return next_cpu;
 	}
 
 	/*
-	 * Do unbound schedule if we can't find a online CPU for this hctx,
-	 * and it should only happen in the path of handling CPU DEAD.
+	 * No other online CPU in hctx->cpumask.
+	 *
+	 * Make sure to re-select CPU next time once after CPUs
+	 * in hctx->cpumask become online again.
 	 */
-	if (!cpu_online(next_cpu)) {
-		if (!tried) {
-			tried = true;
-			goto select_cpu;
-		}
-
-		/*
-		 * Make sure to re-select CPU next time once after CPUs
-		 * in hctx->cpumask become online again.
-		 */
-		hctx->next_cpu = next_cpu;
-		hctx->next_cpu_batch = 1;
-		return WORK_CPU_UNBOUND;
-	}
-
-	hctx->next_cpu = next_cpu;
-	return next_cpu;
+	hctx->next_cpu_batch = 1;
+	return WORK_CPU_UNBOUND;
 }
 
 /**
-- 
2.31.1

