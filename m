Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76869C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C72218D4
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2PWvMNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeLTRgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:36:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbeLTRgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 12:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lh/UE2rcWeNuVlT6YYAIu+vONrVf+TLl/qV0NMHx9/k=; b=o2PWvMNSj4TxlAv9ddKOz/DIX
        +eabdGN8hPtEp3A4Dzo8NjRwiZAxFUzeRiIXWrgw3rlj5LqYwhfiUdDpe1xYQUG3TlgtjA7lzh9hc
        MpUVdBe+eNXEdIhM7dHFbHDraw9zPH+hxWDmH3UdApf+eHNdBUidgGvPFSpp/My1kyPToUwpR4BbO
        VrsOm+qoB60IDkeAieAwolHX9Z0yIoEyTToyBTI/924u/gp8N32XdenhwVR2UX2q5gk1S7w6QMtlH
        H4/9dkU+LGUEDwdfdyX3qvF221SuqS23fHiCzXe/EiBU2uJnoGrr/9pVwUtkeunJFlxiYcBdQ/LIW
        /m8jrBhmg==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga2FC-0006uj-Nm; Thu, 20 Dec 2018 17:36:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2] bsg: deprecate BIDI support in bsg
Date:   Thu, 20 Dec 2018 18:36:20 +0100
Message-Id: <20181220173620.29120-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Besides the OSD command set that never got traction, the only SCSI
command using bidirectional buffers is XDWRITEREAD in the 10 and 32 byte
variants, which is extremely esoteric and has been removed from the spec
again as of SBC4r15.  It probably doesn't make sense to keep the support
code around just for that, so start deprecating the support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - mention that XDWRITEREAD has been removed from SBC

 block/bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bsg.c b/block/bsg.c
index 44f6028b9567..50e5f8f666f2 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -177,6 +177,10 @@ bsg_map_hdr(struct request_queue *q, struct sg_io_v4 *hdr, fmode_t mode)
 			goto out;
 		}
 
+		pr_warn_once(
+			"BIDI support in bsg has been deprecated and might be removed. "
+			"Please report your use case to linux-scsi@vger.kernel.org\n");
+
 		next_rq = blk_get_request(q, REQ_OP_SCSI_IN, 0);
 		if (IS_ERR(next_rq)) {
 			ret = PTR_ERR(next_rq);
-- 
2.19.2

