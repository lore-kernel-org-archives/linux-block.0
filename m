Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAEFC48BE3
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 23:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F6E2070B
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 23:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0cnLFHw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFTXkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:40:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37299 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTXkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 19:40:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so3434546oih.4
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scNy0Tfe+BdKZYj5qpcGlHdmruocVLL136U7yeONjQY=;
        b=0cnLFHw3wyYOy7GJtgs9QmCRnq9eswmVPzeiBI0nzxLIy08w2sne8Vna1Y1grmzkuK
         orXF6GaJfScNIrL+CmEEjfEWeebyFY2BN5C/NjI21notoMZHMFZD8O85FX4FqZJ8Z8r9
         c9WxGq/LLz3LwW3HtljqhWfi0h5SxokaderedRePsLiY444AX/karrDFsSoksoWcCCgZ
         +7KfzBlJb6BYSae/aXYMhV6RyOh/BJhvk9JSH7sv18Mz9knbjhajd4FDNRnGNZuLTc2X
         k/ws4WPi1RFgTyfCmAwHTUeSPhtAYFKNfpXRN3OehGFyz6DqnUc2COeygcoP24s922vi
         ch3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scNy0Tfe+BdKZYj5qpcGlHdmruocVLL136U7yeONjQY=;
        b=sWsj/2fSizEAtjDmIo9l1rp0tagS0HGfs/reUsYlQTWlVG4Nu8Cp1xawDRUpT2I1/R
         n4ix6qiN5PFeY3Zbm7mkiBL0dxEwJm55JMFpSFhPfRID+fALcPuCtLzh80YcD1auOQ9o
         hZFTTtfQ/lWfTFy88hhO5Zkw8XaFZETpCEdlOubDdWgpgOuSYwCUI6c46XBSZtSNBndr
         6oEpY+lzsAqLuoLcuPHeEttkPit7xTL1yGOYh9Vn+ENBu0/ut1rx0a8PA9qTvLatHmzQ
         jd+Q08zjOGgt4A6paPlQCkPCkzfgdAD7zc9Fj3T+loYZPIM+2KBORPefptSxWBVWraSI
         A/pQ==
X-Gm-Message-State: APjAAAU09vIYqPYejy0v3R92AGMf47yJJ9ZXUPKMsTd/8LIvLLF1AthZ
        gxAHsCop+6PM4rGLAdYvyJnUsPiPFLtsd4HkHjW8kA==
X-Google-Smtp-Source: APXvYqy+dAobdNgdfPhzhP0DQIKrQv88wgGeAk/7F+FLUOR+10JaG31ibuPbYrW/Rv/5imGwwlnZKa4QroXz2NVXZYc=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr901169oih.73.1561074051695;
 Thu, 20 Jun 2019 16:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190620161240.22738-1-logang@deltatee.com> <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <91eba9a0-27b4-08b4-7c12-86e24e1bfe85@deltatee.com>
In-Reply-To: <91eba9a0-27b4-08b4-7c12-86e24e1bfe85@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 16:40:40 -0700
Message-ID: <CAPcyv4gPOXaL3qks6RMufu==O9RV2m_-7bBmJqKOFYTf4v_jXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 20, 2019 at 12:35 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-06-20 12:45 p.m., Dan Williams wrote:
> > On Thu, Jun 20, 2019 at 9:13 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >> For eons there has been a debate over whether or not to use
> >> struct pages for peer-to-peer DMA transactions. Pro-pagers have
> >> argued that struct pages are necessary for interacting with
> >> existing code like scatterlists or the bio_vecs. Anti-pagers
> >> assert that the tracking of the memory is unecessary and
> >> allocating the pages is a waste of memory. Both viewpoints are
> >> valid, however developers working on GPUs and RDMA tend to be
> >> able to do away with struct pages relatively easily
> >
> > Presumably because they have historically never tried to be
> > inter-operable with the block layer or drivers outside graphics and
> > RDMA.
>
> Yes, but really there are three main sets of users for P2P right now:
> graphics, RDMA and NVMe. And every time a patch set comes from GPU/RDMA
> people they don't bother with struct page. I seem to be the only one
> trying to push P2P with NVMe and it seems to be a losing battle.
>
> > Please spell out the value, it is not immediately obvious to me
> > outside of some memory capacity savings.
>
> There are a few things:
>
> * Have consistency with P2P efforts as most other efforts have been
> avoiding struct page. Nobody else seems to want
> pci_p2pdma_add_resource() or any devm_memremap_pages() call.
>
> * Avoid all arch-specific dependencies for P2P. With struct page the IO
> memory must fit in the linear mapping. This requires some work with
> RISC-V and I remember some complaints from the powerpc people regarding
> this. Certainly not all arches will be able to fit the IO region into
> the linear mapping space.
>
> * Remove a bunch of PCI P2PDMA special case mapping stuff from the block
> layer and RDMA interface (which I've been hearing complaints over).

This seems to be the most salient point. I was missing the fact that
this replaces custom hacks and "special" pages with an explicit "just
pass this pre-mapped address down the stack". It's functionality that
might plausibly be used outside of p2p, as long as the driver can
assert that it never needs to touch the data with the cpu before
handing it off to a dma-engine.
