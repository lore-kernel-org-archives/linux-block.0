Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E06C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 23:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ED120723
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 23:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZieNfmMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNXEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:04:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53160 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNXEj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 18:04:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEMxEjQ130753
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 23:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=6LFVCzWmyzovXI/WdCa9c8G3q0BMWglxC6+Ttli5gmU=;
 b=ZieNfmMrUVL02s36XvkimJX10U0MtWVNnD2eVqJ8wZRfT+F8zadRLSwlgImUWqp6OLgK
 JfqlM8z9BEHUILbNl2DUAEKq6Y/6SeguM/6zznsGlbe3AOLpHLdqi8jTJ68OGozHfXq0
 Aesh9UZeY2/cxiW56rILvjRWE8t6cfOj7M5yHDnO6nq7KfgFIgOrdw4F2netv42ZUlKK
 EL4Ur5T/rYyCCji5+ufWqK18/8Gsgp6z2zLUCoFJKZjOMCs+A5nYjwUwity5Sunk5h+c
 o6qQgq9G0ZrDdYyRx7ttN6whI5pGY61BXS+TP6lTcmLBEdO65pXLgNQi3YvArbrtfWRq HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w9fayg8dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 23:04:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEMwqJZ102782
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 23:02:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2w9fatanuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 23:02:37 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEN2apx018865
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 23:02:36 GMT
Received: from jubi-laptop.us.oracle.com (/10.211.46.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 15:02:36 -0800
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     junxiao.bi@oracle.com
Subject: [PATCH] block-mq: ratelimit the warning log
Date:   Thu, 14 Nov 2019 15:02:33 -0800
Message-Id: <20191114230233.3582-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140000 definitions=main-1911140187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140000 definitions=main-1911140187
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When doing cpu online/offlile, sometimes this warning will be triggered,
it's harmless, io will be dispatched. But sometimes it warns too much and
even stall the whole system, so ratelimit it.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..846f5d26c523 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1384,7 +1384,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 *   handle dispatched requests to this hctx
 	 */
 	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
-		cpu_online(hctx->next_cpu)) {
+		cpu_online(hctx->next_cpu) && printk_ratelimit()) {
 		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
 			raw_smp_processor_id(),
 			cpumask_empty(hctx->cpumask) ? "inactive": "active");
-- 
2.17.1

