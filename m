Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F29C43215
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773C8206EC
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uK2EhLI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLCJjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZWNuk9tGiFLw60K3+rMwEOfotKEctVC+64L+2oyWZcg=; b=uK2EhLI6LqBXjH0GkVuKjW29TE
        49A7qyay7ke6yFkBzrdG0klMpQwS8+qcIIDvScsAuS3hPSmJ9bfjSEAUi93+n9sob+6EX/GslmKmG
        jMdmIkPSBKwMY0FC9vPA/s+64p+jZbXlljHBDpadJVmNuZOb9S7bwo1DJELWrVLH4NEa+J71TZGzH
        1DZb6Kyz3zb1SfoLSWWDBnei5k77czDQUVUYQSFxSZvLpiHOXoKA9zvRFNaVIYiz1r3CeFxMUNsyI
        qnRTXREhDBVq3G6j77wxH0KfSyGvZkwqMZZTCtj4+iOLIeLd0LtV/pRYLjx1TLAGK7MK+UAXcjd7b
        Fc0vXBXw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eL-00026k-QD; Tue, 03 Dec 2019 09:39:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: remove the empty line at the end of blk-zoned.c
Date:   Tue,  3 Dec 2019 10:39:03 +0100
Message-Id: <20191203093908.24612-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
References: <20191203093908.24612-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6fad6f3f6980..618786f8275c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -488,4 +488,3 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
-
-- 
2.20.1

