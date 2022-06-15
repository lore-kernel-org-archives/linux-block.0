Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD496CCA47E
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353928AbiFOQTC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355504AbiFOQSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580604754A
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8BE6C21C21;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cTgyUe8U9yS5g+cIa5MjDMZW0aOXcrwLKNlSHMFKPg=;
        b=PtHa/9Xhba9eHgL4zHehfjJ16Mg77/D1DL2lBMyouahX2vZEgOkuCtIv838PE55jcgnk8c
        /fc2Xa4CEBWOQ3N6t10YI96njgKwDx3/7srcKz1+NbMJAsR3fNOIqupiBMC9bbFQ2QhGng
        ef6SIOj3RpDSKMHSuzAmRGCI02gtPYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cTgyUe8U9yS5g+cIa5MjDMZW0aOXcrwLKNlSHMFKPg=;
        b=aMCQJS3GR1Tyq9nXG2Cetr2Aiiu5yrmD3d1/QFaVWI9LFaYyRs/ZN4RgGUsBXkH7dcOpdP
        aLDPH65gNb5vPaAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 35FB92C145;
        Wed, 15 Jun 2022 16:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D67C1A0637; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] block: fix default IO priority handling again
Date:   Wed, 15 Jun 2022 18:16:06 +0200
Message-Id: <20220615161616.5055-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; h=from:subject; bh=6xC6IMuAoBDLjO+1hSyfaMEJHwTJVPxPrWFG2SqXOs4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXGYxINOnFb5NP98EmQl5ef90xq9gRepbX7c3Sy xeeCj7OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFxgAKCRCcnaoHP2RA2Sn3CA DbL9KZByZmAbaLWdX8PCjGvnJAZ0vJJhbiuDa3sk4I/E2TKL7s48vp0JgDux7uq6jSDhfKC861pD4d X3cqnaiy1A6eC3cfR2eq4KK9yeH4yYuU44tF+22P4SwgjYAFv+Jhazt1TmZy/q+cPKHc7ivu+s+w3J uR7UmeMIA3V67QoDQ6KSSxQUUCSwOrNPBW7W8LRJfekh6L7l/2hGM/MjAxqbJotfYC7iy2gJ1B7gqB MYsK/NALqDeipbJ/pkRMsCWfV423S1dcZDYrljurMJNN8xx01VCvhnadC/XxuvdJ6oAF6sX6a0Aq14 nv7JlB6wydSX4ScDVDWQ1fFPoNr6Hj
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
scheduler which is also documented in ioprio_set(2) manpage:

"If no I/O scheduler has been set for a thread, then by default the I/O
priority will follow the CPU nice value (setpriority(2)).  In Linux
kernels before version 2.6.24, once an I/O priority had been set using
ioprio_set(), there was no way to reset the I/O scheduling behavior to
the default. Since Linux 2.6.24, specifying ioprio as 0 can be used to
reset to the default I/O scheduling behavior."

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

