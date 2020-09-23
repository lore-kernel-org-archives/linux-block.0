Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABBC4727F
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577E920663
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="CcC/ZKUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWLon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWLon (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097EC0613D2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x22so10058444pfo.12
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpkPd+fTAhj2X7V3WWb/Fwmg/vataD1CR1qCbhap4f4=;
        b=CcC/ZKUA52pIruP3I4urrZThCQrurCSIokR3kJEDalZXoWegpoul8123h+hDEjQI9+
         O+kEOOeGedDgxnLXxLqIgA+0pLbB1F+96jrJjq7kmsZuB23Q6AQIwjgsuxBDuETafreP
         cZS07S7mLWy/mS4F0N9Gk5EBE31cLoenAgAwmBgi0t5IS/cbOUTBmDmnAaTIKeJkmJkZ
         iYH0SywXPjRzRQE7diu+as2/OCiGl9Vu6IhjYVMErGgBe27e+rkxMMRnOSLbSPt0TsRN
         BAu9E2U+akRkYQzA87V/dIvHAqNQ3Ws1jK9tIV3lElE0wfBqGFFkuU4IgRpG9OAQHNrt
         YaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpkPd+fTAhj2X7V3WWb/Fwmg/vataD1CR1qCbhap4f4=;
        b=sCTMf+qWpZhnosOpyeSjwwhUIHUGy9ClXE7MtuXCUQgso7dfM+hDEQJdOye336Nyf7
         gzrahDHNTQU8ABD3Um5NyPtAAgmIcLC8XaO5UuK/ezm8HvYmiJkdWpWKcR/ccrnWU4r3
         zrz/AV3IFwQzOgHAqDWUyrO6FEQcd0hHCLi0XelUPoPHdDQk4z9BzCeJDbwM2UU8B8aG
         /1PPEvxT34oLozI1XXNg/ZfMe2TPEjxV1yqa27xPows1W79eN6wm0sIsasuPSFXlMgQd
         mNuW0NqknfiG5yhJYL1gw5+C8iv5hsSfEkZ1V8gGdwfkqEe0p3IPsD/a4i589PQgQsRe
         6J/A==
X-Gm-Message-State: AOAM530eZM/hxeb1MipYNpDX0LDkng1B5WoTQonu5Q7MyO5apdRIPQ8E
        5YwyEHNFfKEKAwi982n8+B0JkA==
X-Google-Smtp-Source: ABdhPJyIwoJChwdK0TVdZJm3mJJaHP9asayg0CoeYv95i56+QDjppUSQr6vPEoZM3F2mMX5ltg5tNA==
X-Received: by 2002:a63:4a0e:: with SMTP id x14mr3038895pga.222.1600861482687;
        Wed, 23 Sep 2020 04:44:42 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on some corner case
Date:   Wed, 23 Sep 2020 19:44:14 +0800
Message-Id: <20200923114419.71218-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

changelog in v2:
  1. Fix missing save the current thread files
  2. Fix double list add in io_queue_async_work()

Muchun Song (4):
  io_uring: Fix missing smp_mb() in io_cancel_async_work()
  io_uring: Fix remove irrelevant req from the task_list
  io_uring: Fix missing save the current thread files
  io_uring: Fix double list add in io_queue_async_work()

Yinyin Zhu (1):
  io_uring: Fix resource leaking when kill the process

 fs/io_uring.c | 59 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

-- 
2.11.0

