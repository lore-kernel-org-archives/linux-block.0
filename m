Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81DC432BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EABF6056C
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 12:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhHKMtJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKMtI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 08:49:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E72C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q/VvVJUMkdBIfrc0PPP11iXE8LXtzuS50Q4GKM+wD9c=; b=itbuFHCdi3odw54JKxJKEMfdu6
        8sl5XDmB34Tj82npYwE6YJwOlhIKDDMMP7k5qXOGnNRqhAgWGlFHq0r61Ez4CXC5yw6avg83AeYnU
        OZUK7rgQ9hfqGe6v+mDBL6ha8PkxyfMgy1BoudsR6XNFVCGHjbL1Qb5sRwdR7JQFd1iM8Nn2L/eV3
        9UgBc6FbdefRfAdKKyOl5YtNkkPJGuAhVzBC8DyR9W3s3/YUz6sBKB3hClJMRPk6mx18uS8JVIgB3
        fKo5pmEDK6wPmTeCDNtDxoKgbjXcqGqoZMG1nJU7OHjaxCHKojPsLhnn5Ib4VUiEEA8k1QDWfczrj
        A/bT2T6g==;
Received: from [2001:4bb8:184:6215:7ee3:d0e9:131a:82ff] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDndQ-00DPwU-H3; Wed, 11 Aug 2021 12:47:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 3/6] nbd: remove nbd_del_disk
Date:   Wed, 11 Aug 2021 14:44:25 +0200
Message-Id: <20210811124428.2368491-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811124428.2368491-1-hch@lst.de>
References: <20210811124428.2368491-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold nbd_del_disk and remove the pointless NULL check on ->disk given
that it is always set for a successfully allocated nbd_device structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6caf26b84a5b..de8b23af2486 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -235,17 +235,6 @@ static const struct device_attribute backend_attr = {
 	.show = backend_show,
 };
 
-static void nbd_del_disk(struct nbd_device *nbd)
-{
-	struct gendisk *disk = nbd->disk;
-
-	if (disk) {
-		del_gendisk(disk);
-		blk_cleanup_disk(disk);
-		blk_mq_free_tag_set(&nbd->tag_set);
-	}
-}
-
 /*
  * Place this in the last just before the nbd is freed to
  * make sure that the disk and the related kobject are also
@@ -261,7 +250,11 @@ static void nbd_notify_destroy_completion(struct nbd_device *nbd)
 
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
-	nbd_del_disk(nbd);
+	struct gendisk *disk = nbd->disk;
+
+	del_gendisk(disk);
+	blk_cleanup_disk(disk);
+	blk_mq_free_tag_set(&nbd->tag_set);
 
 	/*
 	 * Remove from idr after del_gendisk() completes, so if the same ID is
-- 
2.30.2

