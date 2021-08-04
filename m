Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F394C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC67F61029
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhHDKCS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:02:18 -0400
Received: from verein.lst.de ([213.95.11.211]:46473 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237234AbhHDKCR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 06:02:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 766E967373; Wed,  4 Aug 2021 12:02:03 +0200 (CEST)
Date:   Wed, 4 Aug 2021 12:02:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] n64cart: fix the dma address in n64cart_do_bvec
Message-ID: <20210804100203.GA20072@lst.de>
References: <20210804094958.460298-1-hch@lst.de> <20210804130136.55f633eeb4522f844463159a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804130136.55f633eeb4522f844463159a@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04, 2021 at 01:01:36PM +0300, Lauri Kasanen wrote:
> > diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
> > index 7b4dd10af9ec..c84be0028f63 100644
> > --- a/drivers/block/n64cart.c
> > +++ b/drivers/block/n64cart.c
> > @@ -74,7 +74,7 @@ static bool n64cart_do_bvec(struct device *dev, struct bio_vec *bv, u32 pos)
> >
> >  	n64cart_wait_dma();
> >
> > -	n64cart_write_reg(PI_DRAM_REG, dma_addr + bv->bv_offset);
> > +	n64cart_write_reg(PI_DRAM_REG, dma_addr);
> >  	n64cart_write_reg(PI_CART_REG, (bstart | CART_DOMAIN) & CART_MAX);
> >  	n64cart_write_reg(PI_WRITE_REG, bv->bv_len - 1);
> 
> Hm, then how did it work? Does it always happen to be zero?

It isn't always zero, but for your use cases it might.  That is if
you have a page aligned buffer (e.g. the page cache) it tends to be
zero.

> Have you tested this? I don't have the equipment currently.

No, I don't.  I'm just auditing uses of bv_offset and this one is
clearly bogus.
