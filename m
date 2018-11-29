Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0956C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CEE20863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 10:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mNLhuraA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CEE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK2WCN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:02:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeK2WCM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 17:02:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATAs33H060689;
        Thu, 29 Nov 2018 10:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=W72AQif6uBskFsVeUn3FYDTFEVI8VlHSXPQJp0+XXCY=;
 b=mNLhuraAPnIAuI7ornjBADamnde3vCHUHHjPb/Pn8nxST4c7YjQ3sGWqJttnJnjNTMKr
 DtzdKYJXJwWbu9rBdFGmqGGPPdP3dmMIx27OPEK80aeZJxcYblE3osfDYnzoU9LPdiYK
 EV6fCATw4lkk6eFIF/sOwFm2s3ukceYvKPclZyvkOw9Cds1SbC7HOAzWKtAJFAroLCRQ
 uhhHLxGihCr0TOWDai586/LAkXL9IXlO+rG4rPST3w+26E5OrB6LNXCIU0UZK00DQ7Hc
 gHbudPRFjTEMHNnzzZPn8QJgm+edyNe34Br6WcK5pU0Cqj5cChNK3mUhOkO8mx55EBQ3 MA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nxxkqqg3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 10:57:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATAv5o0013742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 10:57:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATAv5i6024211;
        Thu, 29 Nov 2018 10:57:05 GMT
Received: from kili.mountain (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 02:57:04 -0800
Date:   Thu, 29 Nov 2018 13:56:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: Add a NULL check in
 blk_mq_free_map_and_requests()
Message-ID: <20181129105654.5icpvxx7p2kq257c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129105519.mklhnmx34yjucb22@kili.mountain>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290095
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I recently found some code which called blk_mq_free_map_and_requests()
with a NULL set->tags pointer.  I fixed the caller, but it seems like a
good idea to add a NULL check here as well.  Now we can call:

	blk_mq_free_tag_set(set);
	blk_mq_free_tag_set(set);

twice in a row and it's harmless.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a82830f39933..5f4b93f424b4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2341,7 +2341,7 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
 static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 					 unsigned int hctx_idx)
 {
-	if (set->tags[hctx_idx]) {
+	if (set->tags && set->tags[hctx_idx]) {
 		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
 		blk_mq_free_rq_map(set->tags[hctx_idx]);
 		set->tags[hctx_idx] = NULL;
-- 
2.11.0

