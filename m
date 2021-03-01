Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D83C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 11:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722C16146D
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 11:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhCALFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 06:05:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232561AbhCALFW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Mar 2021 06:05:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0E64ADE5;
        Mon,  1 Mar 2021 11:04:40 +0000 (UTC)
Date:   Mon, 1 Mar 2021 12:04:39 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Drop leftover references to RQF_SORTED
Message-ID: <20210301120439.1fd0eb7b@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit a1ce35fa49852db60fc6e268038530be533c5b15 ("block: remove dead
elevator code") removed all users of RQF_SORTED. However it is still
defined, and there is one reference left to it (which in effect is
dead code). Clear it all up.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c |    1 -
 block/blk-mq-sched.c   |    3 ---
 include/linux/blkdev.h |    2 --
 3 files changed, 6 deletions(-)

--- linux-5.11.orig/block/blk-mq-sched.c	2021-02-14 23:32:24.000000000 +0100
+++ linux-5.11/block/blk-mq-sched.c	2021-03-01 11:06:49.629077653 +0100
@@ -408,9 +408,6 @@ static bool blk_mq_sched_bypass_insert(s
 	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
 		return true;
 
-	if (has_sched)
-		rq->rq_flags |= RQF_SORTED;
-
 	return false;
 }
 
--- linux-5.11.orig/include/linux/blkdev.h	2021-02-14 23:32:24.000000000 +0100
+++ linux-5.11/include/linux/blkdev.h	2021-03-01 11:07:16.006408847 +0100
@@ -65,8 +65,6 @@ typedef void (rq_end_io_fn)(struct reque
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
-/* elevator knows about this request */
-#define RQF_SORTED		((__force req_flags_t)(1 << 0))
 /* drive already may have started this one */
 #define RQF_STARTED		((__force req_flags_t)(1 << 1))
 /* may not be passed by ioscheduler */
--- linux-5.11.orig/block/blk-mq-debugfs.c	2021-02-14 23:32:24.000000000 +0100
+++ linux-5.11/block/blk-mq-debugfs.c	2021-03-01 11:24:00.031637425 +0100
@@ -292,7 +292,6 @@ static const char *const cmd_flag_name[]
 
 #define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
 static const char *const rqf_name[] = {
-	RQF_NAME(SORTED),
 	RQF_NAME(STARTED),
 	RQF_NAME(SOFTBARRIER),
 	RQF_NAME(FLUSH_SEQ),


-- 
Jean Delvare
SUSE L3 Support
