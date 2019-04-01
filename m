Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6061CC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 01:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C71520872
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 01:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zSsr4p6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfDABgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:36:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfDABgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 21:36:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x311YHtf152611;
        Mon, 1 Apr 2019 01:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mCx8epNlw3eIK03WKIrtYxeZDFHnNV18f2TE6GaI5vQ=;
 b=zSsr4p6JF9jt7bfeEucK4ncJsy/8NvZ3ky532oWTUPcRcpHLd62GgT/ztNLoeG3AY0Se
 uKYjMas8MGCSFYy3k+iom2ToFvNO8RJB3XHXnJAE9lIP6fOvwFmra+0ttqFpqTRT28+G
 EIMa486Dae+oUQAGEVIvjGAhc3BVMI2T7rcHXZO0JiXPbDEXCnhpuabQ+WqUIbp0wNjE
 pzlgNmeVboXIF/GazyDHgeaUq7eeyjQkcz0G44sTBtYMozKLzis/SBMcavUl/mCWFThS
 WTEIpAJ0+QWINRWEuWewelXGIjZhrHHuMloB4n/n+xu83ADo505SNEqBXE2AwXlqgEdt Hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2rj13pv25d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 01:36:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x311aXGY001543
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 01:36:33 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x311aTVf024490;
        Mon, 1 Apr 2019 01:36:29 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 18:36:28 -0700
Subject: Re: [PATCH 1/5] blk-mq: re-organize blk_mq_exit_hctx() into two parts
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <20190331030954.22320-2-ming.lei@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f36610c3-efb1-f364-48af-3d365bbb0144@oracle.com>
Date:   Mon, 1 Apr 2019 09:40:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190331030954.22320-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010010
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/31/19 11:09 AM, Ming Lei wrote:
> This patch re-organizes blk_mq_exit_hctx() into two parts, and
> one part is for exit hctx, and another part is for free hw queue.
> 
> No function change, just prepare for fixing hctx lifetime issue.
> 
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 70b210a308c4..53265ce45238 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2229,6 +2229,16 @@ static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
>  					    &hctx->cpuhp_dead);
>  }
>  
> +static void blk_mq_free_hctx(struct request_queue *q,
> +		struct blk_mq_hw_ctx *hctx)
> +{
> +	if (hctx->flags & BLK_MQ_F_BLOCKING)
> +		cleanup_srcu_struct(hctx->srcu);
> +
> +	blk_free_flush_queue(hctx->fq);
> +	sbitmap_free(&hctx->ctx_map);
> +}
> +
>  /* hctx->ctxs will be freed in queue's release handler */
>  static void blk_mq_exit_hctx(struct request_queue *q,
>  		struct blk_mq_tag_set *set,
> @@ -2243,12 +2253,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>  	if (set->ops->exit_hctx)
>  		set->ops->exit_hctx(hctx, hctx_idx);
>  
> -	if (hctx->flags & BLK_MQ_F_BLOCKING)
> -		cleanup_srcu_struct(hctx->srcu);
> -
>  	blk_mq_remove_cpuhp(hctx);
> -	blk_free_flush_queue(hctx->fq);
> -	sbitmap_free(&hctx->ctx_map);
>  }
>  
>  static void blk_mq_exit_hw_queues(struct request_queue *q,
> @@ -2262,6 +2267,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  			break;
>  		blk_mq_debugfs_unregister_hctx(hctx);
>  		blk_mq_exit_hctx(q, set, hctx, i);
> +		blk_mq_free_hctx(q, hctx);

Assuming if this direction is still followed, how about blk_mq_realloc_hw_ctxs()
which is another caller of blk_mq_exit_hctx(), while part of blk_mq_exit_hctx()
is extracted and encapsulated into blk_mq_free_hctx()?

Additional blk_mq_free_hctx() is missing?

Dongli Zhang

>  	}
>  }
>  
> 
