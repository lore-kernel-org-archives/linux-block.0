Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E644C43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 06:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3C24682
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 06:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYqeG6rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfLTGuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:50:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfLTGuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 01:50:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK6iOdH189837;
        Fri, 20 Dec 2019 06:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BTroYEmgac69uUjk7P/6jW4V9WFoMUSwqvnhDOcypx4=;
 b=CYqeG6rxqGxkBBlFulsZHrBeNPXnf47SMuSetL9O4WYxYnYLy1g5AzaSDT5W3ZQC9+vM
 EH9ZwCdTBoBLnAXADbVnH5ytlBvuZa6ZSq/bAfieOTm5f7zv21CS0Pa8/WlSukpRuFml
 TeHIVgJiMAAvIpsS8Ea4Zpk1YvDLUFd/wwBKrfAMfSQNGDi1e6MpRFN8A7wWVUcxqPz+
 fFo4YwRA7nk5AvOqx2gNgP8PqaEygigOu3otucbk+0YWpJobIsaiHS8qtYBfdZyZmr2G
 V/IsOPST5gA/K7VWi1D4vaOWJsCvTwebA00XtuZXfYLXnnRmjUOAhMn762bYL+EqZpit kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2x01jaf05f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 06:50:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK6nltD079108;
        Fri, 20 Dec 2019 06:50:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2x0pcbeemj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 06:50:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBK6npKu005539;
        Fri, 20 Dec 2019 06:49:52 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 22:49:51 -0800
Subject: Re: [PATCH] block: streamline merge possibility checks
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <df9c90e7-9aa7-4f77-7161-1bc38de6f8ba@oracle.com>
Date:   Fri, 20 Dec 2019 14:50:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200052
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/19 3:41 AM, Dmitry Fomichev wrote:
> Checks for data direction in attempt_merge() and blk_rq_merge_ok()

Speak about these two functions, do you think attempt_merge() can be built on blk_rq_merge_ok()?
Things like..
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 48e6725..2a00c4c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -724,28 +724,7 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 static struct request *attempt_merge(struct request_queue *q,
                                     struct request *req, struct request *next)
 {
-       if (!rq_mergeable(req) || !rq_mergeable(next))
-               return NULL;
-
-       if (req_op(req) != req_op(next))
-               return NULL;
-
-       if (rq_data_dir(req) != rq_data_dir(next)
-           || req->rq_disk != next->rq_disk)
-               return NULL;
-
-       if (req_op(req) == REQ_OP_WRITE_SAME &&
-           !blk_write_same_mergeable(req->bio, next->bio))
-               return NULL;
-
-       /*
-        * Don't allow merge of different write hints, or for a hint with
-        * non-hint IO.
-        */
-       if (req->write_hint != next->write_hint)
-               return NULL;
-
-       if (req->ioprio != next->ioprio)
+       if (!blk_rq_merge_ok(req, next->bio))
                return NULL;


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
>  	/* must be same device */
>  	if (rq->rq_disk != bio->bi_disk)
>  		return false;
> 

