Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0370C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7182075A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tucfBu3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfBUPav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:30:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40990 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfBUPav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:30:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LFSnGG032797;
        Thu, 21 Feb 2019 15:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ikq01ZwB7jcQN90UQxvnJC+1ZRqG1jrn8saiOK3gjb4=;
 b=tucfBu3YF+9DlCGkLdIYgCno78ml6g6sZzcxk6rEuv03vXsBND0SmCaeFAaF8wBFFnIh
 4sV0UtdNf5j5cyZGBUhTCCvNEEx9l8j7GpwFlVMPsconDes9N/s1R6mBLcaptFT2WxMn
 tQLodj4wc+26rvdJH5YbqTL8OV3W9X/PNP0d4sWlRVNdO87oOmXQxIa72KcBDaaComAH
 hIJlMKAQEZYyjsNIXWXpeLL6otuauyXxLtyqBsNm3EmuAY9KcZNWfsRWiw9hoxPxLuAZ
 MyrYUFDhDZE6IsE7TTlkJC3h2gX/gJ4yte0v7nL1hkNoUUPwcCHoN7ra0QIen5O4H1AB jg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81egvey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:30:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFUe6H001916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:30:40 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFUdDC017841;
        Thu, 21 Feb 2019 15:30:40 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 07:30:39 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, jack@suse.cz
Subject: [PATCH v2 1/2] loop: do not print warn message if partition scan is successful
Date:   Thu, 21 Feb 2019 23:33:42 +0800
Message-Id: <1550763223-21764-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
References: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=997 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do not print warn message when the partition scan returns 0.

Fixes: d57f3374ba48 ("loop: Move special partition reread handling in loop_clr_fd()")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf55389..7908673 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1115,8 +1115,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 			err = __blkdev_reread_part(bdev);
 		else
 			err = blkdev_reread_part(bdev);
-		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-			__func__, lo_number, err);
+		if (err)
+			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
+				__func__, lo_number, err);
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
-- 
2.7.4

