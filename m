Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8FE61185
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhIOIX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbhIOIX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:23:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA879C061575;
        Wed, 15 Sep 2021 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cnf2Z7l1EQTLpLkBteMlHZ53Wr/+qX1SRjJPZPtj5Kw=; b=ZGI1MAyFQHmfAGyw/4YdJvqSTe
        3ZceMG97ii7G0GcvEfojovEA55KFVfJ0iKpuGkbqRRxBQiFNHegRUap/3P45l4AqH0/gpm8tgJY98
        wSaL1jefV1O/+7DlhLT10nF6noACc0ZCmzbwObKhXj2WVWA2gTbFqMquqnFK4PDh/vFYQCMVDHdpd
        gdyl5S8fkt3OeoJVLrZfzeL4xpHgoxtkICPMEQd964PbN1dTXumy7/UBirodiutOW2bvMGyG34PpH
        /8jks350ROrpgjswN+7DZ+onBrnvaLhA1Q2v05dxhJwFXmbDguPItXkfOHKzWe2x1jAGeNYaCrMK1
        HuafnVMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQQ9Q-00FV1x-Mp; Wed, 15 Sep 2021 08:20:30 +0000
Date:   Wed, 15 Sep 2021 09:20:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, ming.lei@redhat.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v6 6/6] nbd: fix uaf in nbd_handle_reply()
Message-ID: <YUGswNyMnFHxigsW@infradead.org>
References: <20210915081537.1684327-1-yukuai3@huawei.com>
 <20210915081537.1684327-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915081537.1684327-7-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 04:15:37PM +0800, Yu Kuai wrote:
> +++ b/block/blk-core.c
> @@ -489,6 +489,7 @@ void blk_queue_exit(struct request_queue *q)
>  {
>  	percpu_ref_put(&q->q_usage_counter);
>  }
> +EXPORT_SYMBOL(blk_queue_exit);

These needs to be an EXPORT_SYMBOL_GPL.  But more importantly it
needs to be a separate properly documented patch, and this function
needs to grow a kerneldoc comment as well.

> +		/*
> +		 * Get q_usage_counter can prevent accessing freed request
> +		 * through blk_mq_tag_to_rq() in nbd_handle_reply(). If
> +		 * q_usage_counter is zero, then no request is inflight, which
> +		 * means something is wrong since we expect to find a request to
> +		 * complete here.
> +		 */
> +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
> +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
> +				__func__);
> +			break;
> +		}

And this needs a properly documented wrapper as well.

> +
>  		cmd = nbd_handle_reply(nbd, args->index, &reply);
> -		if (IS_ERR(cmd))
> +		if (IS_ERR(cmd)) {
> +			blk_queue_exit(q);
>  			break;
> +		}
>  
>  		rq = blk_mq_rq_from_pdu(cmd);
>  		if (likely(!blk_should_fake_timeout(rq->q)))
>  			blk_mq_complete_request(rq);
> +		blk_queue_exit(q);

That being said I can't say I like how this exposed block layer
internals.  We don't really need a reference to the queue here
anywhere, you just use it as a dumb debug check.  If we really want to
reuse (abuse?) q_usage_counter a helper to just grab a reference and
immediately drop it might be a better fit.
