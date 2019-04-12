Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1840C10F13
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC8620674
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDLBv7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:51:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLBv7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 21:51:59 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4C27934CC26318C8719;
        Fri, 12 Apr 2019 09:51:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 09:51:47 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <miaoxie@huawei.com>, <zhaohongjiang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2] block: fix the return errno for direct IO
Date:   Fri, 12 Apr 2019 10:09:16 +0800
Message-ID: <20190412020916.1160-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the last bio returned is not dio->bio, the status of the bio will
not assigned to dio->bio if it is error. This will cause the whole IO
status wrong.

    ksoftirqd/21-117   [021] ..s.  4017.966090:   8,0    C   N 4883648 [0]
          <idle>-0     [018] ..s.  4017.970888:   8,0    C  WS 4924800 + 1024 [0]
          <idle>-0     [018] ..s.  4017.970909:   8,0    D  WS 4935424 + 1024 [<idle>]
          <idle>-0     [018] ..s.  4017.970924:   8,0    D  WS 4936448 + 321 [<idle>]
    ksoftirqd/21-117   [021] ..s.  4017.995033:   8,0    C   R 4883648 + 336 [65475]
    ksoftirqd/21-117   [021] d.s.  4018.001988: myprobe1: (blkdev_bio_end_io+0x0/0x168) bi_status=7
    ksoftirqd/21-117   [021] d.s.  4018.001992: myprobe: (aio_complete_rw+0x0/0x148) x0=0xffff802f2595ad80 res=0x12a000 res2=0x0

We always have to assign bio->bi_status to dio->bio.bi_status because we
will only check dio->bio.bi_status when we return the whole IO to
the upper layer.

Fixes: 542ff7bf18c6 ("block: new direct I/O implementation")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---

v2: remove white space changes

 fs/block_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 78d3257435c0..24615c76c1d0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -307,10 +307,10 @@ static void blkdev_bio_end_io(struct bio *bio)
 	struct blkdev_dio *dio = bio->bi_private;
 	bool should_dirty = dio->should_dirty;
 
-	if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {
-		if (bio->bi_status && !dio->bio.bi_status)
-			dio->bio.bi_status = bio->bi_status;
-	} else {
+	if (bio->bi_status && !dio->bio.bi_status)
+		dio->bio.bi_status = bio->bi_status;
+
+	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
 		if (!dio->is_sync) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
-- 
2.17.2

