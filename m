Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34543C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTQrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJTQqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:46:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4551DCCCE
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fe/W1bXxM7PXN3m/yBttVB5HtKl4K1Elshq3n8QBbXs=; b=Ti0cxSLvyzNJecz0gkMgJ6fAdz
        pezGFPmVBcJpblyI7ChqpJUjGE4F9V5+kh/QTviy6mGxJDQV5+DyNEsGGpzwPwuEkKcF4apj+bVoT
        /zmryGY79J1TRzdKJ5WCOLKxfcRVcdEl95EjCDQu/fV8EqhK/Al2wIngkXMdL4NtrRHztdcS86GhP
        UpHDeGFJwUhtUA1dgpQ21LkhK56kp09zW8/rMV5ShJeDPlemFil3+sPyX3sJ/3p1J+bHkH6R9hOIz
        QflIwpGeFl4XjZZXPV1PTEhLZeAz3czMSRjCmcc+Trf8HspVPJSwK0vH1FVfDX84xa9MsnS5XTCyo
        vxXrykPA==;
Received: from [205.220.129.26] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYgm-000WLG-2r; Thu, 20 Oct 2022 16:46:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/6] dm: remove free_table_devices
Date:   Thu, 20 Oct 2022 09:46:01 -0700
Message-Id: <20221020164605.1764830-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020164605.1764830-1-hch@lst.de>
References: <20221020164605.1764830-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

free_table_devices just warns and frees all table_device structures when
the target removal did not remove them.  This should never happen, but
if it did, just freeing the structure without deleting them from the
list or cleaning up the resources would not help at all.  So just WARN on
a non-empty list instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 60549b65c799c..36189a32329aa 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -833,19 +833,6 @@ void dm_put_table_device(struct mapped_device *md, struct dm_dev *d)
 	mutex_unlock(&md->table_devices_lock);
 }
 
-static void free_table_devices(struct list_head *devices)
-{
-	struct list_head *tmp, *next;
-
-	list_for_each_safe(tmp, next, devices) {
-		struct table_device *td = list_entry(tmp, struct table_device, list);
-
-		DMWARN("dm_destroy: %s still exists with %d references",
-		       td->dm_dev.name, refcount_read(&td->count));
-		kfree(td);
-	}
-}
-
 /*
  * Get the geometry associated with a dm device
  */
@@ -2123,7 +2110,7 @@ static void free_dev(struct mapped_device *md)
 
 	cleanup_mapped_device(md);
 
-	free_table_devices(&md->table_devices);
+	WARN_ON_ONCE(!list_empty(&md->table_devices));
 	dm_stats_cleanup(&md->stats);
 	free_minor(minor);
 
-- 
2.30.2

