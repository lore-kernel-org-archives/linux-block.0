Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B30FC3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C1F24699
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jXVT0aQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1RWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:22:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1RWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 12:22:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SGwhdf096694;
        Fri, 28 Feb 2020 17:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=vKPu2mMAjTiqlFxO4uxuAPCi1fYk+P4CN6J0gVfkdpY=;
 b=jXVT0aQROfFszL0/BeTk6T9LK8hYmrYE0EUfnEwqMExYtEpk3VI9wOg5GFilBEoHFJCK
 VJf/gS2Jp0SZ8G8gnDVthFiNoHNUb5K4NuUZfFmg06q3+rklhKXByqRLJ4Gx+VVTxwcU
 GtooBoWvePDeklqconkjQJvrPLiJzY5byvQ0B7LKMpS3N6nyodNpWAQeZB+0Y3TagfWI
 KOOR2YHJD/M9swWdhfi1ch65Di2Q66KGWYhTXQyRvF67KDmize0QRF+jq8/YzUxJoAU6
 bCjvjyi9qtDZp5teOvK2mZVWwqR8cEM0d0/jNIas1+xiGbdUrXD5ZBSnJrkO4ZpG0EeC sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ydct3m73t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 17:21:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SHEr9N156479;
        Fri, 28 Feb 2020 17:21:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ydcsf1pms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 17:21:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SHLm1Z005721;
        Fri, 28 Feb 2020 17:21:51 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 09:21:47 -0800
Date:   Fri, 28 Feb 2020 20:21:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Subject: [PATCH resend] loop: Fix IS_ERR() vs NULL bugs in
 loop_prepare_queue()
Message-ID: <20200228172136.h5dvwvrg5yfywxss@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The alloc_workqueue() function returns NULL on error, it never returns
error pointers.

Fixes: 29dab2122492 ("loop: use worker per cgroup instead of kworker")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
Resending because this goes through your -mm tree, Andrew.  The
get_maintainer.pl script lead me astray.

 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da8ec0b9d909..a31ca5e04fae 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -897,7 +897,7 @@ static int loop_prepare_queue(struct loop_device *lo)
 					WQ_UNBOUND | WQ_FREEZABLE |
 					WQ_MEM_RECLAIM,
 					lo->lo_number);
-	if (IS_ERR(lo->workqueue))
+	if (!lo->workqueue)
 		return -ENOMEM;
 
 	return 0;
-- 
2.11.0

