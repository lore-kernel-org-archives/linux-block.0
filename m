Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA31C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 05:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E3760F9D
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 05:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhJZF4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:56:19 -0400
Received: from verein.lst.de ([213.95.11.211]:60418 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhJZF4S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 01:56:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D6506732D; Tue, 26 Oct 2021 07:53:52 +0200 (CEST)
Date:   Tue, 26 Oct 2021 07:53:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] memremap: remove support for external pgmap
 refcounts
Message-ID: <20211026055352.GA30117@lst.de>
References: <20211019073641.2323410-1-hch@lst.de> <20211019073641.2323410-3-hch@lst.de> <YXFtwcAC0WyxIWIC@angband.pl> <20211022055515.GA21767@lst.de> <CAPcyv4joX3K36ovKn2K95iDtW77jJwoAgAs5JSRMcETff=-brg@mail.gmail.com> <CAPcyv4gFCRs_OJ1TutBi-tmWWS2pU_D+bqJVwCcp=7dCMkhGEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gFCRs_OJ1TutBi-tmWWS2pU_D+bqJVwCcp=7dCMkhGEw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 06:42:51PM -0700, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 8:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Oct 21, 2021 at 10:55 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 03:40:17PM +0200, Adam Borowski wrote:
> > > > This breaks at least drivers/pci/p2pdma.c:222
> > >
> > > Indeed.  I've updated this patch, but the fix we need to urgently
> > > get into 5.15-rc is the first one only anyway.
> > >
> > > nvdimm maintainers, can you please act on it ASAP?
> >
> > Yes, I have been pulled in many directions this past week, but I do
> > plan to get this queued for v5.15-rc7.
> 
> Ok, this is passing all my tests and will be pushed out to -next tonight.

FYI, patch 2 needs a trivial compile fix for the p2p case.  But I suspect
given how late in the cycle we are you're only picking up patch 1 anyway.
