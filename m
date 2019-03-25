Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD353C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB720870
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x6cLRlFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfCYFrk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:47:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfCYFrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:47:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5iYNW004978;
        Mon, 25 Mar 2019 05:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=HFHaBCUZ8wMa3FAx2XARpXITPf6N64mPFcEnLvMxejg=;
 b=x6cLRlFsbE3eIqW+zBcR8rVTvo4KUSe6oDxC0TsjwNKhFUNIlLWB2/XDN9cRycNUpzAH
 fs/UipQiRFZskHAyVARQOKz6yet4A+UqFPCOf5vKgjJrOYbmZkYBiNJqBJG6KofYerA4
 Telh6BFrQf19znclI8oIrQk4hMYAVZC9FBQu6WqqJku2Aftj4kqcO8CT9Z8awGhyh3G7
 oJjZV88/4gb+F+lzCq+97Jb0x4tQvQB8i1UadIT60iyFEiib4hpATNOKBiJPxBk2nW+b
 Znk8jF8qioGAyRQpAZU68M2QXQAe5h+p//Kzf33KS/qnxszjeRWWpqsWtBCqq3LgkfBs GA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g0st4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5lCts013533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:13 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5lCF0026045;
        Mon, 25 Mar 2019 05:47:12 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:47:12 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/8] mtip32xx: use blk_mq_queue_tag_inflight_iter
Date:   Mon, 25 Mar 2019 13:38:34 +0800
Message-Id: <1553492318-1810-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=920 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 83302ec..103e691 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2771,12 +2771,12 @@ static int mtip_service_thread(void *data)
 
 			blk_mq_quiesce_queue(dd->queue);
 
-			blk_mq_tagset_busy_iter(&dd->tags, mtip_queue_cmd, dd);
+			blk_mq_queue_tag_inflight_iter(dd->queue, mtip_queue_cmd, dd);
 
 			set_bit(MTIP_PF_ISSUE_CMDS_BIT, &dd->port->flags);
 
 			if (mtip_device_reset(dd))
-				blk_mq_tagset_busy_iter(&dd->tags,
+				blk_mq_queue_tag_inflight_iter(dd->queue,
 							mtip_abort_cmd, dd);
 
 			clear_bit(MTIP_PF_TO_ACTIVE_BIT, &dd->port->flags);
@@ -3903,7 +3903,7 @@ static int mtip_block_remove(struct driver_data *dd)
 
 	blk_freeze_queue_start(dd->queue);
 	blk_mq_quiesce_queue(dd->queue);
-	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
+	blk_mq_queue_tag_inflight_iter(dd->queue, mtip_no_dev_cleanup, dd);
 	blk_mq_unquiesce_queue(dd->queue);
 
 	/*
-- 
2.7.4

