Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4435C433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B833761007
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhDSPPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhDSPPN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 11:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC3A6113C;
        Mon, 19 Apr 2021 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618845283;
        bh=LrNpik8Y2ml8d+eZ/R4YPtQ3IQkIX/0PFipEgNZK50I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWnDWAAbh+G1F4FOukkgenPnQVbzS/40e9ufPYW6VW7SNxTZpHdJJBlS+YG4k/xYp
         HpH+TEtNiFyibpFhB5QRrDZOKmh1H/EA09LvUmc9sPY5dVWFnPZh0XmRqsJ8B59siT
         m3KuhgF22gx8pQhtXyGMtqqyRBEsnhdt3rLtQFUJ7gBossoofA1VVgvYqdZtb30YbV
         5kZvrfiRLY7bjqgPcxqSuFWe0h+ow7LsCrInBoLYXMdZai+M3McnU6qt0f6PB39bxc
         miy1sLzABtalncB6PKiFzgEI+z4r7fsYvzVGxdU/KAwm21ucp3s4eKHs/SdjPPGniO
         Ay+YC4ZRYe/Yw==
Date:   Tue, 20 Apr 2021 00:14:37 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
 <20210419071605.GA19658@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419071605.GA19658@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 09:16:05AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > >         if (poll)
> > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> > 
> > Why? Those callers already provide their own callback that directly get
> > the error.
> > 
> > > How to get error ret from polled rq?
> > 
> > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > It already has the error.
> 
> But it never looks at it..

The question was how to get ret. I didn't mean to imply the example was
actually using it. :)
