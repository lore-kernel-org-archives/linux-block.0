Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC95C47095
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 03:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE5620897
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 03:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="tAplSRDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJGDQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgJGDQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 23:16:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F48C061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 20:16:51 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h6so497611pgk.4
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nHndZKwwfOOj5bwaqodAdSawGiEECEuWU/h1JxfIjE=;
        b=tAplSRDrpqc0bLhzdVINXo66tsmyG4077hKzUat22H5dF7Vj//0RV7AArxOdQoESc2
         Pc1oXj5o1aBDxEsXhyFT5DUjos3yqJdciaIWy9R7gRRGZ3bi//gyke/tUgu5dAYfEGni
         xfH9eipKOHyy0sVf76ROJzb0besS5j3UyYOzr1UUM/kkUuaSuETXstNK3e9bku88JvMc
         pOa/pbNOepvAIcA7Zij2sTe3d08qjaUHOpnkXnWpGeghOWKktvhXZd66o5IYI9tTjAwz
         rHyMxgYjLvQvepUW0rMgxFRZtwjga7DYckXPZg367rZiMg3h3mDNWFMIR0AlwCDy5lzx
         UMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nHndZKwwfOOj5bwaqodAdSawGiEECEuWU/h1JxfIjE=;
        b=dKAPQyvqjVIVrCsShV01S/K2aBzT3E3EaNm0QXhWn2G5H0p14SszIILhcv4S6LC4S3
         VBh5E3H0/V+qqRNprC9G6rpBJNUPQr1cOCLapKbUqqfVb+bcXiNJbd8BBfCUqGyqdJ0u
         sIrlOMDDJDemZv3VdvwNgLnv26r4hPC35e4jEDI08UUXYqn+d2eauXW1uJ7hdGMmjsps
         VSYJ6GM6z2acaKhw+7k5oNKZKIYO/p2uKDunjb9RPmDG1eWUrPwFzRZ54a/ZYVzlIMDb
         FcS7SdbUgM6duwTdVvHa/v9Nl+W083K8snSwRq8FNGIK26h+SCvTBsY8EJnXiQJbuh9v
         auKw==
X-Gm-Message-State: AOAM532F5LvD8TjbsszlWACWpSkrfCEZkj5xTdAGYFU+6ACUnEl7AhrY
        UNk7xDlFFqyAv6ZPEqr3LMaq0w==
X-Google-Smtp-Source: ABdhPJxjUqK0ytYdUt6Nfja9Covk8gWR2hTabrYqA/cE6OV7oT6XN3O0+nt+zWZnwe+FrHvxZ3gc9A==
X-Received: by 2002:a63:705c:: with SMTP id a28mr1165305pgn.266.1602040610841;
        Tue, 06 Oct 2020 20:16:50 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id e1sm729094pfd.198.2020.10.06.20.16.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 20:16:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/4] io_uring: Fix async workqueue is not canceled on some corner case
Date:   Wed,  7 Oct 2020 11:16:31 +0800
Message-Id: <20201007031635.65295-1-songmuchun@bytedance.com>
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

changelog in v3:
  1. Merge patch-4 to patch-1.

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

