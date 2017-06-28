Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:43857 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752483AbdF3KQb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:31 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id E644F3E5229
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:27 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 99F37B400C7
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:07 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 28 Jun 2017 14:47:07 +0300
Subject: [PATCH 18/19] bcache: silence static checker warning
To: linux-block@vger.kernel.org
Message-Id: <20170629221207.897A7100128@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In olden times, closure_return() used to have a hidden return built in.
We removed the hidden return but forgot to add a new return here.  If
"c" were NULL we would oops on the next line, but fortunately "c" is
never NULL.  Let's just remove the if statement.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/md/bcache/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 24cb9b7..243391d 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1381,9 +1381,6 @@ static void cache_set_flush(struct closure *cl)
 	struct btree *b;
 	unsigned i;
 
-	if (!c)
-		closure_return(cl);
-
 	bch_cache_accounting_destroy(&c->accounting);
 
 	kobject_put(&c->internal);
-- 
1.8.3.1
