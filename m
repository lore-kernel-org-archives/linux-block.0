Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ECBC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A361163
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhINHPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbhINHPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:15:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27881C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Df9SelIUYBc0yVIr3NKOtMbMq+ENDsJbIcDBQ82Woao=; b=I3S6UN9HoeiIfMU2tlMAjjNoPU
        9+xzYED3dpLFGNCT12RtZfLNwaBM88oO5EHQ7jJ177lh0QuRJnCVQnGVNBcKcmp3HzKx54T1V2BQr
        OmBYJ4hObv+rxOhXbxTAMMtpgaxXC6Sp/htiFsoB0mn3ngqNAsc7sbJNmEwxqfP5gjB005chvT+7U
        Wrah02H5wY0w25rHJsmczxSk/i6ee2r5nd2YVqIaKSUUjT76VVQ14/5lqizU6lOlm1FRpI4R08Q08
        SJP9pBsQUmuxO0iDO4+KpiyaWbE3REs6bGto6gCZwk3luBv6FhiF6fJfb9NTjlzPtvk/VN1HMePm+
        bV7hTHZg==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ2aZ-00EMxO-PE; Tue, 14 Sep 2021 07:10:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: remove the call to nvme_update_disk_info in nvme_ns_remove
Date:   Tue, 14 Sep 2021 09:06:57 +0200
Message-Id: <20210914070657.87677-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
References: <20210914070657.87677-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to explicitly unregister the integrity profile when
deleting the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 97f8211cf92c1..6600e138945e2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3862,8 +3862,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 	blk_cleanup_queue(ns->queue);
-	if (blk_get_integrity(ns->disk))
-		blk_integrity_unregister(ns->disk);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
-- 
2.30.2

