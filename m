Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53590C43460
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6861447
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhDUKUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:20:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbhDUKUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 06:20:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAJbJC177096;
        Wed, 21 Apr 2021 10:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=SlRAyGU25dwXwyv5aZOPm9CgJNtYNYlpX2MTdvyihHk=;
 b=ZbJrVhQJ222SMc3ou6XiqVlioU67X954DehKzrms1yMXSxFiOgbH1Bzpi1m1cyQiuRDd
 01J6HsYzQ9ODakHe2N3RaLwCgbVGKsYIYqeb4UL4YmfXigjeIQS9HfnD2alGWRm16XEd
 mxsvz0kmOvrDh02+4S3aKygq5HJZUPo2ilbYSmrz9aeGYFOXdM8fwrze3B2Mrzy+rKQ5
 +G+X0qkCr1hPY3LAJDDpvZeiXinvo8CQ/wGpGyPQYU0MXGaGVSvQXBQZ0IxWo5Yg8FFm
 R2X9GAKevy/2wzaJYSzWYjVh1/5P87BGsG1DwgC5GN8cwCCbIsh6dVCE1TAOk0T5eDSL TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38022y17fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:19:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAAwvH050981;
        Wed, 21 Apr 2021 10:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rhf1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:19:53 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LAFFQl063101;
        Wed, 21 Apr 2021 10:19:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 38098rhf0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:19:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13LAJqHq015371;
        Wed, 21 Apr 2021 10:19:52 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 03:19:51 -0700
Date:   Wed, 21 Apr 2021 13:19:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] ataflop: fix off by one in ataflop_probe()
Message-ID: <YH/8QdfDxhjGjXHG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/7+65JruUO/wsg@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: MpqaWVj0MZOzOsX3HfwIMjt7dd3juTo-
X-Proofpoint-GUID: MpqaWVj0MZOzOsX3HfwIMjt7dd3juTo-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210079
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Smatch complains that the "type > NUM_DISK_MINORS" should be >=
instead of >.  We also need to subtract one from "type" at the start.

Fixes: bf9c0538e485 ("ataflop: use a separate gendisk for each media format")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/ataflop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index aed2c2a4f4ea..d601e49f80e0 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2001,7 +2001,10 @@ static void ataflop_probe(dev_t dev)
 	int drive = MINOR(dev) & 3;
 	int type  = MINOR(dev) >> 2;
 
-	if (drive >= FD_MAX_UNITS || type > NUM_DISK_MINORS)
+	if (type)
+		type--;
+
+	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
 		return;
 	mutex_lock(&ataflop_probe_lock);
 	if (!unit[drive].disk[type]) {
-- 
2.30.2

