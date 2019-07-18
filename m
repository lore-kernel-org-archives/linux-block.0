Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE25C76186
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 03:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366BB205F4
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 03:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbfGRDZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390661AbfGRDZg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 23:25:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6A79307D84B;
        Thu, 18 Jul 2019 03:25:35 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 523635C28D;
        Thu, 18 Jul 2019 03:25:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH 0/2] block/scsi/dm-rq: fix leak of request private data in dm-mpath
Date:   Thu, 18 Jul 2019 11:25:17 +0800
Message-Id: <20190718032519.28306-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 18 Jul 2019 03:25:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

When one request is dispatched to LLD via dm-rq, if the result is
BLK_STS_*RESOURCE, dm-rq will free the request. However, LLD may allocate
private stuff for this request, so this way will cause memory leak.

Add .cleanup_rq() callback and implement it in SCSI for fixing the issue.
And SCSI is the only driver which allocates private stuff in .queue_rq()
path.

Another use case of this callback is to free the request and re-submit
bios during cpu hotplug when the hctx is dead, see the following link:

https://lore.kernel.org/linux-block/f122e8f2-5ede-2d83-9ca0-bc713ce66d01@huawei.com/T/#t

Ming Lei (2):
  blk-mq: add callback of .cleanup_rq
  scsi: implement .cleanup_rq callback

 drivers/md/dm-rq.c      |  1 +
 drivers/scsi/scsi_lib.c | 15 +++++++++++++++
 include/linux/blk-mq.h  | 13 +++++++++++++
 3 files changed, 29 insertions(+)

Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Cc: <stable@vger.kernel.org>
Fixes: 396eaf21ee17 ("blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback")
-- 
2.20.1

