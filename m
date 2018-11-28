Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC30DC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8F72082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DSFs/n4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8F72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeK1Owp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52266 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1Owo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3mX89192793;
        Wed, 28 Nov 2018 03:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XtkBsCEZFJUmXzaORwxd3Muknk5RrVpgR0APvnd2NTc=;
 b=DSFs/n4WZFSn1e4rsGgZeCNcAx5Rk7PvJRqZDf0L4DbKO/eHsYnAVPDmpxfVRcnRIROg
 /rxUq5J1uNcZzOAME4SAQsm8O5URuA4zv32+TX/gMpveNCK2IQ36hHX0H2Ts5kigGWB5
 kfjTTRCxq1A3CVI7dYJw2hBesJQaiTufM0Bxhq10JoljqoB4RCIcLgEQpjmIjAdDxJFL
 cU7psklDYWs5YYYBkjx9XNSUN/PeYjdi0fEJqNdzorkf7Umt27nsM5wfavfXEm4Df88t
 hr6oMZYvXypXRvDSqCMqACuYUn64X96Y/W6bAxdxwfaKbB+R4IpH2n3TnYblynf2iM5D vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqfrfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qZEb009546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:35 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qZBs000579;
        Wed, 28 Nov 2018 03:52:35 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:34 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [PATCH v1 5/7] xfs: Add device retry
Date:   Tue, 27 Nov 2018 20:49:49 -0700
Message-Id: <1543376991-5764-6-git-send-email-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check to see if the _xfs_buf_read fails.  If so loop over the
available mirrors and retry the read

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index dd8ba59..f102d01 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -21,6 +21,7 @@
 #include <linux/migrate.h>
 #include <linux/backing-dev.h>
 #include <linux/freezer.h>
+#include <linux/blkdev.h>
 
 #include "xfs_format.h"
 #include "xfs_log_format.h"
@@ -808,6 +809,8 @@ xfs_buf_read_map(
 	const struct xfs_buf_ops *ops)
 {
 	struct xfs_buf		*bp;
+	struct request_queue	*q;
+	unsigned short		i;
 
 	flags |= XBF_READ;
 
@@ -820,7 +823,30 @@ xfs_buf_read_map(
 	if (!(bp->b_flags & XBF_DONE)) {
 		XFS_STATS_INC(target->bt_mount, xb_get_read);
 		bp->b_ops = ops;
-		_xfs_buf_read(bp, flags);
+		q = bdev_get_queue(bp->b_target->bt_bdev);
+
+		/*
+		 * Mirrors are indexed 1 - n, specified through the rw_hint.
+		 * Setting the hint to 0 is unspecified and allows the block
+		 * layer to decide.
+		 */
+		for (i = 0; i <= blk_queue_get_mirrors(q); i++) {
+			bp->b_error = 0;
+			bp->b_rw_hint = i;
+			_xfs_buf_read(bp, flags);
+
+			switch (bp->b_error) {
+			case -EIO:
+			case -EFSCORRUPTED:
+			case -EFSBADCRC:
+				/* loop again */
+				continue;
+			default:
+				goto retry_done;
+			}
+
+		}
+retry_done:
 		return bp;
 	}
 
-- 
2.7.4

