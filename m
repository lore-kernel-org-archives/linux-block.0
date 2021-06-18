Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F6C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A8F613E2
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhFRNrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:47:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40144 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbhFRNrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 09:47:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IDgsAD030678;
        Fri, 18 Jun 2021 13:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=1YJmO/I1GDlFwi4XZmigbTFuokV86Zbeko9gDrEF1/I=;
 b=Bmk1fMwj72Ots9R4lglavhaUszBYlytRRDqstKfX71U5DHlbEWkF2/fN1GEk0ioRwP3f
 Ie18W2/bmgI9QVOT3zOTXPwDfdPdFEN+UOQmeqe/5uwH59J0eWtSADl1/bVsBK0/pWwu
 LrypYCnZBwLPDnTGg7t0NLhkLT67xy6pHsRmxF5cnh3+dYE5UWD5+1SH+HiCy3XyWF63
 aq/lftbZ2yhwhxARxlZlBAaEflvkUgUuI9JHsFlgGxBcfwBU2yb2rEilRk4npf9f1VV6
 QG0QETSiPXZxuco+vUrsyZcG1738ZFBG3r6jz4PunLEMShqp5NwzsCEVkVAwxI+iK85n CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptm1xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:45:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IDfIXN086792;
        Fri, 18 Jun 2021 13:45:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 396waxy6va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:45:35 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IDjZRo107358;
        Fri, 18 Jun 2021 13:45:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 396waxy6uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:45:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15IDjTNe005044;
        Fri, 18 Jun 2021 13:45:31 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 06:45:29 -0700
Date:   Fri, 18 Jun 2021 16:45:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] blk-mq: fix an IS_ERR() vs NULL bug
Message-ID: <YMyjci35WBqrtqG+@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: yL8gISbLYqOgcWJJTp8Zu8tet7fAEC1U
X-Proofpoint-ORIG-GUID: yL8gISbLYqOgcWJJTp8Zu8tet7fAEC1U
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The __blk_mq_alloc_disk() function doesn't return NULLs it returns
error pointers.

Fixes: b461dfc49eb6 ("blk-mq: add the blk_mq_alloc_disk APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 include/linux/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 02a4aab0aeac..fd2de2b422ed 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -431,7 +431,7 @@ enum {
 	static struct lock_class_key __key;				\
 	struct gendisk *__disk = __blk_mq_alloc_disk(set, queuedata);	\
 									\
-	if (__disk)							\
+	if (!IS_ERR(__disk))						\
 		lockdep_init_map(&__disk->lockdep_map,			\
 			"(bio completion)", &__key, 0);			\
 	__disk;								\
-- 
2.30.2

