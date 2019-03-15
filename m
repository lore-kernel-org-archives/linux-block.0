Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76541C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E46218C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hgGRRlmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfCOJGx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:06:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50542 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfCOJGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xInG020924;
        Fri, 15 Mar 2019 09:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=hBt3meiso9L9P5SHWZuowZExw8d7d0HPQjxMIiWYeD0=;
 b=hgGRRlmn3dy45uwU4Xl18NFuh9RXTQDCH3rvtyRZq5H/uPoruw9z293cUHabP/ul5ei+
 fWqNKrdy3UMZrjrWnQALGr2hnMUQk8jeoKz7PjDK7EAD4FQKulAD12rOq1xM0+xyjkSj
 wbUKSfkcXu4trb6RmxV/Cn1/uQpyou2NZt70BEdtKccwJuW08pJB05PzOU9S9ky+O3U3
 KyCtLz8Jiz2JFZP0KTwcKK3zRXcAFTYEWKjtaJjRqVWulHLjuEB1rJ+T8hpLxjpQt47N
 BQeqGIJPHAwGiZgPtCfheh5+83+DPzZ0ZUDfNy/x6NAZIWB5W7jIszcsbFpAdvUIIdhf tQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r44wunjt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:22 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96LG4029141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:21 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96LVa017601;
        Fri, 15 Mar 2019 09:06:21 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:21 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] mtip32xx: use blk_mq_queue_tag_busy_iter
Date:   Fri, 15 Mar 2019 16:57:40 +0800
Message-Id: <1552640264-26101-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=800 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 88e8440..6e356f7 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2770,13 +2770,13 @@ static int mtip_service_thread(void *data)
 
 			blk_mq_quiesce_queue(dd->queue);
 
-			blk_mq_tagset_busy_iter(&dd->tags, mtip_queue_cmd, dd);
+			blk_mq_queue_tag_busy_iter(dd->queue, mtip_queue_cmd, dd, true);
 
 			set_bit(MTIP_PF_ISSUE_CMDS_BIT, &dd->port->flags);
 
 			if (mtip_device_reset(dd))
-				blk_mq_tagset_busy_iter(&dd->tags,
-							mtip_abort_cmd, dd);
+				blk_mq_queue_tag_busy_iter(dd->queue,
+							mtip_abort_cmd, dd, true);
 
 			clear_bit(MTIP_PF_TO_ACTIVE_BIT, &dd->port->flags);
 
@@ -3907,7 +3907,7 @@ static int mtip_block_remove(struct driver_data *dd)
 
 	blk_freeze_queue_start(dd->queue);
 	blk_mq_quiesce_queue(dd->queue);
-	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
+	blk_mq_queue_tag_busy_iter(dd->queue, mtip_no_dev_cleanup, dd, true);
 	blk_mq_unquiesce_queue(dd->queue);
 
 	/*
-- 
2.7.4

