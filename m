Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049AFC4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FD92173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2Hy4chg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfC2OZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:25:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbfC2OZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:25:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TENOHR009567;
        Fri, 29 Mar 2019 14:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Htuadjze+wfMFk2xX+FQkm1G2rt8079ZbjXQim9RLHc=;
 b=S2Hy4chgVtl3Ysv+BVH0oT1W3tnnPVl4p453cX+HuQZS3sSn6K+3Gu3ALR0sbgbFF3MK
 dD/rA37lnF5u8AzKEqyl7ZheVjrNpYSyzc2gG3lDp+PTuIYJiGtiMSUUYd8JEWn7w3HE
 MVZ+zAaQFoH3HF/Xum2keL/MixJeFy2btZ92surVBMBJOjEfDfl/XVnOO2NDW+GFKtXB
 egwKV4YF8RsJl9FmIlOJDsTkr6ICbq+IyyIqO+6f6w4Nwb7gtVP19i7/6cdiRSkkg/Vc
 H+YoOJPsDr/ORcczFgz0o+cFFP2H1231bNLGNZo9MRtmdjem/umIyoMF/i/GM48fDxZj +A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1mq1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:25:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEOtAj030501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:55 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TEOtnv019520;
        Fri, 29 Mar 2019 14:24:55 GMT
Received: from localhost.localdomain (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:24:54 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        axboe@kernel.dk, tytso@mit.edu, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v3 3/3] fs: xfs: add read_verifier() function
Date:   Fri, 29 Mar 2019 22:23:46 +0800
Message-Id: <20190329142346.1677-4-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329142346.1677-1-bob.liu@oracle.com>
References: <20190329142346.1677-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=892 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds an new read_verifier function and pass to
the block layer to verify reads.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 fs/xfs/xfs_buf.c | 23 +++++++++++++++++++++--
 fs/xfs/xfs_buf.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4f5f2ff3f70f..f3185dd9a557 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1243,7 +1243,8 @@ xfs_buf_ioend(
 		xfs_buf_ioerror(bp, bp->b_io_error);
 
 	/* Only validate buffers that were read without errors */
-	if (read && !bp->b_error && bp->b_ops) {
+	if (read && !bp->b_error && bp->b_ops &&
+	    !(bp->b_flags & _XBF_NOVERIFY)) {
 		ASSERT(!bp->b_iodone);
 		bp->b_ops->verify_read(bp);
 	}
@@ -1343,6 +1344,24 @@ xfs_buf_bio_end_io(
 	bio_put(bio);
 }
 
+int read_verifier(struct bio *bio)
+{
+	struct xfs_buf *bp = (struct xfs_buf *)bio->bi_private;
+
+	if (bp && !bp->b_error && bp->b_ops && bp->b_ops->verify_read) {
+		if (xfs_buf_is_vmapped(bp))
+			invalidate_kernel_vmap_range(bp->b_addr,
+						     xfs_buf_vmap_len(bp));
+		bp->b_ops->verify_read(bp);
+		/* set bit so that endio won't verify it again */
+		if (!bp->b_error)
+			bp->b_flags |= _XBF_NOVERIFY;
+		return bp->b_error;
+	} else {
+		return 0;
+	}
+}
+
 static void
 xfs_buf_ioapply_map(
 	struct xfs_buf	*bp,
@@ -1409,7 +1428,7 @@ xfs_buf_ioapply_map(
 			flush_kernel_vmap_range(bp->b_addr,
 						xfs_buf_vmap_len(bp));
 		}
-		submit_bio(bio);
+		submit_bio_verify(bio, &read_verifier);
 		if (size)
 			goto next_chunk;
 	} else {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b9f5511ea998..499637c61001 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -50,6 +50,7 @@ typedef enum {
 #define _XBF_KMEM	 (1 << 21)/* backed by heap memory */
 #define _XBF_DELWRI_Q	 (1 << 22)/* buffer on a delwri queue */
 #define _XBF_COMPOUND	 (1 << 23)/* compound buffer */
+#define _XBF_NOVERIFY	 (1 << 24)/* verify_read should not be called */
 
 typedef unsigned int xfs_buf_flags_t;
 
-- 
2.17.1

