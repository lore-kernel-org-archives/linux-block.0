Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B059C33CB6
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 02:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C96A22522
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="shFwYcWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAPCh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:37:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgAPCh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 21:37:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G2X7sw092328;
        Thu, 16 Jan 2020 02:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=wbCnNCbHsY4nfh4zcxYtHD/BSW30tysrUweL0DwahzM=;
 b=shFwYcWuPqNMSomf2Gv6J8KdYUN+KfS6bWbQNSR5pfyiqVEl+108NelPMUysVnWxJxkZ
 oW8V/iZr33HFOSRrLyORWCQ2qwrt3xjEgz1T7La11B9PPcEtZoC/3Yl+A849Ldm1zpCo
 1hJaN8C7mnJuTfsh+MqmtSGJeTDRfMbKVROYdC8R0jwJMcOnIx5l4ddxXdI00oKP9YIe
 AdNKQZkYi5w/XpTTxDdebH1j2gGlUdReu+mVv5khnYE4kn9uD5PMttL+PMdr4C8j/P1V
 WdvXgWmLz0zMhEyOgmDQPBzY5piCmc4uSRuVg9i4Qy8NuNUeKE3bcnbcOmNvBf+qcN8a pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74sftpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 02:37:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G2YNDf026658;
        Thu, 16 Jan 2020 02:37:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xhy22fe9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 02:37:53 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00G2brVR016896;
        Thu, 16 Jan 2020 02:37:53 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 18:37:52 -0800
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC 1/2] io_uring: clear req->result always before issuing a read/write request
Date:   Wed, 15 Jan 2020 18:37:45 -0800
Message-Id: <1579142266-64789-2-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=782
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=841 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

req->result is cleared when io_issue_sqe() calls io_read/write_pre()
routines.  Those routines however are not called when the sqe
argument is NULL, which is the case when io_issue_sqe() is called from
io_wq_submit_work().  io_issue_sqe() may then examine a stale result if
a polled request had previously failed with -EAGAIN:

        if (ctx->flags & IORING_SETUP_IOPOLL) {
                if (req->result == -EAGAIN)
                        return -EAGAIN;

                io_iopoll_req_issued(req);
        }

and in turn cause a subsequently completed request to be re-issued in
io_wq_submit_work().

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6ffab9aaf..d015ce8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2180,6 +2180,7 @@ static int io_read(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (!force_nonblock)
 		req->rw.kiocb.ki_flags &= ~IOCB_NOWAIT;
 
+	req->result = 0;
 	io_size = ret;
 	if (req->flags & REQ_F_LINK)
 		req->result = io_size;
@@ -2267,6 +2268,7 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (!force_nonblock)
 		req->rw.kiocb.ki_flags &= ~IOCB_NOWAIT;
 
+	req->result = 0;
 	io_size = ret;
 	if (req->flags & REQ_F_LINK)
 		req->result = io_size;
-- 
1.8.3.1

