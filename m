Return-Path: <SRS0=bw4W=SC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C7C43381
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AE620881
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfCaDKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Mar 2019 23:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfCaDKF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Mar 2019 23:10:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 448594623E;
        Sun, 31 Mar 2019 03:10:04 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704ED60BFB;
        Sun, 31 Mar 2019 03:09:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Date:   Sun, 31 Mar 2019 11:09:49 +0800
Message-Id: <20190331030954.22320-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 31 Mar 2019 03:10:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
allowed during cleanup queue even though queue refcount is held.

This change has caused lots of kernel oops triggered in run queue path,
turns out it isn't easy to fix them all.

So move freeing of hw queue resources into queue's release handler, then
the above issue is fixed. Meantime, this way is safe given freeing hw
queue resource doesn't require to use tags.

Thanks,

Ming Lei (5):
  blk-mq: re-organize blk_mq_exit_hctx() into two parts
  blk-mq: re-organize blk_mq_exit_hw_queues() into two parts
  blk-mq: free hw queues in queue's release handler
  block: don't drain in-progress dispatch in blk_cleanup_queue()
  SCSI: don't grab queue usage counter before run queue

 block/blk-core.c        | 14 +-------------
 block/blk-mq.c          | 32 +++++++++++++++++++++++++-------
 block/blk-mq.h          |  3 ++-
 drivers/scsi/scsi_lib.c |  7 -------
 4 files changed, 28 insertions(+), 28 deletions(-)

Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>

-- 
2.9.5

