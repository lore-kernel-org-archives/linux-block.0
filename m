Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF9CA9EC3
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 10:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB372086D
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 10:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/Z7ghEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfJaKxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:53:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfJaKxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 06:53:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAnUBQ188245;
        Thu, 31 Oct 2019 10:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=D9Nzf3Ko7p2zNPurG7+dCpyN8iR6FjyZUSA28aOPZDs=;
 b=k/Z7ghEEacd/WV2pC4P0YWtULQ6FAVG4OqvqdXUCyS5wRQv1ke3Tvj2kdmoqDNsdrzsb
 8sDsIV/Z5oO1n1oRrl5bRTjd6UXWDG40AL2mU2+SRiE3h9JlkauNNsl9OglIgFVWhgKj
 D3U8dikt+qNQR/Y4jN0jACxKPxH5ajIKpCKOsI+yWrsw6QTuT1TGUEFWaSZ1b/nLAGeg
 CWHPsRPvMVrMUSaoc2+AUSg+Vkatphw/Buqty9azbdBHCaZ7x4oaGXXnl+VJhUvqz3V5
 S1wGh8PL0cNQyvi9qtAAYxTp3UjVKJen0VvX60/qBOsQnDpU/QJxk+cllWUxf9wzIrPS eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vxwhftc20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:53:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAqaWd157989;
        Thu, 31 Oct 2019 10:53:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vysbtx97f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:53:49 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9VArmmG010799;
        Thu, 31 Oct 2019 10:53:48 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:53:48 -0700
Date:   Thu, 31 Oct 2019 13:53:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iocost: don't nest spin_lock_irq in ioc_weight_write()
Message-ID: <20191031105341.GA26612@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This code causes a static analysis warning:

    block/blk-iocost.c:2113 ioc_weight_write() error: double lock 'irq'

We disable IRQs in blkg_conf_prep() and re-enable them in
blkg_conf_finish().  IRQ disable/enable should not be nested because
that means the IRQs will be enabled at the first unlock instead of the
second one.

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2a3db80c1dce..a7ed434eae03 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2110,10 +2110,10 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 			goto einval;
 	}
 
-	spin_lock_irq(&iocg->ioc->lock);
+	spin_lock(&iocg->ioc->lock);
 	iocg->cfg_weight = v;
 	weight_updated(iocg);
-	spin_unlock_irq(&iocg->ioc->lock);
+	spin_unlock(&iocg->ioc->lock);
 
 	blkg_conf_finish(&ctx);
 	return nbytes;
-- 
2.20.1

