Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB58FC67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8414620873
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXQHoE1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8414620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeLMGiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeLMGiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K3HtS4PLgyfnrP333MfqkULqBfPg0tDDpqVmKCEk4XI=; b=EXQHoE1y214RSbhauP/KRYc/l
        n5e18ExxQ++wegVkXH2PS504gyn7Fa8OEkW1y3hYqLJls7OdRrVUcbaqVG8RGrfedk777STn3KvwB
        KawnVqmSNtCltL2I0qA1/6UvG82ZBZsJtucYk/k59IKV+CQxwSHtps1UANFrzFLolxsGZKhNgm3Wp
        8M3P7hmHYjkYSrKjsW+e/P00j3MY7L6oTt1P2nkFAJyc/+lBx3kA/Gg+KZ17dzXvOwBoaJGmtjUZP
        LunYYio5/nWPJZWCz+9w0wStiBsBorlMLyHMlO1U2DTpSqY6fZ9wTdrFo+zEobc/6KNRKLnvDp9+k
        PSTlKbTTA==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXKdZ-0006LR-Tj; Thu, 13 Dec 2018 06:38:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying namespace request queue
Date:   Wed, 12 Dec 2018 22:38:18 -0800
Message-Id: <20181213063819.13614-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the multipath device does not support polling (yet) we cannot
pass requests to the polling queue map as those will not generate
interrupt so we cannot reap the completion.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb1c10b0eaf0..5a6c29ee669c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1550,6 +1550,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		/* multipath device does not support polling */
+		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);
 	}
 #endif
 }
-- 
2.17.1

