Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68067C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45422208B8
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gqQCxF4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgE2Rir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 13:38:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Rir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 13:38:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04THS2iw166071;
        Fri, 29 May 2020 17:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=/RW+mkPDwSW00rWCQ1Qu/i8lGlTHo7jS5iJOYu2SJAg=;
 b=gqQCxF4Kh/ueAi+o0LfQggTdkrFPNMOAcWXw8fSEeV+74bqQ3PKXxIiXh1S1INQ4Y0te
 QHuurAoqGCtqpCT7vex8jSNEZb6oNCS0uzzGMfJjSIjRLxXFOoLNS+3tpXeqk20ZIcYp
 8P4PC+jtsDdeziSort9gUr2Rm57dePw45le7gU0uE/OXywA1CpiqnDwRsuaFu24oqrJ0
 72hJBwjjp8CuL5XQSgscbzhej6BK8klrgShRihuqzO1qrinCPIz7DFugjuSAIjl7ts5I
 bT4GgT4Lbz/o/IiOKIFx0ecF9shxmTx3Pntv6k505g98bisk9FQhtc17y3JVRDTACk1H bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8rbn4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 17:38:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04THRisL077787;
        Fri, 29 May 2020 17:38:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31a9kuhym6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 17:38:44 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04THcfH6027323;
        Fri, 29 May 2020 17:38:43 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 10:38:41 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH for-next 1/1] null_blk: force complete for timeout request
Date:   Fri, 29 May 2020 10:31:08 -0700
Message-Id: <20200529173108.25198-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=1
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 7b11eab041da ("blk-mq: blk-mq: provide forced completion
method") exports new API to force a request to complete without error
injection.

There should be no error injection when completing a request by timeout
handler.

Otherwise, the below would hang because timeout handler is failed.

echo 100 > /sys/kernel/debug/fail_io_timeout/probability
echo 1000 > /sys/kernel/debug/fail_io_timeout/times
echo 1 > /sys/block/nullb0/io-timeout-fail
dd if=/dev/zero of=/dev/nullb0 bs=512 count=1 oflag=direct

With this patch, the timeout handler is able to complete the IO.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 6126f771ae99..87b31f9ca362 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1423,7 +1423,7 @@ static bool should_requeue_request(struct request *rq)
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
 	pr_info("rq %p timed out\n", rq);
-	blk_mq_complete_request(rq);
+	blk_mq_force_complete_rq(rq);
 	return BLK_EH_DONE;
 }
 
-- 
2.17.1

