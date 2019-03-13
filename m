Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CDC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E65E20854
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WubfDmxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCMRzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCMRzy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8JaeW1Nvy3CfjJcjr3ig0hsO0HIi7Ps4n1x0iCXrTXM=; b=WubfDmxSPrvyEkKuJdLTKIsXOS
        l6njR/krETx79rYmxT/YlD9Nh+CTwJmDyshfQ0UYufCLC4eIrjrOmxEKY3DITLZmtucccaRouHnRw
        KIdaPbW7NOFvHkV3ey0HJlYHrZIzmAys4YpHMEQOi9wsz856KP8YCVu81+IYKyY0/FJvs2lHOEONJ
        ymm0/tWDLWcXSZuMomOaZAwWVZPWamEESfXlDHpaN03A1nmSgyrt02EZ3QKuGqba1NW8/ICR46AGc
        H86vcdGPyoHgJ8O0ygGgAYVx9SaRoyvKO/KttQaZfbjb92BzSN4Njk4WruC5owlDCAxIjDgnI2GDL
        u/iRxyUQ==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486X-0001hN-Cn; Wed, 13 Mar 2019 17:55:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>
Subject: [PATCH 09/17] nvme-fc: reject reconnect if io queue count is reduced to zero
Date:   Wed, 13 Mar 2019 18:55:02 +0100
Message-Id: <20190313175510.20725-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

If:

 - A successful connect has occurred with an io queue count greater than
   zero and namespaces detected and running.
 - An error or something occurs which causes a termination of the prior
   association and then starts a reconnect,
 - The reconnect then creates a new controller, but for whatever reason,
   nvme_set_queue_count() results in io queue count set to zero.  This
   will skip io queue and tag set changes.
 - But... the controller will transition to live, calling
   nvme_start_ctrl, which calls nvme_start_queues(), which then releases
   I/Os into the transport which then sends them to the driver.

As there are no queues, things eventually hit the driver looking for a
handle, which was cleared when the original controller was reset, and it
can't proceed. Worst case, things progress, but everything fails.

In the failing scenario, the nvme_set_features(NVME_FEAT_NUM_QUEUES)
command actually failed with a NVME_SC_INTERNAL error.  For some reason,
although nvme_set_queue_count() saw the error and set io queue count to
zero, it doesn't return a failure status to the transport, which allows
the transport to continue using the controller.

Fix the problem by simply rejecting the new association if at least 1
I/O queue can't be created. The association reject will fail the
reconnect attempt and fall into the reconnect retry policy.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 23f6bad19274..f3b9d91ba0df 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2475,6 +2475,7 @@ static int
 nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	u32 prior_ioq_cnt = ctrl->ctrl.queue_count - 1;
 	unsigned int nr_io_queues;
 	int ret;
 
@@ -2487,6 +2488,13 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		return ret;
 	}
 
+	if (!nr_io_queues && prior_ioq_cnt) {
+		dev_info(ctrl->ctrl.device,
+			"Fail Reconnect: At least 1 io queue "
+			"required (was %d)\n", prior_ioq_cnt);
+		return -ENOSPC;
+	}
+
 	ctrl->ctrl.queue_count = nr_io_queues + 1;
 	/* check for io queues existing */
 	if (ctrl->ctrl.queue_count == 1)
@@ -2500,6 +2508,10 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queues;
 
+	if (prior_ioq_cnt != nr_io_queues)
+		dev_info(ctrl->ctrl.device,
+			"reconnect: revising io queue count from %d to %d\n",
+			prior_ioq_cnt, nr_io_queues);
 	blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 
 	return 0;
-- 
2.20.1

