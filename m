Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7AFC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6E222CF
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJAC9QXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbfBMJxl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387742AbfBMJxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mlgD158547;
        Wed, 13 Feb 2019 09:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=hMbuxyPzORcwzH0eUzMPHjc5zsz92jBZFARf1sdQ3s0=;
 b=lJAC9QXeZbFwhPIEtMceRxnqxxlGuIgM4idbBLeJ7iC8EyuoJBblqOkQD7TmUKkqR7qD
 9CX9vJeVxCwo+FEhkH5OD/o8Rd2ErxsZ/K5iuWcvsFJ7/Mxg/mwujuiL1arZsJJ6r6GS
 ODGk8Shh8RL079/r/yiTWDeMt10D7Igv6h9O7wYaDYgPMbPBOWBM0ECqJz+VguwkrS2b
 Ll3HKa03R/w5YRSItpKxJR0/XxCC8/71VTrFxSsxaQxIAiMe3zYNvM0hA4ssDwL+nP6s
 2N7bVlqHBDNI+wW/aeqTcsmfDBQrchoocwQTFDxJw+QzykEWswFYDxaXM1hizsIyfG7V 3A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrekh0vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rYYi029957
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:34 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1D9rY1b026559;
        Wed, 13 Feb 2019 09:53:34 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:33 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: [RFC PATCH v2 5/9] Add b_alt_retry to xfs_buf
Date:   Wed, 13 Feb 2019 17:50:40 +0800
Message-Id: <20190213095044.29628-6-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds b_alt_retry boolean to xfs_buf. We will use
this to enable alternate device retry when the bio completes
for single buffer bios.

At this time, we do not yet support alternate device retry for
multi buffer bio

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c | 8 ++++++++
 fs/xfs/xfs_buf.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4f5f2ff3f70f..e2683c8e868c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1409,6 +1409,14 @@ xfs_buf_ioapply_map(
 			flush_kernel_vmap_range(bp->b_addr,
 						xfs_buf_vmap_len(bp));
 		}
+
+		/*
+		 * At the moment, we only support alternate
+		 * device retry on single bio buffers
+		 */
+		if (size == 0)
+			bp->b_alt_retry = true;
+
 		submit_bio(bio);
 		if (size)
 			goto next_chunk;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b9f5511ea998..989b97a17486 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -198,6 +198,7 @@ typedef struct xfs_buf {
 	int			b_last_error;
 
 	const struct xfs_buf_ops	*b_ops;
+	bool			b_alt_retry;	/* toggle alt device retry */
 } xfs_buf_t;
 
 /* Finding and Reading Buffers */
-- 
2.17.1

