Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E50CC47259
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47828206D5
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEFNjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 09:39:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbgEFNjl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 09:39:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7E5FAD7C;
        Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AFF5D1E12FD; Wed,  6 May 2020 15:39:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] iowatcher: Use blktrace_api.h
Date:   Wed,  6 May 2020 15:39:32 +0200
Message-Id: <20200506133933.4773-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200506133933.4773-1-jack@suse.cz>
References: <20200506133933.4773-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blktrace_api.h header instead of redefining the constants once more
in blkparse.c.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 iowatcher/blkparse.c | 104 +--------------------------------------------------
 1 file changed, 1 insertion(+), 103 deletions(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 41e20f0c01f9..982de9459826 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -36,6 +36,7 @@
 #include "blkparse.h"
 #include "list.h"
 #include "tracers.h"
+#include "../blktrace_api.h"
 
 #define IO_HASH_TABLE_BITS  11
 #define IO_HASH_TABLE_SIZE (1 << IO_HASH_TABLE_BITS)
@@ -49,112 +50,9 @@ static struct list_head process_hash_table[PROCESS_HASH_TABLE_SIZE];
 extern int plot_io_action;
 extern int io_per_process;
 
-/*
- * Trace categories
- */
-enum {
-	BLK_TC_READ	= 1 << 0,	/* reads */
-	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_FLUSH	= 1 << 2,	/* flush */
-	BLK_TC_SYNC	= 1 << 3,	/* sync */
-	BLK_TC_QUEUE	= 1 << 4,	/* queueing/merging */
-	BLK_TC_REQUEUE	= 1 << 5,	/* requeueing */
-	BLK_TC_ISSUE	= 1 << 6,	/* issue */
-	BLK_TC_COMPLETE	= 1 << 7,	/* completions */
-	BLK_TC_FS	= 1 << 8,	/* fs requests */
-	BLK_TC_PC	= 1 << 9,	/* pc requests */
-	BLK_TC_NOTIFY	= 1 << 10,	/* special message */
-	BLK_TC_AHEAD	= 1 << 11,	/* readahead */
-	BLK_TC_META	= 1 << 12,	/* metadata */
-	BLK_TC_DISCARD	= 1 << 13,	/* discard requests */
-	BLK_TC_DRV_DATA	= 1 << 14,	/* binary driver data */
-	BLK_TC_FUA	= 1 << 15,	/* fua requests */
-
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
-};
-
-#define BLK_TC_SHIFT		(16)
-#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
-
-/*
- * Basic trace actions
- */
-enum {
-	__BLK_TA_QUEUE = 1,		/* queued */
-	__BLK_TA_BACKMERGE,		/* back merged to existing rq */
-	__BLK_TA_FRONTMERGE,		/* front merge to existing rq */
-	__BLK_TA_GETRQ,			/* allocated new request */
-	__BLK_TA_SLEEPRQ,		/* sleeping on rq allocation */
-	__BLK_TA_REQUEUE,		/* request requeued */
-	__BLK_TA_ISSUE,			/* sent to driver */
-	__BLK_TA_COMPLETE,		/* completed by driver */
-	__BLK_TA_PLUG,			/* queue was plugged */
-	__BLK_TA_UNPLUG_IO,		/* queue was unplugged by io */
-	__BLK_TA_UNPLUG_TIMER,		/* queue was unplugged by timer */
-	__BLK_TA_INSERT,		/* insert request */
-	__BLK_TA_SPLIT,			/* bio was split */
-	__BLK_TA_BOUNCE,		/* bio was bounced */
-	__BLK_TA_REMAP,			/* bio was remapped */
-	__BLK_TA_ABORT,			/* request aborted */
-	__BLK_TA_DRV_DATA,		/* binary driver data */
-};
-
 #define BLK_TA_MASK ((1 << BLK_TC_SHIFT) - 1)
 
-/*
- * Notify events.
- */
-enum blktrace_notify {
-	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
-	__BLK_TN_TIMESTAMP,		/* include system clock */
-	__BLK_TN_MESSAGE,               /* Character string message */
-};
-
-/*
- * Trace actions in full. Additionally, read or write is masked
- */
-#define BLK_TA_QUEUE		(__BLK_TA_QUEUE | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_BACKMERGE	(__BLK_TA_BACKMERGE | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_FRONTMERGE	(__BLK_TA_FRONTMERGE | BLK_TC_ACT(BLK_TC_QUEUE))
-#define	BLK_TA_GETRQ		(__BLK_TA_GETRQ | BLK_TC_ACT(BLK_TC_QUEUE))
-#define	BLK_TA_SLEEPRQ		(__BLK_TA_SLEEPRQ | BLK_TC_ACT(BLK_TC_QUEUE))
-#define	BLK_TA_REQUEUE		(__BLK_TA_REQUEUE | BLK_TC_ACT(BLK_TC_REQUEUE))
-#define BLK_TA_ISSUE		(__BLK_TA_ISSUE | BLK_TC_ACT(BLK_TC_ISSUE))
-#define BLK_TA_COMPLETE		(__BLK_TA_COMPLETE| BLK_TC_ACT(BLK_TC_COMPLETE))
-#define BLK_TA_PLUG		(__BLK_TA_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_UNPLUG_IO	(__BLK_TA_UNPLUG_IO | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_UNPLUG_TIMER	(__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_INSERT		(__BLK_TA_INSERT | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_SPLIT		(__BLK_TA_SPLIT)
-#define BLK_TA_BOUNCE		(__BLK_TA_BOUNCE)
-#define BLK_TA_REMAP		(__BLK_TA_REMAP | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
-#define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
-
-#define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
-#define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
-#define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
-
-#define BLK_IO_TRACE_MAGIC	0x65617400
-#define BLK_IO_TRACE_VERSION	0x07
-/*
- * The trace itself
- */
-struct blk_io_trace {
-	__u32 magic;		/* MAGIC << 8 | version */
-	__u32 sequence;		/* event number */
-	__u64 time;		/* in nanoseconds */
-	__u64 sector;		/* disk offset */
-	__u32 bytes;		/* transfer length */
-	__u32 action;		/* what happened */
-	__u32 pid;		/* who did it */
-	__u32 device;		/* device identifier (dev_t) */
-	__u32 cpu;		/* on what cpu did it happen */
-	__u16 error;		/* completion error */
-	__u16 pdu_len;		/* length of data after this trace */
-};
-
 struct pending_io {
 	/* sector offset of this IO */
 	u64 sector;
-- 
2.16.4

