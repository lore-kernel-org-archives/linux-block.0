Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B9C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJTQqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJTQqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:46:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0041DA349
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Nyxn7i23eIoAMtF7DKHga+NX1a4K76BsjVZrlHuAwtQ=; b=NB0J+LNvauso0WSv6E1WJRHfYs
        5KfF7Vc8olZY98N++Vast86hsyDrU15ULiRCr1eZjhsjLXPpJ3WM91Qvns6oza9NSE+fiZ3RBfymN
        38NvdPAY45Szr1VqVOEKAK1P09XUIIyUVUSHMzHObOAPp4JHBFEqHVvsTtMbCTINhzsKvv1WqKJvU
        6z9WRmnAcVq9hepFDeb8DL2grmK+N7E12t/0CrWSwHMnisP6MldHvvQjJ0RTuhV48tE2QRpEE6Qnt
        3n7/48t94JC/d2/rGKw4qxJlhyF4GWt3VCCH2F/uPYH+mqutpf5b+uIZNPZSvYZzV0Nqmn9gtLkLq
        mwM+WxsA==;
Received: from [205.220.129.26] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYgd-000WIb-Es; Thu, 20 Oct 2022 16:46:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: clear the holder releated fields when deleting the kobjects
Date:   Thu, 20 Oct 2022 09:46:00 -0700
Message-Id: <20221020164605.1764830-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020164605.1764830-1-hch@lst.de>
References: <20221020164605.1764830-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zero out the pointers to the holder related kobjects so that the holder
code doesn't incorrectly when called by dm for the delayed holder
registration.

Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423df..cd90df6c775c2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -528,8 +528,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	blk_unregister_queue(disk);
 out_put_slave_dir:
 	kobject_put(disk->slave_dir);
+	disk->slave_dir = NULL;
 out_put_holder_dir:
 	kobject_put(disk->part0->bd_holder_dir);
+	disk->part0->bd_holder_dir = NULL;
 out_del_integrity:
 	blk_integrity_del(disk);
 out_del_block_link:
@@ -623,7 +625,9 @@ void del_gendisk(struct gendisk *disk)
 	blk_unregister_queue(disk);
 
 	kobject_put(disk->part0->bd_holder_dir);
+	disk->part0->bd_holder_dir = NULL;
 	kobject_put(disk->slave_dir);
+	disk->slave_dir = NULL;
 
 	part_stat_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
-- 
2.30.2

