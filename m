Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC2C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 05:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD222459
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 05:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfKMFeu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:34:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKMFeu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 00:34:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B337B150;
        Wed, 13 Nov 2019 05:34:48 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 06/10] bcache: add code comment bch_keylist_pop() and bch_keylist_pop_front()
Date:   Wed, 13 Nov 2019 13:33:42 +0800
Message-Id: <20191113053346.63536-7-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113053346.63536-1-colyli@suse.de>
References: <20191113053346.63536-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds simple code comments for bch_keylist_pop() and
bch_keylist_pop_front() in bset.c, to make the code more easier to
be understand.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 08768796b543..f37a429f093d 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -155,6 +155,7 @@ int __bch_keylist_realloc(struct keylist *l, unsigned int u64s)
 	return 0;
 }
 
+/* Pop the top key of keylist by pointing l->top to its previous key */
 struct bkey *bch_keylist_pop(struct keylist *l)
 {
 	struct bkey *k = l->keys;
@@ -168,6 +169,7 @@ struct bkey *bch_keylist_pop(struct keylist *l)
 	return l->top = k;
 }
 
+/* Pop the bottom key of keylist and update l->top_p */
 void bch_keylist_pop_front(struct keylist *l)
 {
 	l->top_p -= bkey_u64s(l->keys);
-- 
2.16.4

