Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C4C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E0F60F58
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhHDJoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhHDJoH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:44:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B11C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a1JlLAKyTWc4CI+MEMy/3HU29ue4Lbea5QZPC0M4m4o=; b=JbvVifYAytsQhTbZucmQa0DKFD
        io8Kfz8pAj3ncRXpaax/EizQ3OQXsFtPVcVj6tZyzeYUcKKE8LTsmyMDLJNElj2w/az5EeOAC71PN
        5QY28Ks/5Hpb9rCOYkT18C0vrHUkXO2YfB8dM7ahHaigMX/ipSPi1BoZUQu3Z7sCbkTw/no0uhy+5
        rAGLusuR9aEEIn2RNsw9uVJxXhPQMPzny2RNqMF9IZM0qS9AgpXg3J5piEamqAP1+aaIMWZZXuwQK
        5itNGC0A56yL4PjjZ2cfocWrw+4VFMDxhqSYuqcrybmZtjwpe5Z2Wcf/qmvOyfabMg3XAWfYuH8Ww
        iiFUtJkw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDQV-005e1O-HS; Wed, 04 Aug 2021 09:43:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: remove the extra kobject reference in bd_link_disk_holder
Date:   Wed,  4 Aug 2021 11:41:41 +0200
Message-Id: <20210804094147.459763-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 0d02129e76ed ("block: merge struct block_device and struct
hd_struct") there is no way for the bdev to go away as long as there is
a holder, so remove the extra references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 block/holder.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 904a1dcd5c12..960654a71342 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -92,11 +92,6 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
 	if (ret)
 		goto out_del;
-	/*
-	 * bdev could be deleted beneath us which would implicitly destroy
-	 * the holder directory.  Hold on to it.
-	 */
-	kobject_get(bdev->bd_holder_dir);
 
 	list_add(&holder->list, &bdev->bd_holder_disks);
 	goto out_unlock;
@@ -130,7 +125,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
 		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-- 
2.30.2

