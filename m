Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE3AC38BE1
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2640720836
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ucMgSmBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBXSrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:47:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBXSrX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 13:47:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OIhgl0129333;
        Mon, 24 Feb 2020 18:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=XntSbaUxF422nyR7xQ/lbKVl/N88E1Knty8mIIHh6Ws=;
 b=ucMgSmBgv15kkoI+KWkwVL7RsWESQQpdW0JcLAf3PEyKv9qMmxrzbSaCln7Wp9mda1Ly
 wilakQ/BNR5fKznJ3axEa0+/MzuSI3EED5m5JebFRSDzjUTZEvXf3vTOJgDpGzzbpl3u
 Z+GzCI3/kSxgEwJ04j98LL+lpwnwZeU5HgFZ9XZN/HUj4ZzW2CArv7bJBxALcS/Hq4ZY
 ICYL0viPsQzwH11XJqThCWSZikhuNj2CQFC6T4T1bwTD4YMQqqVchcoM6IcZEZLbwtOe
 D1uw7jayEkudj7LvhZmlleZe+7ku9Wm5iJPLXhYCPmCcZpUwWIlKN1cJyLt/wrngqnFE Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ybvr4njvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 18:47:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OIkYAi090303;
        Mon, 24 Feb 2020 18:47:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ybduuytmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 18:47:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OIlK0K016614;
        Mon, 24 Feb 2020 18:47:20 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 10:47:19 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] null_blk: remove unused fields in 'nullb_cmd'
Date:   Mon, 24 Feb 2020 10:39:11 -0800
Message-Id: <20200224183911.22403-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240136
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'list', 'll_list' and 'csd' are no longer used.

The 'list' is not used since it was introduced by commit f2298c0403b0
("null_blk: multi queue aware block test driver").

The 'll_list' is no longer used since commit 3c395a969acc ("null_blk: set a
separate timer for each command").

The 'csd' is no longer used since commit ce2c350b2cfe ("null_blk: use
blk_complete_request and blk_mq_complete_request").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changes since v1:
  - Remove 'list' and 'csd' as well.

 drivers/block/null_blk.h      | 3 ---
 drivers/block/null_blk_main.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index bc837862b767..62b660821dbc 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -14,9 +14,6 @@
 #include <linux/fault-inject.h>
 
 struct nullb_cmd {
-	struct list_head list;
-	struct llist_node ll_list;
-	struct __call_single_data csd;
 	struct request *rq;
 	struct bio *bio;
 	unsigned int tag;
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 16510795e377..133060431dbd 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1518,8 +1518,6 @@ static int setup_commands(struct nullb_queue *nq)
 
 	for (i = 0; i < nq->queue_depth; i++) {
 		cmd = &nq->cmds[i];
-		INIT_LIST_HEAD(&cmd->list);
-		cmd->ll_list.next = NULL;
 		cmd->tag = -1U;
 	}
 
-- 
2.17.1

