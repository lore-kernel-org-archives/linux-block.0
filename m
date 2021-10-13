Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F65C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B16C610A0
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhJMJAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhJMJAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 05:00:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FEC061570;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r10so5723571wra.12;
        Wed, 13 Oct 2021 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13F9Cq930OG+GGXd8FQ0oaYzD/U3yoMN3sJ8Nxj0JZ0=;
        b=R2uUau2rwqw3lDLQTmYPAavTDo1r7hTGr675Vj+NsGITlkUXtV2ErxYpjSwisYnZj+
         Lr1ieLVAAyDkPSgU/A4B57ZHYRgAKu40Gm+2ogdyQsF6eOTzjvMD+YUErjftgFSYuzVK
         n6Ck3Up0bacvQOvInLZE1wYyKON7wlqEG13fktrgpDifsVsQS1aRdxyLKwhWDP3XVSnX
         +oQ8aWiRS3iupKuCjbAjdpAkhWWV4KpjDqMydcJmHVbe3aAMZ8jQHS3FjTO2X9AD9BdI
         +o2bT9I13gYVFSpYZ7sSUbI3OWAvqbUQ3G1mAbzaNAQsXeBWFOIy2jRx6vTmkvIrVvIa
         BZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13F9Cq930OG+GGXd8FQ0oaYzD/U3yoMN3sJ8Nxj0JZ0=;
        b=wDjNMeDaqpjklIRtVK9ZzSpBxND5LABZQSkmt9QrLRhFAU9C42ssx+nz+FWwyig+pu
         F/zYTm2+EbkHN8jQ4Of2otoPiyzNWM52z1O03vp49pDsPZz9UCj4cyhkd9RYXiI9ks6u
         5bRjK/dYNe/GJj9eIMM7WwSvDXnm7dANN1n9nQVAiq1lUar7vnVIm3FiDTIqROCFvYbH
         pmOux9cNOyF4XtufH9j5hLykbunLYh3m4bOuzmFkZmfyAQewGFsYxsHaMbHhcUwzi2YC
         xW1E5bwfTWhV/qoVcdJFYS7afxFlkRV/doS/Si+CIqMx4PQEf9v3WLjtgxVqvRqNLyQY
         bzsA==
X-Gm-Message-State: AOAM531MUzJsdq8p3ylir01GO1/YG8FxrpQ+eRHZxBZk2U4lD0P57fcU
        pdR5rGMon6EBmLsXROiwyLLXKmxPNmk=
X-Google-Smtp-Source: ABdhPJxc0T23AuqLGCoaKBIWE6l0AZwsq9lOE0YKUhwcVazrNiKaJU0JwOsRAcmLNxruR4x/TP/+bQ==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr38295392wrv.171.1634115480568;
        Wed, 13 Oct 2021 01:58:00 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.208])
        by smtp.gmail.com with ESMTPSA id v1sm13187283wro.54.2021.10.13.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 01:58:00 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH v2 0/3] on top of for-5.16/block
Date:   Wed, 13 Oct 2021 09:57:10 +0100
Message-Id: <cover.1634115360.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

./io_uring -d32 -s32 -c32 -b512 -p1 /dev/nullb0
~3.3 MIOPS vs 3.5 MIOPS, so gives around extra ~4-5%.

The main part is caching struct block_device + some inlining.

v2: without applied patches, merge previous 6/6 into the second patch
    get rid of helpers (Jens, Christoph)
    kill bdev_inode and move inode into bdev (Christoph)

Pavel Begunkov (3):
  block: cache bdev in struct file for raw bdev IO
  block: don't hide inode from block_device users
  blk-mq: optimise *end_request non-stat path

 block/bdev.c              | 44 ++++++++++-----------------------------
 block/blk-mq.c            | 18 +++++++---------
 block/fops.c              | 43 ++++++++++++++++----------------------
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  8 +++++--
 5 files changed, 44 insertions(+), 70 deletions(-)

-- 
2.33.0

