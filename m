Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5763C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974C3208E7
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xQ1ZEVOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974C3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeLGBDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:03:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 20:03:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB70xWct101125;
        Fri, 7 Dec 2018 01:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xU2eap1/TNOG1a8FKS1J9Q64Z1Q4yPrA+FJOdtOYEBo=;
 b=xQ1ZEVOPUFk9O1yDf6Ey7riSZRfFblI9z9WwR8Ygtnmwgb4F/Y7G+YsJGHF893Aq1V8G
 wyWsN6p45OD2B0EfnuIk9yzTdWh07IIIQxTO3WYx63MH0CGvmrIwgdaXEkEYfLAYwEZO
 xn3f7UzPFBrrerWCdkTqWNsMO43xx6F0KGU6GJsyqB3tMBQlML3kX/cFyne2eBACsGNW
 2O7z//BUs54mqPuhr7O0EW4trG+4lqT4i6IpcOkgzNKMvfT/7T7wZoTcWFixij4TP6qC
 ZOhUNxIBCQuj/KGIVizNi+kSYctx2MBRAzWlVvoITrIg6BFQGc7oeGLAulTCQXLy5Ljq OQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxru6wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 01:03:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB713WVY031442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 01:03:32 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB713Wmo030292;
        Fri, 7 Dec 2018 01:03:32 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 01:03:32 +0000
Subject: Re: [PATCH] block: fix direct dispatch issue failure for clones
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
Date:   Fri, 7 Dec 2018 09:04:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070006
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/7/18 6:20 AM, Jens Axboe wrote:
> After the direct dispatch corruption fix, we permanently disallow direct
> dispatch of non read/write requests. This works fine off the normal IO
> path, as they will be retried like any other failed direct dispatch
> request. But for the blk_insert_cloned_request() that only DM uses to
> bypass the bottom level scheduler, we always first attempt direct
> dispatch. For some types of requests, that's now a permanent failure,
> and no amount of retrying will make that succeed.
> 
> Don't use direct dispatch off the cloned insert path, always just use
> bypass inserts. This still bypasses the bottom level scheduler, which is
> what DM wants.
> 
> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index deb56932f8c4..4c44e6fa0d08 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>  		 * bypass a potential scheduler on the bottom device for
>  		 * insert.
>  		 */
> -		return blk_mq_request_issue_directly(rq);
> +		blk_mq_request_bypass_insert(rq, true);
> +		return BLK_STS_OK;
>  	}
>  
>  	spin_lock_irqsave(q->queue_lock, flags);
> 
Not sure about this because it will break the merging promotion for request based DM
from Ming.
396eaf21ee17c476e8f66249fb1f4a39003d0ab4
(blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback)

We could use some other way to fix this.

Thanks
Jianchao
