Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23EEC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82EC2243B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azEJq8oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82EC2243B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeLFPxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeLFPxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UVRkTasI3fmmvzTbMko3VPgciP6NgRKIlYUJcwaigOU=; b=azEJq8oArX6J54eCU7sGDYuH7K
        DIjmBF4Dj8DQbLtf9L1pceTY19lx77yRDAgHxY+CXAFkazlr6t2/45XokaChCQcxfNLTwwH53zzk5
        Hd3AWacSTZDstCLq+jfZAm2rYqTjnLyAHPfzYHWOJSGY7am7o7rPbxMkipEUDha1TZXB9Ng0pkaKr
        P27ZEhE7o3652AUDn01Iv22nunh33zzui/oxmHGXxnJ1prERsyQRMUovYFtKoWB7JnzTKZGgQOuXU
        r39lye8X4tWvTv3RwXUGxP7HCDXLtjSH/PyeQNuEbVz9b2fUH1z/rYzCfhEbf5gcyfFqsvAYmviuX
        JtT0x0qA==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxU-0008Ly-FB; Thu, 06 Dec 2018 15:53:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 5/9] xen-scsifront: remove DISABLE_CLUSTERING
Date:   Thu,  6 Dec 2018 07:52:54 -0800
Message-Id: <20181206155258.11465-6-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206155258.11465-1-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no such limitation in the protocol or implementation, so
remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/xen-scsifront.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index bb76d0d2022b..f0068e96a177 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -696,7 +696,6 @@ static struct scsi_host_template scsifront_sht = {
 	.this_id		= -1,
 	.cmd_size		= sizeof(struct vscsifrnt_shadow),
 	.sg_tablesize		= VSCSIIF_SG_TABLESIZE,
-	.use_clustering		= DISABLE_CLUSTERING,
 	.proc_name		= "scsifront",
 };
 
-- 
2.19.1

