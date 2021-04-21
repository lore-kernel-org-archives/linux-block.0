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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD145C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8707E61449
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhDUKTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:19:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59862 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbhDUKTX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 06:19:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAF67u048515;
        Wed, 21 Apr 2021 10:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=NeK84gnoNqVysfeyXYFbCqb738dTlOAvISWFExp8Ypg=;
 b=HaRD6zEdDaw/42yXRYPAiDDAG1/waogxKSLVi5X62ZBvLdmvn0C09XFHPHjDfxGJH4rA
 eQWm1mJCLVCGQURJ+yCtASPZRf4sViZq/reIF9wnKgb3ne9FcXmtO5h/dCK2XGMMZoeN
 OY+0OJ0f6jMX/jSdDbemChNXd5KiFHt0A0Zong9M+8rOqd0o5BGsguk+hkwCX1p15X/H
 CNE5ql7eQwXO1xsoNsFN8XWoibIDMRzkhkCdrEmfbEibMfcLexw+Pu9BuZV60d7PYQOu
 Slkx4rxbYd2dKFwd2pabXVFNw8R6GykaBATWv+nGFiPKK5eSvH5Bfp4EuvwcZE7QXVyh RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37yveahgaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:18:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAAqll084575;
        Wed, 21 Apr 2021 10:18:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m0cm4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:18:45 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LAAwdX084933;
        Wed, 21 Apr 2021 10:18:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3809m0cm3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:18:44 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13LAIgW7014720;
        Wed, 21 Apr 2021 10:18:42 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 03:18:42 -0700
Date:   Wed, 21 Apr 2021 13:18:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] ataflop: potential out of bounds in do_format()
Message-ID: <YH/7+65JruUO/wsg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: uXnpRIXHCSPgWHcg8dgTm5ru2z8xmkSJ
X-Proofpoint-ORIG-GUID: uXnpRIXHCSPgWHcg8dgTm5ru2z8xmkSJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210078
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function uses "type" as an array index:

	q = unit[drive].disk[type]->queue;

Unfortunately the bounds check on "type" isn't done until later in the
function.  Fix this by moving the bounds check to the start.

Fixes: bf9c0538e485 ("ataflop: use a separate gendisk for each media format")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/ataflop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 104b713f4055..aed2c2a4f4ea 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -729,8 +729,12 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	unsigned long	flags;
 	int ret;
 
-	if (type)
+	if (type) {
 		type--;
+		if (type >= NUM_DISK_MINORS ||
+		    minor2disktype[type].drive_types > DriveType)
+			return -EINVAL;
+	}
 
 	q = unit[drive].disk[type]->queue;
 	blk_mq_freeze_queue(q);
@@ -742,11 +746,6 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	local_irq_restore(flags);
 
 	if (type) {
-		if (type >= NUM_DISK_MINORS ||
-		    minor2disktype[type].drive_types > DriveType) {
-			ret = -EINVAL;
-			goto out;
-		}
 		type = minor2disktype[type].index;
 		UDT = &atari_disk_type[type];
 	}
-- 
2.30.2

