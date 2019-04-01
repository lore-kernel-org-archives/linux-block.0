Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9517C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 04:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AFC2086C
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 04:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDAEm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfDAEm6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 00:42:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D87DC04958C;
        Mon,  1 Apr 2019 04:42:58 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACF4C26349;
        Mon,  1 Apr 2019 04:42:51 +0000 (UTC)
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
Subject: [PATCH V2 0/3] blk-mq: allow to run queue if queue refcount is held
Date:   Mon,  1 Apr 2019 12:42:44 +0800
Message-Id: <20190401044247.29881-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 01 Apr 2019 04:42:58 +0000 (UTC)
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


V2:
	- moving freeing hw queue resources into hctx's release handler


Ming Lei (3):
  blk-mq: free hw queue's resource in hctx's release handler
  block: don't drain in-progress dispatch in blk_cleanup_queue()
  SCSI: don't grab queue usage counter before run queue

 block/blk-core.c        | 14 +-------------
 block/blk-mq-sysfs.c    |  6 ++++++
 block/blk-mq.c          |  8 ++------
 block/blk-mq.h          |  2 +-
 drivers/scsi/scsi_lib.c |  7 -------
 5 files changed, 10 insertions(+), 27 deletions(-)

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

