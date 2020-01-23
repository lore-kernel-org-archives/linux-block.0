Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6899BC2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACAA2071E
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 17:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgAWRCD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:02:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgAWRCD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 12:02:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1556B1D5;
        Thu, 23 Jan 2020 17:02:01 +0000 (UTC)
From:   colyli@suse.de
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Liang Chen <liangchen.linux@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 01/17] bcache: cached_dev_free needs to put the sb page
Date:   Fri, 24 Jan 2020 01:01:26 +0800
Message-Id: <20200123170142.98974-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200123170142.98974-1-colyli@suse.de>
References: <20200123170142.98974-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liang Chen <liangchen.linux@gmail.com>

Same as cache device, the buffer page needs to be put while
freeing cached_dev.  Otherwise a page would be leaked every
time a cached_dev is stopped.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 77e9869345e7..a573ce1d85aa 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1275,6 +1275,9 @@ static void cached_dev_free(struct closure *cl)
 
 	mutex_unlock(&bch_register_lock);
 
+	if (dc->sb_bio.bi_inline_vecs[0].bv_page)
+		put_page(bio_first_page_all(&dc->sb_bio));
+
 	if (!IS_ERR_OR_NULL(dc->bdev))
 		blkdev_put(dc->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 
-- 
2.16.4

