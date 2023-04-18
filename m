Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D88C77B76
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjDRWk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjDRWkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:23 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0B9037
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:08 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-51b6d137403so963490a12.0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857608; x=1684449608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnvrZqGw5I8n5pWX9snTR7Zd8s8Sh2taI4IX+kKiaS4=;
        b=ZSMcByDK8/pZfxSx754LcGLoq6EsEvr5eXmvAP+CeZcbKsd4OKuJSZG96GWh7aLTmz
         y+uApYF0D0iwxahY8nCuGhZ6XSVqMXTsrdoOAv6tzi9qFN+Uy95UaKEvOqRB6RNF/pDV
         sX++A9QnvcxqqZ/svokmt/qbK8FJMUxDcNU2GN2gJIjKcFFV4iecJx5CK9pYg6QHmruv
         j4Rn3KZgYL9GF4NrF38pjEo72ZmCdxhr081Y5ZNoqymH322qSU+ouk72Hq+0BuAoCm/c
         qD1mLK08i3k8PxuR7hakkL/I/MX7HyLsBSq5ydR278bvmC1U12Sb+7sh3aawE0QZFWou
         3zyA==
X-Gm-Message-State: AAQBX9ePAdMF6plk951H+sHwNFY6mjBUebd31B1+JJ1859w1jlex/q9S
        N+ldXI+LwtbzjBkHfZebvo8=
X-Google-Smtp-Source: AKy350YVHDcma7Bu1KSgWG9QCjLxzFtHNRsgmZp+obdgVsgSjd2mNzhFYZhVg/vCl3O/aALKifUCaQ==
X-Received: by 2002:a17:90a:3886:b0:23f:b609:e707 with SMTP id x6-20020a17090a388600b0023fb609e707mr1061930pjb.2.1681857607827;
        Tue, 18 Apr 2023 15:40:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/11] mq-deadline: Improve support for zoned block devices
Date:   Tue, 18 Apr 2023 15:39:51 -0700
Message-ID: <20230418224002.1195163-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves support for zoned block devices in the mq-deadline
scheduler as follows:
* The order of requeued writes (REQ_OP_WRITE*) is preserved.
* The active zone limit is enforced.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
- Left out the patches related to request insertion and requeuing since
  Christoph is busy with reworking these patches.
- Added a patch for enforcing the active zone limit.

Bart Van Assche (11):
  block: Simplify blk_req_needs_zone_write_lock()
  block: Micro-optimize blk_req_needs_zone_write_lock()
  block: Introduce blk_rq_is_seq_zoned_write()
  block: mq-deadline: Simplify deadline_skip_seq_writes()
  block: mq-deadline: Improve deadline_skip_seq_writes()
  block: mq-deadline: Disable head insertion for zoned writes
  block: mq-deadline: Preserve write streams for all device types
  block: mq-deadline: Fix a race condition related to zoned writes
  block: mq-deadline: Handle requeued requests correctly
  block: Add support for the zone capacity concept
  block: mq-deadline: Respect the active zone limit

 Documentation/ABI/stable/sysfs-block |   8 ++
 block/Kconfig.iosched                |   4 +
 block/Makefile                       |   1 +
 block/blk-mq.h                       |   2 +-
 block/blk-settings.c                 |   1 +
 block/blk-sysfs.c                    |   7 ++
 block/blk-zoned.c                    |  43 +++++--
 block/mq-deadline-zoned.c            | 141 +++++++++++++++++++++
 block/mq-deadline-zoned.h            |  31 +++++
 block/mq-deadline.c                  | 177 ++++++++++++++-------------
 block/mq-deadline.h                  |  79 ++++++++++++
 include/linux/blk-mq.h               |   6 +
 include/linux/blkdev.h               |  18 ++-
 13 files changed, 423 insertions(+), 95 deletions(-)
 create mode 100644 block/mq-deadline-zoned.c
 create mode 100644 block/mq-deadline-zoned.h
 create mode 100644 block/mq-deadline.h
