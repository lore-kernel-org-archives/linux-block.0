Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02942C433DF
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B133420E65
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 08:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbgJMIkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 04:40:55 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39065 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403912AbgJMIky (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 04:40:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UBuhU9Q_1602578451;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UBuhU9Q_1602578451)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Oct 2020 16:40:52 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH] block: set NOWAIT for sync polling
Date:   Tue, 13 Oct 2020 16:40:51 +0800
Message-Id: <20201013084051.27255-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sync polling also needs REQ_NOWAIT flag. One sync read/write may be
split into several bios (and thus several requests), and can used up the
queue depth sometimes. Thus the following bio in the same sync
read/write will wait for usable request if REQ_NOWAIT flag not set, in
which case the following sync polling will cause a deadlock.

One case (maybe the only case) for above situation is preadv2/pwritev2
+ direct + highpri. Two conditions need to be satisfied to trigger the
deadlock.

1. HIPRI IO in sync routine. Normal read(2)/pread(2)/readv(2)/preadv(2)
and corresponding write family syscalls don't support high-priority IO and
thus won't trigger polling routine. Only preadv2(2)/pwritev2(2) supports
high-priority IO by RWF_HIPRI flag of @flags parameter.

2. Polling support in sync routine. Currently both the blkdev and
iomap-based fs (ext4/xfs, etc) support polling in direct IO routine. The
general routine is described as follows.

submit_bio
  wait for blk_mq_get_tag(), waiting for requests completion, which
  should be done by the following polling, thus causing a deadlock.
blk_poll
  poll in current process context

This issue can be reproduced by following steps:
1. set max_sectors_kb to '4', and set nr_requests to '4'.
This deliberate setting is imposed to stress the issue.

2. fio test with the following configuration:
ioengine=pvsync2
iodepth=128
numjobs=1
thread
rw=randread
direct=1
hipri=1
bs=4M
filename=/dev/nvme0n1

In this case one sync read will be split into 1024 bios and will exhaust
the queue depth rapidly, causing the following bio waiting in the
following stack forever.

[<0>] blk_mq_get_tag+0x19d/0x290
[<0>] __blk_mq_alloc_request+0x5c/0x130
[<0>] blk_mq_submit_bio+0x103/0x5d0
[<0>] submit_bio_noacct+0x309/0x400
[<0>] submit_bio+0x81/0x190
[<0>] blkdev_direct_IO+0x44c/0x4a0
[<0>] generic_file_read_iter+0x80/0x160
[<0>] do_iter_readv_writev+0x186/0x1c0
[<0>] do_iter_read+0xc6/0x1c0
[<0>] vfs_readv+0x7e/0xc0
[<0>] do_preadv+0xad/0xc0
[<0>] do_syscall_64+0x2d/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix: 675d9e95538e5 ("block: add bio_set_polled() helper")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/bio.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..884ee5aa3df4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -800,17 +800,15 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 /*
- * Mark a bio as polled. Note that for async polled IO, the caller must
- * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
+ * Mark a bio as polled. Note that for polled IO, the caller must expect
+ * -EWOULDBLOCK if we cannot allocate a request (or other resources).
  * We cannot block waiting for requests on polled IO, as those completions
  * must be found by the caller. This is different than IRQ driven IO, where
  * it's safe to wait for IO to complete.
  */
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
-	bio->bi_opf |= REQ_HIPRI;
-	if (!is_sync_kiocb(kiocb))
-		bio->bi_opf |= REQ_NOWAIT;
+	bio->bi_opf |= REQ_HIPRI | REQ_NOWAIT;
 }
 
 #endif /* __LINUX_BIO_H */
-- 
2.27.0

