Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F83C433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48E9208C7
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 07:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIGHv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:51:29 -0400
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:12911 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgIGHv0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 03:51:26 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 03:51:25 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id DABC6582250;
        Mon,  7 Sep 2020 15:44:03 +0800 (CST)
From:   Yang Yang <yang.yang@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com, yang.yang@vivo.com
Subject: [PATCH] kyber: Fix crash in kyber_finish_request()
Date:   Mon,  7 Sep 2020 00:43:46 -0700
Message-Id: <20200907074346.5383-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSx8dTk8dT09OTk0ZVkpOQkJPTU9NT09LS0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6HSo4Fz8qPBhOKQMiPgsZ
        ECoaCRRVSlVKTkJCT01PTU9PT01IVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJT1lXWQgBWUFJSk9LNwY+
X-HM-Tid: 0a7467859d8598b6kuuudabc6582250
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kernel crash when requeue flush request.
It can be reproduced as below:

[    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
...
[    2.517468] pc : clear_bit+0x18/0x2c
[    2.517502] lr : sbitmap_queue_clear+0x40/0x228
[    2.517503] sp : ffffff800832bc60 pstate : 00c00145
...
[    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
[    2.517602] Call trace:
[    2.517606]  clear_bit+0x18/0x2c
[    2.517619]  kyber_finish_request+0x74/0x80
[    2.517627]  blk_mq_requeue_request+0x3c/0xc0
[    2.517637]  __scsi_queue_insert+0x11c/0x148
[    2.517640]  scsi_softirq_done+0x114/0x130
[    2.517643]  blk_done_softirq+0x7c/0xb0
[    2.517651]  __do_softirq+0x208/0x3bc
[    2.517657]  run_ksoftirqd+0x34/0x60
[    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
[    2.517667]  kthread+0x110/0x120
[    2.517669]  ret_from_fork+0x10/0x18

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 block/kyber-iosched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index a38c5ab103d1..af73afe7a05c 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -611,6 +611,9 @@ static void kyber_finish_request(struct request *rq)
 {
 	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
 
+	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
+		return;
+
 	rq_clear_domain_token(kqd, rq);
 }
 
-- 
2.17.1

