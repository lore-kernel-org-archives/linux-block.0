Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50EC10DAA
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACF220C09
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670429;
	bh=EHuvVrnM07dPmNMBqcaf0SREfFCZ6XvDoOjALPhXkgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aa0NxzjN/TuTaRIt6NKgGq556H6etscsxchcxZdOtWk2MxCKVRp76zX/SRx/rV2Ab
	 sVy0XLGFiX18CT5eSiJr5z19QZmMhOzWiYRmuJELCVa/53xvHGpQgl6budiCOHyky0
	 eNqunnVF0kvUOJ7lHW8h/wpugfQ7F9zLt/CqTSrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgIIQEP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbgIIQEM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Sep 2020 12:04:12 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB5620639;
        Wed,  9 Sep 2020 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599667452;
        bh=EHuvVrnM07dPmNMBqcaf0SREfFCZ6XvDoOjALPhXkgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrtPUDUzwmiiFBSlYsP99CvXjvHsmTQy39GPYHZS5J1xTSg0FKPL75BEUPvS/lzi4
         SvyqVsWs9cVwdxQWoahNvRe98uSDZxscE89XeJSGgZPs8fu4FXlAqlb4RtlF/S4Wr1
         +yI5Mqm4pEbempPnDIOAZJjCbixaaZy60eZREKaM=
Date:   Wed, 9 Sep 2020 09:04:09 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909104116.1674592-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 09, 2020 at 06:41:14PM +0800, Ming Lei wrote:
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> -	bool rcu = false;
> +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
>  
> -	__blk_mq_quiesce_queue_nowait(q);
> +	if (!was_quiesced && blocking)
> +		percpu_ref_kill(&q->dispatch_counter);
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(hctx->srcu);
> -		else
> -			rcu = true;
> -	}
> -	if (rcu)
> +	if (blocking)
> +		wait_event(q->mq_quiesce_wq,
> +				percpu_ref_is_zero(&q->dispatch_counter));
> +	else
>  		synchronize_rcu();
>  }

In the previous version, you had ensured no thread can unquiesce a queue
while another is waiting for quiescence. Now that the locking is gone,
a thread could unquiesce the queue before percpu_ref reaches zero, so
the wait_event() may never complete on the resurrected percpu_ref.

I don't think any drivers do such a thing today, but it just looks like
the implementation leaves open the possibility.
