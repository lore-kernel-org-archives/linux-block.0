Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B858C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F7B2086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F7B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeLMOzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729063AbeLMOzG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAAA8AD5C;
        Thu, 13 Dec 2018 14:55:04 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 03/12] bcache: update comment for bch_data_insert
Date:   Thu, 13 Dec 2018 22:53:48 +0800
Message-Id: <20181213145357.38528-4-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

commit 220bb38c21b8 ("bcache: Break up struct search") introduced changes
to struct search and s->iop.
bypass/bio are fields of struct data_insert_op now. Update the comment.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 3bf35914bb57..15070412a32e 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -311,11 +311,11 @@ static void bch_data_insert_start(struct closure *cl)
  * data is written it calls bch_journal, and after the keys have been added to
  * the next journal write they're inserted into the btree.
  *
- * It inserts the data in s->cache_bio; bi_sector is used for the key offset,
+ * It inserts the data in op->bio; bi_sector is used for the key offset,
  * and op->inode is used for the key inode.
  *
- * If s->bypass is true, instead of inserting the data it invalidates the
- * region of the cache represented by s->cache_bio and op->inode.
+ * If op->bypass is true, instead of inserting the data it invalidates the
+ * region of the cache represented by op->bio and op->inode.
  */
 void bch_data_insert(struct closure *cl)
 {
-- 
2.16.4

