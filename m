Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58749C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31822218D3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfDXLDQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXLDQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 07:03:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1BA67CBB0;
        Wed, 24 Apr 2019 11:03:15 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16C435C220;
        Wed, 24 Apr 2019 11:03:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's whole lifetime
Date:   Wed, 24 Apr 2019 19:02:21 +0800
Message-Id: <20190424110221.17435-10-ming.lei@redhat.com>
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 24 Apr 2019 11:03:16 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hennes reported the following kernel oops:

    There is a race condition between namespace rescanning and
    controller reset; during controller reset all namespaces are
    quiesed vie nams_stop_ctrl(), and after reset all namespaces
    are unquiesced again.
    When namespace scanning was active by the time controller reset
    was triggered the rescan code will call nvme_ns_remove(), which
    then will cause a kernel crash in nvme_start_ctrl() as it'll trip
    over uninitialized namespaces.

Patch "blk-mq: free hw queue's resource in hctx's release handler"
should make this issue quite difficult to trigger. However it can't
kill the issue completely becasue pre-condition of that patch is to
hold request queue's refcount before calling block layer API, and
there is still a small window between blk_cleanup_queue() and removing
the ns from the controller namspace list in nvme_ns_remove().

Hold request queue's refcount until the ns is freed, then the above race
can be avoided completely. Given the 'namespaces_rwsem' is always held
to retrieve ns for starting/stopping request queue, this lock can prevent
namespaces from being freed.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reported-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 248ff3b48041..82cda6602ca7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -406,6 +406,7 @@ static void nvme_free_ns(struct kref *kref)
 		nvme_nvm_unregister(ns);
 
 	put_disk(ns->disk);
+	blk_put_queue(ns->queue);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
@@ -3229,6 +3230,11 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_ns;
 	}
 
+	if (!blk_get_queue(ns->queue)) {
+		ret = -ENXIO;
+		goto out_free_queue;
+	}
+
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
@@ -3245,7 +3251,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	id = nvme_identify_ns(ctrl, nsid);
 	if (!id) {
 		ret = -EIO;
-		goto out_free_queue;
+		goto out_put_queue;
 	}
 
 	if (id->ncap == 0) {
@@ -3304,6 +3310,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_put_ns_head(ns->head);
  out_free_id:
 	kfree(id);
+ out_put_queue:
+	blk_put_queue(ns->queue);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
-- 
2.9.5

