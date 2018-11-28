Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1137C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6E12081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AZH+f1Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6E12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeK1S1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:27:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeK1S1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NRSE1EV9x9D+GDaCdnV1ePEQEe9gbQ0wFk9kMgyRS1A=; b=AZH+f1DvkciXClEUhF7TMXGgp
        qcEhd2LmdR9jOQXr/52um/t+W783oGZW5HTGarLETfXbsHr4MjNq8Y60qQ0eIXhPVUpLWBo2wXCrO
        MT2hN2D0BJVrR69SOmaG12Wz90+gVvJLPye1GxJ6h5BmoURV2fJNF2mQwAoOgv0/B/ObJ1oR23G3f
        jtQqrssMW0GeLWx5m7OaT5off7VHhqim3RUYD1aBXWd7rQZScWnEuvX2WPEtoJCEz4xuQ3dxIT2Gb
        4KR/XscDFHhP0lIFhoURzs7Oxf2mXTQC+vQ7F3Yv7Xcs0TXK3a+kCJTLnxd4EM9PfpDxXSQF3KsdS
        thbvmqiJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRuFL-0008JV-9t; Wed, 28 Nov 2018 07:26:55 +0000
Date:   Tue, 27 Nov 2018 23:26:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/8] blk-mq: add plug case for devices that implement
 ->commits_rqs()
Message-ID: <20181128072655.GE11774@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-9-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-9-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	} else if (plug && q->mq_ops->commit_rqs) {
> +		/*
> +		 * If we have a ->commit_rqs(), then we know the driver can
> +		 * batch submission doorbell updates. Add rq to plug list,
> +		 * and flush if we exceed the plug count only.
> +		 */
> +		blk_mq_bio_to_request(rq, bio);
> +		blk_mq_put_ctx(data.ctx);
> +
> +		/*
> +		 * If we have requests for more than one queue here, we
> +		 * should sort the list when it's flushed.
> +		 */
> +		if (!plug->do_sort && !list_empty(&plug->mq_list)) {
> +			same_queue_rq = list_first_entry(&plug->mq_list,
> +						struct request, queuelist);
> +			if (same_queue_rq->q != q)
> +				plug->do_sort = true;
> +		}
> +
> +		list_add_tail(&rq->queuelist, &plug->mq_list);
> +		plug->rq_count++;
> +		if (plug->rq_count >= BLK_MAX_REQUEST_COUNT) {
> +			blk_flush_plug_list(plug, false);
> +			trace_block_plug(q);
> +		}

This seems like a slight variation of the the single queue plug
case.  Can we share the code instead of having slightly differing
logic?

Also that should this respect blk_queue_nomerges?
