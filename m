Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC9BC282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD70222CF
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w81dAFmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfBMJxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbfBMJxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mp4X163899;
        Wed, 13 Feb 2019 09:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=8RLfCTrDcrzJnlGUfPMBd1ABpR9q+jsNRstFzMVJu+o=;
 b=w81dAFmofZMmWa21i3wr9TmwSX5qfFtjkthb0W67XpL7Xq1/JBecgIgOlRDNXUCsFFnP
 hs7CU/nrWETS5Sgwz2qeIQhK6KJ2jMyt12vuhZzxAQtQ3jhFYWUGpFSxk3XEt2nPcFVx
 f9Y3T5sSobraXLu5rJInoEnyacREzfjMZJt3hD2GbytxIvxDypJNnlzmfEDs+2r7uOUp
 0Rec377BjerVyUkGBs0rZxbNg+9OSavPo6nV1q/uq5VJC1dThrNfVtIYZwbS5+BHYey1
 CvsfbZC8FuGcF/qIRJljPJfdcZtZ5n7439i+EuU5w9GO6AgcgkMs6DZq84Y9i883PxE1 7Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qhree11s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rQ1K029677
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:26 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rQ9O000533;
        Wed, 13 Feb 2019 09:53:26 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:25 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH v2 3/9] md:raid1: set mirrors correctly
Date:   Wed, 13 Feb 2019 17:50:38 +0800
Message-Id: <20190213095044.29628-4-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=912 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In stack layer case, the mirror of upper layer device is the sum of mirrors of
all lower layer devices.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/md/raid1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1e5a51f22332..0de28714e9b5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3050,6 +3050,7 @@ static int raid1_run(struct mddev *mddev)
 	struct md_rdev *rdev;
 	int ret;
 	bool discard_supported = false;
+	unsigned long mirrors = 0;
 
 	if (mddev->level != 1) {
 		pr_warn("md/raid1:%s: raid level not set to mirroring (%d)\n",
@@ -3084,11 +3085,15 @@ static int raid1_run(struct mddev *mddev)
 	rdev_for_each(rdev, mddev) {
 		if (!mddev->gendisk)
 			continue;
+		mirrors += blk_queue_get_mirrors(bdev_get_queue(rdev->bdev));
 		disk_stack_limits(mddev->gendisk, rdev->bdev,
 				  rdev->data_offset << 9);
 		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
 			discard_supported = true;
 	}
+	if (mddev->queue)
+		if (!blk_queue_set_mirrors(mddev->queue, mirrors))
+			return -EINVAL;
 
 	mddev->degraded = 0;
 	for (i=0; i < conf->raid_disks; i++)
-- 
2.17.1

