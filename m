Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D167C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FD961359
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDZPQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZPQW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 11:16:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0024D61178;
        Mon, 26 Apr 2021 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619450140;
        bh=TvfpsmgvZ2FA72prfYrnZr+UaAU/xsQv8DOrfXFrwVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tK4M+enpvQz1JSFUzCh1M0CnaG7unwOhtVrd9dKAVaF0xAyc0lYwyaVRog4aTSrol
         5ArkX4XPy5OXVB2s7J22o7KdULLYhzIqOkt4ZKRJ925XpvIvLGEZtqtykdR7WSjsk5
         yzhC21IFthMkU2yGpwc/LagALhJHSGnP3tjgbFFluvMMhM3GpZ7HSHOxdmvM1xWiCi
         EtNauQZiimsGJcd0RSZyGbAo04AWoTI0jpppx04XkeNceHB3nB21l/ZWjXM3aUoJhw
         gYIGZcuVMi9EvrJpfb8OjDQidtobz/PRay4y1nNtTlglsuRGem/SGZr+SY7XCwHO3O
         wmmIDQ6OF+fEQ==
Date:   Tue, 27 Apr 2021 00:15:37 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Message-ID: <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-6-kbusch@kernel.org>
 <20210426144316.GE20668@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426144316.GE20668@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 04:43:16PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> > The block layer knows how to deal with polled requests. Let the NVMe
> > driver use the previously reserved user "flags" fields to define an
> > option to allocate the request from the polled hardware contexts. If
> > polling is not enabled, then the block layer will automatically fallback
> > to a non-polled request.
> 
> So this only support synchronous polling for a single command.  What
> use case do we have for that?  I think io_uring based polling would
> be much more useful once we support NVMe passthrough through that.

There is no significant use case here. I just needed a simple way to
test the polled exec from earlier in the series. It was simple enough so
I included the patch here, but it's really not important compared to the
preceeding patches.
