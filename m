Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A285C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3746B61212
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKDTco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhKDTco (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 15:32:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9EEC061714;
        Thu,  4 Nov 2021 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PsZGxYZJ1vXnhzJHZV0TXIJJbA2U4NKdfuAv3fOctvc=; b=PPqIjiNNj2vnP1ZZKH427cyEZS
        Ze4+vDT+HmiL047OGJvvDQHvezq1cQC1mhfBoBGWv2D/fB9QNHvhp/FnURWxVdWbR6Z6PRp7ueEnq
        d7Uns436Z03Fb9PjdURc5MT2PNotZUKnxFBEUIdOlo5welZZ4xIyY7RE+cZPmwjrI1i+iU8sT8D1L
        N6WSHofEpzg1YRbIuxov2o0XcCwOHHEilEStyKyKg1Xq84rGv4fsk8eb77/zcMBwy2xIMwWJsJlXT
        tb/TQ2irgU4a8/J+SkcPnHxaOPEdIom8BiNsJWG9xjFNB0zgTcBQTM16j1FN/Mec909FSrmf6Vg8H
        ouk8HkmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miiQy-009srx-BB; Thu, 04 Nov 2021 19:30:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hare@suse.de, hch@infradead.org, wubo40@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] block: fix bd_holder_dir kobject_create_and_add() error handling
Date:   Thu,  4 Nov 2021 12:29:59 -0700
Message-Id: <20211104192959.2355827-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 83cbce957446 ("block: add error handling for device_add_disk /
add_disk") added error handling to device_add_disk(), however the goto
label for the bd_holder_dir kobject_create_and_add() failure did not set
the return value correctly, and so we can end up in a situation where
kobject_create_and_add() fails but we report success.

Fixes: 83cbce957446 ("block: add error handling for device_add_disk / add_disk")
Reported-by: Wu Bo <wubo40@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2263f7862241..c5392cc24d37 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -472,8 +472,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
-	if (!disk->part0->bd_holder_dir)
+	if (!disk->part0->bd_holder_dir) {
+		ret = -ENOMEM;
 		goto out_del_integrity;
+	}
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 	if (!disk->slave_dir) {
 		ret = -ENOMEM;
-- 
2.33.0

