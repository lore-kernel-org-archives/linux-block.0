Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE0C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJSWXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJSWXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:36 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4343FA22
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:35 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id z20so18554073plb.10
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4jSX2QP2/Cw0VzpVKGoch68NyWCDGrIgRRlfOEeRkg=;
        b=G0MDJiO+aaRhb4Uy/jonCqXx7uotn2vGcMRIDIcldZfA0C3lnFR//d7twRDoeTsiXl
         VMNuOKRa/5zImr9dpcDuh6RFQ6YreaggSsAmfxLKnmlq8fYRP2FACwfeM4vPMtmsWYrD
         NAqu3E17TwVCgYD7q+3gVi7pGYvwXUz8/qDcmLrdncktAZglqc24q0SNYt9ERYfA/OSd
         ZnH37Fr841AY5K2XfW2bS3Ph+Bk/RDJRkIFnfnGlgmNAC5Dz+8l0U8B9HihK//CBGqva
         QyxbwvvJ6Q0zVtpJLoBTCpkUyHbfI8WD7JI4sh496pC89vTVBgDTiEe4WMICZGWMSsMc
         vc0A==
X-Gm-Message-State: ACrzQf0HcL3yNtUp1cnicRWYkTuR4PuHXEn+nNYku5QsmprjhN/FpBUM
        rS3FidyXyKXkPV1pP4ERZIs=
X-Google-Smtp-Source: AMsMyM7PfUsQcfxi0vjpJ52NtXfoER37fsHHQ46tbIN0AdN2qels1Yescur8VxOSI15QY10xhHk8Qg==
X-Received: by 2002:a17:90a:e10:b0:211:9e6a:a099 with SMTP id v16-20020a17090a0e1000b002119e6aa099mr726920pje.27.1666218215202;
        Wed, 19 Oct 2022 15:23:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/10] Support DMA segments smaller than the page size
Date:   Wed, 19 Oct 2022 15:23:14 -0700
Message-Id: <20221019222324.362705-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

We (Android team) would like to support storage controllers with a segment size
of 4 KiB in combination with a 16 KiB page size. Hence this patch series that
adds supports for DMA segments smaller than the page size. In addition a few
cleanup patches for the block layer are included. Please consider this patch
series for the kernel v6.2 merge window.

Thanks,

Bart.

Bart Van Assche (10):
  block: Remove request.write_hint
  block: Constify most queue limits pointers
  block: Micro-optimize get_max_segment_size()
  block: Add support for small segments in blk_rq_map_user_iov()
  block: Introduce QUEUE_FLAG_SUB_PAGE_SEGMENTS
  block: Fix the number of segment calculations
  block: Add support for segments smaller than the page size
  scsi: core: Set the SUB_PAGE_SEGMENTS request queue flag
  scsi_debug: Support configuring the maximum segment size
  null_blk: Support configuring the maximum segment size

 block/blk-map.c                   | 43 +++++++++++++++++++++-----
 block/blk-merge.c                 | 50 +++++++++++++++++++------------
 block/blk-mq.c                    |  2 ++
 block/blk-settings.c              | 16 +++++-----
 block/blk.h                       | 17 +++++++----
 drivers/block/null_blk/main.c     | 20 +++++++++++--
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/scsi/scsi_debug.c         |  3 ++
 drivers/scsi/scsi_lib.c           |  2 ++
 include/linux/blk-mq.h            |  1 -
 include/linux/blkdev.h            |  3 ++
 11 files changed, 115 insertions(+), 43 deletions(-)

