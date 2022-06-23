Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D289C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiFWX0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:10 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41AC5639F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:09 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1161194pjk.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCdTfgB9B206ex+Pm4IZ4xJkr/WOteWb4XsafHpzrEE=;
        b=8GhTlarT2BzejAopRfRQwaySPNqTnAbdVp3varpUUNN86I3M6vPbmDZaxfk7ltwyhR
         8otvakun2Fs54G3mld57e+U9HQb2tIIpEWtYFK1kiqvlCugTmKLe4E14ns4ZQWr9Jb60
         tEYcVq7G+gSRJE/aGhVDnNS5eh3hvjswb9uh3lcsa1XelGB8SbyFW+sL0yvewmu+t4rp
         u4W1AUMLaoiyfHIkdUZavgpSwcb80IxCnXSU8QGNOaQalI6u+XedZKIWKht7xgwYSGhi
         LV92kUWX2hiU6yka8j5AUgc2NkAwPmm1TirLHDIPYbiv/+5MuvsNpAkP2qKU3c4PKh4A
         9AMw==
X-Gm-Message-State: AJIora8WV3c0Dp8ASWc5k7grRCIzYpHDAszkqOREiTirKiK67JDYuIo1
        Jia3+pm/+FnCupByD6o5i2M=
X-Google-Smtp-Source: AGRyM1sAPG2t7Ul7BIWjVP6IWjaIKABT+yJNSBx6ueMI+PyKq+dp+BIGNAwoWqiyq8w3xXApDEySxg==
X-Received: by 2002:a17:90a:4e05:b0:1ec:8de4:1dd5 with SMTP id n5-20020a17090a4e0500b001ec8de41dd5mr449952pjh.242.1656026769290;
        Thu, 23 Jun 2022 16:26:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/6] Improve zoned storage write performance
Date:   Thu, 23 Jun 2022 16:25:57 -0700
Message-Id: <20220623232603.3751912-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Measurements have shown that limiting the queue depth to one per sequential
zone has a significant negative performance impact on zoned UFS devices. Hence
this patch series that increases the queue depth for write commands for
sequential zones when using the mq-deadline scheduler.

SCSI and UFS patches will be submitted at a later time (after multiqueue
support is available for the UFS driver).

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Changes compared to v1:
- Left out the SCSI and NVMe patches.
- Added a null_blk patch.
- Included measurement results.

Bart Van Assche (6):
  block: Document blk_queue_zone_is_seq() and blk_rq_zone_is_seq()
  block: Introduce the blk_rq_is_zoned_seq_write() function
  block: Introduce a request queue flag for pipelining zoned writes
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Refactor null_queue_rq()
  block/null_blk: Add support for pipelining zoned writes

 block/blk-zoned.c                 | 17 +++--------------
 block/mq-deadline.c               | 15 +++++++++------
 drivers/block/null_blk/main.c     | 30 ++++++++++++++++++++----------
 drivers/block/null_blk/null_blk.h |  3 +++
 drivers/block/null_blk/zoned.c    |  4 +++-
 include/linux/blk-mq.h            | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            | 16 ++++++++++++++++
 7 files changed, 84 insertions(+), 31 deletions(-)

