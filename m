Return-Path: <SRS0=P8sc=3O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A333C32771
	for <linux-block@archiver.kernel.org>; Sat, 25 Jan 2020 02:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A162071A
	for <linux-block@archiver.kernel.org>; Sat, 25 Jan 2020 02:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HdpPF3gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbgAYCiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jan 2020 21:38:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38050 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbgAYCiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jan 2020 21:38:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P2YD8j008807;
        Sat, 25 Jan 2020 02:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=dLhPPXFZ1NX+iTt0fiqbRMwm/CK4E4mRxRFzcuVz7P8=;
 b=HdpPF3gPTNNzkIiKb1TUu/p4gdOXu48gXDI01GmUwCtKiCJLUEWSefKBMG5UHx3h9z2T
 XoFBAiBwZ8YIx/FpNHOar/YoQnul38nEF/Ob66qpu91mt9duu7J3j5j9zH0Eg4BJWZdi
 CbsdPCGD4JOpof+QXEX+gb1/Zi8I4tRwM+Xcln0Q5o8aB8svsgmrkJc0k0MG6gWlz8Fm
 MfdOjkmwXfdbcK8FctbrvsTF+N/cvV7ojQ+MWL7QXodzqU/ULQ+aCPSqGXyPMy7tFSuo
 N6LJMBUY2VpYa8cJzlEtp1Tc0cEx+IGcBY9ERkeTkgXYLIqFsGNpqupkrcX+l3qN5hDR Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xksyqva0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 02:38:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P2XZNe005587;
        Sat, 25 Jan 2020 02:38:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xratapu48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 02:38:19 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00P2cGeB013620;
        Sat, 25 Jan 2020 02:38:16 GMT
Received: from [192.168.0.110] (/39.176.206.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 18:38:16 -0800
Subject: Re: [PATCH v5 3/6] block: Introduce
 blk_queue_get_max_write_zeroes_sectors()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        axboe@kernel.dk, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157968992539.174869.7490844754165043549.stgit@localhost.localdomain>
 <157969068832.174869.10818825289800365633.stgit@localhost.localdomain>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <eb2a8ad1-5ac2-db7e-5e47-ee77e10fa49a@oracle.com>
Date:   Sat, 25 Jan 2020 10:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <157969068832.174869.10818825289800365633.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001250021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001250021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/20 6:58 PM, Kirill Tkhai wrote:
> This introduces a new primitive, which returns max sectors
> for REQ_OP_WRITE_ZEROES operation.
> @op_flags is unused now, and it will be enabled in next patch.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  block/blk-core.c       |    2 +-
>  block/blk-merge.c      |    9 ++++++---
>  include/linux/blkdev.h |    8 +++++++-
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 

Reviewed-by: Bob Liu <bob.liu@oracle.com>

> diff --git a/block/blk-core.c b/block/blk-core.c
> index ac2634bcda1f..2edcd55624f1 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -978,7 +978,7 @@ generic_make_request_checks(struct bio *bio)
>  			goto not_supported;
>  		break;
>  	case REQ_OP_WRITE_ZEROES:
> -		if (!q->limits.max_write_zeroes_sectors)
> +		if (!blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf))
>  			goto not_supported;
>  		break;
>  	default:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 1534ed736363..467b292bc6e8 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -105,15 +105,18 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
>  static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
>  		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
>  {
> +	unsigned int max_sectors;
> +
> +	max_sectors = blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf);
>  	*nsegs = 0;
>  
> -	if (!q->limits.max_write_zeroes_sectors)
> +	if (!max_sectors)
>  		return NULL;
>  
> -	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
> +	if (bio_sectors(bio) <= max_sectors)
>  		return NULL;
>  
> -	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
> +	return bio_split(bio, max_sectors, GFP_NOIO, bs);
>  }
>  
>  static struct bio *blk_bio_write_same_split(struct request_queue *q,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 23a5850f35f6..264202fa3bf8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -988,6 +988,12 @@ static inline struct bio_vec req_bvec(struct request *rq)
>  	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
>  }
>  
> +static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
> +		struct request_queue *q, unsigned int op_flags)
> +{
> +	return q->limits.max_write_zeroes_sectors;
> +}
> +
>  static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>  						     unsigned int op_flags)
>  {
> @@ -1001,7 +1007,7 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>  		return q->limits.max_write_same_sectors;
>  
>  	if (unlikely(op == REQ_OP_WRITE_ZEROES))
> -		return q->limits.max_write_zeroes_sectors;
> +		return blk_queue_get_max_write_zeroes_sectors(q, op_flags);
>  
>  	return q->limits.max_sectors;
>  }
> 
> 

