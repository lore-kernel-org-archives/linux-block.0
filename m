Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11161C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B1020665
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xoKgzDvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfAHINi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:13:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49600 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfAHINh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 03:13:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0883QuV068912;
        Tue, 8 Jan 2019 08:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=WSAc1PrUxV217qpEoJIJGE/bDMBd/wJqWFbATuzxKGw=;
 b=xoKgzDvEb6VC9q39YAooG0lcDc4G9e+lIAU9m7ppzC0H+wVnirFAOIDKzXoo4pXVT+ii
 m59me8sdm9vVxQ5yxEu9jETUAuGla2Opma/bOe2pfmXdpFe5uhBI74+jYGdWo8K9IwL3
 BwDIv38uorYF/TuhO3AYNEXpQJsxxOlIOuKvIlyExU8ot6izJ+oUCbcNwQt+Lt6LqegL
 Qq3JucOdvmmMUiohbOEpT+Wu9ZbyThVITkCKb6qa0t0uu7sKqgMjd+DGIofcaRRwUJxu
 IyO0TMgH3hhb1UClW0+JZhOs+MXdMDlzEWejDMDs1lwYv5c65X7wfREnesY8MMR3Ftf0 rg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7qstj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 08:13:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x088DVdl010128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 08:13:31 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x088DU3K023106;
        Tue, 8 Jan 2019 08:13:31 GMT
Received: from linux.cn.oracle.com (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 00:13:30 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        paul.durrant@citrix.com
Subject: [PATCH v5 1/2] xen/blkback: add stack variable 'blkif' in connect_ring()
Date:   Tue,  8 Jan 2019 16:15:49 +0800
Message-Id: <1546935350-20957-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As 'be->blkif' is used for many times in connect_ring(), the stack variable
'blkif' is added to substitute 'be-blkif'.

Suggested-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkback/xenbus.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e..a4aadac 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -1023,6 +1023,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 static int connect_ring(struct backend_info *be)
 {
 	struct xenbus_device *dev = be->dev;
+	struct xen_blkif *blkif = be->blkif;
 	unsigned int pers_grants;
 	char protocol[64] = "";
 	int err, i;
@@ -1033,25 +1034,25 @@ static int connect_ring(struct backend_info *be)
 
 	pr_debug("%s %s\n", __func__, dev->otherend);
 
-	be->blkif->blk_protocol = BLKIF_PROTOCOL_DEFAULT;
+	blkif->blk_protocol = BLKIF_PROTOCOL_DEFAULT;
 	err = xenbus_scanf(XBT_NIL, dev->otherend, "protocol",
 			   "%63s", protocol);
 	if (err <= 0)
 		strcpy(protocol, "unspecified, assuming default");
 	else if (0 == strcmp(protocol, XEN_IO_PROTO_ABI_NATIVE))
-		be->blkif->blk_protocol = BLKIF_PROTOCOL_NATIVE;
+		blkif->blk_protocol = BLKIF_PROTOCOL_NATIVE;
 	else if (0 == strcmp(protocol, XEN_IO_PROTO_ABI_X86_32))
-		be->blkif->blk_protocol = BLKIF_PROTOCOL_X86_32;
+		blkif->blk_protocol = BLKIF_PROTOCOL_X86_32;
 	else if (0 == strcmp(protocol, XEN_IO_PROTO_ABI_X86_64))
-		be->blkif->blk_protocol = BLKIF_PROTOCOL_X86_64;
+		blkif->blk_protocol = BLKIF_PROTOCOL_X86_64;
 	else {
 		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
 		return -ENOSYS;
 	}
 	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
 					   0);
-	be->blkif->vbd.feature_gnt_persistent = pers_grants;
-	be->blkif->vbd.overflow_max_grants = 0;
+	blkif->vbd.feature_gnt_persistent = pers_grants;
+	blkif->vbd.overflow_max_grants = 0;
 
 	/*
 	 * Read the number of hardware queues from frontend.
@@ -1067,16 +1068,16 @@ static int connect_ring(struct backend_info *be)
 				requested_num_queues, xenblk_max_queues);
 		return -ENOSYS;
 	}
-	be->blkif->nr_rings = requested_num_queues;
-	if (xen_blkif_alloc_rings(be->blkif))
+	blkif->nr_rings = requested_num_queues;
+	if (xen_blkif_alloc_rings(blkif))
 		return -ENOMEM;
 
 	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
-		 be->blkif->nr_rings, be->blkif->blk_protocol, protocol,
+		 blkif->nr_rings, blkif->blk_protocol, protocol,
 		 pers_grants ? "persistent grants" : "");
 
-	if (be->blkif->nr_rings == 1)
-		return read_per_ring_refs(&be->blkif->rings[0], dev->otherend);
+	if (blkif->nr_rings == 1)
+		return read_per_ring_refs(&blkif->rings[0], dev->otherend);
 	else {
 		xspathsize = strlen(dev->otherend) + xenstore_path_ext_size;
 		xspath = kmalloc(xspathsize, GFP_KERNEL);
@@ -1085,10 +1086,10 @@ static int connect_ring(struct backend_info *be)
 			return -ENOMEM;
 		}
 
-		for (i = 0; i < be->blkif->nr_rings; i++) {
+		for (i = 0; i < blkif->nr_rings; i++) {
 			memset(xspath, 0, xspathsize);
 			snprintf(xspath, xspathsize, "%s/queue-%u", dev->otherend, i);
-			err = read_per_ring_refs(&be->blkif->rings[i], xspath);
+			err = read_per_ring_refs(&blkif->rings[i], xspath);
 			if (err) {
 				kfree(xspath);
 				return err;
-- 
2.7.4

