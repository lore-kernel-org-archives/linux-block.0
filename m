Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CBC4363A
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12C422283
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 22:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFQhPaJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439198AbgJTWmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:42:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439144AbgJTWmA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 18:42:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KMeIT5106193;
        Tue, 20 Oct 2020 22:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=9CF09juyMLDXwlB/JkIoYdAQ4cPLEFn1gDhrmUFNFFU=;
 b=AFQhPaJHKjg1sx+si5bCuqcy5H6YLrMFjtowvLtbQcdu4/RNLL8orH453XKYh70W0hP5
 KzbYf1FI3KwAcGZ6f81gYrYaV972Wth2C2qiIGp4yJ8ukRchm94n5uaQk+l/VFbvFQng
 /O966LamzYaxgxEL3TOjmZi/tCSgVo1YIVdusMThZPQqBwZTE/1wqsHl4y8mbJoA/xNW
 ZyGueNU9nVtO5hilPR/EeORohzRkGa2BlewUECSHVTzuB8wY4dCQ2L0AGW2HtZNDUMuv
 W2kP5C36CKaDPRxrb5MkxxbjZAFiabi2G6lquS90B6h+BEzkJb3Vd5x4yCk6Ir5Crh6y KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 347s8mwkxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 22:41:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KMdtr9032914;
        Tue, 20 Oct 2020 22:41:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 348acrc5n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 22:41:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09KMfuIS007397;
        Tue, 20 Oct 2020 22:41:56 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 15:41:55 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] blk-mq: fix comment as bt_tags_for_each() is not only for started request
Date:   Tue, 20 Oct 2020 15:41:32 -0700
Message-Id: <20201020224132.22539-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=1
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200154
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the introduction of 'BT_TAG_ITER_STARTED' by commit 602380d28e28
("blk-mq: add blk_mq_all_tag_iter"), the bt_tags_for_each() is not only
used for started request, e.g., in below case:

blk_mq_hctx_has_requests()
-> blk_mq_all_tag_iter()
   -> __blk_mq_all_tag_iter() --> only BT_TAG_ITER_STATIC_RQS is set
      -> bt_tags_for_each()
         -> bt_tags_iter()

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 block/blk-mq-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..43af5063fe2e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -289,10 +289,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @tags:	Tag map to iterate over.
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request. Return true
- *		to continue iterating tags, false to stop.
+ * @fn:		Pointer to the function that will be called for each request
+ *		depending on the value of @flags. @fn will be called as
+ *		follows: @fn(rq, @data, @reserved) where rq is a pointer to a
+ *		request. Return true to continue iterating tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @flags:	BT_TAG_ITER_*
  */
-- 
2.17.1

