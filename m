Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C0CC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAFB20873
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 05:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otVR0jO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfBKFmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:42:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKFmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 00:42:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1B5XwGA183364;
        Mon, 11 Feb 2019 05:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=AI7geo5/vVaaJ8eeQAMFy9gofJfDJdlmvtd9zkaV+2k=;
 b=otVR0jO7NpR8Sgeax2in8sAye2XczAkMzod4sVwx8S9RExbZ+vVxvDwTXRdRyu63TQKt
 rBRdZ2/3N+SBCXfuuNbpHmmG0C1mbKV4jeGG4jBJ1aRNXqVgjSWk7huRoz3szXh7ti5n
 hAv2aRGCjQfTMVhlQzhCJAWSsVF8vvxYPweeGhyWz6HpAz3b52ioIKs5z897oA6bund5
 yoDidQNmLMj/qpwolhOHjM3BDtM33LQGd3/Vt7q6si+GsL1nnPvDLsmfxEJwOczRnzr1
 m66xkpHyf2LBdWPCpgv4SERC1QngptCL/lm1u8Xb/RPSZ4/ZZZ9eQfTCuJI879oSCVI/ wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qhredknu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 05:42:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1B5gM0o015760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 05:42:22 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1B5gLXH020158;
        Mon, 11 Feb 2019 05:42:21 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 Feb 2019 21:42:21 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue
Date:   Mon, 11 Feb 2019 13:41:05 +0800
Message-Id: <1549863665-1691-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110043
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

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f5b533..2d93eb5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -737,6 +737,18 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
+		/*
+		 * If RQF_DONTPREP, rq has contained some driver specific
+		 * data, so insert it to hctx dispatch list to avoid any
+		 * merge.
+		 */
+		if (rq->rq_flags & RQF_DONTPREP) {
+			rq->rq_flags &= ~RQF_SOFTBARRIER;
+			list_del_init(&rq->queuelist);
+			blk_mq_request_bypass_insert(rq, false);
+			continue;
+		}
+
 		if (!(rq->rq_flags & RQF_SOFTBARRIER))
 			continue;
 
-- 
2.7.4

