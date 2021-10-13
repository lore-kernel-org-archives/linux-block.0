Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B22EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635C860E0C
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhJMSAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbhJMSAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 14:00:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7636C061753
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Fe5vHx+bE8kXoZOycGIcOiOADUlVDd4HJkus+1bHmI=; b=ETpaueKbjhadfip1rhJgUzA8Pv
        89jDDtyx4KVQE4mExflsjTOHnZ0ZEac5RBXoi3oK/vg1GzVT8TA3x+2Ks1n41eIl2mErjDX0BaMC3
        T7Xm7zPhg2LBWuFvfCXkbeJurMGQRek7XY47iZSC/tUiVpIeCeVaBoT1DxupTLOHa9q+9k3oHcdUC
        zW1Z06dQNR4xhix/31zQWZuKXdTKbEC/DVtAh7SFgSbbPXRoGjCEaFajcRbx5brCvf9TLWtPd8e+R
        +ZJwXKT4ZlI3W6LChMDm6oe2327Y/b1YnhCu+2CeLz8yDr2YPNrpxCaiysYUhrDWvxf6bWwi3u23Q
        EDDhuG5w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maiUu-007gEP-Kv; Wed, 13 Oct 2021 17:57:19 +0000
Date:   Wed, 13 Oct 2021 18:57:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] block: inline fast path of driver tag allocation
Message-ID: <YWcd7NzLHv9Qt7Lx@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-3-axboe@kernel.dk>
 <YWcV52525ZR6ilwx@infradead.org>
 <ad0cc4dc-1742-87ac-73f7-2d16be37f44f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0cc4dc-1742-87ac-73f7-2d16be37f44f@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 11:46:04AM -0600, Jens Axboe wrote:
> On 10/13/21 11:22 AM, Christoph Hellwig wrote:
> > On Wed, Oct 13, 2021 at 10:49:35AM -0600, Jens Axboe wrote:
> >> If we don't use an IO scheduler or have shared tags, then we don't need
> >> to call into this external function at all. This saves ~2% for such
> >> a setup.
> > 
> > Hmm.  What happens if you just throw an inline tag onto
> > blk_mq_get_driver_tag?
> 
> I'd be surprised if that's any different than my patch in terms of
> performance, the fast path would be about the same. I don't feel
> strongly about it, can do that instead.

I find the double indirection in your patch a bit confusing.  Not a big
deal if it is actually required, but if we can avoid that I'd prefer
not to add the extra indirection.
