Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E735C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600C72467B
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pq66JbP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSI46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:56:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLSI46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 03:56:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ8sATp136393;
        Thu, 19 Dec 2019 08:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=zgbUyIwZSlRwJrqDCWGlA4t1prryEIZ4r9PN/qSElVc=;
 b=Pq66JbP2S3ux0zcsdOhwsA6fLEOnwGhzwvqSe4rf6/KC26HITyE8QZosS0Au8DESR1lp
 SgDoCiibuFVCZPXphi/5jIKDoRTjyDwf9bb1GOpex5B4IzkL38CH0M+azYwKiBWXoor8
 y8xmFMOED0k7HF74222sMEmGVQyacm83iG0fhj/G6IlzXPuqZq2giNUoTm2JE5WrsaCw
 5qRXrJpnM9CSjZj5L7gVwIEEELEDI/N5q6RAgwjVBw80wuptW3ae2oxbWMV+jmsnjOfM
 6hOXHaZ8X0xGCeSnymnz3AeWDlxBQg0hrwslSrk+gmh9dLdaHB29QV/LCEW3mzxjseEi 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wvrcrjv19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:56:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ8s7sN064759;
        Thu, 19 Dec 2019 08:56:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wyp0957p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:56:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJ8usjk012521;
        Thu, 19 Dec 2019 08:56:54 GMT
Received: from [10.191.9.152] (/10.191.9.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 00:56:54 -0800
Subject: Re: [PATCH] block: streamline merge possibility checks
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <c76929ea-2fcb-bbd3-a394-5d42f619191e@oracle.com>
Date:   Thu, 19 Dec 2019 16:56:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190076
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/19 3:41 AM, Dmitry Fomichev wrote:
> Checks for data direction in attempt_merge() and blk_rq_merge_ok()
> are redundant and will always succeed when the both I/O request
> operations are equal. Therefore, remove them.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/blk-merge.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index d783bdc4559b..796451aed7d6 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -745,8 +745,7 @@ static struct request *attempt_merge(struct request_queue *q,
>  	if (req_op(req) != req_op(next))
>  		return NULL;
>  
> -	if (rq_data_dir(req) != rq_data_dir(next)
> -	    || req->rq_disk != next->rq_disk)
> +	if (req->rq_disk != next->rq_disk)
>  		return NULL;
>  
>  	if (req_op(req) == REQ_OP_WRITE_SAME &&
> @@ -868,10 +867,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  	if (req_op(rq) != bio_op(bio))
>  		return false;
>  
> -	/* different data direction or already started, don't merge */
> -	if (bio_data_dir(bio) != rq_data_dir(rq))
> -		return false;
> -

Reviewed-by: Bob Liu <bob.liu@oracle.com>

>  	/* must be same device */
>  	if (rq->rq_disk != bio->bi_disk)
>  		return false;
> 

