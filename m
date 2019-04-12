Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3608DC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0617D20675
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDLDam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:30:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfDLDam (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 23:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1677B308429B;
        Fri, 12 Apr 2019 03:30:42 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A777519C7E;
        Fri, 12 Apr 2019 03:30:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V5 0/9] blk-mq: fix races related with freeing queue
Date:   Fri, 12 Apr 2019 11:30:23 +0800
Message-Id: <20190412033032.10418-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 12 Apr 2019 03:30:42 +0000 (UTC)
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



Ming Lei (9):
  blk-mq: grab .q_usage_counter when queuing request from plug code path
  blk-mq: move cancel of requeue_work into blk_mq_release
  blk-mq: free hw queue's resource in hctx's release handler
  blk-mq: move all hctx alloction & initialization into
    __blk_mq_alloc_and_init_hctx
  blk-mq: split blk_mq_alloc_and_init_hctx into two parts
  blk-mq: always free hctx after request queue is freed
  blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release
  block: don't drain in-progress dispatch in blk_cleanup_queue()
  SCSI: don't hold device refcount in IO path

 block/blk-core.c        |  23 +-----
 block/blk-mq-sysfs.c    |   8 +++
 block/blk-mq.c          | 188 ++++++++++++++++++++++++++++--------------------
 block/blk-mq.h          |   2 +-
 drivers/scsi/scsi_lib.c |  28 +-------
 include/linux/blk-mq.h  |   2 +
 include/linux/blkdev.h  |   7 ++
 7 files changed, 132 insertions(+), 126 deletions(-)

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>

-- 
2.9.5

