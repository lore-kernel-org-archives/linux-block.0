Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E04C10F0E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 10:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D102147C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 10:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oxKjwQfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfDDKEn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:04:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDKEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 06:04:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34A3g0T163450;
        Thu, 4 Apr 2019 10:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=HSJ9MRGkEWjkSpig+MiLw4kI99Yke2oEBvlJf/AcmLI=;
 b=oxKjwQfKirZPqLt1ep3xl/95PfZFiziJdrVeryB1uswQpzco53m8xL35yA3XBXWovcWc
 ldwGnY7QbGJdZAKgIaAzxzI38CftnU1jrMv2mQic2KK7XfwXuis+1D+iz9WXebb1M9Qc
 0+SX9hROe+lYNCM3B29552TRf3AKAikv/AeeD/XF2fOfBpjsckDmiheygoHbSLEXg80H
 LTexR9Kf9L43xTNNYoyj8dRP+XHx0x2g2/mOHHQZepdxUlqQ4BX7/UTn7jxh9+bMTjCT
 CIxQvD5IzD5ckzSdhyPfvEoG1otdElg+XiNcVyLcAIW/AoTd8TxAqIswAu9C8GdHCWj7 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rj13qe22w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 10:04:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34A3Sln117333;
        Thu, 4 Apr 2019 10:04:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rm9mjh72c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 10:04:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x34A4HKc003367;
        Thu, 4 Apr 2019 10:04:17 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 03:04:17 -0700
Date:   Thu, 4 Apr 2019 13:04:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] io_uring: Potential Oops in io_sq_offload_start()
Message-ID: <20190404100405.GA27094@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404100218.GA26946@kadam>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040071
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040071
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "p->sq_thread_cpu" variable is an integer which comes from the user.
We can't pass values greater than NR_CPUS to cpu_possible() or it could
lead to an out of bound read and possibly an Oops.

The recently added cpu_possible_safe() function can handle unfiltered
input so lets use that instead.  This patch also removes the call to
array_index_nospec() since that is handled in cpu_possible_safe().

Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/io_uring.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c0fecb9d889f..9789887b0d36 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2240,16 +2240,13 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 		ctx->sq_thread_idle = HZ;
 
 	ret = -EINVAL;
-	if (!cpu_possible(p->sq_thread_cpu))
+	if (!cpu_possible_safe(p->sq_thread_cpu))
 		goto err;
 
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		if (p->flags & IORING_SETUP_SQ_AFF) {
-			int cpu;
-
-			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
 			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
-							ctx, cpu,
+							ctx, p->sq_thread_cpu,
 							"io_uring-sq");
 		} else {
 			ctx->sqo_thread = kthread_create(io_sq_thread, ctx,
-- 
2.17.1

