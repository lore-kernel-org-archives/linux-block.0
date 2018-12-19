Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28526C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEC6218AE
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 14:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+0GdN1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeLSOjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:39:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbeLSOjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 09:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IW9P7elJQzZzCPYrWz2rrv3xmmnm5jhCP4yTVocJkvs=; b=r+0GdN1eq5rlD1c5OYoeQh4/t
        yyFxH0qUtVlkQ5PXN4vtEGgylKHh3k4iixeGYPmH66aC8jYMPpK8Sgv8kjELp7i2pJuRZt9HmNOdK
        pYIccW6d5FymK9tRuBKk3XNKK/K03/srvkhxDDunRC4vE6BkefV5sdSM08WmWiCxTRg8+HxF7MUN0
        1HfxNImls1a3JCzluzvYqCtAMZe4eErD80CWfPu1P7sla/WuhFs3Iim7zJzjAIIVGypWWCf+YOERV
        +qOYQbmUEF9gE4Rtuo6zxIAhLGbLaFcIQ2VPtXDecdB4/ScWM1vD9ew+1dffjA5+X8qrMq0jxlxzR
        zNmu1YxSA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZd0a-0003pY-IZ; Wed, 19 Dec 2018 14:39:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] bsg: deprecate BIDI support in bsg
Date:   Wed, 19 Dec 2018 15:39:34 +0100
Message-Id: <20181219143934.3910-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Besides the OSD command set that never got traction, the only SCSI
command using bidirectional buffers is XDWRITEREAD in the 10 and 32
byte variants, which is extremely esoteric.  It probably doesn't make
sense to keep the support code around just for that, so start
deprecating the support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bsg.c b/block/bsg.c
index 9a442c23a715..60b41bf79e16 100644
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

