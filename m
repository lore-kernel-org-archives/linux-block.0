Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E6C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A33220868
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 07:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CmAr1/eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A33220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeKPSKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:10:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kRoV+RvAiPq7MqensuQhQLXJt+nxkCGdZk1xFC9hwG4=; b=CmAr1/eJbU/iCMxOwMzskdcxA
        Hhjy2TSDGNpln/3M8kMqRXe0w1aerRrNKbJaRRlAO83e2UL7QY69/5b/c6eER329O3TkYPePS3u4m
        lgY5kYdCtphq/1eIcqUP2l6YW7yGt9DO6zh3UGX6WXkj/w/DVycI9m/2YlK3PjG3LTt1xApi3DLk7
        cTJ/8ilPi+mNBiad/o9JejOdF9IPmiG+yo3u/5Xo9C98WbhCmyztsKJ0hUlNfGdY7FMuBHvIHfqsc
        wIGHtmPc+zqPSG/7uNBHJlvOsIMf2xEVCoaIWCppXlsxIrzIGwFmOREcJZZBs+QHbK6HoZfX6Yceo
        PHR25AKOg==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZ1e-0006X2-NB; Fri, 16 Nov 2018 07:58:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove the rq_alloc_data request_queue field
Date:   Fri, 16 Nov 2018 08:58:47 +0100
Message-Id: <20181116075847.29485-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
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

