Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7CC10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4174120716
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 22:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s+aP4S9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCLWBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:01:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLWBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 18:01:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CLr6uN195603;
        Thu, 12 Mar 2020 22:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=60ih50iVrwQ1Ke4KG0FuCWK/lXuJySvoGaGu2tb9FGg=;
 b=s+aP4S9/vYgxJqtj+8KLhD5uYMSoIKF7mr4hCxbEzrvj2G238NkJdqhzotgKfeyYc9c3
 WFKzLzawM7vG2Bbdo3iwLQ1EuXtGFXefU2cStEbHfaOAzZoJOad8yOgMl2uveczKzOZ+
 HQzxF5PSAmWTMZCYdilRZFFvWeWW48m/bFOpfgiHBW3dl+VJ0ts1d9xl3FI+52b+wCgU
 4MRfDN1cgsxJte/oT8X79AuV6gGdkuIuxZOZvreqnFHyFihMRVLGcWSKzAbYg8M3FbTL
 fKaZAimGHLnHCfOXEZYXpczndDu7w8acUpLKq0fQ5nK4Y+xLKt6K+3n9qdPX5rAnzhqS pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yqtaervxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 22:01:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CLqGnO116377;
        Thu, 12 Mar 2020 22:01:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yqta9kmpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 22:01:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CM12eD029720;
        Thu, 12 Mar 2020 22:01:02 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 15:01:01 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-5.7/drivers v2 1/1] null_blk: describe the usage of fault injection param
Date:   Thu, 12 Mar 2020 15:01:40 -0700
Message-Id: <20200312220140.12233-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=1 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=1
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120109
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As null_blk is a very good start point to test block layer, this patch
adds description and comments to 'timeout', 'requeue' and 'init_hctx' to
explain how to use fault injection with null_blk.

The nvme has similar with nvme_core.fail_request in the form of comment.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  - rebase at for-5.7/drivers
  - describe 'init_hctx' as well

 drivers/block/null_blk_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 8060ffa4bc75..b324cc5fcaf7 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -97,14 +97,21 @@ module_param_named(home_node, g_home_node, int, 0444);
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
 
 static char g_init_hctx_str[80];
 module_param_string(init_hctx, g_init_hctx_str, sizeof(g_init_hctx_str), 0444);
+MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<interval>,<probability>,<space>,<times>");
 #endif
 
 static int g_queue_mode = NULL_Q_MQ;
-- 
2.17.1

