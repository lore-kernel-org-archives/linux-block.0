Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB78C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 05:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiGVFuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:50:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088743E71
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6YnQZKxackpjZezhhPgWoj4Y9+hmUAS+p9B9sssh4Xs=; b=VaXJ6+lEu4Fjpc9D3g+8Vbv0k+
        D8uVnOGO776kCYGnTjG70jl7xTQ5v0ArBKDU8SLt+bPyMy5nWdXlYG5iWisCI3T/Xu1UfT5Amuz6D
        EoonfjRbhUGc/qo+vfcQfPNbRu4ZdUg7Gr1h2H49cCkaNgaKclRHvhVeYfNBIgJrOuFCbIWu8bAQ6
        SzOQUcMrNBl6R8EtJ7LGSN9v16SUsB0xekJtgZFtVPhDOJed/o6XtzFl7fJiW2IVC4NbIaNTPmN9h
        2wFzXeyTcdDMkt3wnggsJxspWmDwyVdig1ARAuSdfjCK6NbCsNbyjq+vl7ObCq7RcRn32sTlI7fkn
        gom1AQvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oElYh-000Blv-Ne; Fri, 22 Jul 2022 05:50:43 +0000
Date:   Thu, 21 Jul 2022 22:50:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 2/2] ublk_drv: make sure that correct flags(features)
 returned to userspace
Message-ID: <Yto6s09YN1FK2Zi6@infradead.org>
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722050930.611232-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 01:09:30PM +0800, Ming Lei wrote:
> +	unsigned long *map = (unsigned long *)&ub->dev_info.flags[0];
> +
> +	/* We are not ready to support zero copy */
> +	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
> +
> +	/*
> +	 * 128bit flags will be copied back to userspace as feature
> +	 * negotiation result, so have to clear flags which driver
> +	 * doesn't support yet, then userspace can get correct flags
> +	 * (features) to handle.
> +	 */
> +	bitmap_clear(map, __UBLK_F_NR_BITS, 128 - __UBLK_F_NR_BITS);

Please don't do the cast and bitmap ops.  In fact I think the current
ABI is rather nasty.  To make everyones life easier just use a single
u64 flags, an mark the second one reserved so that we can extent into
it with extra flags or something else.  That way normal C operator
leve bitops just work.

> +enum ublk_flag_bits {
> +	__UBLK_F_SUPPORT_ZERO_COPY,
> +	__UBLK_F_URING_CMD_COMP_IN_TASK,
> +	__UBLK_F_NR_BITS,
> +};

Please make these #defines so that userspace can detect if they
exist in a header using #ifdef.
