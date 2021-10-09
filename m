Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D945C433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4AE60F59
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhJIM22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhJIM21 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3EC061570;
        Sat,  9 Oct 2021 05:26:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i12so25559626wrb.7;
        Sat, 09 Oct 2021 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBEdLjsSDpzSYSrkJTEaUEEJcVMFPpSfiM84UPXqOU8=;
        b=OB+4rId2iZJtnZl7HGJ6IR0yuqog3G0yy80LkkezhN8bMmR82H8AHwmEsRH2tcyNql
         4lBM32yH901vUvWS+dh+LMDbfwzHzx86VhGmpWTEKhfivFb27vWGEjcMtsiBJb0p8+fQ
         LZAmlOR2wYzAlEUlc9iVwA+EiXKLty8/WtOa7cmvv/7NcgclR7tXRk5xM8jmNoLOSfDb
         /i6Ow/O9Y1xMUANDLkkHBnqnwKN2pf03PGsNeZNPLyGNaOsU+m+IQwwozkQRFS7fFyKQ
         eBNP44qKbzcIxhvvzdB0ummzbC1YEVno+9jGge8LviB5JiGyFjLutWH0YgRhJzsoXjUk
         rIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBEdLjsSDpzSYSrkJTEaUEEJcVMFPpSfiM84UPXqOU8=;
        b=XOnkx6A9Xz6xJIa43UKaPDR46gzy56P4HQT8q9WH8YT2r1YH6djwg4zoGES8lBToqg
         VV0eRxzhc5MZNRNVZq8r+SSj3GxJBUU+hhvxuRte/CLUlkoppcSTzmoLDVT1sXC7x6GW
         3YQ14ohdKL7uPglqmcgDbzEDu4yJZkjfoWR4tYnOmbOp8i/rXrfi9++VW/HrRqn+a5PM
         ImNKUlynlm6QD9c0So/Y2upn+lFfhu29GjY4mb4lVcn01J3PzgspYyNhgSsWG13j67Oc
         g/rc0qPfNsrgqXc5oE05Q9+oRMUGUR7t4jsNVJbsCopY2rBqYeaWSXrL8FwpfbpB334k
         pWMw==
X-Gm-Message-State: AOAM532r+RWunzPcIq6bRT75LCpfZUVs/PkA6AQY0Q7kNdJ43Ugfeid8
        jDf87pEUbtQXMc2g2U5uSk2ZM1S+PqM=
X-Google-Smtp-Source: ABdhPJzRDRW6ohCZvt2WHcPnSnvdsUmQuJ2PtNbitBkJIjGK1cBod9GMZmm/QJQaYe3jB5oP7qA79w==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr10650758wrs.14.1633782389425;
        Sat, 09 Oct 2021 05:26:29 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:29 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 0/6] some block optimisations
Date:   Sat,  9 Oct 2021 13:25:37 +0100
Message-Id: <cover.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On top of perf-wip branch,

./io_uring -d32 -s32 -c32 -b512 -p1 /dev/nullb0
~3.3 MIOPS vs 3.5 MIOPS, so gives around extra ~4-5%.

The main part is caching struct block_device + some inlining.

Pavel Begunkov (6):
  block: cache bdev in struct file for raw bdev IO
  block: inline BDEV_I and friends
  blk-mq: optimise *end_request non-stat path
  block: inline hot paths of blk_account_io_*()
  blk-mq: inline hot part of __blk_mq_sched_restart
  block: convert ->bd_inode to container_of()

 block/bdev.c           | 16 ----------------
 block/blk-core.c       | 30 +++++++++---------------------
 block/blk-mq-sched.c   |  4 +---
 block/blk-mq-sched.h   |  8 +++++++-
 block/blk-mq.c         |  9 ++++-----
 block/blk.h            | 24 +++++++++++++++++++++---
 block/fops.c           | 40 ++++++++++++++++++++++------------------
 include/linux/blkdev.h | 31 +++++++++++++++++++++++++------
 8 files changed, 89 insertions(+), 73 deletions(-)

-- 
2.33.0

