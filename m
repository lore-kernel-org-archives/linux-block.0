Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753089AbdEJOA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2017 10:00:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4ADrWqE009883
        for <linux-block@vger.kernel.org>; Wed, 10 May 2017 10:00:59 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2abx638xwg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 10 May 2017 10:00:58 -0400
Received: from localhost
        by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <wenxiong@us.ibm.com>;
        Wed, 10 May 2017 11:00:56 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
        by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v4AE0mlQ29098206
        for <linux-block@vger.kernel.org>; Wed, 10 May 2017 11:00:53 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
        by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v4AE0X7b019201
        for <linux-block@vger.kernel.org>; Wed, 10 May 2017 11:00:33 -0300
From: wenxiong@linux.vnet.ibm.com
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com, dougmill@linux.vnet.ibm.com,
        axboe@fb.com, wenxiong@linux.vnet.ibm.com
Subject: [PATCH] blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with split op
Date: Wed, 10 May 2017 08:54:11 -0500
Message-Id: <1494424451-856-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

When formatting NVMe to 512B/4K + T10 DIf/DIX, dd with split op returns
"Input/output error". Looks block layer split the bio after calling
bio_integrity_prep(bio). This patch fixes the issue.

Below is how we debug this issue:
(1)format nvme to 4K block # size with type 2 DIF
(2)dd with block size bigger than 1024k.
oflag=direct
dd: error writing '/dev/nvme0n1': Input/output error

We added some debug code in nvme device driver. It showed us the first
op and the second op have the same bi and pi address. This is not
correct.

1st op: nvme0n1 Op:Wr slba 0x505 length 0x100, PI ctrl=0x1400,
	dsmgmt=0x0, AT=0x0 & RT=0x505
	Guard 0x00b1, AT 0x0000, RT physical 0x00000505 RT virtual 0x00002828

2nd op: nvme0n1 Op:Wr slba 0x605 length 0x1, PI ctrl=0x1400, dsmgmt=0x0,
	AT=0x0 & RT=0x605  ==> This op fails and subsequent 5 retires..
	Guard 0x00b1, AT 0x0000, RT physical 0x00000605 RT virtual 0x00002828

With the fix, It showed us both of the first op and the second op have
correct bi and pi address.

1st op: nvme2n1 Op:Wr slba 0x505 length 0x100, PI ctrl=0x1400,
	dsmgmt=0x0, AT=0x0 & RT=0x505
	Guard 0x5ccb, AT 0x0000, RT physical 0x00000505 RT virtual
	0x00002828
2nd op: nvme2n1 Op:Wr slba 0x605 length 0x1, PI ctrl=0x1400, dsmgmt=0x0,
	AT=0x0 & RT=0x605
	Guard 0xab4c, AT 0x0000, RT physical 0x00000605 RT virtual
	0x00003028

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 block/blk-mq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c7836a1..4754a4a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1517,13 +1517,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	blk_queue_bounce(q, &bio);
 
+	blk_queue_split(q, &bio, q->bio_split);
+
 	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-	blk_queue_split(q, &bio, q->bio_split);
-
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
 		return BLK_QC_T_NONE;
-- 
1.7.1
