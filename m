Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA5C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B932082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wkK785TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B932082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK1Owk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1Owk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3mp2q033441;
        Wed, 28 Nov 2018 03:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=BJnmFYQQlGRu/5A4+zMVKg4kh2H7+FpVmnF4JYWo4q4=;
 b=wkK785TJDZl3d3oYaFCYpE0DxZz8WoqFzGoHUH2P2KEUVnsPz9EREcaPfrtpW40WP5lE
 QlTjVLAHueQfS9uTXIzE0sYc3G/ahSdKC0AF49h3qgTfbDJ8KxtZ3P0tfy9HevGPsI3H
 51/tKC5/TBmWO4R+7nPRn2KthnJWthLoMbgRK6iD0hGCpsZnZz2KMFaJOxzKF4XMm5S+
 iiS7cJgt+cc+y7d0pc5YPqxTgpzZkK+YBfgsc3q98yArG2SmBk1Ir6aZ3f5+NjEBXrqL
 13nJVEnWO2rhl88DB5fnq8QNKU5BBCF3WltBa7WDdwR1hV43ImN5CwsgGejtENWyyKNg 6A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2u7tkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qU2Q018655
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:30 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qUt4005857;
        Wed, 28 Nov 2018 03:52:30 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:30 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [PATCH v1 1/7] block: add nr_mirrors to request_queue
Date:   Tue, 27 Nov 2018 20:49:45 -0700
Message-Id: <1543376991-5764-2-git-send-email-allison.henderson@oracle.com>
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

From: Bob Liu <bob.liu@oracle.com>

When fs data/metadata checksum mismatch, lower block devices may have other
correct copies. e.g if we did raid1 for protecting fs metadata.
Then fs could try other copies of metadata instead of panic, but fs need be
awared how many mirrors the block devices have and specify which mirror/copy to
retry.

This patch add @nr_mirrors to struct request_queue which is similar as
blk_queue_nonrot(), filesystem can grab device request queue and check the
number of mirrors of this block device.

@nr_mirrors is 0 by default which means no mirrors, drivers e.g raid1 are
responsible for setting the right value.

Also added helper functions for get/set the number of mirrors for a specific
device request queue.

Todo:
* Export nr_mirrors through /sysfs.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 block/blk-core.c       |  3 +++
 block/blk-settings.c   | 18 ++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index ce12515f..50779c8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1082,6 +1082,9 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	if (blkcg_init_queue(q))
 		goto fail_ref;
 
+	/* Set queue default mirrors to 0 explicitly. */
+	blk_queue_set_mirrors(q, 0);
+
 	return q;
 
 fail_ref:
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 696c04c..6f4f9c7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -904,6 +904,24 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
+/*
+ * Get the number of read redundant mirrors.
+ */
+unsigned short blk_queue_get_mirrors(struct request_queue *q)
+{
+	return q->nr_mirrors;
+}
+EXPORT_SYMBOL(blk_queue_get_mirrors);
+
+/*
+ * Set the number of read redundant mirrors.
+ */
+void blk_queue_set_mirrors(struct request_queue *q, unsigned short mirrors)
+{
+	q->nr_mirrors = mirrors;
+}
+EXPORT_SYMBOL(blk_queue_set_mirrors);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4293dc1..fac35da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -680,6 +680,7 @@ struct request_queue {
 
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
+	unsigned short		nr_mirrors; /* Default value is zero */
 };
 
 #define QUEUE_FLAG_QUEUED	0	/* uses generic tag queueing */
@@ -1267,6 +1268,8 @@ extern void blk_queue_rq_timed_out(struct request_queue *, rq_timed_out_fn *);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+extern unsigned short blk_queue_get_mirrors(struct request_queue *q);
+extern void blk_queue_set_mirrors(struct request_queue *q, unsigned short mirrors);
 
 /*
  * Number of physical segments as sent to the device.
-- 
2.7.4

