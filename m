Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbeHJJy3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:54:29 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 16/17] bcache: remove unnecessary space before ioctl function pointer arguments
Date: Fri, 10 Aug 2018 15:23:56 +0800
Message-Id: <20180810072357.19823-17-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is warned by checkpatch.pl, this patch removes the extra space.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/bcache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 66e6d5639b38..83504dd8100a 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -275,8 +275,8 @@ struct bcache_device {
 
 	int (*cache_miss)(struct btree *b, struct search *s,
 			  struct bio *bio, unsigned int sectors);
-	int (*ioctl) (struct bcache_device *d, fmode_t mode,
-		      unsigned int cmd, unsigned long arg);
+	int (*ioctl)(struct bcache_device *d, fmode_t mode,
+		     unsigned int cmd, unsigned long arg);
 };
 
 struct io {
-- 
2.18.0
