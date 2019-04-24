Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B6C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F4A218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfDXQuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:50:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfDXQuJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:50:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89E30AF6A;
        Wed, 24 Apr 2019 16:50:08 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Shenghui Wang <shhuiw@foxmail.com>, Coly Li <colyli@suse.de>
Subject: [PATCH 18/18] bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYNC branch of run_cache_set
Date:   Thu, 25 Apr 2019 00:48:43 +0800
Message-Id: <20190424164843.29535-19-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

In the CACHE_SYNC branch of run_cache_set(), LIST_HEAD(journal) is used
to collect journal_replay(s) and filled by bch_journal_read().

If all goes well, bch_journal_replay() will release the list of
jounal_replay(s) at the end of the branch.

If something goes wrong, code flow will jump to the label "err:" and leave
the list unreleased.

This patch will release the list of journal_replay(s) in the case of
error detected.

v1 -> v2:
* Move the release code to the location after label 'err:' to
  simply the change.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 3f34b96ebbc3..0ffe9acee9d8 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1790,6 +1790,8 @@ static int run_cache_set(struct cache_set *c)
 	struct cache *ca;
 	struct closure cl;
 	unsigned int i;
+	LIST_HEAD(journal);
+	struct journal_replay *l;
 
 	closure_init_stack(&cl);
 
@@ -1949,6 +1951,12 @@ static int run_cache_set(struct cache_set *c)
 	set_bit(CACHE_SET_RUNNING, &c->flags);
 	return 0;
 err:
+	while (!list_empty(&journal)) {
+		l = list_first_entry(&journal, struct journal_replay, list);
+		list_del(&l->list);
+		kfree(l);
+	}
+
 	closure_sync(&cl);
 	/* XXX: test this, it's broken */
 	bch_cache_set_error(c, "%s", err);
-- 
2.16.4

