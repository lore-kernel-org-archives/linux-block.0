Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023AAC433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D947B61073
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJWQYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:24:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18965C061714
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d3so6245507wrh.8
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0rj0DHQogObLFA/0pyr/prSiZAhCZ84qE7XwTL+36A=;
        b=PxkMxMMst/C+awAzAoDh9UGoqqpmNjc7Lpaw7gd7Q2Alv2cT5x+pgT4i0N1w4vYiHe
         UsVwiPvOD8MBVUA4UwodERG2gfKH9KYBTUIXy/rpC9oJ1IhjJ5QiHjVaPy8UsCzq60Ym
         BsgxAP7ZFg4XRddzXUhKepzqlPvrf8w/TW9Rl0DJzgkzfMCX5TjBzLbiAmEvQiY/Bx14
         CnLCJxYzvJ9eZMtSCIt9l4nx1tkPaP3GpTMGGC210l5lZPg5YnTU6ZsxAaCQRadbrZpL
         sd9aLoZ8EiG6j9A8j7U4xwzGtY5oP5RsarEoJrYhqidV2ykW6UfTH9CFXXGxRfl7LiRj
         F4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0rj0DHQogObLFA/0pyr/prSiZAhCZ84qE7XwTL+36A=;
        b=k+XcWGxpTbFXdDS9nTYuP4cG24icqqjDOuQryzCuviSfWmC8zMrn+waTQXAHg05cvC
         tYLOIN5Q6lvpOsbvMGUqiqj6bFUX8NBYmVULkofypwyMbP8Vrqc0N1ezA6FrrV1MgF5l
         8u0s2dX+OM7e/AyTuwzPHc1P+Zuy+wlMxol2R6wvP2pOKRFIyFfDBiNOyoqosq6qP3T2
         xVqiAhDG0mIS/UbO+XSeHQ81YmzMSi6FBFUsuSks1VcKku/a4YM32j5Rm+wK9T23+HXj
         rnOCQ4K2H5aTQzdsqX+PWUiHS0Pa5s5aiZxbqUQhEmpDZ44dhGxs72jr6iSOQ3KPiDBx
         Cl6Q==
X-Gm-Message-State: AOAM530XixbHmq5uj3Mp5MDIDpSda3A7fzUeGD7EVHSatt9WSFWzzeEC
        RWbNNcCvBEWdaiVy6ROI7ydTDisEnjs=
X-Google-Smtp-Source: ABdhPJxvxpGAIjzbj2EN7GNAfKWXwtxCjP7piHw5kSXlnE+8hfHsfc22gugvrFTP/HKA9vDHHo02Ag==
X-Received: by 2002:adf:a413:: with SMTP id d19mr9050202wra.246.1635006105397;
        Sat, 23 Oct 2021 09:21:45 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id c16sm2174799wrt.43.2021.10.23.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:21:45 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/5] block optimisations
Date:   Sat, 23 Oct 2021 17:21:31 +0100
Message-Id: <cover.1635006010.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Another split off from the "block optimisation round" series focusing
on fops.c. It addresses Cristoph's review, the main change is
setting bvec directly instead of passing a "hint"
to bio_iov_iter_get_pages() in 3/5, and a prep patch 2/5.

I don't find a good way how to deduplicate __blkdev_direct_IO_async(),
there are small differences in implementation. If that's fine I'd
suggest to do it afterwards, anyway I want to brush up
__blkdev_direct_IO(), e.g. remove effectively unnecessary DIO_MULTI_BIO
flag.

Performance stays the same, solely 1/5 gives ~4.5 -> 4.7 MIOPS,
plus 1-2% from 3/5.

Pavel Begunkov (5):
  block: add single bio async direct IO helper
  block: refactor bio_iov_bvec_set()
  block: avoid extra iter advance with async iocb
  block: kill unused polling bits in __blkdev_direct_IO()
  block: add async version of bio_set_polled

 block/bio.c         |  37 ++++++--------
 block/fops.c        | 116 ++++++++++++++++++++++++++++++++++++--------
 include/linux/bio.h |   6 +++
 3 files changed, 116 insertions(+), 43 deletions(-)

-- 
2.33.1

