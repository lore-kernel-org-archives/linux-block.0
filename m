Return-Path: <SRS0=P8sc=3O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B6DC2D0CE
	for <linux-block@archiver.kernel.org>; Sat, 25 Jan 2020 02:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EB32071A
	for <linux-block@archiver.kernel.org>; Sat, 25 Jan 2020 02:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgQNPS21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgAYCik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jan 2020 21:38:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbgAYCij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jan 2020 21:38:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P2Y8PA022556;
        Sat, 25 Jan 2020 02:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=OVf19r+SZgHVKf5GnsEzTB2gGGuOXL2zSODru/PROg0=;
 b=mgQNPS2116ovCqnMpsButoW6vS4LYIYcoYRt5A/+1r5FxTImu5Crz4ZGHKP7tls6nSaJ
 WR3Jj+ApzSTn6AfOT9S/yPm67SxGZpqYVORTgffzqBP1Dbuorv08FGog/iJLSfBhXaHU
 GGY9CM4quGWVMrqxs0sO8mzxMa6rrNK8Kk2T7xg8C2PF2w895/P79gVa0UQ5gbDybdO4
 +Jhjm0QwZ/E52mGn98jqz+jCi1C36B/PfmJVgyRrdF1bSpN8mbMNVtS0I1RkxV28AFUc
 lJjrHrSt6hJDrVRuVatC0d+F+cTHm+V/eL3bOwpm/b55NLNnGzs/xoR+K6B8PrFwdxij 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xktnrv593-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 02:38:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P2YF9A110642;
        Sat, 25 Jan 2020 02:38:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xrd0rr2bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 02:38:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00P2c4cC021548;
        Sat, 25 Jan 2020 02:38:05 GMT
Received: from [192.168.0.110] (/39.176.206.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 18:38:04 -0800
Subject: Re: [PATCH v5 2/6] block: Pass op_flags into
 blk_queue_get_max_sectors()
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
 <157969068296.174869.13461609442947913096.stgit@localhost.localdomain>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <8b77117b-1cc0-a379-2cdf-554a8060206c@oracle.com>
Date:   Sat, 25 Jan 2020 10:37:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <157969068296.174869.13461609442947913096.stgit@localhost.localdomain>
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
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001250021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/20 6:58 PM, Kirill Tkhai wrote:
> This preparation patch changes argument type, and now
> the function takes full op_flags instead of just op code.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  block/blk-core.c       |    4 ++--
>  include/linux/blkdev.h |    8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 50a5de025d5e..ac2634bcda1f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1250,10 +1250,10 @@ EXPORT_SYMBOL(submit_bio);
>  static int blk_cloned_rq_check_limits(struct request_queue *q,
>  				      struct request *rq)
>  {
> -	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
> +	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
>  		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
>  			__func__, blk_rq_sectors(rq),
> -			blk_queue_get_max_sectors(q, req_op(rq)));
> +			blk_queue_get_max_sectors(q, rq->cmd_flags));
>  		return -EIO;
>  	}
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0f1127d0b043..23a5850f35f6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -989,8 +989,10 @@ static inline struct bio_vec req_bvec(struct request *rq)
>  }
>  
>  static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
> -						     int op)
> +						     unsigned int op_flags)
>  {
> +	int op = op_flags & REQ_OP_MASK;
> +

Nitpick. int op = req_op(rq);

Anyway, looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

>  	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
>  		return min(q->limits.max_discard_sectors,
>  			   UINT_MAX >> SECTOR_SHIFT);
> @@ -1029,10 +1031,10 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
>  	if (!q->limits.chunk_sectors ||
>  	    req_op(rq) == REQ_OP_DISCARD ||
>  	    req_op(rq) == REQ_OP_SECURE_ERASE)
> -		return blk_queue_get_max_sectors(q, req_op(rq));
> +		return blk_queue_get_max_sectors(q, rq->cmd_flags);
>  
>  	return min(blk_max_size_offset(q, offset),
> -			blk_queue_get_max_sectors(q, req_op(rq)));
> +			blk_queue_get_max_sectors(q, rq->cmd_flags));
>  }
>  
>  static inline unsigned int blk_rq_count_bios(struct request *rq)
> 
> 

