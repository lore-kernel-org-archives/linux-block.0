Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B532C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEBC6148E
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhGAIUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAIUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 04:20:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00026C061756
        for <linux-block@vger.kernel.org>; Thu,  1 Jul 2021 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XFUy35hk/kBhiWuhUej28etO8To3p9NspdFbhuO4xZs=; b=LjUW5dKfSPP9MzO9Ao/QqqN4Vj
        1F/yE9cIhBQS+vOZlPmsKidnTD/CjZ+AXy1A3sf28BbXbCXtFrrYq152irOKWuZBPr0aQJw6OC/W8
        yhVyOeFswzs5Hi3quJhslehyPL9gUaY5ld0mljVbk9Gi3keDh/E6sLvIrUpXEiGLoZ0klusvz5pss
        JPAIVPXP6eiSz8Yq8kRQodXLOoBStfK9ufXdmtNxfz44hT72+mTLKRsqBxrLLnWrMYHqC/+1unDPx
        sGqSbVIGEYEgBVQnXbVjCNc/SqQIWQYKrvXxmeiVbf8w3gKpJZ9e4RyX7xK7Q6uswYcOd9roZQOdK
        JYLUXg/w==;
Received: from [2001:4bb8:180:285:b614:ad7e:3c44:605c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyrsc-006KsV-Nb; Thu, 01 Jul 2021 08:17:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: grab a device refcount in disk_uevent
Date:   Thu,  1 Jul 2021 10:16:37 +0200
Message-Id: <20210701081638.246552-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701081638.246552-1-hch@lst.de>
References: <20210701081638.246552-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sending uevents requires the struct device to be alive.  To
ensure that grab the device refcount instead of just an inode
reference.

Fixes: bc359d03c7ec ("block: add a disk_uevent helper")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 79aa40b4c39c..af4d2ab4a633 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -365,12 +365,12 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
 	xa_for_each(&disk->part_tbl, idx, part) {
 		if (bdev_is_partition(part) && !bdev_nr_sectors(part))
 			continue;
-		if (!bdgrab(part))
+		if (!kobject_get_unless_zero(&part->bd_device.kobj))
 			continue;
 
 		rcu_read_unlock();
 		kobject_uevent(bdev_kobj(part), action);
-		bdput(part);
+		put_device(&part->bd_device);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-- 
2.30.2

