Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB0C433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CFE207F7
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 01:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8Ab3XgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgFABZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 May 2020 21:25:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45243 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgFABZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 May 2020 21:25:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0511IC0j057545;
        Mon, 1 Jun 2020 01:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=td7ltNIq9vnxMbVKRde7yqiRKFmy/LqJyJcn1ndS+kU=;
 b=n8Ab3XgMlCN6B4OyOhMv0j4wIs84quvD88iDTc41qoZAEA+OGw1EXKMZQlGkHDuagdTr
 ETY3B5q5eB/WpSHJ7q7zBTtrthHVRYz4Oq/S7249Uxpps9ctVtEzJN4FfXoKoabSCSu1
 cXRSS9RKUdkcggyFCmeQUweYO+Vq7v7tBm9D/eYG0ZcLsjoruAVA7SKmYuaMionHFzo5
 demGW9a+0wublKjJ0oFAL6F9V9osMaRj0+QHEjyMuQ2wZKxR2opUt1igKmvM8dO2wGXd
 cZDfi458VXWIqd/2WYgSpxkjmR5SEYN1FHlvWGMUbSArDOFb6qPvDFKmuZg4cN0JPCP8 Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31bewqmbsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 01:24:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0511HsR8042839;
        Mon, 1 Jun 2020 01:24:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31c18qq0mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 01:24:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0511NufU003986;
        Mon, 1 Jun 2020 01:23:58 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 May 2020 18:23:56 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     nbd@other.debian.org, linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nbd: remove unused 'NBD_MAGIC'
Date:   Sun, 31 May 2020 18:16:02 -0700
Message-Id: <20200601011602.29381-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601011602.29381-1-dongli.zhang@oracle.com>
References: <20200601011602.29381-1-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=8 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=8 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove 'NBD_MAGIC' as it is not used since commit 5ea8d10802ec ("nbd:
separate out the config information").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/nbd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 74c1363702f5..83435ce141a8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -141,8 +141,6 @@ static struct dentry *nbd_dbg_dir;
 
 #define nbd_name(nbd) ((nbd)->disk->disk_name)
 
-#define NBD_MAGIC 0x68797548
-
 #define NBD_DEF_BLKSIZE 1024
 
 static unsigned int nbds_max = 16;
-- 
2.17.1

