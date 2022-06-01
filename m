Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4EACCA478
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiFAOvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiFAOvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 10:51:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971215DD21
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 07:51:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4BC211F8F6;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654095071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUduM4lG2q2GY35eSJ4HLE/WEL036XTWEqWZF30BRZA=;
        b=j6I9ufRf+6qlHq5Ye9C7SShlYxn5Y8nSobvRjrbcQ3JV6LsfZJrKn7oz2LP/uziqTGyXMJ
        ZWYTR1VtK5K8VOATnlbzcVPumU+ByskpCVfc5idlpoFeY3/OtonXI9zJGLh8Jr8fJ2KxQ3
        6oP8W+yqleiMp2wTcEyzZxV0Nm7CI/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654095071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUduM4lG2q2GY35eSJ4HLE/WEL036XTWEqWZF30BRZA=;
        b=UKQBt1HZTfQJnp4lW3g3OzAaAtC/0kMWmg8YNe2Ugpu47o/OHV1yapNREacYIX0pFl6xZR
        4/pZloQc8Q7y4YAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 133932C145;
        Wed,  1 Jun 2022 14:51:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C9F06A0637; Wed,  1 Jun 2022 16:51:10 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] block: fix default IO priority handling again
Date:   Wed,  1 Jun 2022 16:51:06 +0200
Message-Id: <20220601145110.18162-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220601132347.13543-1-jack@suse.cz>
References: <20220601132347.13543-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; h=from:subject; bh=F/+79O3vT4YJ18myuAZmNBRsDmfEk3VfFl9MazpsqGQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBil3zaD2Dh0tXPI5QrXiqY5Xj8NIYkL00D+oD9WQcq QdRrANaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYpd82gAKCRCcnaoHP2RA2QrBCA DNeuqpwzGyaHeIRCxuFM3ewOcoGjZR217e2DveCBDlnv+hu9MnF7o4f/QgqlZH+dJWbXz4JhKt8/Xt 4KPj62xrhpg4YoTWCV5q/t10cgtbvy51Ar8LfGadwrIdVujrVnIS0cfOD0cYQ5Oty/ftjgMlWKMBTJ KY0d517H8N5KfeOUmXSGG+AZYo+4OXXa3ShfDAcYRatFyrv2uIDlBze/fZkIzfd2o129aZwzLafnri dd3QVXbYlHqCNSkvswJskOvHjRHepyiUavLTX5DrNThyqz5l19yu6NT62E9JEf16L1CyYrOTt38Y9B eY4iVxeB+uyLfoteXbbVq29RD4P6rQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit e70344c05995 ("block: fix default IO priority handling")
introduced an inconsistency in get_current_ioprio() that tasks without
IO context return IOPRIO_DEFAULT priority while tasks with freshly
allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
move io_context creation into where it's needed") but after this commit
they became common because now only BFQ IO scheduler setups task's IO
context. Similar inconsistency is there for get_task_ioprio() so this
inconsistency is now exposed to userspace and userspace will see
different IO priority for tasks operating on devices with BFQ compared
to devices without BFQ. Furthemore the changes done by commit
e70344c05995 change the behavior when no IO priority is set for BFQ IO
scheduler which is also documented in ioprio_set(2) manpage - namely
that tasks without set IO priority will use IO priority based on their
nice value.

So make sure we default to IOPRIO_CLASS_NONE as used to be the case
before commit e70344c05995. Also cleanup alloc_io_context() to
explicitely set this IO priority for the allocated IO context.

Fixes: e70344c05995 ("block: fix default IO priority handling")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioc.c        | 2 ++
 include/linux/ioprio.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index df9cfe4ca532..63fc02042408 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -247,6 +247,8 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
 #endif
+	ioc->ioprio = IOPRIO_DEFAULT;
+
 	return ioc;
 }
 
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 774bb90ad668..d9dc78a15301 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -11,7 +11,7 @@
 /*
  * Default IO priority.
  */
-#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
+#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0)
 
 /*
  * Check that a priority value has a valid class.
-- 
2.35.3

