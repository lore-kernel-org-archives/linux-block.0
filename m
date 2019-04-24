Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87997C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196721900
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfDXQuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:50:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfDXQuF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:50:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A40AAF68;
        Wed, 24 Apr 2019 16:50:04 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Shenghui Wang <shhuiw@foxmail.com>, Coly Li <colyli@suse.de>
Subject: [PATCH 17/18] bcache: fix wrong usage use-after-freed on keylist in out_nocoalesce branch of btree_gc_coalesce
Date:   Thu, 25 Apr 2019 00:48:42 +0800
Message-Id: <20190424164843.29535-18-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

Elements of keylist should be accessed before the list is freed.
Move bch_keylist_free() calling after the while loop to avoid wrong
content accessed.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 64def336f053..b139858b0802 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1476,11 +1476,11 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 
 out_nocoalesce:
 	closure_sync(&cl);
-	bch_keylist_free(&keylist);
 
 	while ((k = bch_keylist_pop(&keylist)))
 		if (!bkey_cmp(k, &ZERO_KEY))
 			atomic_dec(&b->c->prio_blocked);
+	bch_keylist_free(&keylist);
 
 	for (i = 0; i < nodes; i++)
 		if (!IS_ERR_OR_NULL(new_nodes[i])) {
-- 
2.16.4

