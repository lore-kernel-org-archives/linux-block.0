Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6EC3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6247C206C1
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fE4nIzv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfHPVNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:13:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHPVNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 17:13:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GL8YwN010691;
        Fri, 16 Aug 2019 21:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=cHWyiwwwMElLoUgLHe+NGSuxdarj4fkXyz/Y4z+UbFQ=;
 b=fE4nIzv3L1zktcSNWF/R1+8L53jxaAUio58kJJ7gdARN0an4n442JouixdW93KjjDKwx
 Pnb+IFDYWdAZ7p27lPAy4koR8CMr2iJ9qEO7kiqCZTbUPFw2l5NYvD1Q6mfXsIrUb2my
 rpTtc7CwOEoqwXuDDTsITaN44GpmZoWLyrpVun37GdgeHFY9A9jyk7I+r5fbOorndMZK
 EStpbT4G2ycjzHbS2iH3U0cBkakipjow+JIv6FSous/KY1Q19dKzLybuh+iGe+s8QlvF
 ZxSPrRCOjMInwZO3wFxdKO21lbrF5AM+exRNJu6ZPqF/lNNQnEogZ1h0ne3A1rj9x7go +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjr2h4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 21:13:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GL8ClX003676;
        Fri, 16 Aug 2019 21:13:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2udscpt3e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 21:13:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7GLDioO030632;
        Fri, 16 Aug 2019 21:13:44 GMT
Received: from jubi-laptop.us.oracle.com (/10.11.23.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 14:13:44 -0700
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, junxiao.bi@oracle.com
Subject: [PATCH] block: remove queue_head
Date:   Fri, 16 Aug 2019 14:12:33 -0700
Message-Id: <20190816211233.22414-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160215
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160215
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The dispatch list was not used any more as lagency block gone.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 block/blk-core.c       | 1 -
 include/linux/blkdev.h | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..82c9c1ef1de6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -479,7 +479,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (!q)
 		return NULL;
 
-	INIT_LIST_HEAD(&q->queue_head);
 	q->last_merge = NULL;
 
 	q->id = ida_simple_get(&blk_queue_ida, 0, 0, gfp_mask);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375dafb1c..680c4d08f1a2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -391,10 +391,6 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 struct request_queue {
-	/*
-	 * Together with queue_head for cacheline sharing
-	 */
-	struct list_head	queue_head;
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
 
-- 
2.17.1

