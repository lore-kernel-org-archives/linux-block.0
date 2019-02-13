Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA48C282CE
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D661222CD
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DBEDCLXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfBMJxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387821AbfBMJxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mi8e163835;
        Wed, 13 Feb 2019 09:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=djq8BbFMatF5YBAugCJjJvi0D9KcFtTqCJonR8JZfsA=;
 b=DBEDCLXMe4fSmDntnCJNF8b5JT2JIGK9LXq9nKSxRZmSbgm/AMhuceh8GFffJ4U+oNAn
 wxgkmAMmw1xhl+CaegZH7v9LFAtDWg5P5Yx7188Z62hvrSmY9Ko1CWjL/bI7V9qRtQ34
 QKDQo0h1jNVR137jFtHaa6PLyKnsb0k6saFxgYdtbrl4Izt5eWZcuUForZ49juqrSlmv
 LFNSkFSdqk44B1ZcvdyiaC1JjoeqTOVRCskGV4EMcskj9sDWPmOpvpUV826T49WKm6fD
 6vDvTQvF2qRPqpEifX2yeS+V932yyqfFLpRued61f4UYYHfyvdx+c5bB2UunKv+/5ZHL Xw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qhree11sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rbnT021083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:38 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rbGh000718;
        Wed, 13 Feb 2019 09:53:37 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:36 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: [RFC PATCH v2 6/9] xfs: Add b_rd_hint to xfs_buf
Date:   Wed, 13 Feb 2019 17:50:41 +0800
Message-Id: <20190213095044.29628-7-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=988 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds a new field b_rd_hint to xfs_buf.  We will
need this to properly initialize the new bio->bi_rw_hint when
submitting the read request.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c |  6 +++++-
 fs/xfs/xfs_buf.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e2683c8e868c..6098195ecaf4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1338,8 +1338,11 @@ xfs_buf_bio_end_io(
 	if (!bp->b_error && xfs_buf_is_vmapped(bp) && (bp->b_flags & XBF_READ))
 		invalidate_kernel_vmap_range(bp->b_addr, xfs_buf_vmap_len(bp));
 
-	if (atomic_dec_and_test(&bp->b_io_remaining) == 1)
+	if (atomic_dec_and_test(&bp->b_io_remaining) == 1) {
+		if (bp->b_flags & XBF_RW_HINT)
+			bitmap_copy(bp->b_rd_hint, bio->bi_rd_hint, BLKDEV_MAX_MIRRORS);
 		xfs_buf_ioend_async(bp);
+	}
 	bio_put(bio);
 }
 
@@ -1385,6 +1388,7 @@ xfs_buf_ioapply_map(
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
+	bitmap_copy(bio->bi_rd_hint, bp->b_rd_hint, BLKDEV_MAX_MIRRORS);
 	bio_set_op_attrs(bio, op, op_flags);
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 989b97a17486..af9bdff29e66 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -40,6 +40,7 @@ typedef enum {
 #define XBF_SYNCIO	 (1 << 10)/* treat this buffer as synchronous I/O */
 #define XBF_FUA		 (1 << 11)/* force cache write through mode */
 #define XBF_FLUSH	 (1 << 12)/* flush the disk cache before a write */
+#define XBF_RW_HINT	 (1 << 13)/* Read/write hint used for alt dev retry */
 
 /* flags used only as arguments to access routines */
 #define XBF_TRYLOCK	 (1 << 16)/* lock requested, but do not wait */
@@ -65,6 +66,7 @@ typedef unsigned int xfs_buf_flags_t;
 	{ XBF_SYNCIO,		"SYNCIO" }, \
 	{ XBF_FUA,		"FUA" }, \
 	{ XBF_FLUSH,		"FLUSH" }, \
+	{ XBF_RW_HINT,		"RW_HINT" }, \
 	{ XBF_TRYLOCK,		"TRYLOCK" },	/* should never be set */\
 	{ XBF_UNMAPPED,		"UNMAPPED" },	/* ditto */\
 	{ _XBF_PAGES,		"PAGES" }, \
@@ -197,6 +199,16 @@ typedef struct xfs_buf {
 	unsigned long		b_first_retry_time; /* in jiffies */
 	int			b_last_error;
 
+	/*
+	 * Bitmask used by block device for alternate device retry
+	 *
+	 * To retry a read with the next device, resubmit the bio with
+	 * the bi_rd_hint returned from the last read.
+	 * Otherwise use bitmap_zero() if we don't care about alt mirror
+	 * device retry.
+         */
+	DECLARE_BITMAP(b_rd_hint, BLKDEV_MAX_MIRRORS);
+
 	const struct xfs_buf_ops	*b_ops;
 	bool			b_alt_retry;	/* toggle alt device retry */
 } xfs_buf_t;
-- 
2.17.1

