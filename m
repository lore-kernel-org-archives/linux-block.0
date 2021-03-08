Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9DC433E9
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D51651E6
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhCHHq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 02:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhCHHqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 02:46:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F217C06174A
        for <linux-block@vger.kernel.org>; Sun,  7 Mar 2021 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WAZmR7IvxS8sB9w1a8MZLOHfY6g7zP9/lNuLwV8XQxA=; b=vrbdfhFGIOFzOhbEjsDN+XbkTA
        QMYnIz446uW3ITWfOCU4/jem0z7wkSyVW3H3MMbXl6YAWQo40RNzfWwOGRODDYLJMOdAgZSdoR85r
        74dKht/IjddLI1ZPImJZaFypGK3LbEiI5TtBLb2Z9aMqg2OScGoPLr7hyTQFGOPiRGKV8kdAi/kUr
        VVIFbwzHPeGHhGdGr0vVr3qeClV/L8yX8OJ6KhI2+MATrRGgvXIFCzWlCyHL0SaXLcV1it2/3mwGv
        BwiCGVEFetMb1bz1ztcUjAyk2J+tFssxBzV1dC9lwAc49DFeTG5S/2zmIqHkcWLnH5MOdwlnOk9g7
        8Zh8V2NQ==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJAaS-00FBq1-Uu; Mon, 08 Mar 2021 07:45:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] paride/pd: remove ->revalidate_disk
Date:   Mon,  8 Mar 2021 08:45:48 +0100
Message-Id: <20210308074550.422714-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308074550.422714-1-hch@lst.de>
References: <20210308074550.422714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
index 897acda20ac85a..828a45ffe0e7d8 100644
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
2.30.1

