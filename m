Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF06C10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 01:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A10E2084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 01:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sGAhhVSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCBio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:38:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59006 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDCBio (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 21:38:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x330sJYq184071;
        Wed, 3 Apr 2019 00:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pX4qg1Dg6O2/kYcbpu2WMTihq+z88u4YENKQNpl77Zo=;
 b=sGAhhVSJy+yV5xUpQcI1E1Gw0FEa5YKTM+OPuIQqgzOvxVqb/G36vINW5skCcD3NcRH5
 /E5moWKAjdspxAceLAnaPQxRlglNFbeXWLi48O6p4tR/lBZ5/3dUI2FtFhT+1EQAMyjL
 GXcn3IP7pLabgkXxDOOH2/Sc9NrdTSr4UB/Sckkv0EPlVXfPOC+ZJzms5jvZHvgApx7B
 FoG+adtt0gIXJtUUId24PX3BHEKfg699PyKoTIu0M1qNw5I4Xq6yfBxu88fGJ78NC7rK
 vUVix/CTY8ahFdRn/5o73nYh5dynZwVY0f2bWU8kvaajGGO0WUtoXAzOOmq0Joa61S0n mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2rj0dnn4bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 00:58:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x330vRph015228;
        Wed, 3 Apr 2019 00:58:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mhruu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 00:58:40 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x330wXjp011042;
        Wed, 3 Apr 2019 00:58:34 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 17:58:33 -0700
Subject: Re: [PATCH] block: Fix a race between tag iteration and hardware
 queue changes
To:     Bart Van Assche <bvanassche@acm.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>, stable@vger.kernel.org
References: <20190402223202.30752-1-bvanassche@acm.org>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <3f83312b-7896-54d9-1a7b-a3abacc04e46@oracle.com>
Date:   Wed, 3 Apr 2019 09:02:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190402223202.30752-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030003
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030003
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/3/19 6:32 AM, Bart Van Assche wrote:
> Since the callback function called by blk_mq_queue_tag_busy_iter()
> may sleep calling synchronize_rcu() from __blk_mq_update_nr_hw_queues()
> is not sufficient to wait until blk_mq_queue_tag_busy_iter() has
> finished. Instead of making __blk_mq_update_nr_hw_queues() wait until
> q->q_usage_counter == 0 is globally visible, do not iterate over tags
> if the request queue is frozen.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 530ca2c9bd69 ("blk-mq: Allow blocking queue tag iter callbacks") # v4.19.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-tag.c | 10 +++++-----
>  block/blk-mq.c     |  5 +----
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index a4931fc7be8a..89f479634b4d 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -383,14 +383,13 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  
>  	/*
>  	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
> -	 * while the queue is frozen. So we can use q_usage_counter to avoid
> -	 * racing with it. __blk_mq_update_nr_hw_queues() uses
> -	 * synchronize_rcu() to ensure this function left the critical section
> -	 * below.
> +	 * while the queue is frozen. Hold q_usage_counter to serialize
> +	 * __blk_mq_update_nr_hw_queues() against this function.
>  	 */
>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return;
> -
> +	if (atomic_read(&q->mq_freeze_depth))
> +		goto out;
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		struct blk_mq_tags *tags = hctx->tags;
>  
> @@ -405,6 +404,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>  		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
>  	}
> +out:
>  	blk_queue_exit(q);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 652d0c6d5945..f9fc1536408d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3226,10 +3226,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_freeze_queue(q);
> -	/*
> -	 * Sync with blk_mq_queue_tag_busy_iter.
> -	 */
> -	synchronize_rcu();

I used to see the removal of above in one of Jianchao's patchset.

https://lore.kernel.org/patchwork/patch/1051047/

Dongli Zhang

> +
>  	/*
>  	 * Switch IO scheduler to 'none', cleaning up the data associated
>  	 * with the previous scheduler. We will switch back once we are done
> 
