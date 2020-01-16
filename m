Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B646C33CB2
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 02:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1B24671
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSZmf9uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAPCh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:37:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50748 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgAPCh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 21:37:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G2YaqH070122;
        Thu, 16 Jan 2020 02:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=a2BsJDAF+XwJHKVGuK8ukr3WnbL66NAyLIcMJnXYrvA=;
 b=NSZmf9ukonOy90FVEA43GAp02D1cXXUOfwAxXzeU7kZATNE6rYcVQvd7bLz/R5Uj32VH
 JMj2ZXPCgBMkrRgo2RdBJhTDdc8jNBzE6yclhREF/ob1R1oi7wB1CwFHPnWZ3AZWtOU1
 PTOau9AmlYlMywtPDr+ohNImYBdQ78ByZZm7xFF/I92hjbmgT+S+jvAryJ2BTx22hiKV
 RDRO3BmtnYJtZUUK8GVT7G5qVp+PX/J8d9PmAOPEbgpGtkFll4NWkKUeyiOhcuVxcwsk
 qHGMNUnh1YN+gFglJrTyEEUQu9BQvOfbu4g9awIwC+zM8EabA+3BVNzagPPAiLMFY9rX Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73yqu4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 02:37:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G2YM66026530;
        Thu, 16 Jan 2020 02:37:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xhy22fea5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 02:37:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00G2br75030536;
        Thu, 16 Jan 2020 02:37:53 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 18:37:53 -0800
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling io_issue_sqe()
Date:   Wed, 15 Jan 2020 18:37:46 -0800
Message-Id: <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
so acquire ctx->uring_lock beforehand similar to other instances of
calling io_issue_sqe().

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d015ce8..7b399e2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4359,7 +4359,9 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		req->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
 		req->in_async = true;
 		do {
+			mutex_lock(&req->ctx->uring_lock);
 			ret = io_issue_sqe(req, NULL, &nxt, false);
+			mutex_unlock(&req->ctx->uring_lock);
 			/*
 			 * We can get EAGAIN for polled IO even though we're
 			 * forcing a sync submission from here, since we can't
-- 
1.8.3.1

