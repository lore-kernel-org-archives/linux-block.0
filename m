Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3374EC433B4
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 17:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9561261
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 17:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhEQRQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 13:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhEQRQC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 13:16:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AAFB61285;
        Mon, 17 May 2021 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271686;
        bh=gBtObo7/6QCuct1lI++nwYijYXvNSZxZRKnFoAxtAao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSQoNpEzzPp+Q0SofRiLXMc0x3ZPAL+arkcesSexgSMntO9Fna3V2SaJZPhTI6KBZ
         b2C7Kf9Rz3L248yMzoX5X0V8AxOJ1Zk/D/FDwcSaO0j0iiSQzSDfFpNDoZSFc13oSZ
         j3aXTQGyUvvHhMKe/AmYwiAq74AcbzYYvFGr0c+lOhh24gPyiRc8ZWM8DcIBO7CGan
         oS97aRCXaM+PuQO5X7B+uj5FrEhE6enVHqtCfYJJn6P+//Y174GtbS8PRdctB2RyHt
         mBoSpJPXee2IBfHZtXCJpcut0+v+3/zwdEQoqIhB2oFcLDDsrjqOJDq3z+QwLrju94
         CHIFZ1eiAKmJQ==
Date:   Mon, 17 May 2021 10:14:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Message-ID: <20210517171443.GB2709391@dhcp-10-100-145-180.wdc.com>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-6-kbusch@kernel.org>
 <20210426144316.GE20668@lst.de>
 <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
 <CA+1E3rLD7Zx2iKtUoTBVc4VXBj2ohXFeXSw59umBZ3Q=QEA0xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLD7Zx2iKtUoTBVc4VXBj2ohXFeXSw59umBZ3Q=QEA0xQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 17, 2021 at 10:25:21PM +0530, Kanchan Joshi wrote:
> On Mon, Apr 26, 2021 at 8:46 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Mon, Apr 26, 2021 at 04:43:16PM +0200, Christoph Hellwig wrote:
> > > On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> > > > The block layer knows how to deal with polled requests. Let the NVMe
> > > > driver use the previously reserved user "flags" fields to define an
> > > > option to allocate the request from the polled hardware contexts. If
> > > > polling is not enabled, then the block layer will automatically fallback
> > > > to a non-polled request.
> > >
> > > So this only support synchronous polling for a single command.  What
> > > use case do we have for that?  I think io_uring based polling would
> > > be much more useful once we support NVMe passthrough through that.
> >
> > There is no significant use case here. I just needed a simple way to
> > test the polled exec from earlier in the series. It was simple enough so
> > I included the patch here, but it's really not important compared to the
> > preceeding patches.
> 
> It would be great to see this in at some point; helps in making
> passthrough more useful.
> I'll look into integrating this with async-passthrough.

Right, async ioctl would really provide better justification for
passthrough polling. I'll post a new version of this series this week to
address the previously submitted feedback, but without this patch for
now.
