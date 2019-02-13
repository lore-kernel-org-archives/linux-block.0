Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC3BC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3172077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecxi0IdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391386AbfBMJx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58650 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbfBMJx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mg99164813;
        Wed, 13 Feb 2019 09:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=4aVe1qcdo+EJ2dG63MtwaP+x1ZR6HAKRsDn8i3GaN9E=;
 b=ecxi0IdOKpnOGDmk6nXAIr/+fAC4uQ6O0kTcUsALwIGnNVV4If/S1lPzdxvnE7IZ9LId
 EwvODUlyD4/QoIKeWnsfcIvQYl0mipVKMAIsRB+WwF8k+BlctE0NXp6plBNtnBoR8dfE
 pk7uVosEL8u5F26wDp5cm0+6ukPvfMqgmcM0MivRdrGzD/UswVFTqtbGSIW5vZwIKBK1
 XCZgSwjI7OZbTxUvUcljstjL262r+6YxqD+LfVN7JzryJQ6bKfOF4y8zFC8SQrYxpKcI
 Xrwutb2PENMRel0xWaMY1FRN4pXobUbOywNkWCe8ylqf6aJcorttPj0YbM+8xo8c7yoC jQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qhre5gyvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rhR7010664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:43 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rhgM005276;
        Wed, 13 Feb 2019 09:53:43 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:43 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: [RFC PATCH v2 8/9] xfs: Rewrite retried read
Date:   Wed, 13 Feb 2019 17:50:43 +0800
Message-Id: <20190213095044.29628-9-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=883 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Allison Henderson <allison.henderson@oracle.com>

If we had to try more than one mirror to get a successful
read, then write that buffer back to correct the bad mirror

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 2c250221cb78..e54dbc776d15 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -861,6 +861,14 @@ xfs_buf_read_map(
 
 		}
 retry_done:
+
+		/*
+		 * if we had to try more than one mirror to sucessfully read
+		 * the buffer, write the buffer back
+		 */
+		if (!bp->b_error && i > 0)
+			xfs_bwrite(bp);
+
 		return bp;
 	}
 
-- 
2.17.1

