Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC289C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C81E21D24
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NeJbLHUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgINHIE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgINHID (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 03:08:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C880C06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X+FmxIt5JE+tfu/twlkJQ3NgOci/ZqyUCdgHEOv5SbU=; b=NeJbLHUzKPUJ2hBG5KtDdv0i9Z
        ImnLMfa/xWVxf+kikLAERO6HwzgS1FTE3bdB6sIlBFH6lWyDYidc3ChdJoP1jRcPG30YIYQ2NdS/N
        j7Xj32DidkLIa4ngVjMvDFjXxt75tC7f6yQAr9eH+HvHVDMEE0yJ4r05OrIr45mBox5jiDHKJDqCz
        TZ5tw/XRiNwkaQvGPTond/PE4zPhHBUo6mljNtgpDytFUxUbXbUasQsVrswlvho4l7wJu74tYHPHf
        3YNFH3+yGH4xqJ+pRq4pEyNqOONpuhqGEYIu1a+KUUd0Vf9eZtyIIycvEpgjDBdaKcEz8+Avs7EtD
        znnZ+tCQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHiam-0006gh-W1; Mon, 14 Sep 2020 07:08:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] paride/pd: remove ->revalidate_disk
Date:   Mon, 14 Sep 2020 09:03:35 +0200
Message-Id: <20200914070337.1578317-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914070337.1578317-1-hch@lst.de>
References: <20200914070337.1578317-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->revalidate_disk is only called during add_disk for pd, but at that
point the driver has already set the capacity to the one returned from
Identify a little earlier, so this additional update is entirely
superflous.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index a7af4f27b7c3f1..022a7ea451307e 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -859,16 +859,6 @@ static unsigned int pd_check_events(struct gendisk *p, unsigned int clearing)
 	return r ? DISK_EVENT_MEDIA_CHANGE : 0;
 }
 
-static int pd_revalidate(struct gendisk *p)
-{
-	struct pd_unit *disk = p->private_data;
-	if (pd_special_command(disk, pd_identify) == 0)
-		set_capacity(p, disk->capacity);
-	else
-		set_capacity(p, 0);
-	return 0;
-}
-
 static const struct block_device_operations pd_fops = {
 	.owner		= THIS_MODULE,
 	.open		= pd_open,
@@ -877,7 +867,6 @@ static const struct block_device_operations pd_fops = {
 	.compat_ioctl	= pd_ioctl,
 	.getgeo		= pd_getgeo,
 	.check_events	= pd_check_events,
-	.revalidate_disk= pd_revalidate
 };
 
 /* probing */
-- 
2.28.0

