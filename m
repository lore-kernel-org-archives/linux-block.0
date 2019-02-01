Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F5C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6375F20869
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mMte/lE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfBAH4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:56:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfBAH42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 02:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3tz3dA8YAfgSwTNZlXBMk+Ut75GyD80Dut7IKVEoxWs=; b=mMte/lE7H7Yvs97GgEylrWmeLa
        pARA/CiIJlOle+18gqTRg+N2DFrxNufrdmhdtCcwemPdi2/c5h8BIqpm8xdtgwOo7BTomg3IWi0k4
        mLQgijs0vJNSLQdTaM3WHii496ayuS/fEYfkln5VjahMDZXY1ODbu+P9BppwUMpJAXJaNzrn8XgRz
        bnqrZnuQ2yXClL7w92KAh9r/YRcGSUEAL0ya4m1bXUaxh8sh7a+Zqx2LTJJ2XiJlpdtwcyGSJIHrV
        osSS2N7uNyjByBAHuKYU/q3mhwG2ODKz6BVVGZv1qn6G2kgQpchQzXgGROcDWRwtxPewVH79wisPd
        HLxlGVxw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpTgW-0005s5-64; Fri, 01 Feb 2019 07:56:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] scsi: stop setting up request->special
Date:   Fri,  1 Feb 2019 08:55:55 +0100
Message-Id: <20190201075557.9249-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201075557.9249-1-hch@lst.de>
References: <20190201075557.9249-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No more need in a blk-mq world where the scsi command and request
are allocated together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/qedf/qedf_io.c | 6 ------
 drivers/scsi/qedi/qedi_fw.c | 7 -------
 drivers/scsi/scsi_lib.c     | 3 ---
 drivers/scsi/sr.c           | 1 -
 4 files changed, 17 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 6bbc38b1b465..6ca583bdde23 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -1128,12 +1128,6 @@ void qedf_scsi_completion(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 		return;
 	}
 
-	if (!sc_cmd->request->special) {
-		QEDF_WARN(&(qedf->dbg_ctx), "request->special is NULL so "
-		    "request not valid, sc_cmd=%p.\n", sc_cmd);
-		return;
-	}
-
 	if (!sc_cmd->request->q) {
 		QEDF_WARN(&(qedf->dbg_ctx), "request->q is NULL so request "
 		   "is not valid, sc_cmd=%p.\n", sc_cmd);
diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 25d763ae5d5a..e2a995a6e8e7 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -616,13 +616,6 @@ static void qedi_scsi_completion(struct qedi_ctx *qedi,
 		goto error;
 	}
 
-	if (!sc_cmd->request->special) {
-		QEDI_WARN(&qedi->dbg_ctx,
-			  "request->special is NULL so request not valid, sc_cmd=%p.\n",
-			  sc_cmd);
-		goto error;
-	}
-
 	if (!sc_cmd->request->q) {
 		QEDI_WARN(&qedi->dbg_ctx,
 			  "request->q is NULL so request is not valid, sc_cmd=%p.\n",
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6fd1d8d83f07..7e256b384a99 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1568,10 +1568,7 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 
 	scsi_init_command(sdev, cmd);
 
-	req->special = cmd;
-
 	cmd->request = req;
-
 	cmd->tag = req->tag;
 	cmd->prot_op = SCSI_PROT_NORMAL;
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 38ddbbfe5f3c..039c27c2d7b3 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -394,7 +394,6 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 	ret = scsi_init_io(SCpnt);
 	if (ret != BLK_STS_OK)
 		goto out;
-	WARN_ON_ONCE(SCpnt != rq->special);
 	cd = scsi_cd(rq->rq_disk);
 
 	/* from here on until we're complete, any goto out
-- 
2.20.1

