Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9746EC433E2
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 08:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7C21D94
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 08:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="auIoq9oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgIOIXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIOIQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D9C06178A
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 01:16:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g29so1601768pgl.2
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCyQLZIomtOO1i6n72+em9VVg13AQuPSjMf53LDYaqM=;
        b=auIoq9oCUFxSo4pwN0sve/6Y70uneeWypGCBG5hiKQEvrs5xsnPny5hFer4eYtvobB
         i1e8/4/NUocwRqRvZU4d3158MMYfZg9uMyBexYuihdiruBMYNWdXKwXZmAO2N378J80N
         eqkHCtMx81ILLcpD+YrJBxPJuBdMEMfiKoVJ9PCflvPIRPoKR3aLmjbC9JpchjGEgL+2
         OAAG2s6uGACAX/l/xxBhnVkglCSTQNyHNAdoPoaq3u4mqUNcVpJM4OnR+IYbo/Jgnt2E
         jYrW4IZZm931VWbRzDf+K2XYOH9XodrcyeKISXf5fabViRfS4vXU4n23bTlmOwPIyfCG
         FM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCyQLZIomtOO1i6n72+em9VVg13AQuPSjMf53LDYaqM=;
        b=Vm4GirSkbJwzgnEZ8XAHKiMVRt4x/HA7fhkPeT6wFgHsUTso11RyN1tr+Ma8yLuEGu
         6DCqhMnHwtlDTQMIQNGEs4dL5v8CL5WSM7n4Ro2szUqpo2eHi5gzG5aBj61YVb7RIqEm
         iB8YnuKfg6h8LW+pZEcwR1CZ5muME04ryZhfmB1pTptpqolmg7SJWh5tyZq2Fp4BVs+c
         +LfOwfi1BFHUOcl64+S05jZr5ffjt1qPiL601wDhZiOckZlWn7uZrr9039lukEL6PFte
         6IpmD1yRp099c6y5DUrE/UGOPmUizMj0R85Dl0BuQG3f9B4qCHNzJs7ybMgSum/o9t03
         CxTA==
X-Gm-Message-State: AOAM530oKPIR6XW+gLvatWjIvEn1Q0Iq8XuKmy1TR5FhpK41QTcgZQDP
        Rgsp8qKYkYeFB2uPFUnrvvL3XQ==
X-Google-Smtp-Source: ABdhPJz/sjjpFc3hiXj9N7JffKpq8GhR5gx1bxMX6eM7XMcT5j1DHbJd+okuEH1Z85Q1f72+EGOhYg==
X-Received: by 2002:aa7:8249:0:b029:142:2501:39dd with SMTP id e9-20020aa782490000b0290142250139ddmr827130pfn.44.1600157764267;
        Tue, 15 Sep 2020 01:16:04 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id x19sm10539429pge.22.2020.09.15.01.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:16:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/3] io_uring: Fix async workqueue is not canceled on some corner case
Date:   Tue, 15 Sep 2020 16:15:48 +0800
Message-Id: <20200915081551.12140-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We should make sure that async workqueue is canceled on exit, but on
some corner case, we found that the async workqueue is not canceled
on exit in the linux-5.4. So we started an in-depth investigation.
Fortunately, we finally found the problem. The commit:

  1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")

did not completely solve this problem. This patch series to solve this
problem completely. And there's no upstream variant of this commit, so
this patch series is just fix the linux-5.4.y stable branch.

Muchun Song (2):
  io_uring: Fix missing smp_mb() in io_cancel_async_work()
  io_uring: Fix remove irrelevant req from the task_list

Yinyin Zhu (1):
  io_uring: Fix resource leaking when kill the process

 fs/io_uring.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

-- 
2.11.0

