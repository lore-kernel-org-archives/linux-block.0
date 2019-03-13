Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E580C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008F220854
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuIVmbkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCMR4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCMR4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NoWrSiVU5TJCRDjKdIhh3DO0eirxhUOza/cBFk/T6eM=; b=NuIVmbkgwMK6MnMUCO4SQ/CYU4
        nf6/3hy7wvooQcSuzzR6WqtloA3OfuwumGBTtvOqecGI6gf7ZrZBgP1o1M3cWgCpMvPvjpf08RkWh
        1cEMZbyd3BypdXu77hM3bCXxC/s0uI4TBzjWUOLZH3ZAeUDDNUFyuXR+Vhfd3Mq5NMjh0v1LyarUe
        5qFtJUbTjMOI0V4/TNunffz071og0fBVoZaChWEcpZInmt4uhuFk605I0CZaC7cpu0HA468b9QkFu
        v3C7AxKokBgkoaBylyd7XpY0qk/Eh1gDBt+idIveUPXeGDZc2b30MbTnYwYSPyO4KYa8SWQl1/FIp
        hCQIk90w==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486c-0001oQ-Sa; Wed, 13 Mar 2019 17:55:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>,
        Nigel Kirkland <nigel.kirkland@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 11/17] nvmet-fc: bring Disconnect into compliance with FC-NVME spec
Date:   Wed, 13 Mar 2019 18:55:04 +0100
Message-Id: <20190313175510.20725-12-hch@lst.de>
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

The FC-NVME spec, when finally approved, modified the disconnect LS
such that the only scope available is the association.

Rework the Disconnect LS processing to be in accordance with the
change.

Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fc.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8d34aa573d5b..7f051f9dfa8f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1502,10 +1502,8 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			(struct fcnvme_ls_disconnect_rqst *)iod->rqstbuf;
 	struct fcnvme_ls_disconnect_acc *acc =
 			(struct fcnvme_ls_disconnect_acc *)iod->rspbuf;
-	struct nvmet_fc_tgt_queue *queue = NULL;
 	struct nvmet_fc_tgt_assoc *assoc;
 	int ret = 0;
-	bool del_assoc = false;
 
 	memset(acc, 0, sizeof(*acc));
 
@@ -1536,18 +1534,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		assoc = nvmet_fc_find_target_assoc(tgtport,
 				be64_to_cpu(rqst->associd.association_id));
 		iod->assoc = assoc;
-		if (assoc) {
-			if (rqst->discon_cmd.scope ==
-					FCNVME_DISCONN_CONNECTION) {
-				queue = nvmet_fc_find_target_queue(tgtport,
-						be64_to_cpu(
-							rqst->discon_cmd.id));
-				if (!queue) {
-					nvmet_fc_tgt_a_put(assoc);
-					ret = VERR_NO_CONN;
-				}
-			}
-		} else
+		if (!assoc)
 			ret = VERR_NO_ASSOC;
 	}
 
@@ -1575,26 +1562,10 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 				sizeof(struct fcnvme_ls_disconnect_acc)),
 			FCNVME_LS_DISCONNECT);
 
-
-	/* are we to delete a Connection ID (queue) */
-	if (queue) {
-		int qid = queue->qid;
-
-		nvmet_fc_delete_target_queue(queue);
-
-		/* release the get taken by find_target_queue */
-		nvmet_fc_tgt_q_put(queue);
-
-		/* tear association down if io queue terminated */
-		if (!qid)
-			del_assoc = true;
-	}
-
 	/* release get taken in nvmet_fc_find_target_assoc */
 	nvmet_fc_tgt_a_put(iod->assoc);
 
-	if (del_assoc)
-		nvmet_fc_delete_target_assoc(iod->assoc);
+	nvmet_fc_delete_target_assoc(iod->assoc);
 }
 
 
-- 
2.20.1

