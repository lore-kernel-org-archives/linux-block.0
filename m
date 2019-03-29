Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A5C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32DE2173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0eklocWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfC2OYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:24:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58700 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfC2OYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:24:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEE1Lu004595;
        Fri, 29 Mar 2019 14:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=o5MGkO/UI8Fuf/rRxWKaYIiK+9cGRsQljalxnNRo8lA=;
 b=0eklocWt/7F0Qdz/LYmVaQQQbH1T9v+hTQ6555kaNzmOHmm6CoNl7SUBZVjItn2P85Mf
 sh3HVmXdnPjz5YNMkZPNlRjva/iVlhOyJVVJ7fpBEKeo3+wL88b56M/gikM2u14JKpWp
 z1gmKT82VlGklvmuD3oV4qjz3uN8uJuI+2Ze0NxEQtT43iNdToiHHUhjRsRREVw9l/Y/
 5moa8JtS7kVbzJMxpaYM6M1mokIZq8a7Tixyzfb1prW71w5PRP53djsVC1wdPYdc296I
 Bw7bz1OzR/Bi3V03zehJBnE23Hy0Onirx390zYcN20H2LGd3oWfqiBHEVWCnmI8vQkor dQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g1crf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEOWZM006959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:32 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TEOVP3019283;
        Fri, 29 Mar 2019 14:24:31 GMT
Received: from localhost.localdomain (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:24:30 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        axboe@kernel.dk, tytso@mit.edu, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v3 1/3] block: introduce submit_bio_verify()
Date:   Fri, 29 Mar 2019 22:23:44 +0800
Message-Id: <20190329142346.1677-2-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329142346.1677-1-bob.liu@oracle.com>
References: <20190329142346.1677-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=971 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290102
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a function verifier callback to submit_bio.  The
filesystem layer can use submit_bio_verify to pass a call back
to the block layer which can then be used to verify if the data
read is correct.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 block/blk-core.c    | 13 ++++++++++---
 include/linux/bio.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6b78ec56a4f2..d265d2924c32 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1156,15 +1156,16 @@ blk_qc_t direct_make_request(struct bio *bio)
 EXPORT_SYMBOL_GPL(direct_make_request);
 
 /**
- * submit_bio - submit a bio to the block device layer for I/O
+ * submit_bio_verify - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
  *
- * submit_bio() is very similar in purpose to generic_make_request(), and
+ * submit_bio_verify() is very similar in purpose to generic_make_request(), and
  * uses that function to do most of the work. Both are fairly rough
  * interfaces; @bio must be presetup and ready for I/O.
  *
  */
-blk_qc_t submit_bio(struct bio *bio)
+blk_qc_t submit_bio_verify(struct bio *bio,
+		int (*verifier_cb_func)(struct bio *))
 {
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
@@ -1197,6 +1198,12 @@ blk_qc_t submit_bio(struct bio *bio)
 
 	return generic_make_request(bio);
 }
+EXPORT_SYMBOL(submit_bio_verify);
+
+blk_qc_t submit_bio(struct bio *bio)
+{
+	return submit_bio_verify(bio, NULL);
+}
 EXPORT_SYMBOL(submit_bio);
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..ddaadab74dcf 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -398,6 +398,8 @@ static inline struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs)
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, NULL);
 }
 
+extern blk_qc_t submit_bio_verify(struct bio *,
+		int (*verifier_cb_func)(struct bio *));
 extern blk_qc_t submit_bio(struct bio *);
 
 extern void bio_endio(struct bio *);
-- 
2.17.1

