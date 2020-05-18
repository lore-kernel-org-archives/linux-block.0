Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB7520801
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 08:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgERIcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERIcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 04:32:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C2C05BD09
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 01:32:41 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jabCB-00057g-Hr; Mon, 18 May 2020 10:32:23 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 008161006FB; Mon, 18 May 2020 10:32:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in blk_mq_alloc_request_hctx
In-Reply-To: <20200518063937.757218-6-hch@lst.de>
References: <20200518063937.757218-1-hch@lst.de> <20200518063937.757218-6-hch@lst.de>
Date:   Mon, 18 May 2020 10:32:22 +0200
Message-ID: <871rnhzlrd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fcfce666457e2..540b5845cd1d3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -386,6 +386,20 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>  	return rq;
>  }
>  
> +static void __blk_mq_alloc_request_cb(void *__data)
> +{
> +	struct blk_mq_alloc_data *data = __data;
> +
> +	data->rq = __blk_mq_alloc_request(data);
> +}
> +
> +static struct request *__blk_mq_alloc_request_on_cpumask(const cpumask_t *mask,
> +		struct blk_mq_alloc_data *data)
> +{
> +	smp_call_function_any(mask, __blk_mq_alloc_request_cb, data, 1);
> +	return data->rq;
> +}

Is this absolutely necessary to be a smp function call? That's going to
be problematic vs. RT. Same applies to the explicit preempt_disable() in
patch 7.

Thanks,

        tglx




