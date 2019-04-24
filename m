Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89884C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588B6206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbfDXQtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730534AbfDXQtn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DB79AF68;
        Wed, 24 Apr 2019 16:49:42 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 11/18] bcache: return error immediately in bch_journal_replay()
Date:   Thu, 25 Apr 2019 00:48:36 +0800
Message-Id: <20190424164843.29535-12-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When failure happens inside bch_journal_replay(), calling
cache_set_err_on() and handling the failure in async way is not a good
idea. Because after bch_journal_replay() returns, registering code will
continue to execute following steps, and unregistering code triggered
by cache_set_err_on() is running in same time. First it is unnecessary
to handle failure and unregister cache set in an async way, second there
might be potential race condition to run register and unregister code
for same cache set.

So in this patch, if failure happens in bch_journal_replay(), we don't
call cache_set_err_on(), and just print out the same error message to
kernel message buffer, then return -EIO immediately caller. Then caller
can detect such failure and handle it in synchrnozied way.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/md/bcache/journal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 5180bed911ef..828ab474696a 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -331,9 +331,12 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 	list_for_each_entry(i, list, list) {
 		BUG_ON(i->pin && atomic_read(i->pin) != 1);
 
-		cache_set_err_on(n != i->j.seq, s,
-"bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
-				 n, i->j.seq - 1, start, end);
+		if (n != i->j.seq) {
+			pr_err("bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
+			n, i->j.seq - 1, start, end);
+			ret = -EIO;
+			goto err;
+		}
 
 		for (k = i->j.start;
 		     k < bset_bkey_last(&i->j);
-- 
2.16.4

