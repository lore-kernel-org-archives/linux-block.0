Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C19C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01B220651
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfANTYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:24:24 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39266 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbfANTYY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 14:24:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TIEqqEp_1547493709;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TIEqqEp_1547493709)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jan 2019 03:21:49 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] blk-iolatency: fix IO hang due to negative inflight counter
Date:   Tue, 15 Jan 2019 03:21:37 +0800
Message-Id: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Our test reported the following stack, and vmcore showed that
->inflight counter is -1.

[ffffc9003fcc38d0] __schedule at ffffffff8173d95d
[ffffc9003fcc3958] schedule at ffffffff8173de26
[ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
[ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
[ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
[ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
[ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
[ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
[ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
[ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
[ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
[ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
[ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
[ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
[ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
[ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
[ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
[ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
[ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e

The ->inflight counter may be negative (-1) if

0) blk-throttle had been enabled when the IO was issued, so its bio
has a associated blkg,

1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
in this blkg was not available by then,

2) blk-iolatency was enabled before this IO reached its endio, so that
iolatency_grp became available when the IO did the endio.

3) the ->inflight counter is decreased from 0 to -1.

This uses atomic_dec_is_positive() instead to avoid the negative
inflight counter.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-iolatency.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 159af76d60e6..da4ede5c5ddf 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -660,7 +660,12 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 		}
 		rqw = &iolat->rq_wait;
 
-		atomic_dec(&rqw->inflight);
+		/*
+		 * if blkg is enabled by another throttler (e.g. blk-throttle)
+		 * and blk-iolatency is enabled while IO is inflight,
+		 * blk-iolatency's ->inflight counter may be still 0.
+		 */
+		atomic_dec_if_positive(&rqw->inflight);
 		if (!enabled || iolat->min_lat_nsec == 0)
 			goto next;
 		iolatency_record_time(iolat, &bio->bi_issue, now,
@@ -692,7 +697,8 @@ static void blkcg_iolatency_cleanup(struct rq_qos *rqos, struct bio *bio)
 			goto next;
 
 		rqw = &iolat->rq_wait;
-		atomic_dec(&rqw->inflight);
+		/* see comments in blkcg_iolatency_done_io() */
+		atomic_dec_if_positive(&rqw->inflight);
 		wake_up(&rqw->wait);
 next:
 		blkg = blkg->parent;
-- 
2.20.1.2.gb21ebb6

