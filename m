Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0794C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8CC2082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ok9UvSOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8CC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeK1Owp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50990 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeK1Owo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3mqb2033449;
        Wed, 28 Nov 2018 03:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ZCXvsAPo6OYYs9OnVI2LKGBoGcqQFZjhpapjNkfKV0s=;
 b=ok9UvSOjuDlKRm4TVLyev5+xwxyKSoJ1u2OZlSx0ygRppRlETpCn5pOUC0U4xzCJtp1y
 UCMTK3NzpFTwsXxVduVTlcsjv/Y7L0tcuCGs8+JDMirtIkPwJotEkEkgoO9XCUlBbiXO
 YX7CwPwea/tt0SHkv1GUOtb6sIR5XgKrYYXbRyiPC4h/OcHfiAkgGf/1nnYFHxnOi3Gr
 UmBIJpshqGT6loQ1JHbFz9mWcgaBBEE+dNNRxrC+xf/gNxp2l9Smk/vZUb+zNVSq/2rN
 PG7/PkLteraLe5PT3QuawAdwlQhcYunULljeJzrJVMAAq+67wPe6ZODHxIsKV+Sp6h0G QQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2u7tku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qaqK009600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:36 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAS3qa0Z028909;
        Wed, 28 Nov 2018 03:52:36 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:35 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [PATCH v1 6/7] xfs: Rewrite retried read
Date:   Tue, 27 Nov 2018 20:49:50 -0700
Message-Id: <1543376991-5764-7-git-send-email-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=880
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we had to try more than one mirror to get a successful
read, then write that buffer back to correct the bad mirro

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index f102d01..81f6491 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -847,6 +847,14 @@ xfs_buf_read_map(
 
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
2.7.4

