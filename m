Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A468C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 01:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9562146F
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 01:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zLnkrnO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfC1BnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:43:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1BnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 21:43:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S1ewe3039587;
        Thu, 28 Mar 2019 01:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6f3n5sty/WuNSD8LzRtxHlCFLR5BtbNn/e4hgvQve8w=;
 b=zLnkrnO+0aW4AUZyR272K1+KyYGOJJRKSB28Ct1vR4CYX6GCkt9OPhcfS/zOVe5qkF81
 DxPv2/OtiL73lKmX+3uS5MTYy3UgBptXiH+TdG0LImJsY8fmfBaG2RufL8LzuKUvAnCT
 E91OGkWuYHYhlwQUanwyuQ7traVv891gIUaAK5J+aE9gt4CX40rB+R7gd0gbNFNe/M3D
 s9SaTOMb8Q6HLPucUINRswoDl+zdVN8SLZ3Vb9+fo0TRrbngW4Dz43w1EJwn8VBs1Uwm
 u17Rf1nzbzXeUy/rf1xnEue37bbIqjIBRKb1P3coO2mUaM0VJYwGgCrV/Jzpwrb/KZRc RA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6djkwbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:42:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2S1gmh3029293
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:42:49 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2S1gmG4031987;
        Thu, 28 Mar 2019 01:42:48 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 18:42:48 -0700
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com> <20190311184031.GA11707@lst.de>
 <20190311193753.GE10411@localhost.localdomain>
 <20190327083142.GQ20525@lst.de> <20190327132116.GA8419@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3d72ec9f-0aa5-d455-b453-40c319871287@oracle.com>
Date:   Thu, 28 Mar 2019 09:42:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327132116.GA8419@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/27/19 9:21 PM, Keith Busch wrote:
> On Wed, Mar 27, 2019 at 01:31:42AM -0700, Christoph Hellwig wrote:
>>> Okay, I may even be able to drop the new block exports if we do request
>>> termination in generic block layer. That's probably the right thing
>>> anyway since that layer is in a better position to check the necessary
>>> conditions that make tag iteration safe. Bart did point out that is
>>> generally not safe for drives to do, so it'd be good to safegaurd against
>>> incorrect usage.
>>
>> Did you get a chance to look into this?
> 
> I haven't had a chance to put it through the proper tests (I no longer
> have a hotplug machine), but this is what I'd written if you can give it
> a quick look:
> 
> From 5afd8e3765eabf859100fda84e646a96683d7751 Mon Sep 17 00:00:00 2001
> From: Keith Busch <keith.busch@intel.com>
> Date: Tue, 12 Mar 2019 13:58:12 -0600
> Subject: [PATCH] blk-mq: Provide request termination API
> 
> A driver that determined hardware contexts backing its request queue
> is unable to service new commands, it would have to end those commands
> in its IO path. This requires unlikely checks per-IO.
> 
> Create a new API that terminates all requests directly rather than
> requiring those requests get flushed through the low level driver. This
> is safe only if the current request allocation state is unchanging, so
> driver must have quiesced and initiated a freeze on its queue, and after
> it has reclaimed any in flight requests so that the tag iterator is not
> racing with in flux requests. The new API enforces these conditions in
> order to successfully terminate requests.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-mq.c         | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c181603cbd..ad98c27e2b34 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -952,6 +952,42 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	blk_queue_exit(q);
>  }
>  
> +static bool blk_mq_terminate_request(struct blk_mq_hw_ctx *hctx,
> +		struct request *rq, void *priv, bool reserved)
> +{
> +	int *hctx_idx = priv;
> +
> +	if (WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE))
> +		return false;
> +	if (hctx->queue_num >= *hctx_idx)
> +		blk_mq_end_request(rq, BLK_STS_IOERR);
> +	return true;
> +}
> +
> +/**
> + * blk_mq_terminate_queued_requests() - end requests with an error queued on
> + *					hardware contexts at and above the
> + *					provided index.
> + * @q: request queue
> + * @hctx_idx: starting hardware context, 0 for all hctx's
> + *
> + * A low level driver should invoke this routine when its hardware contexts are
> + * not capable of handling future requests. The caller must ensure their
> + * request_queue is quiesced, freeze initiated, and all dispatched requests
> + * have been reclaimed so the tag iteration has a static request allocation to
> + * consider.
> + */
> +void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx)
> +{
> +	if (WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth)))
> +		return;
> +	if (WARN_ON_ONCE(!blk_queue_quiesced(q)))
> +		return;
> +	blk_sync_queue(q);
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_request, &hctx_idx);
> +}


Is it really OK to end these requests directly w/o dequeue ?
All of them are on ctx->rq_list, or hctx->dispatch list or internal queue of io scheduler.

Terrible things may happen after we unquiesce the queue.

Thanks
Jinchao

> +EXPORT_SYMBOL(blk_mq_terminate_queued_requests);
> +
>  struct flush_busy_ctx_data {
>  	struct blk_mq_hw_ctx *hctx;
>  	struct list_head *list;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index a64b3fdce0b0..d47cd4575abb 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -334,6 +334,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
>  
>  void blk_mq_quiesce_queue_nowait(struct request_queue *q);
> +void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx);
>  
>  unsigned int blk_mq_rq_cpu(struct request *rq);
>  
> 
