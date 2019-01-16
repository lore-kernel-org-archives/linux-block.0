Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32744C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA68520859
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 13:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdO+z5DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbfAPNqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:46:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57690 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390707AbfAPNqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 08:46:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0GDdDUH166178;
        Wed, 16 Jan 2019 13:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=xxgXSWUT67f49fw4ZpzihxahKicR2Mjqt7I/SL7+Cmg=;
 b=cdO+z5DLtcsFK3gbvaqFIjXvV+MXR1xm8AC5+nxPN62rXmu/Z4m6adcue9LIh3gZzJmA
 KPhaqTjyW1qN79JxBXkVPMgtZOk/G3HbHal79Plku2x4yomXj0kG4PGBHNUMR8W6afgo
 NV+OMkh1emG2Ya6SjrRaJD2nmwauD0vxjfwhP2bX8VaXhxZgxu8B0dyCaU7qGV9kDTBM
 MJhZEArAj2l565wPKLgiIW2w4Sz5heNwF2A3Ku9dG4Hnp8GyLeD4BBt835XXsRkIQMaC
 U3tqsw5ffPsCEQryTfmH6hSYDnkblmyn9k9zu0ltteCWqOMffvulJprDYJ/XLrYKao0S 0A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pybjs9yuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 13:45:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0GDjRfg008788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 13:45:27 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0GDjQoO006720;
        Wed, 16 Jan 2019 13:45:26 GMT
Received: from linux.cn.oracle.com (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 05:45:26 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Subject: [PATCH 1/1] xen-blkback: do not wake up shutdown_wq after xen_blkif_schedule() is stopped
Date:   Wed, 16 Jan 2019 21:47:41 +0800
Message-Id: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160114
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to wake up xen_blkif_schedule() as kthread_stop() is able
to already wake up the kernel thread.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/xen-blkback/xenbus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e..37ac59e 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -254,10 +254,8 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 		if (!ring->active)
 			continue;
 
-		if (ring->xenblkd) {
+		if (ring->xenblkd)
 			kthread_stop(ring->xenblkd);
-			wake_up(&ring->shutdown_wq);
-		}
 
 		/* The above kthread_stop() guarantees that at this point we
 		 * don't have any discard_io or other_io requests. So, checking
-- 
2.7.4

