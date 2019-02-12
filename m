Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE31C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 01:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE0214DA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 01:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YwuYpG55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBLB5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:57:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53834 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLB5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 20:57:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1C1nmTK015066;
        Tue, 12 Feb 2019 01:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=rBurHdC8oSNzyIqXdYve+lSKmc04XSp42t+v/RQZGSQ=;
 b=YwuYpG55U5a/pZLTa59uxf+XcThc4/LvNN2tm3rGqKoH0u3uAx6BEFXE3T7yfRCoA/lQ
 CBwUvj9Y0sfGu+5+AQ2Yjxx3iC1GmSfo+E9W8TmhyXEVO+f3ySe2uGHaWPVAwSLzU2sp
 xQUCHxiuXArgavpCciuSqld7rJ1tGZ0AMi5t4Ezbo7M2HKUCvszY530IuRwTx9+1rjrk
 plA7aYbdMrrEYKZDgqkTvrEqccbJ14b5/1LxhOf7OoULdk0f0h1iIzbC2Bey3q/c/Ep7
 baOKniKk5542XwaWdXcuxRMGVH4Z0pJrZkOlDyAh72niBtG8k6leVmHjBFzy4SEzsYl1 /Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qhre597cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 01:57:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1C1vYOh012917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 01:57:34 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1C1vX78007728;
        Tue, 12 Feb 2019 01:57:34 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 17:57:33 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue
Date:   Tue, 12 Feb 2019 09:56:25 +0800
Message-Id: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When requeue, if RQF_DONTPREP, rq has contained some driver
specific data, so insert it to hctx dispatch list to avoid any
merge. Take scsi as example, here is the trace event log (no
io scheduler, because RQF_STARTED would prevent merging),

   kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
   kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
   kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
   kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]

(32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
the sdb only contained the part of (32768 + 8), then only that part
was completed. The lucky thing was that scsi_io_completion detected
it and requeued the remaining part. So we didn't get corrupted data.
However, the requeue of (32776 + 8) is not expected.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
V2:
 - refactor the code based on Jens' suggestion

 block/blk-mq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f5b533..9437a5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -737,12 +737,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->rq_flags & RQF_SOFTBARRIER))
+		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
 			continue;
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, true, false, false);
+		/*
+		 * If RQF_DONTPREP, rq has contained some driver specific
+		 * data, so insert it to hctx dispatch list to avoid any
+		 * merge.
+		 */
+		if (rq->rq_flags & RQF_DONTPREP)
+			blk_mq_request_bypass_insert(rq, false);
+		else
+			blk_mq_sched_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
-- 
2.7.4

