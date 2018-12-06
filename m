Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C6C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC1821527
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ThGeGOTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC1821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeLFPxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeLFPxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HJxLLOF+rWr0Wp/hHNU6xNmRzUVZTCR5AKMTHz2l4z0=; b=ThGeGOTmrkJ9MX+DdCz8OXXP6r
        qK3cEbFF9F8dQ7pRfrNOUl2yojFzxKWuj0k1tJFneaXuP8Py30sEuzWhX/OU22aYIdjUBfNejyc1c
        ZOwVMGw/UeCTXX+0JwvXh75xiqm+byhIuwB0Cxy7JcUDIt5NN/RWiV8UeylWrLAh/gl6zuh0uWOKe
        9wEmE3HK0x5YayHPO0mjAqjogFYs5RUIstf/XHnBLhYxUYfbzviShAAInFcSdT6Yp3m2DNfI9QIdA
        KMcBoIuQIpfMF1jYYT0Iesahnf+qHxUTz24s5HxMhNlr52XI6SsDviHiS4SKYhj+nYgTUz6a8KBaO
        DJOXhPvw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxU-0008LV-0q; Thu, 06 Dec 2018 15:53:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 3/9] myrb: remove the DISABLE_CLUSTERING flag
Date:   Thu,  6 Dec 2018 07:52:52 -0800
Message-Id: <20181206155258.11465-4-hch@lst.de>
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

The old DAC960 drivers was fine with merging over segment bondaries,
so this new driver should be to.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/myrb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index f1abe38e3b3a..aeb282f617c5 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -2236,7 +2236,6 @@ struct scsi_host_template myrb_template = {
 	.shost_attrs		= myrb_shost_attrs,
 	.sdev_attrs		= myrb_sdev_attrs,
 	.this_id		= -1,
-	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 /**
-- 
2.19.1

