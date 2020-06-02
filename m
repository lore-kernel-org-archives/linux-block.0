Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E1C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CF22077D
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zADTeLJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFBG2C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:28:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBG2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 02:28:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0526Hxdl099134;
        Tue, 2 Jun 2020 06:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=y11ojtJRmrzcDQ+xl5ZXszXwY1/cOJAOtPNNEl2j1R0=;
 b=zADTeLJhtTs1/kold8kRuP46jlkH2bfG4K/a+0D5bGH8FQKQjAH8zZVqr5KRkkN0ZFbB
 aaXUT68jCeJf92UhnSg+d1U58U05h+ifUf2B2ee2R8J4oudzBZmMoNEr3x6Ki8eHukHU
 fq2ftm2KbwD5e8Z9Fm57+APQo8aVEhNFcpnXCVeh0A0sHR0/5xBwKhpqQEWl0W5ui5Lw
 35EDW/Ib4InztBOxrqYuklgU0dL6JyjlC72C4QB0iR0gZPGU3UDsiudFpSk8qkWvU2yY
 XNXJHQHKl4pjRe169joaodApWqn0+V9TIS9XL2qUOdQAmKmcMv4yrXM7JRS7Ik+HkSVl Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31bewqt8qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 06:27:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0526JNuZ125092;
        Tue, 2 Jun 2020 06:25:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31c12nmnns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 06:25:54 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0526PqwG017086;
        Tue, 2 Jun 2020 06:25:53 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 23:25:52 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hare@suse.de, dwagner@suse.de,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] blk-mq: get ctx in order to handle BLK_MQ_S_INACTIVE in blk_mq_get_tag()
Date:   Mon,  1 Jun 2020 23:17:49 -0700
Message-Id: <20200602061749.32029-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=1 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=1 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020038
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When scheduler is set, we hit below page fault when we offline cpu.

[ 1061.007725] BUG: kernel NULL pointer dereference, address: 0000000000000040
[ 1061.008710] #PF: supervisor read access in kernel mode
[ 1061.009492] #PF: error_code(0x0000) - not-present page
[ 1061.010241] PGD 0 P4D 0
[ 1061.010614] Oops: 0000 [#1] SMP PTI
[ 1061.011130] CPU: 0 PID: 122 Comm: kworker/0:1H Not tainted 5.7.0-rc7+ #2'
... ...
[ 1061.013760] Workqueue: kblockd blk_mq_run_work_fn
[ 1061.014446] RIP: 0010:blk_mq_put_tag+0xf/0x30
... ...
[ 1061.017726] RSP: 0018:ffffa5c18037fc70 EFLAGS: 00010287
[ 1061.018475] RAX: 0000000000000000 RBX: ffffa5c18037fcf0 RCX: 0000000000000004
[ 1061.019507] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff911535dc1180
... ...
[ 1061.028454] Call Trace:
[ 1061.029307]  blk_mq_get_tag+0x26e/0x280
[ 1061.029866]  ? wait_woken+0x80/0x80
[ 1061.030378]  blk_mq_get_driver_tag+0x99/0x110
[ 1061.031009]  blk_mq_dispatch_rq_list+0x107/0x5e0
[ 1061.031672]  ? elv_rb_del+0x1a/0x30
[ 1061.032178]  blk_mq_do_dispatch_sched+0xe2/0x130
[ 1061.032844]  __blk_mq_sched_dispatch_requests+0xcc/0x150
[ 1061.033638]  blk_mq_sched_dispatch_requests+0x2b/0x50
[ 1061.034239]  __blk_mq_run_hw_queue+0x75/0x110
[ 1061.034867]  process_one_work+0x15c/0x370
[ 1061.035450]  worker_thread+0x44/0x3d0
[ 1061.035980]  kthread+0xf3/0x130
[ 1061.036440]  ? max_active_store+0x80/0x80
[ 1061.037018]  ? kthread_bind+0x10/0x10
[ 1061.037554]  ret_from_fork+0x35/0x40
[ 1061.038073] Modules linked in:
[ 1061.038543] CR2: 0000000000000040
[ 1061.038962] ---[ end trace d20e1df7d028e69f ]---

This is because blk_mq_get_driver_tag() would be used to allocate tag once
scheduler (e.g., mq-deadline) is set. However, in order to handle
BLK_MQ_S_INACTIVE in blk_mq_get_tag(), we need to set data->ctx for
blk_mq_put_tag().

Fixes: bf0beec0607db3c6 ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
This is based on for-next because currently the pull request for v5.8 is
not picked by mainline.

 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9a36ac1c1fa1..8bf6c06a86c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1056,6 +1056,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data = {
 		.q = rq->q,
+		.ctx = rq->mq_ctx,
 		.hctx = rq->mq_hctx,
 		.flags = BLK_MQ_REQ_NOWAIT,
 		.cmd_flags = rq->cmd_flags,
-- 
2.17.1

