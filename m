Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33217 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbdBVKOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 05:14:19 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 0/4] blk-mq: cleanup on all kinds of kobjects
Date: Wed, 22 Feb 2017 18:13:58 +0800
Message-Id: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset cleans up on kojects of request_queue.mq_kobj,
sw queue's kobject and hw queue's kobject.

The 1st patch initialized kobject of request_queue and sw queue
in blk_mq_init_allocated_queue(), so we can avoid to initialize
these kobjects several times, and this patch fixes one kerne
warning reported from Omar Sandoval.

The 2nd patch makes lifetime consitent between mq request queue/sw
queue and their kobjects.

The 3rd patch makes lifetime consitent between hw queue and their
kobjects.

The last patch is a followup of 3rd patch.

Thanks,
Ming

Ming Lei (4):
  blk-mq: initialize mq kobjects in blk_mq_init_allocated_queue()
  blk-mq: make lifetime consitent between q/ctx and its kobject
  blk-mq: make lifetime consistent between hctx and its kobject
  blk-mq: free hctx->cpumask in release handler of hctx's kobject

 block/blk-mq-sysfs.c | 40 +++++++++++++++++++++++++---------------
 block/blk-mq.c       | 28 ++++++++++------------------
 block/blk-mq.h       |  2 ++
 3 files changed, 37 insertions(+), 33 deletions(-)

-- 
2.7.4
