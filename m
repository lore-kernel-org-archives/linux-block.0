Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757515AbdDSAb5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2017 20:31:57 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] mtip32xx: make it working with mq scheduler
Date: Wed, 19 Apr 2017 08:31:39 +0800
Message-Id: <20170419003142.9581-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patchset fixes two issues on mtip32xx when mq schedluer is
used, and the issue is introduced in v4.11-rc:

1) the 1st two patches fixes one kernel oops trigered in blk_mq_tag_to_rq()

2) the 3rd patch fixes hardware failure and system panic which is caused
by misusing request index as request tag in .init_request()


Please consider this patchset for v4.11.

Sorry for being a bit late because my test system is just recovered.

Thanks,
Ming

Ming Lei (3):
  blk-mq: export blk_mq_get_driver_tag
  mtip32xx: assign driver tag
  mtip32xx: use runtime tag to initialize command header

 block/blk-mq.c                    |  1 +
 drivers/block/mtip32xx/mtip32xx.c | 38 ++++++++++++++++++++++++++------------
 include/linux/blk-mq.h            |  3 +++
 3 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.9.3
