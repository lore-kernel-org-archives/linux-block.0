Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0063CC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73712077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="joy6C8Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCMR4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCMR4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lXo7ned/+EiOXw+nVR1KDuwcLOv2pk8/6Q5oIzKNtbw=; b=joy6C8AhfyFcoWDhFEbdfNl9Sy
        JZ6R3bZmjd1pzEOD8DNZAtIqNF1HXX5ztPfML2TU7XbvYqdFBqWNi3YUoBXQEb6t2XAyMjkwc7vMI
        D+kC/QpeaBaXc9xZ0rsNl5+25Y9BUHfUzI37+kwKpf8uo1/qHEw6uFEy2yOrsX8UTp9+Mg+2Y43sM
        g8nk4gwb1L8D1SxtJ02SGkR9v7DleuZFZRp3JtZqaHvgvqKIuK3gILjv6W0mKUQK0clKmgitZ8rAP
        BL27OJIklPEFG2dN42pQdhrRi3XTgB7sz7UnQeZSuVfhI55K3kSXZr6+BpcGZPaSTrSGS4GFEv3g7
        z3Md7i7w==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486i-0001wd-8F; Wed, 13 Mar 2019 17:56:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 13/17] nvme: remove nvme_ns_config_oncs
Date:   Wed, 13 Mar 2019 18:55:06 +0100
Message-Id: <20190313175510.20725-14-hch@lst.de>
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

Just opencode the two function calls in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 951e9f31b57c..26ae805fc958 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1552,12 +1552,6 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
 }
 
-static inline void nvme_ns_config_oncs(struct nvme_ns *ns)
-{
-	nvme_config_discard(ns);
-	nvme_config_write_zeroes(ns);
-}
-
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
 {
@@ -1611,7 +1605,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-	nvme_ns_config_oncs(ns);
+
+	nvme_config_discard(ns);
+	nvme_config_write_zeroes(ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.20.1

