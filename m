Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB50C76195
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D6522296
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfGVFk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfGVFkZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 01:40:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD8333E2CB;
        Mon, 22 Jul 2019 05:40:25 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 151DE5D704;
        Mon, 22 Jul 2019 05:40:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] nvme: don't abort completed request in nvme_cancel_request
Date:   Mon, 22 Jul 2019 13:39:52 +0800
Message-Id: <20190722053954.25423-4-ming.lei@redhat.com>
In-Reply-To: <20190722053954.25423-1-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 22 Jul 2019 05:40:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before aborting in-flight requests, all IO queues have been shutdown.
However, request's completion fn may not be done yet because it may
be scheduled to run via IPI.

So don't abort one request if it is marked as completed, otherwise
we may abort one normal completed request.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81fc7f4..cb8007cce4d1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
+	/* don't abort one completed request */
+	if (blk_mq_request_completed(req))
+		return;
+
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
-- 
2.20.1

