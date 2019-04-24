Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A3C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC2F218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfDXQtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732574AbfDXQtK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10C81AF58;
        Wed, 24 Apr 2019 16:49:09 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 03/18] bcache: avoid clang -Wunintialized warning
Date:   Thu, 25 Apr 2019 00:48:28 +0800
Message-Id: <20190424164843.29535-4-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang has identified a code path in which it thinks a
variable may be unused:

drivers/md/bcache/alloc.c:333:4: error: variable 'bucket' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
                        fifo_pop(&ca->free_inc, bucket);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
 #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/md/bcache/util.h:189:6: note: expanded from macro 'fifo_pop_front'
        if (_r) {                                                       \
            ^~
drivers/md/bcache/alloc.c:343:46: note: uninitialized use occurs here
                        allocator_wait(ca, bch_allocator_push(ca, bucket));
                                                                  ^~~~~~
drivers/md/bcache/alloc.c:287:7: note: expanded from macro 'allocator_wait'
                if (cond)                                               \
                    ^~~~
drivers/md/bcache/alloc.c:333:4: note: remove the 'if' if its condition is always true
                        fifo_pop(&ca->free_inc, bucket);
                        ^
drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
 #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
                                ^
drivers/md/bcache/util.h:189:2: note: expanded from macro 'fifo_pop_front'
        if (_r) {                                                       \
        ^
drivers/md/bcache/alloc.c:331:15: note: initialize the variable 'bucket' to silence this warning
                        long bucket;
                                   ^

This cannot happen in practice because we only enter the loop
if there is at least one element in the list.

Slightly rearranging the code makes this clearer to both the
reader and the compiler, which avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 5002838ea476..f8986effcb50 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -327,10 +327,11 @@ static int bch_allocator_thread(void *arg)
 		 * possibly issue discards to them, then we add the bucket to
 		 * the free list:
 		 */
-		while (!fifo_empty(&ca->free_inc)) {
+		while (1) {
 			long bucket;
 
-			fifo_pop(&ca->free_inc, bucket);
+			if (!fifo_pop(&ca->free_inc, bucket))
+				break;
 
 			if (ca->discard) {
 				mutex_unlock(&ca->set->bucket_lock);
-- 
2.16.4

