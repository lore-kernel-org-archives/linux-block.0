Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CFC10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06B2147C
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wYKM0kRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCD0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:26:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCD0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 23:26:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x333O1Sx098882;
        Wed, 3 Apr 2019 03:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1bGrLyEyCSL2kerBNJETptNhw9QrWsPxzlN3cesXG4s=;
 b=wYKM0kRpe7lEe1XV4VkQ808LA3jIhgdx4mlf42iVDoEHeP613WUyNfPOlyAY/+VrhUg5
 Brc/RsqUKyrs+W0MiE10Wa4uY3XCuYce84+kCYRCXUUCbFP/sc7IOOZS0qlVnNJo0Vj7
 dx9STVZck7H7dQlW5izQQAGWFX9Krw6UWV67SIvE7og5Nnz7l8ahRqCg3iz5ZZPcV+dZ
 1v4RHu5IhI+7tRqfQSZoMHVKURJprx3UucLRuZLrny4UgZMrZ3dLXT6IuSLHZfl4cQUn
 47iVN8CJpJMwkYvvaggVzWRGeNpSUBwVWPsK62V53kkXULXVQ/t2gjBarYgc+cxKRufz 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2rj0dnnhgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 03:26:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x333PHt5053303;
        Wed, 3 Apr 2019 03:26:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rm8f53t9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 03:26:08 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x333Q6Ch026801;
        Wed, 3 Apr 2019 03:26:07 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 20:26:06 -0700
Subject: Re: [PATCH] block: Fix a race between tag iteration and hardware
 queue changes
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
References: <20190402223202.30752-1-bvanassche@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9d74985d-969c-b68d-fa05-2707ed27e013@oracle.com>
Date:   Wed, 3 Apr 2019 11:26:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402223202.30752-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030019
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart

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

percpu_ref_tryget should be enough here.

If the refcount is not zero, get it and the process of updating nr_hw_queues will wait, and we will
be safe.

If the refcount has been zeroed, it says that there is no any requests and blk_mq_queue_tag_busy_iter
needn't to do anything, so quit is OK.

Add a atomic_read(&q->mq_freeze_depth) here is unnecessary and may cause deadlock.

For example, the recovery process want to freeze and drain the queue, but the device has been dead.
We have to depend on timeout work to finish the in-flight requests with blk_mq_queue_tag_busy_iter.
But now, it cannot do nothing because this mq_freeze_depth checking.

The synchronize_rcu is indeed unnecessary after we introduce percpu_ref_tryget here.

Thanks
Jianchao


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
> +
>  	/*
>  	 * Switch IO scheduler to 'none', cleaning up the data associated
>  	 * with the previous scheduler. We will switch back once we are done
> 
