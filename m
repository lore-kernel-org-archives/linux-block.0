Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C1C433ED
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB613613AA
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhDREmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 00:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDREmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 00:42:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7ADC06174A;
        Sat, 17 Apr 2021 21:41:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 30so15384606qva.9;
        Sat, 17 Apr 2021 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUKitwCUbGa+VeZmvp2HCZHQ5Wi454pmfSTHoR/nqTI=;
        b=UjwdpIJA0UPg3JYBq2uliXNIfyG314sMQ2SQTXl+SPWVudS60OVeySCbfprn3tuIkk
         HaqBD/c0ipIwsPEiR2N55x6J49+ZzCQfqAuPFfOC13RnXS6s+t5Sagbq7gsnbWiBH/P6
         Vzki8IzQSa4rbQQJe31ir3XK4aRNDocMKgXVpm9cnA3pPoBMwQpPi0fzevRrnW5eus9P
         KAEftNVtsYZGuBOHl9yl7YkX/jO1DdG4cgp9N1BdHvg7lxr3I39Zuqi/Hd12QBjIBRKh
         f7Jea/m2BjnrHw0DbDPXXrY2QL8EuzKHVl+MCHgkoM6I934/qECM979bW8SA+j9Aw/Ti
         a8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUKitwCUbGa+VeZmvp2HCZHQ5Wi454pmfSTHoR/nqTI=;
        b=X1Z7Gm6rOBBzjH63Av8jjX82X/tgdb/OoGwtvndHMzTFRhOBqNpaPD2kQb01modjFg
         0KgqCSi1Bho9Oa9oIdU/T1hCsR0qPLICiqaXyqzUfGWL/3SYI04DIWekDNB8zhR/+eOv
         vNLJJkCERJIwA5xHv7VGr4OgOIQmeXHtC6GuZ5Z3cD87eBAEP0ez54vCuYIKkAnDgouX
         SGQ5oGOAiWWv1YEqHEuWpFArpDT2Y0yJL/uEliFb9OvR8NZJ08ZhIjUS+9F2Zs63tP5t
         SBm15WTP8gh8eMbE0wY/vJCoDTo/38o327SW/SOYSfmt1uu+8cjCuC6CnBVycYw5Hu/B
         8C+Q==
X-Gm-Message-State: AOAM533lGXslo7AIWtJjx2YX4zf+saNct7qw2o8kZrKARKmCZSGXIgh0
        f18t9wXB8kiqIgn348mtxRR5BgFdRCyYaA==
X-Google-Smtp-Source: ABdhPJx8FOWi/GLdgj58lXtC4kOezy1s4Tp0tqrbCDwcXgtmdzEv/xo21VmwN7eXszCTqGgBKAlMCg==
X-Received: by 2002:ad4:5543:: with SMTP id v3mr15710965qvy.32.1618720893643;
        Sat, 17 Apr 2021 21:41:33 -0700 (PDT)
Received: from unknown.attlocal.net ([2600:1700:65a0:ab60:94de:a0f8:7217:23b2])
        by smtp.gmail.com with ESMTPSA id o23sm7133634qtp.55.2021.04.17.21.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 21:41:33 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: [Patch] blk-wbt: fix a divide-by-zero error in rwb_arm_timer()
Date:   Sat, 17 Apr 2021 21:41:01 -0700
Message-Id: <20210418044101.26730-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Cong Wang <cong.wang@bytedance.com>

We hit a divide error in rwb_arm_timer() and crash dump shows
rqd->scale_step is 16777215 (0xffffff in hex), so the expression
"(rqd->scale_step + 1) << 8)" is 0x100000000, which is just beyond
32-bit integer range, hence it is truncated to 0 and int_sqrt(0)
returns 0 too, so we end up passing 0 as a divisor to div_u64().

Looking at the assembly code generated:

    add    $0x1,%edi
    shl    $0x8,%edi
    movslq %edi,%rdi
    mov    0x10(%rbx),%rdi
    xor    %edx,%edx
    mov    %eax,%ecx
    shl    $0x4,%rdi
    mov    %rdi,%rax
    div    %rcx

we notice that the left shift is still using 32 bit register %edi,
because the type of rqd->scale_step is 'int'. But actually int_sqrt()
takes 'long' as a parameter, so the temporary result should fit well
at least on x86_64. Fix this by explicitly casting the expression to
u64 and call int_sqrt64() to avoid any ambiguity on 32 bit.

After this patch, the assembly code looks correct:

    add    $0x1,%edi
    movslq %edi,%rdi
    shl    $0x8,%rdi
    mov    0x10(%rbx),%rdi
    xor    %edx,%edx
    mov    %eax,%ecx
    shl    $0x4,%rdi
    mov    %rdi,%rax
    div    %rcx

Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Fam Zheng <fam.zheng@bytedance.com>
Cc: Xiongchun Duan <duanxiongchun@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 block/blk-wbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 42aed0160f86..5157ca86574f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -337,7 +337,7 @@ static void rwb_arm_timer(struct rq_wb *rwb)
 		 * though.
 		 */
 		rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
-					int_sqrt((rqd->scale_step + 1) << 8));
+					int_sqrt64((u64)(rqd->scale_step + 1) << 8));
 	} else {
 		/*
 		 * For step < 0, we don't want to increase/decrease the
-- 
2.25.1

