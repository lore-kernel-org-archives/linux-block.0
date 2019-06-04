Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66248C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2420843
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 15:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfFDPQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:16:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727737AbfFDPQx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 11:16:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EC04ACF5;
        Tue,  4 Jun 2019 15:16:52 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 06/15] bcache: remove unnecessary prefetch() in bset_search_tree()
Date:   Tue,  4 Jun 2019 23:16:15 +0800
Message-Id: <20190604151624.105150-7-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190604151624.105150-1-colyli@suse.de>
References: <20190604151624.105150-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function bset_search_tree(), when p >= t->size, t->tree[0] will be
prefetched by the following code piece,
 974                 unsigned int p = n << 4;
 975
 976                 p &= ((int) (p - t->size)) >> 31;
 977
 978                 prefetch(&t->tree[p]);

The purpose of the above code is to avoid a branch instruction, but
when p >= t->size, prefetch(&t->tree[0]) has no positive performance
contribution at all. This patch avoids the unncessary prefetch by only
calling prefetch() when p < t->size.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bset.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 8f07fa6e1739..aa2e4ab0fab9 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -960,22 +960,10 @@ static struct bset_search_iter bset_search_tree(struct bset_tree *t,
 	unsigned int inorder, j, n = 1;
 
 	do {
-		/*
-		 * A bit trick here.
-		 * If p < t->size, (int)(p - t->size) is a minus value and
-		 * the most significant bit is set, right shifting 31 bits
-		 * gets 1. If p >= t->size, the most significant bit is
-		 * not set, right shifting 31 bits gets 0.
-		 * So the following 2 lines equals to
-		 *	if (p >= t->size)
-		 *		p = 0;
-		 * but a branch instruction is avoided.
-		 */
 		unsigned int p = n << 4;
 
-		p &= ((int) (p - t->size)) >> 31;
-
-		prefetch(&t->tree[p]);
+		if (p < t->size)
+			prefetch(&t->tree[p]);
 
 		j = n;
 		f = &t->tree[j];
-- 
2.16.4

