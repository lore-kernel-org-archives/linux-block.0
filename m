Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DEC7EE25
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 10:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFIKa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjFIKaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 06:30:02 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371773ABA;
        Fri,  9 Jun 2023 03:21:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkhlICn_1686306082;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkhlICn_1686306082)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 18:21:23 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: [RFC] block: relax permission for Persistent Reservations ioctl
Date:   Fri,  9 Jun 2023 18:21:22 +0800
Message-Id: <20230609102122.118800-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the shared storage is accessed from containers [1], it's not
recommended to grant CAP_SYS_ADMIN to containers for access to
Persistent Reservations in risk of container escape.

Remove the extra CAP_SYS_ADMIN permission constraint for Persistent
Reservations ioctl which shall do no harm [2].

[1] https://lore.kernel.org/linux-block/345a7cdc-e55b-7aaa-43d4-59b3f911ef18@linux.alibaba.com/
[2] https://lore.kernel.org/linux-block/ZGxaxnOeadVwb2gR@infradead.org/

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
I also noticed that the extra CAP_SYS_ADMIN permission constraint is not
added until v4 [*] of original pull request for Persistent Reservation
API.

[*] https://lore.kernel.org/all/1444911052-9423-1-git-send-email-hch@lst.de/
---
 block/ioctl.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c5f637ff153..46c9ac43bbf8 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -260,8 +260,6 @@ static int blkdev_pr_register(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_registration reg;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!ops || !ops->pr_register)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&reg, arg, sizeof(reg)))
@@ -278,8 +276,6 @@ static int blkdev_pr_reserve(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!ops || !ops->pr_reserve)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&rsv, arg, sizeof(rsv)))
@@ -296,8 +292,6 @@ static int blkdev_pr_release(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!ops || !ops->pr_release)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&rsv, arg, sizeof(rsv)))
@@ -314,8 +308,6 @@ static int blkdev_pr_preempt(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_preempt p;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!ops || !ops->pr_preempt)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&p, arg, sizeof(p)))
@@ -332,8 +324,6 @@ static int blkdev_pr_clear(struct block_device *bdev,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_clear c;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!ops || !ops->pr_clear)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&c, arg, sizeof(c)))
-- 
2.19.1.6.gb485710b

