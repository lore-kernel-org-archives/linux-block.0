Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950A5C282DE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 08:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DCC20B1F
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 08:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdrIBkcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfDHIPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:15:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDHIPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 04:15:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x388Drhh143445;
        Mon, 8 Apr 2019 08:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=p8SPSjCn008e07/4+WJbLSruNtiI92Hx8qaumPKlQbY=;
 b=sdrIBkcpORRohOOZBxziQBn3Gh6QXCPN5DcpKga7R9kTDg748mXZQ+JK6ajuKuOWeAVZ
 NRfHTD1tSOK6rQPedUNxqxu9IIWv/h5IMBNTP6vSYDBMMLqiwiJzC6DNxvk6JYhvwIux
 SpXK2e5QYSmIV3WR6N6GdGyvbqPCUJSv4m6OsG1NXJPWH3kNNP8uCT//JxUD1/Gp5FiG
 0VBDaSjg4U8b4D0t/uLvv2Z9PjWLu2i9VQzMXUbOxAVA93gKdtE/AMrYjeqeH41JfHKN
 2+DL1HmhmjlJjxfRGXHSA7Ot4edPwkPWxr+K1+fRcjEa/KtlXhVZoSKR3KGJIdHwGb5W KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rpkhsmpph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 08:15:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x388DmtZ104387;
        Mon, 8 Apr 2019 08:15:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rpkehjxxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 08:15:25 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x388FN8B024630;
        Mon, 8 Apr 2019 08:15:24 GMT
Received: from kadam (/41.202.241.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 01:15:22 -0700
Date:   Mon, 8 Apr 2019 11:15:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/2] io_uring: Potential Oops in io_sq_offload_start()
Message-ID: <20190408081513.GB15239@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404104527.GX4038@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080077
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
No change.

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

