Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6613BC07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 04:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB1361452
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 04:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGFEDe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 00:03:34 -0400
Received: from out0.migadu.com ([94.23.1.103]:65091 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEDe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 00:03:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625544051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZoKs/OhR46IWQP8VjL/YQEhdZZw2ZLWUoBMJggDRK3c=;
        b=UW0Nz+EU8l/VxKP/zB03WheGmRgd2Tzf8F5QbZGuHqgdoKjP+qBoKr7t7FY625gSSWt0CP
        zNDjXWuLRw/MaO2SPBzgUJtUcNyhN6AVOzxWfXyL67ukUVK9kvW73Tiz9BPZTIbI3QVuUI
        iDea9Ks+OGovtKz8rRbo5xfITZj636A=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
        chaitanya.kulkarni@wdc.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH V2] nbd: fix order of cleaning up the queue and freeing the tagset
Date:   Tue,  6 Jul 2021 12:00:16 +0800
Message-Id: <20210706040016.1360412-1-guoqing.jiang@linux.dev>
In-Reply-To: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
References: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

We must release the queue before freeing the tagset.

Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
Reported-and-tested-by: syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com
Signed-off-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
V2 changes: Correct the fixes tag and mail address.

 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b7d663736d35..c38317979f74 100644
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
2.25.1

