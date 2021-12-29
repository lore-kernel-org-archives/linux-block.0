Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49063C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 21:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhL2VEv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhL2VEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 16:04:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E71C061574
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 13:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB5ECB81840
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 21:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D62C36AEA;
        Wed, 29 Dec 2021 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640811888;
        bh=r9TaRkAh5hG/EzMILebC2Z/n/BSaJcBZ14iqrqRBHCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP9av2Nazsft5ApIm/F8qrRYVkpZMI1Sh5u16nxXneV+CWV240UbQLough77stmTj
         +uEGQ2BJJfc8GRJ/Pf66X0iVrC9OnGfT1mYBVZG95b65WDq+506Or06quxeqrrt+JV
         3ol+gqfXpz7oQdjcKfRJN/Xl8x3iPnGkTEVC5GshhyrA5SjxOzyKhjLT19CRnBz4XJ
         dW9NNEA+oUUJTkuqOdSRF0Kz7zSnS8GRCf8qdb9+nU7J5RgYNOm4xOJRTCgK+j1dVo
         a+d3ii/dTQg+kcsN8kCfTyNWpxDWx4yOn6dTAEYXpPXJryPlByDYk8CeU66//6jzLQ
         /zsyKU8hQqtjg==
Date:   Wed, 29 Dec 2021 13:04:46 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20211229210446.GC2493133@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-3-kbusch@kernel.org>
 <20211229174602.GC28058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229174602.GC28058@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 29, 2021 at 06:46:02PM +0100, Christoph Hellwig wrote:
> > +			rq_list_move(rqlist, &requeue_list, req, prev, next);
> > +
> > +			req = prev;
> > +			if (!req)
> > +				continue;
> 
> Shouldn't this be a break?

The condition just means we're at the beginning of the rqlist. There may
be more requests to consider, so we have to continue.

Or are you saying any failed prep should just abandon the batched
sequence? If so, we would need to concat the return list with the rest
of rqlist before breaking.
 
> > +			*rqlist = next;
> > +			prev = NULL;
> > +		} else
> > +			prev = req;
> > +	}
> 
> I wonder if a restart label here would be a little cleaner, something
> like:

I applied your suggestion to give it a look, and I agree. Will use that
for the next version.
