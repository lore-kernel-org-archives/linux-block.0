Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE4C35671
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 13:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFF820828
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 13:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dXWYyb26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBXNN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:13:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgBXNN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 08:13:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OD8TWE028070;
        Mon, 24 Feb 2020 13:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=dJGr99zHD0Q9XFx6gtERb1B1C3O2MITBpTCUfAe3Tw4=;
 b=dXWYyb26qv+lUJiFVNbmkAb8v9k98kfgsiDzrZ0tmPm76Z+McTBBmq+nrQAYm15Tvusx
 snU4JBaAzWRCh73k4Cv6whHWTm3aQ+f3/d/Hv7v5xtQycWGhv/QHCu0jN2NdXzQMAt2W
 03InSdrnNxKQbrDMsZMU3bcQQeA/wxA0+ayuCX3sKTRvyNBLXlagm0beFFbkAWzAm09w
 jCCRrmMjuUWSM+eiukRqY/O1WCmqqGNJayHVStfS6k/OTSa1QvJs9dI9N7FocBO0wXs9
 z3x4wfCOpPHDS4Ajum7Kk8S6qt/Dh6AgVQszsp8KF/lFFRRGDoxBpVL9YdC7W2X2MMCF gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yavxrf55b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 13:13:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ODBsUO077515;
        Mon, 24 Feb 2020 13:13:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ybe116wxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 13:13:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01ODDMBR023955;
        Mon, 24 Feb 2020 13:13:22 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 05:13:22 -0800
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        Bob Liu <bob.liu@oracle.com>
Subject: [PATCH] block/bio-integrity: simplify the way of calculate nr_pages
Date:   Mon, 24 Feb 2020 21:12:58 +0800
Message-Id: <20200224131258.18156-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240107
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove unnecessary start/end variables.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 block/bio-integrity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25..575df98 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -202,7 +202,6 @@ bool bio_integrity_prep(struct bio *bio)
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
 	struct request_queue *q = bio->bi_disk->queue;
 	void *buf;
-	unsigned long start, end;
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
 	unsigned int intervals;
@@ -241,9 +240,7 @@ bool bio_integrity_prep(struct bio *bio)
 		goto err_end_io;
 	}
 
-	end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	start = ((unsigned long) buf) >> PAGE_SHIFT;
-	nr_pages = end - start;
+	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Allocate bio integrity payload and integrity vectors */
 	bip = bio_integrity_alloc(bio, GFP_NOIO, nr_pages);
-- 
2.9.5

