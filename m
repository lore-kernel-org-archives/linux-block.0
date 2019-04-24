Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EB9C282E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97359206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfDXQt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:60010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732215AbfDXQt0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1CFAAF68;
        Wed, 24 Apr 2019 16:49:25 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 07/18] bcache: move definition of 'int ret' out of macro read_bucket()
Date:   Thu, 25 Apr 2019 00:48:32 +0800
Message-Id: <20190424164843.29535-8-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
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
Reviewed-by: Hannes Reinecke <hare@suse.com>
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

