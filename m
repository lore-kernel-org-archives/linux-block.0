Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE0EC83000
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287C520838
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 00:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uL3PGpLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD3AsD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:48:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3AsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 20:48:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U0lRr5159660;
        Thu, 30 Apr 2020 00:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=0axGusDsOOmBmP9znveBjr17FUrJlyl6C2OrPhH5ahA=;
 b=uL3PGpLl9Pa/vr3pZjfhsvY11ybXJi25+KCylmUBEyHUFZwiP8gobEgpj3KZLjt7jOXv
 W2xSmCZueA768gkhrRpsY2BxnJonKUq3wKV8/sT4vazhOYuBcoNuwQwYI/FQVfiHxe+J
 X8Al2hxjqSoZjCSK80lAeOuidv4j0tm3ths+94HVxLln/yiVJMMrn0J6cKYHmyJaqMAo
 dARBPpO7FFrH77iCukcrMreiRtGkf7447Zx4GrsA3f0VWkcMWSJGzwSpneloAkykLe4B
 JKZ3Jb9JmgPbcpWPxMQA6ezWWQQ4h9ilup/fvnNdnjh5s7KI5M0RresJFVwxiUWsttB/ rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30p2p0e4yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 00:48:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U0m0iG100026;
        Thu, 30 Apr 2020 00:48:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30pvd28grx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 00:48:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03U0ltR7003690;
        Thu, 30 Apr 2020 00:47:56 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 17:47:55 -0700
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/1] io_uring: use proper references for fallback_req locking
Date:   Wed, 29 Apr 2020 17:47:50 -0700
Message-Id: <1588207670-65832-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=856
 suspectscore=3 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=3 mlxlogscore=911 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use ctx->fallback_req address for test_and_set_bit_lock() and
clear_bit_unlock().

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 54b7c48..8d23dc6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1290,7 +1290,7 @@ static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
 	struct io_kiocb *req;
 
 	req = ctx->fallback_req;
-	if (!test_and_set_bit_lock(0, (unsigned long *) ctx->fallback_req))
+	if (!test_and_set_bit_lock(0, (unsigned long *) &ctx->fallback_req))
 		return req;
 
 	return NULL;
@@ -1377,7 +1377,7 @@ static void __io_free_req(struct io_kiocb *req)
 	if (likely(!io_is_fallback_req(req)))
 		kmem_cache_free(req_cachep, req);
 	else
-		clear_bit_unlock(0, (unsigned long *) req->ctx->fallback_req);
+		clear_bit_unlock(0, (unsigned long *) &req->ctx->fallback_req);
 }
 
 struct req_batch {
-- 
1.8.3.1

