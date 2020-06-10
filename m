Return-Path: <SRS0=qLys=7X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E2C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 17:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AD820734
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o/K8gaqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFJRYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:24:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52436 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJRYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 13:24:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AHMcxD148306;
        Wed, 10 Jun 2020 17:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=xWK0SsPzdRxAbm5qxbxrT1uitLDVumqDlSt+PmBeNPI=;
 b=o/K8gaqDeyqshGD4gsikjHIw/FkJ7XOsyZN9xWiJ7TXbJrutOd8hDhUf1WzwchYnGl5Y
 B5ipiiH71U4TxiyLtiqq4efUO0qOursSupifIiBq34uebPQWCy4Ezj4vNP+3LWi58uri
 my00yvxmlUM69JpX4nimPwj18Zt5aKCh2P6qJDMB6tc4GrNBE4mErXaa51ShRyhoMh3x
 4f4ZW4soc0/w8ofFGP0g1pDrR6N6giTsw6r1Vht0GHkXb6sfYds+jY/C2I8osqzZ6BsE
 kEa2NLY033Z7kY3gUdumC0llqtsZx9XpEjgUz6PwnITkGPwW7uv0Zyjq6XPHU1mW3WxE Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3sn3hes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 17:24:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AHNjfF099623;
        Wed, 10 Jun 2020 17:24:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31gn2ytpc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 17:24:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05AHO5RP012671;
        Wed, 10 Jun 2020 17:24:07 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 10:24:05 -0700
Date:   Wed, 10 Jun 2020 20:23:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] rsxx: Fix potential NULL dereference setting up debugfs
Message-ID: <20200610172359.GB90634@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "card->gendisk" pointer is allocated in rsxx_setup_dev() but there
is a module option "enable_blkdev" which lets people disable the block
device.  In that situation the "card->gendisk" pointer is NULL and it
would lead to a NULL dereference here.

Fixes: 36f988e978f8 ("rsxx: Adding in debugfs entries.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This patch is from static analysis.  The patch is obviously harmless.
So far as I can tell, the bug is real.  But maybe a different solution
is prefered?

 drivers/block/rsxx/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 10f6368117d81..6207449fa716f 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -228,6 +228,9 @@ static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 	struct dentry *debugfs_pci_regs;
 	struct dentry *debugfs_cram;
 
+	if (!card->gendisk)
+		return;
+
 	card->debugfs_dir = debugfs_create_dir(card->gendisk->disk_name, NULL);
 	if (IS_ERR_OR_NULL(card->debugfs_dir))
 		goto failed_debugfs_dir;
-- 
2.26.2

