Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbeHJJxl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:53:41 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 08/17] bcache: replace '%pF' by '%pS' in seq_printf()
Date: Fri, 10 Aug 2018 15:23:48 +0800
Message-Id: <20180810072357.19823-9-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

'%pF' and '%pf' are deprecated vsprintf pointer extensions, this patch
replace them by '%pS', which is suggested by checkpatch.pl.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/closure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 8570fc426e31..034067e0e9ce 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -168,7 +168,7 @@ static int debug_seq_show(struct seq_file *f, void *data)
 	list_for_each_entry(cl, &closure_list, all) {
 		int r = atomic_read(&cl->remaining);
 
-		seq_printf(f, "%p: %pF -> %pf p %p r %i ",
+		seq_printf(f, "%p: %pS -> %pS p %p r %i ",
 			   cl, (void *) cl->ip, cl->fn, cl->parent,
 			   r & CLOSURE_REMAINING_MASK);
 
@@ -178,7 +178,7 @@ static int debug_seq_show(struct seq_file *f, void *data)
 			   r & CLOSURE_RUNNING	? "R" : "");
 
 		if (r & CLOSURE_WAITING)
-			seq_printf(f, " W %pF\n",
+			seq_printf(f, " W %pS\n",
 				   (void *) cl->waiting_on);
 
 		seq_printf(f, "\n");
-- 
2.18.0
