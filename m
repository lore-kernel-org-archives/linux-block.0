Return-Path: <SRS0=kuF4=CO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755DC43461
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 12:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7102072D
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 12:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XGtHY7HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgIEMwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:52:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIEMwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Sep 2020 08:52:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085CnlfC046112;
        Sat, 5 Sep 2020 12:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=6zESj+OzV/BEb7y6Xdu+g+bYS9iPWu7pSQIdAlq9jp0=;
 b=XGtHY7HAT7XCqX5twIPmusk4VKCqiKKIrsC23pO7Ar3yx5wN3wXepNqhFVkDkaiLbtel
 BStaaOTHK29HGERhsGYX/itQyioPwyz82v3+viP/LxOFZijOzNRhZya7SHwdZAeGHAfZ
 uGpSzG/p1dEau+9EEQbHfvL21OXCgz9JN589kHO1+/qB9ahkqOB0fuIVLKYOU6aQidmo
 OpVCDctUPXIdBbBoI8RqKJCDajtDsk9ZexiIE0VV6J2P3RNED8VGmKmCmHvX9ATcg1Yq
 EGV93rXaf43xiBISw8UCrjj3TWoECztUPPmnPNouyDzSc61jPFwTk2li2AATGMVGixS4 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33c23qh7b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 05 Sep 2020 12:52:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085CpGFL115484;
        Sat, 5 Sep 2020 12:52:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33c20hrayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Sep 2020 12:52:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 085CqC0q019757;
        Sat, 5 Sep 2020 12:52:14 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Sep 2020 05:52:11 -0700
Date:   Sat, 5 Sep 2020 15:52:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] blk-mq: Fix refcounting leak in __blk_mq_register_dev()
Message-ID: <20200905125206.GE183976@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050123
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a kobject_add() hidden in the call to kobject_add().

	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
                                      ^^^^^^^^^^^^^^^^^^^^^^^

It needs to be release on the error path.

Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 block/blk-mq-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 062229395a50..5a63659163c1 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -321,7 +321,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
-		goto out;
+		goto out_kobj;
 
 	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
@@ -333,8 +333,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	q->mq_sysfs_init_done = true;
 
-out:
-	return ret;
+	return 0;
 
 unreg:
 	while (--i >= 0)
@@ -342,6 +341,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
+out_kobj:
 	kobject_put(&dev->kobj);
 	return ret;
 }
-- 
2.28.0

