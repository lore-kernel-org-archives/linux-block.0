Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF862C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 05:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA83222D0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 05:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfKMFfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:35:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:54318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKMFfE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 00:35:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 824DAB150;
        Wed, 13 Nov 2019 05:35:02 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 08/10] bcache: add code comments in bch_btree_leaf_dirty()
Date:   Wed, 13 Nov 2019 13:33:44 +0800
Message-Id: <20191113053346.63536-9-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113053346.63536-1-colyli@suse.de>
References: <20191113053346.63536-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds code comments in bch_btree_leaf_dirty() to explain
why w->journal should always reference the eldest journal pin of
all the writing bkeys in the btree node. To make the bcache journal
code to be easier to be understood.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 39d7fc1ef1ee..48e33ee0d876 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -569,6 +569,11 @@ static void bch_btree_leaf_dirty(struct btree *b, atomic_t *journal_ref)
 
 	set_btree_node_dirty(b);
 
+	/*
+	 * w->journal is always the oldest journal pin of all bkeys
+	 * in the leaf node, to make sure the oldest jset seq won't
+	 * be increased before this btree node is flushed.
+	 */
 	if (journal_ref) {
 		if (w->journal &&
 		    journal_pin_cmp(b->c, w->journal, journal_ref)) {
-- 
2.16.4

