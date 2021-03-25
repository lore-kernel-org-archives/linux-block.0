Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3CC433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 08:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFCE6191F
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 08:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYI06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:26:58 -0400
Received: from verein.lst.de ([213.95.11.211]:40136 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhCYI0u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 04:26:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE2A468B05; Thu, 25 Mar 2021 09:26:47 +0100 (CET)
Date:   Thu, 25 Mar 2021 09:26:47 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325082647.GA27622@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com> <20210301192452.16770-2-javier.gonz@samsung.com> <YFswq8pgzg9y00GO@x1-carbon.lan> <20210325020951.GA2105@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325020951.GA2105@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 11:09:51AM +0900, Minwoo Im wrote:
> > I was still allowed to write to NSID2:
> > 
> > sudo nvme zns report-zones -d 1 /dev/nvme0n2
> > SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: SEQWRITE_REQ   Attrs: 0x0
> > 
> > Should this really be allowed?
> 
> I think this should not be allowed at all.  Thanks for the testing!

It should not be allowed, but it seems like a pre-existing problem
as nvme_user_cmd does not verify the nsid.

> > I was under the impression that Christoph's argument for implementing per
> > namespace char devices, was that you should be able to do access control.
> > Doesn't that mean that for the new char devices, we need to reject ioctls
> > that specify a nvme_passthru_cmd.nsid != the NSID that the char device
> > represents?
> > 
> > 
> > Although, this is not really something new, as we already have the same
> > behavior when it comes ioctls and the block devices. Perhaps we want to
> > add the same verification there?
> 
> I think there should be verifications.

Yes.

> > Regardless if we want to add a verification for block devices or not,
> > it just seemed to me that the whole argument for introducing new char
> > devices was to allow access control per namespace, which doesn't seem
> > to have been taken into account, but perhaps I'm missing something.
> 
> Any other points that you think it's not been taken account?  I think it
> should map to previous blkdev operations, but with some verfications
> there.  It would be great if you can share any other points supposed to
> be supported here :)

Agreed.
