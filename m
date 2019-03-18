Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E7CC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 03:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421A620857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 03:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfCRDaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCRDaW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 23:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A02FAC057F2B;
        Mon, 18 Mar 2019 03:30:22 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0735DD97;
        Mon, 18 Mar 2019 03:30:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: cancel request synchronously
Date:   Mon, 18 Mar 2019 11:29:50 +0800
Message-Id: <20190318032950.17770-3-ming.lei@redhat.com>
In-Reply-To: <20190318032950.17770-1-ming.lei@redhat.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 18 Mar 2019 03:30:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme_cancel_request() is used in error handler, and it is always
reliable to cancel request synchronously, and avoids possible race
in which request may be completed after real hw queue is destroyed.

One issue is reported by our customer on NVMe RDMA, in which freed ib
queue pair may be used in nvme_rdma_complete_rq().

Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 470601980794..2c43e12b70af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -288,7 +288,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 				"Cancelling I/O %d", req->tag);
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request(req);
+	blk_mq_complete_request_sync(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.9.5

