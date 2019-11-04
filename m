Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45CCA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 10:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BED21929
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 10:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ACMDSvzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDKSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:18:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58830 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDKSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 05:18:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4A8Geg180234;
        Mon, 4 Nov 2019 10:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=n4z6yY3cjmuea5DEJWf/55zw6urF7hHTqiKHjMTvZmI=;
 b=ACMDSvzQ7F42D+/QznGerfRA5g/qmKY/Ss2aYWGsxNzcgk7Bw6A4ryooByiHaXCtRqW9
 QndKOQGQ3k3+nR4Ac31PFa1QPXDuaD7q0FvSVsZ/sXHP4LEDX6Veq+3KZ5jCg+qojghv
 XT3oxjiKkTnCv86ShKARfAOhlBvfj8IQXdDeBBJPmGabm4qZfvRWcLamWudKluTlS7QB
 acVMcACAgilO+uNML5R63guKok2XVidOH5b91uHqkKW27JUlBUD9qlY07d4Am9ecPG3C
 wCcF99SYNp5TV+qlAnjmnA8Kl+HpnMGq93xAzVtU1BSF7CLswk7cGr/Ep2dr26KefLc+ TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w117tpamk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:18:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4A7cMO177113;
        Mon, 4 Nov 2019 10:18:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w1k8ughp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:18:20 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4AIIo3015795;
        Mon, 4 Nov 2019 10:18:18 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 02:18:18 -0800
Date:   Mon, 4 Nov 2019 13:18:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iocost: add a comment about locking in ioc_weight_write()
Message-ID: <20191104101811.GA20821@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49d0ebd2sl.fsf@segfault.boston.devel.redhat.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040101
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It wasn't very clear that blkg_conf_prep() disables IRQ and that they
are enabled in blkg_conf_finish() so this patch adds a comment about it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't know if it's too late to fold this in with the previous patch?

 block/blk-iocost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a7ed434eae03..c5a8703ca6aa 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2095,6 +2095,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 		return nbytes;
 	}
 
+	/* blkg_conf_prep() takes the q->queue_lock and disables IRQs */
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, buf, &ctx);
 	if (ret)
 		return ret;
@@ -2115,6 +2116,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	weight_updated(iocg);
 	spin_unlock(&iocg->ioc->lock);
 
+	/* blkg_conf_finish() unlocks the q->queue_lock and enables IRQs */
 	blkg_conf_finish(&ctx);
 	return nbytes;
 
-- 
2.20.1

