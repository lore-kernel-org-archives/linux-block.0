Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2EC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3B20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DF8+HFfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeLMPRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbeLMPRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AsPQ8Zk1N+n6QA1EPXmC6mz+BLWdK7VbmMCGrljtlso=; b=DF8+HFfRgl3eaa8woeY2e5QrdQ
        KFi436KY1MczvR9uXiXvqiP1vhySJCmzEotaJh/qdql6uq3PpzNwFPJEhRj7pkYzkXh8Z38XGggKh
        TMub6kVEJBrXoVfklH3G2C/HZK/qugIdTtO2J/EzVH/P/XVx767WU0dgL5HGkomKnBbB+cvRPNG2A
        R7CsVPrLqkkULyMcOhBMPyJfAX0iWsdQc82dr3uweR0oqxPKsWXtLhoiYzY9YdmpY8aqaB1l063Fi
        SfHHFc64+ligRL+TMZCNVcZjkJ77xVe5Maq6/RcYpZHPYh8qHjZJdQA5sJJGVT2PfKVTcE7vkbIOv
        wmRpfrDw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSjx-0001Ke-W7; Thu, 13 Dec 2018 15:17:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 06/10] xen-scsifront: remove DISABLE_CLUSTERING
Date:   Thu, 13 Dec 2018 16:17:06 +0100
Message-Id: <20181213151710.30036-7-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213151710.30036-1-hch@lst.de>
References: <20181213151710.30036-1-hch@lst.de>
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
2.19.2

