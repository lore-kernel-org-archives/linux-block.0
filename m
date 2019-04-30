Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFDAC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C1C2147A
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfD3Bwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfD3Bwj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 21:52:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06F6C3086238;
        Tue, 30 Apr 2019 01:52:39 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5D7A60BE2;
        Tue, 30 Apr 2019 01:52:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V9 0/7] blk-mq: fix races related with freeing queue
Date:   Tue, 30 Apr 2019 09:52:22 +0800
Message-Id: <20190430015229.23141-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 30 Apr 2019 01:52:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
allowed during cleanup queue even though queue refcount is held.

This change has caused lots of kernel oops triggered in run queue path,
turns out it isn't easy to fix them all.

So move freeing of hw queue resources into hctx's release handler, then
the above issue is fixed. Meantime, this way is safe given freeing hw
queue resource doesn't require tags.

V3 covers more races.

V9:
	- fix one issue in patch 1 of V8 by put the queue usage counter in
	  early return branch
	- make patch 4 of V8 a bit clean, as suggested by Christoph and
	  Hannes

V8:
	- merge the 4th and 5th of V7 into one patch, as suggested by Christoph
	- drop the 9th patch

V7:
	- add reviewed-by and tested-by tag
	- rename "dead_hctx" as "unused_hctx"
	- check if there are live hctx in queue's release handler
	- only patch 6 is modified

V6:
	- remove previous SCSI patch which will be routed via SCSI tree
	- add reviewed-by tag
	- fix one related NVMe scan vs reset race

V5:
	- refactor blk_mq_alloc_and_init_hctx()
	- fix race related updating nr_hw_queues by always freeing hctx
	  after request queue is released

V4:
	- add patch for fixing potential use-after-free in blk_mq_update_nr_hw_queues
	- fix comment in the last patch

V3:
	- cancel q->requeue_work in queue's release handler
	- cancel hctx->run_work in hctx's release handler
	- add patch 1 for fixing race in plug code path
	- the last patch is added for avoiding to grab SCSI's refcont
	in IO path

V2:
	- moving freeing hw queue resources into hctx's release handler


Ming Lei (7):
  blk-mq: grab .q_usage_counter when queuing request from plug code path
  blk-mq: move cancel of requeue_work into blk_mq_release
  blk-mq: free hw queue's resource in hctx's release handler
  blk-mq: split blk_mq_alloc_and_init_hctx into two parts
  blk-mq: always free hctx after request queue is freed
  blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release
  block: don't drain in-progress dispatch in blk_cleanup_queue()

 block/blk-core.c       |  23 +-----
 block/blk-mq-sched.c   |  12 +++-
 block/blk-mq-sysfs.c   |   8 +++
 block/blk-mq.c         | 189 ++++++++++++++++++++++++++++---------------------
 block/blk-mq.h         |   2 +-
 include/linux/blk-mq.h |   2 +
 include/linux/blkdev.h |   7 ++
 7 files changed, 139 insertions(+), 104 deletions(-)

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,

-- 
2.9.5

