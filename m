Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE4C33C9E
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 01:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BCD2067D
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 01:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FYDHltDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAIBAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:00:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgAIBAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 20:00:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0090wLNK047958;
        Thu, 9 Jan 2020 00:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=U9W9OGdyVHVyoP6glrzGJi9ys2HKa08nDmzlsOwBhyU=;
 b=FYDHltDJR+ZZHaiC5MYg8Ls6mMnDXnd+Dp6qfe2PSSD9z9wJfrBwEeGuJn6SGY/I9ZDU
 FqSSIWeJI+4THksuaGly3UxDhI1H0js94NZmOkEU49zMZrkHD6kPy7wmUBh/bFj8vJI/
 Yu9jglywk1IJhCpoBoF+LVdqp4Nvs824qQGn0/b7THlnYhOgG87QlHcvulyP1GLGRwLe
 ucBSrmlqEob8BBPMUnEBV9WdJ7icK4FunoANuLrGifzy0n4SQQcMv8OZfSmW92vQZhYe
 8fx171Jw285kxF8MJ3axVuadfy0tC7e8/tygyBqwH2yei3Z+cK29tEftpMKPXTYAUREr BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xajnq7f5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 00:58:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0090rqRO143766;
        Thu, 9 Jan 2020 00:56:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xdmrx1e82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 00:56:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0090umQG025466;
        Thu, 9 Jan 2020 00:56:49 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 16:56:48 -0800
Subject: Re: [PATCH] block: streamline merge possibility checks
To:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
 <df9c90e7-9aa7-4f77-7161-1bc38de6f8ba@oracle.com>
 <20200108134437.GF4455@infradead.org>
 <BN8PR04MB643390C7263ACE2AFBDF5917E13E0@BN8PR04MB6433.namprd04.prod.outlook.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <4dea4331-9de3-e6b7-c453-05f9baeaec00@oracle.com>
Date:   Thu, 9 Jan 2020 08:56:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BN8PR04MB643390C7263ACE2AFBDF5917E13E0@BN8PR04MB6433.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090007
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/20 6:02 AM, Dmitry Fomichev wrote:
>> -----Original Message-----
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Wednesday, January 8, 2020 8:45 AM
>> To: Bob Liu <bob.liu@oracle.com>
>> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>; linux-
>> block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Damien Le Moal
>> <Damien.LeMoal@wdc.com>
>> Subject: Re: [PATCH] block: streamline merge possibility checks
>>
>> On Fri, Dec 20, 2019 at 02:50:05PM +0800, Bob Liu wrote:
>>> On 12/19/19 3:41 AM, Dmitry Fomichev wrote:
>>>> Checks for data direction in attempt_merge() and blk_rq_merge_ok()
>>>
>>> Speak about these two functions, do you think attempt_merge() can be
>> built on blk_rq_merge_ok()?
>>> Things like..
>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>> index 48e6725..2a00c4c 100644
>>> --- a/block/blk-merge.c
>>> +++ b/block/blk-merge.c
>>> @@ -724,28 +724,7 @@ static enum elv_merge blk_try_req_merge(struct
>> request *req,
>>>  static struct request *attempt_merge(struct request_queue *q,
>>>                                      struct request *req, struct request *next)
>>>  {
>>> -       if (!rq_mergeable(req) || !rq_mergeable(next))
>>> -               return NULL;
>>> -
>>> -       if (req_op(req) != req_op(next))
>>> -               return NULL;
>>> -
>>> -       if (rq_data_dir(req) != rq_data_dir(next)
>>> -           || req->rq_disk != next->rq_disk)
>>> -               return NULL;
>>> -
>>> -       if (req_op(req) == REQ_OP_WRITE_SAME &&
>>> -           !blk_write_same_mergeable(req->bio, next->bio))
>>> -               return NULL;
>>> -
>>> -       /*
>>> -        * Don't allow merge of different write hints, or for a hint with
>>> -        * non-hint IO.
>>> -        */
>>> -       if (req->write_hint != next->write_hint)
>>> -               return NULL;
>>> -
>>> -       if (req->ioprio != next->ioprio)
>>> +       if (!blk_rq_merge_ok(req, next->bio))
>>>                 return NULL;
>>
>> This looks sensible, but we might have to be a bit more careful.
>> rq_mergeable checks for RQF_NOMERGE_FLAGS and various ops, while
>> bio_mergeable is missing those.  So I think you need to go through
>> carefully if we need to keep any extra checks, but otherwise using
>> blk_rq_merge_ok looks sensible.
> 
> I tried this patch as is and, indeed, it leads to blktests failures and filesystem
> errors, apparently because of the RQF_NOMERGE_FLAGS  difference.
> However, the patch below seems to work - I've been running my host system
> with it for a couple of days with no issues. This one is added on top of
> "block: streamline merge possibility checks" patch.
> 
> From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Date: Wed, 8 Jan 2020 14:24:06 -0500
> Subject: [PATCH] block: simplify merge checks
> 
> The code parts to decide on merge possibility in attempt_merge() and
> blk_rq_merge_ok() look very similar. It is possible to move these
> checks to a common inline helper function.
> 
> Suggested-by: Bob Liu <bob.liu@oracle.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/blk-merge.c | 56 +++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index f68d67b367d6..49052a53051f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -732,6 +732,36 @@ static enum elv_merge blk_try_req_merge(struct request *req,
>  	return ELEVATOR_NO_MERGE;
>  }
>  
> +static inline bool blk_rq_mergeable(struct request *rq, struct bio *bio)
> +{
> +	if (!rq_mergeable(rq))
> +		return false;
> +
> +	if (req_op(rq) != bio_op(bio))
> +		return false;
> +
> +	/* must be same device */
> +	if (rq->rq_disk != bio->bi_disk)
> +		return false;
> +
> +	/* must be using the same buffer */
> +	if (req_op(rq) == REQ_OP_WRITE_SAME &&
> +	    !blk_write_same_mergeable(rq->bio, bio))
> +		return false;
> +
> +	/*
> +	 * Don't allow merge of different write hints, or for a hint with
> +	 * non-hint IO.
> +	 */
> +	if (rq->write_hint != bio->bi_write_hint)
> +		return false;
> +
> +	if (rq->ioprio != bio_prio(bio))
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
>   * For mq with scheduling, the appropriate queue wide lock should be held.
> @@ -739,7 +769,7 @@ static enum elv_merge blk_try_req_merge(struct request *req,
>  static struct request *attempt_merge(struct request_queue *q,
>  				     struct request *req, struct request *next)
>  {
> -	if (!blk_rq_merge_ok(req, next->bio))
> +	if (!rq_mergeable(next) || !blk_rq_mergeable(req, next->bio))
>  		return NULL;
>  
>  	/*
> @@ -841,35 +871,13 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
>  
>  bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  {
> -	if (!rq_mergeable(rq) || !bio_mergeable(bio))
> -		return false;
> -
> -	if (req_op(rq) != bio_op(bio))
> -		return false;
> -
> -	/* must be same device */
> -	if (rq->rq_disk != bio->bi_disk)
> +	if (!bio_mergeable(bio) || !blk_rq_mergeable(rq, bio))
>  		return false;
>  

Nitpick, I think bio_mergeable(bio) can also put inside blk_rq_mergeable().
Anyway, looks fine to me, thanks!
Reviewed-by: Bob Liu <bob.liu@oracle.com>

>  	/* only merge integrity protected bio into ditto rq */
>  	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
>  		return false;
>  
> -	/* must be using the same buffer */
> -	if (req_op(rq) == REQ_OP_WRITE_SAME &&
> -	    !blk_write_same_mergeable(rq->bio, bio))
> -		return false;
> -
> -	/*
> -	 * Don't allow merge of different write hints, or for a hint with
> -	 * non-hint IO.
> -	 */
> -	if (rq->write_hint != bio->bi_write_hint)
> -		return false;
> -
> -	if (rq->ioprio != bio_prio(bio))
> -		return false;
> -
>  	return true;
>  }
>  
> 

