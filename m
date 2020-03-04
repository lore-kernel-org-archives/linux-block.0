Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B4CC3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9269D20717
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 19:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P+C2a0D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDT0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:26:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDT0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 14:26:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024JOgJ0069936;
        Wed, 4 Mar 2020 19:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=RVwMPoBytgJqzvT5Zwwfx1pDAOri+D3vJZqoRxlhfz4=;
 b=P+C2a0D1aH+Lot/o+i66MqgkOSPyazmJ4SyIhxCO1QyPVxUM7pvVSTsT5+5E3ecHrJZ+
 sVhpbbHCbnHA/Ns7OcKdsCJ89vdESPYP4KA5Wr/oHasyHNyLWvBoqjJhJi/w6ifRtuAO
 JmejqWyWD6TuvfpU3VoYOwZStkkwq6/z4bmlRCdOq8rXs1buRvEOLkbXSWM0YmKmjf4L
 q7vHCL+ZXLSEJBA1FldrA1Pu5z3/RQUHN+J+3LboFqipaAIIIgpDyBBsK+Obe2tkkqO2
 CwPHd2XCx70CeffoPaQ9mxtGeFCscGsWliE5ZcI649M4P1H5d5C9zXycP5sWzS069+n/ /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2yffwr0ens-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 19:26:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024JNJJf107698;
        Wed, 4 Mar 2020 19:26:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yg1rrys8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 19:26:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024JQ5UG016484;
        Wed, 4 Mar 2020 19:26:06 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 11:26:05 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] null_blk: describe the usage of fault injection param
Date:   Wed,  4 Mar 2020 11:16:44 -0800
Message-Id: <20200304191644.25220-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040127
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As null_blk is a very good start point to test block layer, this patch adds
description and comments to 'timeout' and 'requeue' to explain how to use
fault injection with null_blk.

The nvme has similar with nvme_core.fail_request in the form of comment.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/null_blk_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 133060431dbd..1ee5aaacdb0f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -96,11 +96,17 @@ module_param_named(home_node, g_home_node, int, 0444);
 MODULE_PARM_DESC(home_node, "Home node for the device");
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+/*
+ * For more details about fault injection, please refer to
+ * Documentation/fault-injection/fault-injection.rst.
+ */
 static char g_timeout_str[80];
 module_param_string(timeout, g_timeout_str, sizeof(g_timeout_str), 0444);
+MODULE_PARM_DESC(timeout, "Fault injection. timeout=<interval>,<probability>,<space>,<times>");
 
 static char g_requeue_str[80];
 module_param_string(requeue, g_requeue_str, sizeof(g_requeue_str), 0444);
+MODULE_PARM_DESC(requeue, "Fault injection. requeue=<interval>,<probability>,<space>,<times>");
 #endif
 
 static int g_queue_mode = NULL_Q_MQ;
-- 
2.17.1

