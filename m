Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC7C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B520870
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dfb9jaUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfCYFr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:47:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfCYFr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:47:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5iNem012287;
        Mon, 25 Mar 2019 05:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=B16cFUfS6yD+xn3VK8ZrKe+BmymbY5Q0EdsbbXhicUo=;
 b=dfb9jaUvXF60fErvKT6aq3usaLnGHwixBVYSNPGuxoqeX+V0dgQEF4m4CcLZKljEiXH+
 aNKxKxRHwYzAVMJ32mulSNMohn05XTx4TljPmPkWBiKJKWXEyCMPVp9x1FjOYGMJ5nLz
 iJkE+bP1qhd+48UG6HOUtHdeDqbwNV/Vzd7X9HInfJicle8n0VtLHcOkgrFmiHff4D04
 ESqVhRN8ULWSolxBsrTFOpu9Io9fDRFcB8vjwC61MAaW1TInL6nBgHD3Kk1HpvwAW1sC
 U3m59RnZDM3TMzqA76b7bMEi0QyOrF5WZdEBv6N6J5g6ZUgzq462ssEs+I+ZLSbvWmF/ WQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6dj1ufs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5l48V004712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:04 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5l32P031698;
        Mon, 25 Mar 2019 05:47:03 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:47:02 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/8] blk-mq: get rid of the synchronize_rcu in __blk_mq_update_nr_hw_queues
Date:   Mon, 25 Mar 2019 13:38:31 +0800
Message-Id: <1553492318-1810-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In commit 530ca2c (blk-mq: Allow blocking queue tag iter callbacks),
we try to get a non-zero q_usage_counter to avoid access hctxs that
being modified. So the synchronize_rcu is useless and should be
removed.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-tag.c | 4 +---
 block/blk-mq.c     | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc..5f28002 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -384,9 +384,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
-	 * racing with it. __blk_mq_update_nr_hw_queues() uses
-	 * synchronize_rcu() to ensure this function left the critical section
-	 * below.
+	 * racing with it.
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c1816..2102d91 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3211,10 +3211,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
 	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
-	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
 	 * updating the new sw to hw queue mappings.
-- 
2.7.4

