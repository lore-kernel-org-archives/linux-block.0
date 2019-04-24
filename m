Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F7C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7095021900
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfDXQtx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730534AbfDXQtx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90919AF68;
        Wed, 24 Apr 2019 16:49:52 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 14/18] bcache: add comments for closure_fn to be called in closure_queue()
Date:   Thu, 25 Apr 2019 00:48:39 +0800
Message-Id: <20190424164843.29535-15-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add code comments to explain which call back function might be called
for the closure_queue(). This is an effort to make code to be more
understandable for readers.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/md/bcache/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index fa856b2ca7af..0363ab534c8e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -662,6 +662,11 @@ static const struct block_device_operations bcache_ops = {
 void bcache_device_stop(struct bcache_device *d)
 {
 	if (!test_and_set_bit(BCACHE_DEV_CLOSING, &d->flags))
+		/*
+		 * closure_fn set to
+		 * - cached device: cached_dev_flush()
+		 * - flash dev: flash_dev_flush()
+		 */
 		closure_queue(&d->cl);
 }
 
@@ -1675,6 +1680,7 @@ static void __cache_set_unregister(struct closure *cl)
 void bch_cache_set_stop(struct cache_set *c)
 {
 	if (!test_and_set_bit(CACHE_SET_STOPPING, &c->flags))
+		/* closure_fn set to __cache_set_unregister() */
 		closure_queue(&c->caching);
 }
 
-- 
2.16.4

