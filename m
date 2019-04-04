Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB8C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 02:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00092133D
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 02:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kMvIKkfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDCxw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:53:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDDCxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 22:53:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x342rcui023872;
        Thu, 4 Apr 2019 02:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=OppRsf5R8GtQ7DOAGXoRu99YOawhCPz1bLgCqWEt4Mk=;
 b=kMvIKkfw7wwOS6MuFuOy8412knXq5IM8f9b0TibHNu0SRqxyGOuClLZ2iKzp1nnVBPWR
 neeKr05ZS7bq6MCWurD2zE5TYa2onvB1qqZF7kV+gG4UU99me0kBUwGbQrYEGWgzbhgb
 vWXruMIj3HhtsraAcGUdstSVaCZLvnKsf7PzDb9Aclrv39LhRAKslv8dTa9AOOXRJJ9u
 dasGCZ2Ius0Pt7uwtxFYVPM2HR70/9HF/Uk+vQetkG7ti/QXHh/kB8OkZnADKrOMbsAS
 6Zx3ngA7+vPjDN7gBfebqgatAfpuIkfm5XHv+OCYkb4bFfrT1mnmNUzw9d1j61hwGePK tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rj13qcchr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 02:53:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x342rM5n095701;
        Thu, 4 Apr 2019 02:53:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mjctmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 02:53:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x342rkto022043;
        Thu, 4 Apr 2019 02:53:47 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 19:53:46 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] blk-mq: do not reset plug->rq_count before the list is sorted
Date:   Thu,  4 Apr 2019 10:57:44 +0800
Message-Id: <1554346664-24038-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040019
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We would never be able to sort the list if we first reset plug->rq_count
which is used in conditional check later.

Fixes: ce5b009cff19 ("block: improve logic around when to sort a plug list")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b..c162718 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1711,11 +1711,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
-	plug->rq_count = 0;
 
 	if (plug->rq_count > 2 && plug->multiple_queues)
 		list_sort(NULL, &list, plug_rq_cmp);
 
+	plug->rq_count = 0;
+
 	this_q = NULL;
 	this_hctx = NULL;
 	this_ctx = NULL;
-- 
2.7.4

