Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3A7CA9EC3
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653352087F
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rNyrMxAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfJaKz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:55:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35394 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaKz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 06:55:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAsNb4192100;
        Thu, 31 Oct 2019 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=tm+ynhomfiVzszaGXuALO61BT3GqIPJ1petNTHqSuA4=;
 b=rNyrMxADWHmk/W0nX15kbwSzDYNeeFUpT7c0LDL4KRxvxXAKnWhBYVSkNaGWSYaOMD8A
 gWpq121IvjGexVQMbY3iYBnho72bcrbhR8bBXaR1fB6yLbwi57sh+FprEZyFLjvvyOSQ
 nmTEyRFX47RfI8krXyHu+T1XBIWYpUFvJQYG92XzGtqEyzfolVHk40XkO0CEfpEtR5RN
 WY9ZNE99zZRnkfUVT0Nx2OWmtqEeL/XcTU4BJoXkz3RZj/JSVSQAoEtmcWHe47vTWU+w
 lbA9u3uhzQbJGpYPBBK+qJrn8HjqTEEvXYtkdcK5Lqdml/YX6732lO1H3VUwbPxx+9nY HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vxwhftcag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:55:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VAqlgh047316;
        Thu, 31 Oct 2019 10:55:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vyqpdvky1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:55:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9VAtrJH014719;
        Thu, 31 Oct 2019 10:55:53 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:55:53 -0700
Date:   Thu, 31 Oct 2019 13:55:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] io_uring: signedness bug in io_async_cancel()
Message-ID: <20191031105547.GC26612@mwanda>
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
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310111
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem is that this enum is unsigned, and we do use "ret" for the
enum values, but we also use it for negative error codes.  If it's not
signed then it causes a problem in the error handling.

Fixes: 6ec62e598211 ("io_uring: support for generic async request cancel")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c4cdfe16cba7..9dcbde233657 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2144,8 +2144,8 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			   struct io_kiocb **nxt)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	enum io_wq_cancel ret;
 	void *sqe_addr;
+	int ret;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
-- 
2.20.1

