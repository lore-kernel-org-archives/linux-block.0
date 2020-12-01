Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF47C83016
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 19:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DAF206E3
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 19:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbgLATjH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:39:07 -0500
Received: from verein.lst.de ([213.95.11.211]:51136 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgLATjF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 14:39:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A23967373; Tue,  1 Dec 2020 20:38:23 +0100 (CET)
Date:   Tue, 1 Dec 2020 20:38:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201193823.GA3522@lst.de>
References: <20201201125610.17138-1-javier.gonz@samsung.com> <20201201125610.17138-5-javier.gonz@samsung.com> <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com> <20201201140348.GA5138@localhost.localdomain> <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain> <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 02, 2020 at 04:30:02AM +0900, Keith Busch wrote:
> > > In multi-path, private namespaces for a head are not in /dev, so I don't
> > > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
> > > like it will make a little bit confusions between chardev and hidden blkdev.
> > > 
> > > I don't against to update nvme-cli things also even naming conventions are
> > > going to become different than nvmeXcYnZ.
> > 
> > Agree. But as I understand it, Keith had a good argument to keep names
> > aligned with the hidden bdev. 
> 
> My suggested naming makes it as obvious as possible that the character
> device in /dev/ and the hidden block device in /sys/ are referring to
> the same thing. What is confusing about that?
> 
> > It is also true that in that comment he suggested nesting the char
> > device in /dev/nvme
> 
> Yeah, I'm okay with sub-directories for these special handles, but there
> are arguments against it too. I don't feel that strongly about it either
> way.

I'd prefer different naming for the char vs the block devices.  Yes,
this will require a little work in the userspace tools to support the
character device, but I think it is much cleaner.

Devices in subdirectories of /dev/ are very rare and keep causing problem
with userspace tooling for the few drivers that use them, so I don't
think they are a good idea.
