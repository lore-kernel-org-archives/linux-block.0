Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE9C10F03
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755012077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H89rzwWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCMRzv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCMRzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cZNH1UDgjHssIcr4zuVmj3khs8swLSWTUTaIVeGW7V4=; b=H89rzwWTZqMNmmAGcfk8I21Nd6
        jwKe6cAnYKEmNXZXnramQu1vy14cgu0qCh9KHSbZ0NDoXoYQN3moHLmqGxJJHn47FfOib/YGUMM6M
        1SQ2DUKD6fs3KjrYjvfHtkkWUVk/MdKn27SJHEq3gF0VA51/aMVpr9Ac0lkIy1jrZLvKkJwlMG9n3
        Mx4ndgUUF+TrRlYuozWOh6QV/eKgZ/rEDQhQJpwIQ0WpYCvm5BWTpsiJYij9hQt1JPYh+nS1quLMB
        kJVUrW6nRiimHQrx9hpOCIZm0it8p5BZREFG1cajsfAZYR8YRrZZpw34oDPAoKc1m2FnNQk+gYRLb
        HNmawbdg==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486S-0001Zm-51; Wed, 13 Mar 2019 17:55:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 07/17] nvme-fc: use nr_phys_segments to determine existence of sgl
Date:   Wed, 13 Mar 2019 18:55:00 +0100
Message-Id: <20190313175510.20725-8-hch@lst.de>
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

For some nvme command, when issued by the nvme core layer, there
is an internal buffer which can cause blk_rq_payload_bytes() to
return a non-zero value yet there is no actual/real command payload
and sg list.  An example is the WRITE ZEROES command.

To address this, when making choices on whether to dma map an sgl,
use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes().
When there is a sgl, blk_rq_payload_bytes() will return the amount
of data to be transferred by the sgl.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b29b12498a1a..ba8f2a9cbdaf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2107,7 +2107,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 
 	freq->sg_cnt = 0;
 
-	if (!blk_rq_payload_bytes(rq))
+	if (!blk_rq_nr_phys_segments(rq))
 		return 0;
 
 	freq->sg_table.sgl = freq->first_sgl;
@@ -2304,12 +2304,23 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	data_len = blk_rq_payload_bytes(rq);
-	if (data_len)
+	/*
+	 * nvme core doesn't quite treat the rq opaquely. Commands such
+	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
+	 * there is no actual payload to be transferred.
+	 * To get it right, key data transmission on there being 1 or
+	 * more physical segments in the sg list. If there is no
+	 * physical segments, there is no payload.
+	 */
+	if (blk_rq_nr_phys_segments(rq)) {
+		data_len = blk_rq_payload_bytes(rq);
 		io_dir = ((rq_data_dir(rq) == WRITE) ?
 					NVMEFC_FCP_WRITE : NVMEFC_FCP_READ);
-	else
+	} else {
+		data_len = 0;
 		io_dir = NVMEFC_FCP_NODATA;
+	}
+
 
 	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
 }
-- 
2.20.1

