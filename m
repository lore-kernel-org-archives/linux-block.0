Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8343C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A43218C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQ0ttMj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCOJHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:07:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44886 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfCOJGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xIDk057534;
        Fri, 15 Mar 2019 09:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=OC/PdQhEPXLumSdNoF/bK0ObwxgKZgaL5SrQOG5BdtQ=;
 b=VQ0ttMj3Q7gxdNh6WbdeF8gSVgCqxu3LVd0I/9nmYWAQe3vhHatIxpvaD9DlR8X+4EnZ
 7vADoSf7Mj7ap5cYxRjRjAcw+JPnECYGvdKDOl9/VpGy6jWpPqm2PjAmUnJeXxTXnXKE
 tnINDT5W6J5EM0Zn0HNjxaXxsJsw8R5F8pFOZb92izlwyKDdq8Dnxn/oO95IlZQKzKkD
 XiLtC/YuIAxe/FpjZK100Ytej5FMArnFsmU4bcuWttxycvP/ofhQJl56wEj4kHoelSQ5
 fxh25m6AUmKmJSEPOjaSCIhtMEk668z8udyd9m4DDxbhPyqqpyqDfBQnXF4FxdbheuxI Ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r430f61hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96D9K022654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:13 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96CLJ021411;
        Fri, 15 Mar 2019 09:06:12 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:11 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] blk-mq: get rid of the synchronize_rcu in __blk_mq_update_nr_hw_queues
Date:   Fri, 15 Mar 2019 16:57:37 +0800
Message-Id: <1552640264-26101-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In commit 530ca2c (blk-mq: Allow blocking queue tag iter callbacks),
we try to get a non-zero q_usage_counter to avoid access hctxs that
being modified. So the synchronize_rcu is useless and should be
removed.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-tag.c | 4 +---
 block/blk-mq.c     | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2089c6c..b792537 100644
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
index 9437a5e..07584a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3208,10 +3208,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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

