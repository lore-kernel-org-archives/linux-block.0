Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E5C43216
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68351610D2
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhHROw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbhHROw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:52:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C258C061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8mOfo5CAn4drO/2dqEnobIxexcb3A3V9vsqqifptuwA=; b=KBeCY4zh0j9yfBn+9KEHnMZeep
        N8OZxIUp61v82ZGUqaXRCl6f02tf60FKZjzP1miwl58unQTNbqWG5D4MQugprLP2zlIlB/NxaJzOR
        t9D/7YvuowW3Fw9e3jUoI73A7FV6pFPx2eJOc3yPqGdv6LqLMvtyWcoYe9CBSEVNHoUTarCJsrAVB
        iL+TG69GS+RyxWRLbH2wKdAmJ5EGbvXUWz71oJ4RoxzF72nyMKp29YY9Ld75A4hGbcKM2GZ0RAh2t
        och8DgavTK0xMv5d0Sp6xSwRnPE0h2xCmAcGU2FC6+bKkJcUkLjqYN2IfGFbmT7m4K89QMcenYOGg
        mrLYmRtw==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMtv-003woj-Un; Wed, 18 Aug 2021 14:50:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 05/11] block: call blk_integrity_add earlier in device_add_disk
Date:   Wed, 18 Aug 2021 16:45:36 +0200
Message-Id: <20210818144542.19305-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Doing all the sysfs file creation before adding the bdev and thus
allowing it to be opened will simplify the about to be added error
handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index f05e58f214d2..75d900e4c82f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -492,6 +492,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
+	blk_integrity_add(disk);
+
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
@@ -538,7 +540,6 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	blk_register_queue(disk);
 
 	disk_add_events(disk);
-	blk_integrity_add(disk);
 }
 EXPORT_SYMBOL(device_add_disk);
 
-- 
2.30.2

