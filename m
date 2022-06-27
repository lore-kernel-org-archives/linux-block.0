Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B849DC43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiF0Xnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiF0Xnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:49 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D113D5C
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:48 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id i64so10411461pfc.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPEnshaUEAGoNI4ffNkDG+b9cRihYYn55w5+nX6xUys=;
        b=lo4j75cmCv5DX9q/LU++4eAE06XO+BCINBgN0CBV4Xx+NPXezW5BaJXR69+xdHlrYg
         xPnJ9pZa8kfAey8UAB3uUSdIadgvLooIuOfj+xg8z1cLZj/yWZM8yRd633d8m4KOhdMy
         xrwEm+0T1IcDiKN36US8c4glPoYiNlhWPf2TYVNh8NE0aVPReJb4qjwc74vi7tjAVbi/
         54+TdZ+f8vg0PzGoV5o3BAWx5DR14xd6Q2uHg2+5BDGkGxdwYrT7LBg7jN7IlbTt7Ds/
         cW2riE98yoEK8gaadqEah9x7Ix1vhYsc/KkJfnALTznyWgqWJOUt6lcjY6TQO/GPXJw8
         ouYw==
X-Gm-Message-State: AJIora9goSK0cfZWMCzEgqJ3TSSXHocXKbu9JsH5aF7S5wVLVdu3drWv
        VdI3YxBwX255ml7CTnS+11Q=
X-Google-Smtp-Source: AGRyM1vAULk0VNpvqwfhfHnFMp6GmZ7gXHEiN8k/MKeStCcuW98hkIwvV/p4T4k9qZV2Zv5kuZwvrQ==
X-Received: by 2002:a63:301:0:b0:411:442b:bb7d with SMTP id 1-20020a630301000000b00411442bbb7dmr3531224pgd.112.1656373427957;
        Mon, 27 Jun 2022 16:43:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/8] Improve zoned storage write performance
Date:   Mon, 27 Jun 2022 16:43:27 -0700
Message-Id: <20220627234335.1714393-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Measurements have shown that limiting the queue depth to one per sequential
zone has a significant negative performance impact for zoned UFS devices. Hence
this patch series that increases the queue depth for write commands for
sequential zones when using the mq-deadline scheduler.

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Changes compared to v2:
- Included the patches again that enable write pipelining for NVMe ZNS SSDs.
- Disabled merging in the null_blk test script. As a result, the test script
  now shows a 14x improvement with pipelining enabled.
- Renamed blk_rq_is_zoned_seq_write() into blk_rq_is_seq_zone_write().

Changes compared to v1:
- Left out the patch for the UFS driver.
- Included patches for the null_blk driver.

Bart Van Assche (8):
  block: Document blk_queue_zone_is_seq() and blk_rq_zone_is_seq()
  block: Introduce the blk_rq_is_seq_zone_write() function
  block: Introduce a request queue flag for pipelining zoned writes
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Refactor null_queue_rq()
  block/null_blk: Add support for pipelining zoned writes
  nvme: Make the number of retries command specific
  nvme: Enable pipelining of zoned writes

 block/blk-zoned.c                 | 17 +++--------------
 block/mq-deadline.c               | 18 ++++++++++++------
 drivers/block/null_blk/main.c     | 30 ++++++++++++++++++++----------
 drivers/block/null_blk/null_blk.h |  3 +++
 drivers/block/null_blk/zoned.c    | 13 ++++++++++++-
 drivers/nvme/host/core.c          |  9 ++++++++-
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/zns.c           |  2 ++
 include/linux/blk-mq.h            | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            | 16 ++++++++++++++++
 10 files changed, 107 insertions(+), 32 deletions(-)

