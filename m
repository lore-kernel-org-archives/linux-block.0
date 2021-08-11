Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09BC4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3763760FA0
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhHKMr4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 08:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhHKMrz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 08:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800DEC061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vQt95oM61eET5+kiBSYsNWnQOETYhTTnfEu/uTorkMY=; b=OvHqIM0gRAzf74CsVeifrGLaHS
        +JvjgT3giFqrlh2AP24d5zhFC53a3r5RqOQkGQAaJMFxwsDB8+y+YzorbtGAa0BkPWPrThfaJWdBg
        Zw0wvh5fP9/0F726kuQMgYhzdI9LtF6MhI6AK/19eFvu2wYa+enlKiHBpfuSlNhL72JpIeiHCfAxk
        bV53up7LDi+cMqe4StCq3YTpa7VbaXDtzeD9FFTw/6zeNeGNJiqNiH2QQjMtNF8RzIX7fVgCcR+tj
        5YSSQJOhupBIVU8O3s86gx1V8KPro/6Cc7PC4wOjlqkofs4n0ZfPXhduiucCjQEA0NB7mcSOXwzBL
        rdm/OgZw==;
Received: from [2001:4bb8:184:6215:7ee3:d0e9:131a:82ff] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDncc-00DPlf-7z; Wed, 11 Aug 2021 12:46:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 2/6] nbd: refactor device removal
Date:   Wed, 11 Aug 2021 14:44:24 +0200
Message-Id: <20210811124428.2368491-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811124428.2368491-1-hch@lst.de>
References: <20210811124428.2368491-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Share common code for the synchronous and workqueue based device removal,
and remove the pointless use of refcount_dec_and_mutex_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9a7c9a425ab0..6caf26b84a5b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -259,48 +259,37 @@ static void nbd_notify_destroy_completion(struct nbd_device *nbd)
 		complete(nbd->destroy_complete);
 }
 
-static void nbd_dev_remove_work(struct work_struct *work)
+static void nbd_dev_remove(struct nbd_device *nbd)
 {
-	struct nbd_device *nbd =
-		container_of(work, struct nbd_device, remove_work);
-
 	nbd_del_disk(nbd);
 
-	mutex_lock(&nbd_index_mutex);
 	/*
-	 * Remove from idr after del_gendisk() completes,
-	 * so if the same id is reused, the following
-	 * add_disk() will succeed.
+	 * Remove from idr after del_gendisk() completes, so if the same ID is
+	 * reused, the following add_disk() will succeed.
 	 */
+	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, nbd->index);
-
 	nbd_notify_destroy_completion(nbd);
 	mutex_unlock(&nbd_index_mutex);
 
 	kfree(nbd);
 }
 
-static void nbd_dev_remove(struct nbd_device *nbd)
+static void nbd_dev_remove_work(struct work_struct *work)
 {
-	/* Call del_gendisk() asynchrounously to prevent deadlock */
-	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags)) {
-		queue_work(nbd_del_wq, &nbd->remove_work);
-		return;
-	}
-
-	nbd_del_disk(nbd);
-	idr_remove(&nbd_index_idr, nbd->index);
-	nbd_notify_destroy_completion(nbd);
-	kfree(nbd);
+	nbd_dev_remove(container_of(work, struct nbd_device, remove_work));
 }
 
 static void nbd_put(struct nbd_device *nbd)
 {
-	if (refcount_dec_and_mutex_lock(&nbd->refs,
-					&nbd_index_mutex)) {
+	if (!refcount_dec_and_test(&nbd->refs))
+		return;
+
+	/* Call del_gendisk() asynchrounously to prevent deadlock */
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags))
+		queue_work(nbd_del_wq, &nbd->remove_work);
+	else
 		nbd_dev_remove(nbd);
-		mutex_unlock(&nbd_index_mutex);
-	}
 }
 
 static int nbd_disconnected(struct nbd_config *config)
-- 
2.30.2

