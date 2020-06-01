Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497EEC433E1
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 01:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218FF207F7
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 01:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cLUts0ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFABZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 May 2020 21:25:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFABZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 May 2020 21:25:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0511GinO029800;
        Mon, 1 Jun 2020 01:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=soZUl3/aG71B/k1/PkbJ+p5RT1UVgYuZaKnNxUhQBZQ=;
 b=cLUts0ESlycTaC43qJFEbYb8aatoCeqGpMO5URaI1Pj0xj2YblgyKW2pyn2M/npwP5Z8
 i2ctIYHGlfBzcTrCVKqFuA7d8E9uOA+FnRUI9icQwAGIAWedi1o188gUAz8pJR6YflRR
 ytCwN5cfFLfD8p7bllUq9mftkuROx2JXlb4/Bs901p4buqd/L8NMrOfbxiRVU4Uuvz2H
 PuG1cae4Guh56jxJhNZje2EviJ1ga5kQZ2AScRYy65ZaiKJd2SlQlIaPQRzKvF0WMk3y
 WkdZKqn5ugZ3dKsWgYCu3TCf7WcyNGg89QkzkQRTXjdPo06VTjfcWyBRHsb/yce8d1Ta jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfekv95q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 01:24:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0511HwGX053015;
        Mon, 1 Jun 2020 01:23:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31c25h5dmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 01:23:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0511NuSp001716;
        Mon, 1 Jun 2020 01:23:58 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 May 2020 18:23:56 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     nbd@other.debian.org, linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nbd: append module param and description following corresponding variables
Date:   Sun, 31 May 2020 18:16:01 -0700
Message-Id: <20200601011602.29381-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601011602.29381-1-dongli.zhang@oracle.com>
References: <20200601011602.29381-1-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=8 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=8
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006010008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A lot of drivers append the module parameter and its description following
the corresponding variables (e.g., 'g_submit_queues' in null or
'admin_timeout' in nvme).

This patch would do the same for 'nbds_max' and 'max_part' in nbd driver.
This makes it much more friendly to cscope when reading the code.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/nbd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..74c1363702f5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -146,7 +146,13 @@ static struct dentry *nbd_dbg_dir;
 #define NBD_DEF_BLKSIZE 1024
 
 static unsigned int nbds_max = 16;
+module_param(nbds_max, int, 0444);
+MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
+
 static int max_part = 16;
+module_param(max_part, int, 0444);
+MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
+
 static int part_shift;
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
@@ -2444,8 +2450,3 @@ module_exit(nbd_cleanup);
 
 MODULE_DESCRIPTION("Network Block Device");
 MODULE_LICENSE("GPL");
-
-module_param(nbds_max, int, 0444);
-MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
-module_param(max_part, int, 0444);
-MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
-- 
2.17.1

