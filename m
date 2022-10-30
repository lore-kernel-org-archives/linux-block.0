Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5952BFA3742
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 15:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3Pbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Pbu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:31:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89960D0
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EFXUQkOni9cxO7luloI3Uc+qTKEe2mxoeIaJyoyA+KI=; b=mYsnIb/vIvKUMPPpC+qPOk1xz8
        3BF9sX4dOSriQetS9eLQ5CFQtZUap+bgT2rkB5E0BnxkfwO0pxykV08tmknLMQCKQiPTbmsesOK/r
        E8sxnGsRfus8SXIwtXBPVfY3xyHjCQVnnilBYSprfesGEO5jQu0ejuYoWgAWwh+Eiw6TnwpfH78uI
        Yi3mYzRQsKfxTLzqyAm77WV6Liydqct8AzzHYCYKrmKxIrUD8sExKQNkYbqpEX0k6YI0PJzvV7rVb
        biQ3K+BeTXsx0/dHig3UodLeWaSTgALKExIolzrTHvsKfr4G0AZECRE+jq74sdWHSlHSSviZd5SM1
        w5xbYjmA==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opAHg-00HVkO-Tg; Sun, 30 Oct 2022 15:31:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: clear ->slave_dir when dropping the main slave_dir reference
Date:   Sun, 30 Oct 2022 16:31:13 +0100
Message-Id: <20221030153120.1045101-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030153120.1045101-1-hch@lst.de>
References: <20221030153120.1045101-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zero out the pointer to ->slave_dir so that the holder code doesn't
incorrectly treat the object as alive when add_disk failed or after
del_gendisk was called.

Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423df..aa0e2f5684543 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -528,6 +528,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	blk_unregister_queue(disk);
 out_put_slave_dir:
 	kobject_put(disk->slave_dir);
+	disk->slave_dir = NULL;
 out_put_holder_dir:
 	kobject_put(disk->part0->bd_holder_dir);
 out_del_integrity:
@@ -624,6 +625,7 @@ void del_gendisk(struct gendisk *disk)
 
 	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
+	disk->slave_dir = NULL;
 
 	part_stat_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
-- 
2.30.2

