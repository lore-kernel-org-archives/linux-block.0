Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF5C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F322082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GxV8qlGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F322082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeK1Own (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbeK1Own (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3o1VB189539;
        Wed, 28 Nov 2018 03:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=yD5x9hILqKnXnR+iJkaVfDAkoFG33aIC5PnQ9piiAJw=;
 b=GxV8qlGol1acBowmlfmmJnaodJXalW/XQY9QmNQhkoISHwxVd+Hc2s1xw+mQw0wDwc32
 fHJHACGP/A2dA/VGrLLBnzXaDSbwEPooYklOXfuHwSDcVaF4AQHfgrHHyDN08MBC3ejy
 Ko56/rtvf+RDy51IfJ1diwTTPEci3/fIT0mYc9UlzGl0rxo2OHFDR5Zd/F4s52IOIyro
 6j+JOq0umz4/dnAfYkEzUXRmyckZQyC6QAQctr0tihFkVXtH24Ph0AVnp0X2l4G35UUq
 D5DAo4ORaFcIJoTWMetua17WLDhIoop7lT+vKtjmI0gE9XbHULDomXhpyT7M5ZaLmIuB fA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9r7rbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:34 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qY1q026429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:34 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAS3qYjd023554;
        Wed, 28 Nov 2018 03:52:34 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:33 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [PATCH v1 4/7] xfs: Add b_rw_hint to xfs_buf
Date:   Tue, 27 Nov 2018 20:49:48 -0700
Message-Id: <1543376991-5764-5-git-send-email-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a new field b_rw_hint to xfs_buf.  We will
need this to properly initialize the new bio->bi_rw_hint when
submitting the read request.  When the read completes, we
then store the returned mirror in the b_rw_hint.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c | 5 ++++-
 fs/xfs/xfs_buf.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index b21ea2b..dd8ba59 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1322,8 +1322,10 @@ xfs_buf_bio_end_io(
 	if (!bp->b_error && xfs_buf_is_vmapped(bp) && (bp->b_flags & XBF_READ))
 		invalidate_kernel_vmap_range(bp->b_addr, xfs_buf_vmap_len(bp));
 
-	if (atomic_dec_and_test(&bp->b_io_remaining) == 1)
+	if (atomic_dec_and_test(&bp->b_io_remaining) == 1) {
+		bp->b_rw_hint = bio->bi_rw_hint;
 		xfs_buf_ioend_async(bp);
+	}
 	bio_put(bio);
 }
 
@@ -1369,6 +1371,7 @@ xfs_buf_ioapply_map(
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
+	bio->bi_rw_hint = bp->b_rw_hint;
 	bio_set_op_attrs(bio, op, op_flags);
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b9f5511..db138e5 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -197,6 +197,13 @@ typedef struct xfs_buf {
 	unsigned long		b_first_retry_time; /* in jiffies */
 	int			b_last_error;
 
+	/*
+	 * If b_rw_hint is set before a read, it specifies an alternate mirror
+	 * to read from.  Upon bio completion, b_rw_hint stores the last mirror
+	 * that was read from
+	 */
+	unsigned short		b_rw_hint;
+
 	const struct xfs_buf_ops	*b_ops;
 } xfs_buf_t;
 
-- 
2.7.4

