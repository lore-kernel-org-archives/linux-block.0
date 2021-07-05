Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD070C07E98
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 09:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C413A61370
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 09:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGEJgj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 05:36:39 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:11772 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhGEJgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 05:36:39 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 05:36:39 EDT
DKIM-Signature: a=rsa-sha256;
        b=Z6H+7hA3o20CEwBP/O/hdFZVeJf50Q6E569FxTNQqZh9Rev+kxHRD9/hWIbZG2rD27Mv6TD24+VdKEeJ1xHVfLVStFIW/kVVlaog6F9kpfUsg38z2Ig/dzxhO9pNuETywyZHe7B4ADeR2x8ekraIu85mA++djy667Wh9MZXKKak=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=AiGdhOxKK5jbqL2QYbvZgZZtHQzK5itW0Kp8ooht490=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id AB2DE380510;
        Mon,  5 Jul 2021 17:26:01 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] block: nbd: fix order of cleaning up the queue and freeing the tagset
Date:   Mon,  5 Jul 2021 17:25:43 +0800
Message-Id: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkgaGVZNGB8fS0xCT0NOQktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohg6Lgw5Fj9OHBkrKAoDDhUW
        ExwKFBNVSlVKTUlOT0xMSk1JSE9IVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFKQ0lLNwY+
X-HM-Tid: 0a7a75fd23ebd994kuwsab2de380510
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Must release the queue before freeing the tagset.

Fixes: 1c99502fae35 ("loop: use blk_mq_alloc_disk and blk_cleanup_disk")
Reported-and-tested-by: syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com
Signed-off-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b7d6637..c383179
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -239,8 +239,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 
 	if (disk) {
 		del_gendisk(disk);
-		blk_mq_free_tag_set(&nbd->tag_set);
 		blk_cleanup_disk(disk);
+		blk_mq_free_tag_set(&nbd->tag_set);
 	}
 
 	/*
-- 
2.7.4

