Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CF4C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC92083D
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQwIrCPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCSPBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:01:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCSPBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 11:01:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JEwb3k070771;
        Tue, 19 Mar 2019 15:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=sSLt82ymOty8e4lvlU6Sd4QTwNrS/bBF9c/hDUAMw8g=;
 b=BQwIrCPJrpIqIxxyGb0TT4h6m4JRrzPO9fRbsztOV4+jV/ZaLwMKrrjsru/XxbOmhtIi
 hwCdSlJDufMn+gJhned7xV6qUO3GHZVwHlFZ2Q3pukHBGcXqiF3kfI7r276LPbpRz7QN
 J/6gNhH4SbuiFickTubv6i6qQO6RSAfC9MV5R9JrDg9uPmP2hm0ksMx9mHlcnEid5stI
 eURTjxxKBqW9S71INTSVOGum7Gr/hevxyH9+3Kx8VEU6qNQix1102J1b7QohFjUNnBrx
 irHeF3Xt0Ss1ydxXMZXjwd/eU14id4XCWAf69JHVSYo0+aae30NJG+eNJycFdu96axaS bw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssrd5te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 15:01:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2JF1Qrk031784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 15:01:26 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2JF1Qj4005894;
        Tue, 19 Mar 2019 15:01:26 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 08:01:25 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keith.busch@intel.com
Subject: [PATCH 1/1] blk-mq: remove unused 'nr_expired' from blk_mq_hw_ctx
Date:   Tue, 19 Mar 2019 23:05:18 +0800
Message-Id: <1553007918-5026-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190111
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no usage of 'nr_expired'.

The 'nr_expired' was introduced by commit 1d9bd5161ba3 ("blk-mq: replace
timeout synchronization with a RCU and generation based scheme"). Its usage
was removed since commit 12f5b9314545 ("blk-mq: Remove generation
seqeunce").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/linux/blk-mq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814b..3535969 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -57,7 +57,6 @@ struct blk_mq_hw_ctx {
 	unsigned int		queue_num;
 
 	atomic_t		nr_active;
-	unsigned int		nr_expired;
 
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
-- 
2.7.4

