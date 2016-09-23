Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52619 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758358AbcIWUnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 16:43:46 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Final block fixes for 4.8
Message-ID: <df17b81b-c88a-4bdb-183c-ea47f48a5db0@fb.com>
Date: Fri, 23 Sep 2016 14:43:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Three fixes, two regressions and one that poses a problem in blk-mq with
the new nvmef code.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (1):
       blk-mq: skip unmapped queues in blk_mq_alloc_request_hctx

Sagi Grimberg (1):
       nvme-rdma: only clear queue flags after successful connect

Vivek Goyal (1):
       blk-throttle: Extend slice if throttle group is not empty

  block/blk-mq.c           | 16 ++++++++++++++--
  block/blk-throttle.c     |  6 ++++--
  drivers/nvme/host/rdma.c |  2 +-
  3 files changed, 19 insertions(+), 5 deletions(-)

-- 
Jens Axboe

