Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F4C3F6B0
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiHLVI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiHLVII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:08 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434EB4426
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:08 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id t22so2053149pjy.1
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JF+DfDPjdjZJe3x+b+uTutFtpYGOzPTldsk0Iuh1MZE=;
        b=ZQfIGauqdmWrUCc/LJ23C9NncwzIeMHOwD1+bAZSs8VekB1hYZmcyMbdVEHkUoj+vB
         1d2bJnmrkrg6w9MjCgw1XptvfqkRm4Q0C1jfEGXfl6jeAfdrvQbNsdUHmuLkDZRS11p8
         UNsCgN0S1tbC3/pnx6YY0pp7ruYyd3g3moAWDHu05a3MfGaYUQ1OuPHGwyN+12IzDeA3
         GCh40oJOYAa4bGCgygQXg6vgEvRXmWpkNEw/r6z5S4eyh+PW99BbYgNbpazD0gV/9DEl
         jhsA5mcX7a3ASsIk2iFCYTHEGdNnaBD7wIQbrrtIdRWpXs5mOQwY4vzYjlBohPq0dXwU
         0C4w==
X-Gm-Message-State: ACgBeo0K3ahj2uWK2mAPFN38d3UHEyIDpz5pjKgBoabO/O9lR/09RcjM
        vAxqcKuYy0FwvC4KjGBWcWQ=
X-Google-Smtp-Source: AA6agR7nna5pcHY7SZqJhBROb1WlRrfTeqA/br44ZaZ/8dRA9bl9t4CKSqCiT3fGbXm+SC3dfs1Efg==
X-Received: by 2002:a17:90b:1a8f:b0:1f7:299d:9c08 with SMTP id ng15-20020a17090b1a8f00b001f7299d9c08mr6041129pjb.190.1660338487531;
        Fri, 12 Aug 2022 14:08:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/6] Make blk_mq_map_queues() return void
Date:   Fri, 12 Aug 2022 14:07:54 -0700
Message-Id: <20220812210800.2253972-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The only block driver for which the .map_queues() callback can fail is null_blk. Since
most blk_mq_map_queues() callers ignore the return value of this function, modify the
null_blk driver such that its .map_queues() callback does not fail and change the
blk_mq_map_queues() return type into void.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (6):
  block: Change the return type of blk_mq_map_queues() into void
  block: Change the return type of blk_mq_pci_map_queues() into void
  block: Change the return type of blk_mq_virtio_map_queues() into void
  scsi: Change the return type of .map_queues() into void
  null_blk: Modify the behavior of null_map_queues()
  block: Change the return type of .map_queues() into void

 block/blk-mq-cpumap.c                     |  4 +---
 block/blk-mq-pci.c                        |  7 +++----
 block/blk-mq-rdma.c                       |  6 +++---
 block/blk-mq-virtio.c                     |  7 ++++---
 block/blk-mq.c                            | 10 ++++------
 drivers/block/null_blk/main.c             |  8 ++++----
 drivers/block/rnbd/rnbd-clt.c             |  4 +---
 drivers/block/virtio_blk.c                |  4 +---
 drivers/nvme/host/fc.c                    |  3 +--
 drivers/nvme/host/pci.c                   |  4 +---
 drivers/nvme/host/rdma.c                  |  4 +---
 drivers/nvme/host/tcp.c                   |  4 +---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    |  5 +----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  5 ++---
 drivers/scsi/megaraid/megaraid_sas_base.c |  6 ++----
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  5 +----
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  5 ++---
 drivers/scsi/pm8001/pm8001_init.c         |  2 +-
 drivers/scsi/qla2xxx/qla_nvme.c           |  6 +-----
 drivers/scsi/qla2xxx/qla_os.c             | 10 ++++------
 drivers/scsi/qlogicpti.c                  |  6 ++----
 drivers/scsi/scsi_debug.c                 |  7 ++-----
 drivers/scsi/scsi_lib.c                   |  4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     |  6 +++---
 drivers/scsi/virtio_scsi.c                |  4 ++--
 drivers/ufs/core/ufshcd.c                 |  9 +++------
 include/linux/blk-mq-pci.h                |  4 ++--
 include/linux/blk-mq-rdma.h               |  2 +-
 include/linux/blk-mq-virtio.h             |  2 +-
 include/linux/blk-mq.h                    |  4 ++--
 include/scsi/scsi_host.h                  |  2 +-
 31 files changed, 60 insertions(+), 99 deletions(-)

