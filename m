Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7166C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A6021873
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 13:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIg13CaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeLSNV3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:21:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 08:21:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBJDIV1e040500;
        Wed, 19 Dec 2018 13:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=euAumByCSm7kN28p5B2dIhcyTedrVQCoKnMXG35mlOY=;
 b=GIg13CaFsilx7OmpNMnJh7O/GAJ2azdeQTkUeb4/TK7K+SHdfqug6ED8d3nbVynqXgch
 bRuFapV84DYFAcwYtnRX8fuOODikbcR2reYQpdsuAIJXekj2ei3JcGJ2GL98k3HVQHav
 t2tmVhnABbKpiflTNnuaLzjASuNopSSFSnaZ1hyhMTA83i7EsyrHXS+EX2x5QYjKrJRa
 C2888uunm6dW4H1LLR5A7U/va+KjjZCvcniYREMLsx9osQpGvu4biZqQUfgkuABTZ37L
 MtUrBWGkeAZQ9WTcXP9SDaIgHXy8RQ1bgS+ZQVXz5GX8CpV56Ru/Ub8ouCJ24eEvVddy HA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pfn1yrh8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 13:21:19 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBJDLItJ024268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 13:21:18 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBJDLHaS031163;
        Wed, 19 Dec 2018 13:21:17 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Dec 2018 05:21:17 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        paul.durrant@citrix.com
Subject: [PATCH v3 1/1] xen/blkback: rework connect_ring() to avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Date:   Wed, 19 Dec 2018 21:23:02 +0800
Message-Id: <1545225782-31403-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812190115
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The xenstore 'ring-page-order' is used globally for each blkback queue and
therefore should be read from xenstore only once. However, it is obtained
in read_per_ring_refs() which might be called multiple times during the
initialization of each blkback queue.

If the blkfront is malicious and the 'ring-page-order' is set in different
value by blkfront every time before blkback reads it, this may end up at
the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
xen_blkif_disconnect() when frontend is destroyed.

This patch reworks connect_ring() to read xenstore 'ring-page-order' only
once.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  * change the order of xenstore read in read_per_ring_refs
  * use xenbus_read_unsigned() in connect_ring()

Changed since v2:
  * simplify the condition check as "(err != 1 && nr_grefs > 1)"
  * avoid setting err as -EINVAL to remove extra one line of code

 drivers/block/xen-blkback/xenbus.c | 74 +++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e..dfea3a4 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 	int err, i, j;
 	struct xen_blkif *blkif = ring->blkif;
 	struct xenbus_device *dev = blkif->be->dev;
-	unsigned int ring_page_order, nr_grefs, evtchn;
+	unsigned int nr_grefs, evtchn;
 
 	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
 			  &evtchn);
@@ -936,43 +936,36 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		return err;
 	}
 
-	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
-			  &ring_page_order);
+	nr_grefs = blkif->nr_ring_pages;
+	WARN_ON(!nr_grefs);
+
+	for (i = 0; i < nr_grefs; i++) {
+		char ring_ref_name[RINGREF_NAME_LEN];
+
+		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
+		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
+				   "%u", &ring_ref[i]);
+
+		if (err != 1 && nr_grefs > 1) {
+			xenbus_dev_fatal(dev, err, "reading %s/%s",
+					 dir, ring_ref_name);
+			return -EINVAL;
+		}
+
+		if (err != 1)
+			break;
+	}
+
 	if (err != 1) {
-		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
+		WARN_ON(nr_grefs != 1);
+
+		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
+				   &ring_ref[0]);
 		if (err != 1) {
-			err = -EINVAL;
 			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
-			return err;
-		}
-		nr_grefs = 1;
-	} else {
-		unsigned int i;
-
-		if (ring_page_order > xen_blkif_max_ring_order) {
-			err = -EINVAL;
-			xenbus_dev_fatal(dev, err, "%s/request %d ring page order exceed max:%d",
-					 dir, ring_page_order,
-					 xen_blkif_max_ring_order);
-			return err;
-		}
-
-		nr_grefs = 1 << ring_page_order;
-		for (i = 0; i < nr_grefs; i++) {
-			char ring_ref_name[RINGREF_NAME_LEN];
-
-			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
-			err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
-					   "%u", &ring_ref[i]);
-			if (err != 1) {
-				err = -EINVAL;
-				xenbus_dev_fatal(dev, err, "reading %s/%s",
-						 dir, ring_ref_name);
-				return err;
-			}
+			return -EINVAL;
 		}
 	}
-	blkif->nr_ring_pages = nr_grefs;
 
 	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
 		req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -1030,6 +1023,7 @@ static int connect_ring(struct backend_info *be)
 	size_t xspathsize;
 	const size_t xenstore_path_ext_size = 11; /* sufficient for "/queue-NNN" */
 	unsigned int requested_num_queues = 0;
+	unsigned int ring_page_order;
 
 	pr_debug("%s %s\n", __func__, dev->otherend);
 
@@ -1075,6 +1069,20 @@ static int connect_ring(struct backend_info *be)
 		 be->blkif->nr_rings, be->blkif->blk_protocol, protocol,
 		 pers_grants ? "persistent grants" : "");
 
+	ring_page_order = xenbus_read_unsigned(dev->otherend,
+					       "ring-page-order", 0);
+
+	if (ring_page_order > xen_blkif_max_ring_order) {
+		err = -EINVAL;
+		xenbus_dev_fatal(dev, err,
+				 "requested ring page order %d exceed max:%d",
+				 ring_page_order,
+				 xen_blkif_max_ring_order);
+		return err;
+	}
+
+	be->blkif->nr_ring_pages = 1 << ring_page_order;
+
 	if (be->blkif->nr_rings == 1)
 		return read_per_ring_refs(&be->blkif->rings[0], dev->otherend);
 	else {
-- 
2.7.4

