Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C9C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6196D20663
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFEO6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgFEO6p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:58:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE2F8B483;
        Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B19F51E0267; Fri,  5 Jun 2020 16:58:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] blktrace: break out of blktrace setup on concurrent calls
Date:   Fri,  5 Jun 2020 16:58:36 +0200
Message-Id: <20200605145840.1145-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200605145349.18454-1-jack@suse.cz>
References: <20200605145349.18454-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

We use one blktrace per request_queue, that means one per the entire
disk.  So we cannot run one blktrace on say /dev/vda and then /dev/vda1,
or just two calls on /dev/vda.

We check for concurrent setup only at the very end of the blktrace setup though.

If we try to run two concurrent blktraces on the same block device the
second one will fail, and the first one seems to go on. However when
one tries to kill the first one one will see things like this:

The kernel will show these:

```
debugfs: File 'dropped' in directory 'nvme1n1' already present!
debugfs: File 'msg' in directory 'nvme1n1' already present!
debugfs: File 'trace0' in directory 'nvme1n1' already present!
``

And userspace just sees this error message for the second call:

```
blktrace /dev/nvme1n1
BLKTRACESETUP(2) /dev/nvme1n1 failed: 5/Input/output error
```

The first userspace process #1 will also claim that the files
were taken underneath their nose as well. The files are taken
away form the first process given that when the second blktrace
fails, it will follow up with a BLKTRACESTOP and BLKTRACETEARDOWN.
This means that even if go-happy process #1 is waiting for blktrace
data, we *have* been asked to take teardown the blktrace.

This can easily be reproduced with break-blktrace [0] run_0005.sh test.

Just break out early if we know we're already going to fail, this will
prevent trying to create the files all over again, which we know still
exist.

[0] https://github.com/mcgrof/break-blktrace

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/trace/blktrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f2084087..1a1943d39802 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -3,6 +3,9 @@
  * Copyright (C) 2006 Jens Axboe <axboe@kernel.dk>
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blktrace_api.h>
@@ -494,6 +497,16 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	/*
+	 * bdev can be NULL, as with scsi-generic, this is a helpful as
+	 * we can be.
+	 */
+	if (q->blk_trace) {
+		pr_warn("Concurrent blktraces are not allowed on %s\n",
+			buts->name);
+		return -EBUSY;
+	}
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;
-- 
2.16.4

