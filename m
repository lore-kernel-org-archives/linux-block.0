Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB54C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 05:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E56520657
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 05:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0M54NWx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbfAGFdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 00:33:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33366 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAGFdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 00:33:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x075SxNo085244;
        Mon, 7 Jan 2019 05:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=/0rNv2p4CzA4wws7RsCXPLy6DpLH7z0aeBw/27C1jmk=;
 b=0M54NWx0lwXQ6YTFdyL5nZaNCB/JuXuc6Mxxx7n7Gqz4dtLvCDDzRytXEj50w8/Nug6z
 TUiV9JiC1wl4TE0FuFCoIZXTEUFp72mN+HzkZL05V2PVBHNLD8CAfGIn5AlX5QQrAAvG
 iXn50xqoZGVXfS+DjKCqBWeCMJbQ89OQ/ZH87fnYW6yAaBbVGckucGVPqtCGP8HfSmNY
 IwW9L7GVmcdpwbm4Tq5Pk8JRyMutBrjbK/fFgiH2TJ/0xSPAEnPxzo0bhy8ohMdBAGQs
 vo0ZpSoLkCHbvoJI1ofGE3yqHvwP3W7IkgiuErwnmOR7a3c528yOuK39YWJE7ZRzmptu WA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ptm0tut5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 05:33:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x075WxUb024097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 05:32:59 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x075WwQ6029983;
        Mon, 7 Jan 2019 05:32:59 GMT
Received: from linux.cn.oracle.com (/10.182.69.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 06 Jan 2019 21:32:58 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        Paul.Durrant@citrix.com
Subject: [PATCH v4 1/2] xen/blkback: add stack variable 'blkif' in connect_ring()
Date:   Mon,  7 Jan 2019 13:35:58 +0800
Message-Id: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9128 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070048
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As 'be->blkif' is used for many times in connect_ring(), the stack variable
'blkif' is added to substitute 'be-blkif'.

Suggested-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
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

