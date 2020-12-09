Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A67C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 06:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E8223B84
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 06:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgLIGxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:53:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49642 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgLIGxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 01:53:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B96nWCK080174;
        Wed, 9 Dec 2020 06:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+IT8Yy3kgKxWkKlqQ1luhnWnmuHtXoAMtQWH8bcVOmQ=;
 b=D5Fj1RxXSsgfhEI/ojWP6HjJpZT6TqGLbbmkCPg9fXva8Sg6cxMGBqOXpdkdQYtEUpMo
 4apzWem00crvO6OouSWXFZRFzisX6RVRwm8AlOeM8q/b3qsgfT2u/UE/tT/lD0BILB4q
 K1yU6uhCOHJsKvPEfBaiLTPv/9vcd/c+/L2Y2Qlstfwp6lXYR0sRW9OpI8wtDlSkV13D
 bnGMSElAO6u9JNEaNeYhUPIgt2Rr4E2zDE7qNwe4cMlrsqLBOJ0vVMIxc6Z9S0JAtLY3
 SGqPZsZe0s47tdtCbBMuJO9NHhif7VjgER0LqJDUIHoZW9QLEXVpmWTTd50pcTZ/tmwq SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 357yqbxmv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 06:52:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B96oZjC138647;
        Wed, 9 Dec 2020 06:52:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 358m3ytnp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 06:52:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B96qRj4002592;
        Wed, 9 Dec 2020 06:52:27 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 22:52:26 -0800
Date:   Wed, 9 Dec 2020 09:52:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] block/rnbd-clt: Fix error code in rnbd_clt_add_dev_symlink()
Message-ID: <X9B0IyxwbBDq+cSS@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090046
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "ret" variable should be set to -ENOMEM but it returns uninitialized
stack data.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index c3c96a567568..a5cd47b82b40 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -499,6 +499,7 @@ static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
 	dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
 	if (!dev->blk_symlink_name) {
 		rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
+		ret = -ENOMEM;
 		goto out_err;
 	}
 
-- 
2.29.2

