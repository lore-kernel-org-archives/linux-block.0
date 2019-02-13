Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8231EC282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F3D222CD
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctttriTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbfBMJxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbfBMJxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mgcv163804;
        Wed, 13 Feb 2019 09:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Ad+zZ6/ZPUMB/Kv9Vg5krh7HY7WfIeBOyxxzOXDmo7w=;
 b=ctttriTrfRyyTI0foAO+2oPHy9NIG15gjAcHNkL9jzu/f49ylX24i2f7alNXBNBUz8bm
 yg4eNM8+Gl6DJq1VuaZhIJNkctIp5g7WbS9N4F7/mR7eS79R4oy6nExMJC2Brdj5SmA3
 H4GahO6Kt8lcGWiq7ug5VOF7h4G7fxscQyL+G7iLWrmDg6XXWybirHN7GbtGp/Reh7TB
 2AZuYOlq03DJIz4BJEzGs/yoGS0E7VJiALdnHYczh+wtZ2AfU8gTBUBErKFh8jxoLaJp
 uq64g6tGz/3sWhwZ3nP5x9lv5L6XSfyu1PpvrXtbJpC9SrTtUvKIYuprserIXqPUQZ/n 1A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qhree11sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9re4n021320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:41 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rea9000731;
        Wed, 13 Feb 2019 09:53:40 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:40 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: [RFC PATCH v2 7/9] xfs: Add device retry
Date:   Wed, 13 Feb 2019 17:50:42 +0800
Message-Id: <20190213095044.29628-8-bob.liu@oracle.com>
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

Check to see if the _xfs_buf_read fails.  If so loop over the
available mirrors and retry the read

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 6098195ecaf4..2c250221cb78 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -21,6 +21,7 @@
 #include <linux/migrate.h>
 #include <linux/backing-dev.h>
 #include <linux/freezer.h>
+#include <linux/blkdev.h>
 
 #include "xfs_format.h"
 #include "xfs_log_format.h"
@@ -824,6 +825,9 @@ xfs_buf_read_map(
 	const struct xfs_buf_ops *ops)
 {
 	struct xfs_buf		*bp;
+	struct request_queue	*q;
+	unsigned long		i;
+	int			retries = 0;
 
 	flags |= XBF_READ;
 
@@ -836,7 +840,27 @@ xfs_buf_read_map(
 	if (!(bp->b_flags & XBF_DONE)) {
 		XFS_STATS_INC(target->bt_mount, xb_get_read);
 		bp->b_ops = ops;
-		_xfs_buf_read(bp, flags);
+		q = bdev_get_queue(bp->b_target->bt_bdev);
+
+		if (bp->b_alt_retry)
+			retries = blk_queue_get_mirrors(q);
+
+		for (i = 0; i <= retries; i++) {
+			bp->b_error = 0;
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
2.17.1

