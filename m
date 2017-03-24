Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34595 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbdCXMgc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 08:36:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id w20so225890pgc.1
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 05:36:31 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 0/4] block: misc changes
Date: Fri, 24 Mar 2017 20:36:17 +0800
Message-Id: <20170324123621.5227-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st  patch add comments on blk-mq races with timeout handler.

The other 3 patches improves handling for dying queue:
	- the 2nd one adds one barrier in blk_queue_enter() for
	avoiding hanging caused by out-of-order
	- the 3rd and 4th patches block new I/O entering queue
	after queue is set as dying

V1:
	- add comments on races related with timeout handler
	- add Tested-by & Reviewed-by tag

thanks,
Ming

Ming Lei (4):
  blk-mq: comment on races related with timeout handler
  block: add a read barrier in blk_queue_enter()
  block: rename blk_mq_freeze_queue_start()
  block: block new I/O just after queue is set as dying

 block/blk-core.c                  | 12 ++++++++++++
 block/blk-mq.c                    | 32 +++++++++++++++++++++++++++-----
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 include/linux/blk-mq.h            |  2 +-
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.9.3
