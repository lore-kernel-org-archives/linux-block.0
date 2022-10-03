Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDBEC433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJCPfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJCPfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 11:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14615729
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qKy0mrwb1ZaeVcnoJdtpT0vU2IyZpITeq2cNcv3elU=;
        b=QI25XqqnZfwn7ABQTyB2IwXViyPF3u2viiiAvNC398Tr7O/ATip4pH2ZYtrpsas8Exaoio
        9i/xvcEJno+Hoi0dCe9A3igsu49yc6Y4WHbUaj54PVlM3goCTjihspOazx8GfabPvUM43j
        jgib16ylh9nmjBRWuWtYJYruoz/8Bds=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-KEkOcCM2PdifNFHJk09eNw-1; Mon, 03 Oct 2022 11:34:52 -0400
X-MC-Unique: KEkOcCM2PdifNFHJk09eNw-1
Received: by mail-wr1-f72.google.com with SMTP id s5-20020adf9785000000b0022e1af0e7e8so1584987wrb.11
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 08:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9qKy0mrwb1ZaeVcnoJdtpT0vU2IyZpITeq2cNcv3elU=;
        b=UXC037ch7s5/9PBYQQ2MmJiIwJjEDFBXTLxlq52wKFs7a5ldnYuQ0daYHko8VgScnY
         +UpFkRmQ+TFpKMgyLESNFLL9s187YumHh4qqKBIDCDgS/4YYeNfM/ayr5D34jEj9G+NW
         gT2LikMQ4qMFN+jHZMeRSJRgVLdyTpImFlUZPlTZXxriQ6/9NbJVWFpP8fFAr/hcElLk
         uDRTSNzaQGmIz2F/OSCuAR593gQWIu7XCNkGjGebErJK/ydJdPalKEp6iHR3LthPLzXl
         6nfCP50wyiLv3ZiDZCPeWs7NnrFrD9p2EGPIfqwgdJZevTdtT4N9QIRCZWW2MLp1EDAS
         csFw==
X-Gm-Message-State: ACrzQf3t4DRok2VyrJ/QdrJ3Kqd8kqwMUMi4tP+Mk4FevhDZ1iQqOVxU
        gQqTIhLYulaLUYoYgaUiybJbTbvxkoRXlbj506BvtQGEV+Oumcxr5Zw6XDSAvkEnGcExg/necci
        H3EhK+z3Jr++QKWTyx7+XXhgdCbUlu8hS+tPTAgfx+OetfA9PWIBmwC4A8Owx3YNpRsw1htfPjN
        o=
X-Received: by 2002:a5d:588c:0:b0:22b:24d4:d896 with SMTP id n12-20020a5d588c000000b0022b24d4d896mr13440200wrf.611.1664811291163;
        Mon, 03 Oct 2022 08:34:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dK79kXgKpUAVjxCPuM7ftmnrqJfkV/6uJjTLHWR/lVxoHiO15CtzuAB4IFYHSYe+goWsQ7g==
X-Received: by 2002:a5d:588c:0:b0:22b:24d4:d896 with SMTP id n12-20020a5d588c000000b0022b24d4d896mr13440171wrf.611.1664811290913;
        Mon, 03 Oct 2022 08:34:50 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:50 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 5/5] sched/core: Merge cpumask_andnot()+for_each_cpu() into for_each_cpu_andnot()
Date:   Mon,  3 Oct 2022 16:34:20 +0100
Message-Id: <20221003153420.285896-6-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This removes the second use of the sched_core_mask temporary mask.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..b4c3112b0095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -360,10 +360,7 @@ static void __sched_core_flip(bool enabled)
 	/*
 	 * Toggle the offline CPUs.
 	 */
-	cpumask_copy(&sched_core_mask, cpu_possible_mask);
-	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);
-
-	for_each_cpu(cpu, &sched_core_mask)
+	for_each_cpu_andnot(cpu, cpu_possible_mask, cpu_online_mask)
 		cpu_rq(cpu)->core_enabled = enabled;
 
 	cpus_read_unlock();
-- 
2.31.1

