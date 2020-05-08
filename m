Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9506C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA52051A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OokTMV2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHVmN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 17:42:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 17:42:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048LbxF8010318;
        Fri, 8 May 2020 21:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=+CUeK4c5OHwsBUY6ZJnHwZnLc8ujfRHIAkrSPiOAzrA=;
 b=OokTMV2yaxwsa4/eXkxOwmuOH7UfCgkH9XyPT2Xr6PKJGU0ZKTnoaQ/h1psxUiBIADrv
 oXTWas6ieG9RSC3Lk1RT13WSu8Cr1dIRIE+y3laCCueBw8b8rf/VOHxnWCHeUeawYSg8
 VVv5cQJ+Up+MTOW3yMluimaTVeT0P7ke0waB3WyX+50URxQryVt2eT1R6K6b0IutSmbX
 uPpnrBwgkLJKdGoTJL63WQ4bH2A5nYJ04VA+JJ0bzGtrDVSCv6Oe9Xod67vfcMJv+Q6g
 Z9jh95mr1mc+jBgA4hmiO2Ff3DqKHKXa1lLDnoloUdaU8Z1zlaI6kFDR0PzadVR8HX1P ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30vtepnas0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 21:42:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048Law6h145316;
        Fri, 8 May 2020 21:42:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 30vtdpcaku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 May 2020 21:42:11 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048LcYvD148110;
        Fri, 8 May 2020 21:42:10 GMT
Received: from dhcp-10-76-241-128.usdhcp.oraclecorp.com.com (dhcp-10-76-241-128.usdhcp.oraclecorp.com [10.76.241.128])
        by aserp3030.oracle.com with ESMTP id 30vtdpcakd-1;
        Fri, 08 May 2020 21:42:10 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, martin.petersen@oracle.com,
        himanshu.madhani@oracle.com
Subject: [PATCH 1/1] block: don't inject fake timeouts on quiesced queues
Date:   Fri,  8 May 2020 14:44:55 -0700
Message-Id: <1588974295-15294-1-git-send-email-alan.adamson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=3 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080183
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Injecting a fake block timeout error when the queue is QUIESCED, a hang can
occur.  The fix is to ingnore the request to fake a timeout id the queue is
QUIESCED.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 block/blk-timeout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 8aa68fae96ad..482a777295ba 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -22,10 +22,10 @@ static int __init setup_fail_io_timeout(char *str)
 
 int blk_should_fake_timeout(struct request_queue *q)
 {
-	if (!test_bit(QUEUE_FLAG_FAIL_IO, &q->queue_flags))
-		return 0;
-
-	return should_fail(&fail_io_timeout, 1);
+	if (test_bit(QUEUE_FLAG_FAIL_IO, &q->queue_flags) &&
+	    !blk_queue_quiesced(q))
+		return should_fail(&fail_io_timeout, 1);
+	return 0;
 }
 
 static int __init fail_io_timeout_debugfs(void)
-- 
1.8.3.1

