Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18358 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGRAYl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jul 2018 20:24:41 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/3] blk-mq: Enable runtime power management
Date: Tue, 17 Jul 2018 16:49:37 -0700
Message-Id: <20180717234940.11231-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens,

This patch series not only enables runtime power management for blk-mq but also
simplifies power management for the legacy block layer. Please consider this
patch series for kernel v4.19 (I am aware that you are on vacation).

Thanks,

Bart.

Bart Van Assche (3):
  block: Fix a comment in a header file
  block, scsi: Rework runtime power management
  blk-mq: Enable support for runtime power management

 block/blk-core.c          | 60 ++++++++++++++++-----------------------
 block/blk-mq-debugfs.c    |  1 -
 block/blk-mq.c            | 12 ++++----
 block/elevator.c          | 11 +------
 drivers/scsi/sd.c         |  4 +--
 drivers/scsi/ufs/ufshcd.c | 10 +++----
 include/linux/blk-mq.h    |  1 +
 include/linux/blkdev.h    |  9 ++----
 8 files changed, 42 insertions(+), 66 deletions(-)

-- 
2.18.0
