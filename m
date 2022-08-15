Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E475C3F6B0
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 17:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiHORAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiHORAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 13:00:53 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C51181E
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 10:00:52 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso14994538pjo.1
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 10:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fDMsWB70AfCqrSP8gvqZ6knTs8ogtqhpD6f1co3N8zo=;
        b=FB6Vpr1TRumHQMizRIE+fAI3BgWn3+Gu160ENjXFDV9abRMLzA/pO747mEIHOtDojl
         /G6gJAOqRG8xStzYQ20iiEaACAljCBcsJY+ys8SXxHwO0doiHGAlqkzBHWNCu6HDBgIZ
         rM1mnwqyk2ijIERBEwkMDVZCHnOxPDFECssOALTnnyjxyAC+bISKkfy46/82YPJVVRW3
         xMQD2TfIog2LmfUbi76iQID1gYG7Jg8sxA8Cl1f4OtdGJ6ASwNJJjQsefhtEc/qNos0x
         tZ8VdzyHUx7Jy68g4W0Ib6SB6ame+lWEMc9eOvQMCc5Ja8900MMiPBV5suGrqrhRdQIa
         k03w==
X-Gm-Message-State: ACgBeo1H1UfqI2mK9UbUf1tSwAAjVPzNnez5JMunGsjpZZPw/3bvRQ5Y
        F6V8tWM/jbV1g5qGO6Jd6MJW2RD42bg=
X-Google-Smtp-Source: AA6agR4UeWSjwLECC2+agR+MUVMssVu8KPIZ0TIuHACUlMqMuBqFvsui3b2qBYCKs9OXFV4lJnXwsQ==
X-Received: by 2002:a17:90a:55:b0:1f7:4513:8cac with SMTP id 21-20020a17090a005500b001f745138cacmr18762370pjb.93.1660582851777;
        Mon, 15 Aug 2022 10:00:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c1a1:6549:b273:880b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016eea511f2dsm7255690plx.242.2022.08.15.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:00:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] Make blk_mq_map_queues() return void
Date:   Mon, 15 Aug 2022 10:00:41 -0700
Message-Id: <20220815170043.19489-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The only block driver for which the .map_queues() callback can fail is
null_blk. Since most blk_mq_map_queues() callers ignore the return value of
this function, modify the null_blk driver such that its .map_queues()
callback does not fail and change the blk_mq_map_queues() return type into
void.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
- Combined all patches except one into a single patch as requested by Christoph.

Bart Van Assche (2):
  null_blk: Modify the behavior of null_map_queues()
  block: Change the return type of blk_mq_map_queues() into void

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

