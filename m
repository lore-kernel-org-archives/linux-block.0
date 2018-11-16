Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34840C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA162145D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AjOZ1Xtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA162145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKPSV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:21:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kRoV+RvAiPq7MqensuQhQLXJt+nxkCGdZk1xFC9hwG4=; b=AjOZ1XtnyjVOt59Fx2pTeCUyuZ
        tgZAEBiTcf4yZRbFWWa20MOjiOFKYfWxYXdVvKDjBy5zAISxRgkrZJJLWnhvqnzlujjm3V0KZX45T
        tcQekAdQWco+OfCj+BcTeAXbP6SVq3fRlbyIUm29GwK1pmhVL76HtqI9YOFAdWryVp1CKP95g5/pR
        HzoF21tRNDwPDgrYyQHuCPNtbCsdYT3gAQxtpviMeFURexn9dRoNb/C6rsp84NYapSOKqkBH4If2E
        ebqX/8xUDp3wMtizTloFF65q4ZIiA8q3oFLXPMyfF0BxNdPM7/phyocgXxs6UgqTBa3Lm/G2GeyLR
        x7ildjvQ==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZCd-0002bZ-23; Fri, 16 Nov 2018 08:10:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/6] block: remove the rq_alloc_data request_queue field
Date:   Fri, 16 Nov 2018 09:10:01 +0100
Message-Id: <20181116081006.5083-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116081006.5083-1-hch@lst.de>
References: <20181116081006.5083-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1d185f1fc333..5c5ef461845f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -567,7 +567,6 @@ struct request_queue {
 	bool			mq_sysfs_init_done;
 
 	size_t			cmd_size;
-	void			*rq_alloc_data;
 
 	struct work_struct	release_work;
 
-- 
2.19.1

