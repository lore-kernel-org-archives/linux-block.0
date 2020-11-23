Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FF5C2D0E4
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 08:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559B72076E
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 08:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCvs1oYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKWIMZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 03:12:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgKWIMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 03:12:25 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AN81iVn140451;
        Mon, 23 Nov 2020 03:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=ev3EinYL9tCopc87vbeKgaRQQCq3J2K2KV3bOE41sLw=;
 b=QCvs1oYB8goA4vhfB2ZJoqjb44MldSTSzJoJRs1e1m286rgi0ib5gHfZC4TaeDAqKHrW
 EMXXBWmmkrSIZp3vSSiG7zJVqXO8pkG85E0gXVykRskKFN8ZK29mu8F9m+ksmEsY6iy2
 j7kCeULUYm5PXV8RfSynLp5R2Psi6e0PPzPViPfrJN/8vLMKQr5Ncd8BKxHWQiC8FQGt
 M1aNmg0bQRYp63q2TTHCjhe3/6aquhfJfY0dgwo7bniVDzZF36f42/A0Pvsg/M+/S0do
 yDcRdoI/X03u68QUetrN9dQm0/bFclv4x6Juo6ZDy44Z3cBrx11aOJJEv5/dCLuSHIoO /w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34yjmnrh2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 03:12:23 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AN8C03P017093;
        Mon, 23 Nov 2020 08:12:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8a8kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 08:12:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AN8CJSd7537158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 08:12:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FA5A52079;
        Mon, 23 Nov 2020 08:12:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1ABCB52077;
        Mon, 23 Nov 2020 08:12:19 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH 2/2] block: fix kerneldoc typos
Date:   Mon, 23 Nov 2020 09:12:16 +0100
Message-Id: <20201123081216.64025-2-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123081216.64025-1-jwi@linux.ibm.com>
References: <20201123081216.64025-1-jwi@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 mlxlogscore=857
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230052
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Correct a misspelled 'submitted', and add a whitespace.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e..c0b2ead059ca 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1047,8 +1047,8 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-	 * to collect a list of requests submited by a ->submit_bio method while
-	 * it is active, and then process them after it returned.
+	 * to collect a list of requests submitted by a ->submit_bio method
+	 * while it is active, and then process them after it returned.
 	 */
 	if (current->bio_list) {
 		bio_list_add(&current->bio_list[0], bio);
@@ -1071,7 +1071,7 @@ EXPORT_SYMBOL(submit_bio_noacct);
  *
  * The success/failure status of the request, along with notification of
  * completion, is delivered asynchronously through the ->bi_end_io() callback
- * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
+ * in @bio.  The bio must NOT be touched by the caller until ->bi_end_io() has
  * been called.
  */
 blk_qc_t submit_bio(struct bio *bio)
-- 
2.17.1

