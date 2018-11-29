Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D98AC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 05:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2674420834
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 05:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="InIRR8k6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2674420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeK2QUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:20:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38986 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2QUz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 11:20:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT58lsk186679;
        Thu, 29 Nov 2018 05:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=6c9vUm9CIYiMwq05XmbGbH9J1Io9Ug8I7KAol5/Fx+s=;
 b=InIRR8k6CIQoLIBk6IsRQl7elTICkBIkuXitOcvCmyx9aViTuKZMPnci9fV+p2NinUtU
 NadaFMwsj3sIv6nYNHK6T6hQce9u9XnQb6ckUPcndHINk3UUgeeIEKupDjVbZNI+ZqjG
 hXJfXV8xYl4+TtjIlQ0PkQzU2yX1bkyIV0Bvli1GfgJRxhkA4mRbQG5dwRiktXmY94MV
 SIFZ5POcbBUF+f5GYUHHO6Fvp8phiyH17LGdasFkhtU+2+NfwBX25o3+UYinkVVGs/40
 DBa0Eha/msOYG3JbjaeqZxh92eMIuKJMjcm5tSkTfK3obtDt6ULwkNyDCrBby2lsz2iP 6A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqp2gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 05:16:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAT5GbHb016585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 05:16:37 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAT5GbrV004944;
        Thu, 29 Nov 2018 05:16:37 GMT
Received: from manjunathpatil.us.oracle.com (/10.211.44.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 21:16:36 -0800
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        manjuanth.b.patil@oracle.com
Subject: [PATCH] xen-blkfront: use old rinfo after enomem during migration
Date:   Wed, 28 Nov 2018 21:17:45 -0800
Message-Id: <1543468665-22795-1-git-send-email-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290043
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
Feel free to suggest/comment on this.

I am trying to do the following at dst during the migration now.
1. Dont clear the old rinfo in blkif_free(). Instead just clean it.
2. Store the old rinfo and nr_rings into temp variables in negotiate_mq()
3. let nr_rings get re-calculated based on backend data
4. try allocating new memory based on new nr_rings
5. 
  a. If memory allocation is a success
     - free the old rinfo and proceed to use the new rinfo
  b. If memory allocation is a failure
     - use the old the rinfo
     - adjust the nr_rings to the lowest of new nr_rings and old nr_rings

-Thanks,
Manjunath
--
During migration, the dst side device resume can fail to allocate rinfo
struct. Each rinfo is about 80K in size and allocating 4[typical] such
rings would need an order 7 allocation[512KB chuck] there by incresing
the chance of memory allocation failure. Device resume failure during
migration will lead the processes accessing the device into hung state.

This patch aims to reuse old rinfo in case of memory allocation failure.

Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 drivers/block/xen-blkfront.c |   46 +++++++++++++++++++++++++++++++++++------
 1 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 0ed4b20..041ba67 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1353,9 +1353,17 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 	for (i = 0; i < info->nr_rings; i++)
 		blkif_free_ring(&info->rinfo[i]);
 
-	kfree(info->rinfo);
-	info->rinfo = NULL;
-	info->nr_rings = 0;
+	if (unlikely(info->connected == BLKIF_STATE_SUSPENDED)) {
+		/* We are migrating. You may reuse it. Just clean. */
+		for (i = 0; i < info->nr_rings; i++) {
+			memset(&info->rinfo[i], 0,
+				sizeof(struct blkfront_ring_info));
+		}
+	} else {
+		kfree(info->rinfo);
+		info->rinfo = NULL;
+		info->nr_rings = 0;
+	}
 }
 
 struct copy_from_grant {
@@ -1903,6 +1911,16 @@ static int negotiate_mq(struct blkfront_info *info)
 {
 	unsigned int backend_max_queues;
 	unsigned int i;
+	struct blkfront_ring_info *rinfo_old = NULL;
+	unsigned int nr_rings_old = 0;
+
+	/* Migrating. We did not free old rinfo. Reuse it if possible */
+	if (unlikely(info->connected == BLKIF_STATE_SUSPENDED)) {
+		nr_rings_old = info->nr_rings;
+		rinfo_old = info->rinfo;
+		info->rinfo = NULL;
+		info->nr_rings = 0;
+	}
 
 	BUG_ON(info->nr_rings);
 
@@ -1918,10 +1936,24 @@ static int negotiate_mq(struct blkfront_info *info)
 			      sizeof(struct blkfront_ring_info),
 			      GFP_KERNEL);
 	if (!info->rinfo) {
-		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
-		info->nr_rings = 0;
-		return -ENOMEM;
-	}
+		if (unlikely(nr_rings_old)) {
+			/* We might waste some memory if
+			 * info->nr_rings < nr_rings_old
+			 */
+			info->rinfo = rinfo_old;
+			if (info->nr_rings > nr_rings_old)
+				info->nr_rings = nr_rings_old;
+			xenbus_dev_fatal(info->xbdev, -ENOMEM,
+			"reusing old ring_info structure(new ring size=%d)",
+				info->nr_rings);
+		} else {
+			xenbus_dev_fatal(info->xbdev, -ENOMEM,
+				"allocating ring_info structure");
+			info->nr_rings = 0;
+			return -ENOMEM;
+		}
+	} else if (unlikely(nr_rings_old))
+		kfree(rinfo_old);
 
 	for (i = 0; i < info->nr_rings; i++) {
 		struct blkfront_ring_info *rinfo;
-- 
1.7.1

