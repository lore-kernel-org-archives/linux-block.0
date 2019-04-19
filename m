Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE66EC282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EAA222D2
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfDSSXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727875AbfDSSXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5793CAEA1;
        Fri, 19 Apr 2019 16:05:20 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 01/16] bcache: move definition of 'int ret' out of macro read_bucket()
Date:   Sat, 20 Apr 2019 00:04:54 +0800
Message-Id: <20190419160509.66298-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'int ret' is defined as a local variable inside macro read_bucket().
Since this macro is called multiple times, and following patches will
use a 'int ret' variable in bch_journal_read(), this patch moves
definition of 'int ret' from macro read_bucket() to range of function
bch_journal_read().

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index b2fd412715b1..6e18057d1d82 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -147,7 +147,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
 {
 #define read_bucket(b)							\
 	({								\
-		int ret = journal_read_bucket(ca, list, b);		\
+		ret = journal_read_bucket(ca, list, b);			\
 		__set_bit(b, bitmap);					\
 		if (ret < 0)						\
 			return ret;					\
@@ -156,6 +156,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
 
 	struct cache *ca;
 	unsigned int iter;
+	int ret = 0;
 
 	for_each_cache(ca, c, iter) {
 		struct journal_device *ja = &ca->journal;
@@ -267,7 +268,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
 					    struct journal_replay,
 					    list)->j.seq;
 
-	return 0;
+	return ret;
 #undef read_bucket
 }
 
-- 
2.16.4

