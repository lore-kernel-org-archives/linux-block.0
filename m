Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D93C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FE7217D4
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8XFMqIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfAXK34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:29:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46834 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXK34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 05:29:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0OASm47006769;
        Thu, 24 Jan 2019 10:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=hQej6UF1LTZ0w9kwbGSYaL9fm0v3KNorNjx9k+P50rw=;
 b=l8XFMqIyFTBwwAa2iZ8X6xFqRg0QCOgUQs9Cx7v4gJgbRgu+qLyxiZsz0uB4Cw6GbwUj
 GnUWq4RIyR67c19gGF6qv/cgTxPKJtvgruWNU8Lk7NQLNDw4gLfbCCy0AdFhWzPFdFxH
 /tPgZAH9hc81CZzk5p+WwfRUQZonDxYLPvzI0MNXoD6kMXBh9dhiWF2oc7P+aqlvMKgA
 31gvnvscT0dJxv9dleH6v8BxynxqQufptR00iLaEvjZ9hhMlCgvjk3JHBeSUpFyr/35R
 yFtMoydQGAsnmg/pvQUWDi5Fix74L34pgIRqM+iHElIUHP0bSU5aNG0tH9/U9Bz04hAO ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sdeq7e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:29:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0OATrNc006444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:29:53 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0OATrVR020958;
        Thu, 24 Jan 2019 10:29:53 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 02:29:53 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: fix the cmd_flag_name array
Date:   Thu, 24 Jan 2019 18:28:55 +0800
Message-Id: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901240077
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Swap REQ_NOWAIT and REQ_NOUNMAP and add REQ_HIPRI.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 90d6876..f812083 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -308,8 +308,9 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(PREFLUSH),
 	CMD_FLAG_NAME(RAHEAD),
 	CMD_FLAG_NAME(BACKGROUND),
-	CMD_FLAG_NAME(NOUNMAP),
 	CMD_FLAG_NAME(NOWAIT),
+	CMD_FLAG_NAME(NOUNMAP),
+	CMD_FLAG_NAME(HIPRI),
 };
 #undef CMD_FLAG_NAME
 
-- 
2.7.4

