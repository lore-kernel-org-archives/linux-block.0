Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14186C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB672082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AeSOtSxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB672082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGEQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:16:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47564 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGEQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 23:16:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB74DpEt067073;
        Fri, 7 Dec 2018 04:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qLP8RAZfsGU0TDpj1ZbaMz0GzS2DloBjXjB7AxvJHvI=;
 b=AeSOtSxpDcNYmDWxQPGzWw7IKgOGOtZAFV5rNf2XrQsE503FHoYdvc/yv4pLISQ923KU
 3U/fusTyF3kUGfQO+MC8SMMNolmFWQDaFelxtTlhH7Q89zbl4gFBCnsAu+fHk0Sw0lyG
 fA1q1ucgvmafeM7Af2qXUMbhYzSY99sVUiIKGhtqFcFsmsIbStqAe0gEhGapSEFJ9NCf
 HLKr8tjlF+W/PrhnOk8COMBlyFBnc5YDTkuqsbVf3iG6VMCC885wsgILe9HoJSwNMRPu
 ecGWAb9jShpJps6afMNeP8A/gdLx7DlPGWvD/VoFmjbJu+D6RGyzpiaJcwiB+bFJmadS Jg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqubr3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 04:16:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB74G8af009242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 04:16:08 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB74G7eA027974;
        Fri, 7 Dec 2018 04:16:07 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 20:16:07 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Subject: [PATCH 1/1] xen/blkback: rework connect_ring() to avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Date:   Fri,  7 Dec 2018 12:18:04 +0800
Message-Id: <1544156284-7756-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070034
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
 drivers/block/xen-blkback/xenbus.c | 49 ++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e..4a8ce20 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -919,14 +919,15 @@ static void connect(struct backend_info *be)
 /*
  * Each ring may have multi pages, depends on "ring-page-order".
  */
-static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
+static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir,
+			      bool use_ring_page_order)
 {
 	unsigned int ring_ref[XENBUS_MAX_RING_GRANTS];
 	struct pending_req *req, *n;
 	int err, i, j;
 	struct xen_blkif *blkif = ring->blkif;
 	struct xenbus_device *dev = blkif->be->dev;
-	unsigned int ring_page_order, nr_grefs, evtchn;
+	unsigned int nr_grefs, evtchn;
 
 	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
 			  &evtchn);
@@ -936,28 +937,18 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		return err;
 	}
 
-	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
-			  &ring_page_order);
-	if (err != 1) {
+	nr_grefs = blkif->nr_ring_pages;
+
+	if (!use_ring_page_order) {
 		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
 		if (err != 1) {
 			err = -EINVAL;
 			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
 			return err;
 		}
-		nr_grefs = 1;
 	} else {
 		unsigned int i;
 
-		if (ring_page_order > xen_blkif_max_ring_order) {
-			err = -EINVAL;
-			xenbus_dev_fatal(dev, err, "%s/request %d ring page order exceed max:%d",
-					 dir, ring_page_order,
-					 xen_blkif_max_ring_order);
-			return err;
-		}
-
-		nr_grefs = 1 << ring_page_order;
 		for (i = 0; i < nr_grefs; i++) {
 			char ring_ref_name[RINGREF_NAME_LEN];
 
@@ -972,7 +963,6 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 			}
 		}
 	}
-	blkif->nr_ring_pages = nr_grefs;
 
 	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
 		req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -1030,6 +1020,8 @@ static int connect_ring(struct backend_info *be)
 	size_t xspathsize;
 	const size_t xenstore_path_ext_size = 11; /* sufficient for "/queue-NNN" */
 	unsigned int requested_num_queues = 0;
+	bool use_ring_page_order = false;
+	unsigned int ring_page_order;
 
 	pr_debug("%s %s\n", __func__, dev->otherend);
 
@@ -1075,8 +1067,28 @@ static int connect_ring(struct backend_info *be)
 		 be->blkif->nr_rings, be->blkif->blk_protocol, protocol,
 		 pers_grants ? "persistent grants" : "");
 
+	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
+			   &ring_page_order);
+
+	if (err != 1) {
+		be->blkif->nr_ring_pages = 1;
+	} else {
+		if (ring_page_order > xen_blkif_max_ring_order) {
+			err = -EINVAL;
+			xenbus_dev_fatal(dev, err,
+					 "requested ring page order %d exceed max:%d",
+					 ring_page_order,
+					 xen_blkif_max_ring_order);
+			return err;
+		}
+
+		use_ring_page_order = true;
+		be->blkif->nr_ring_pages = 1 << ring_page_order;
+	}
+
 	if (be->blkif->nr_rings == 1)
-		return read_per_ring_refs(&be->blkif->rings[0], dev->otherend);
+		return read_per_ring_refs(&be->blkif->rings[0], dev->otherend,
+					  use_ring_page_order);
 	else {
 		xspathsize = strlen(dev->otherend) + xenstore_path_ext_size;
 		xspath = kmalloc(xspathsize, GFP_KERNEL);
@@ -1088,7 +1100,8 @@ static int connect_ring(struct backend_info *be)
 		for (i = 0; i < be->blkif->nr_rings; i++) {
 			memset(xspath, 0, xspathsize);
 			snprintf(xspath, xspathsize, "%s/queue-%u", dev->otherend, i);
-			err = read_per_ring_refs(&be->blkif->rings[i], xspath);
+			err = read_per_ring_refs(&be->blkif->rings[i], xspath,
+						 use_ring_page_order);
 			if (err) {
 				kfree(xspath);
 				return err;
-- 
2.7.4

