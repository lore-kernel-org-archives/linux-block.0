Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B24C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 19:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D370B20652
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 19:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wt2ovZze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFTTd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:33:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35626 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfFTTd4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 15:33:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so2755786qke.2
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U0/M0hJ5KzLhd8Pu6VVXoRLFvHgguLN3K3fjwlVNVaM=;
        b=Wt2ovZze54UqqqHzCmnXCGlb5Qc3bnUJjGObm0j8zbiYre8HlvEk5208lFcXh7pfvs
         zv5mh5GND6Bykqlz3QQS9Mbg/CG59bWfywFqT02HavCh4SuLF6NAC/WP+XrfIa6Knj4B
         CdPS626RVGFyzJ8coeEllSa84zPPVHqdGM4FF5J5QBbaL1Z30OFC6v7TFAE91MmAtxB5
         5pqEAXptwIWPMJY9VB5+d3VeyRmIbMyV6lfNLd5bap3hf+isOY8MtgUb2sGq410RxNnI
         5ROVsOyIKWybeR9yAm5KdOEmV8A/m+0PJLN1KrfAMRKRy3bwQ6EqDdTUAV739zFNtR2z
         Mohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U0/M0hJ5KzLhd8Pu6VVXoRLFvHgguLN3K3fjwlVNVaM=;
        b=FwTaMUbPKQn436ALYd7n7sjgSy2Wmu8hN0JJrbZKbgwXsQpmYe8s/C9GzQkDFpn2EJ
         PL3PXA3U26Qql6/4BKnWf1iEuYPYENWfxpxNIk75b5sLmWMQH5z5WIs59Ag1adElEmjL
         wgTHaOLZATCJbVeRc/PpAp+7g6XVt5DU+wtCBKcdE9awoMkne5ONmXjtEwr0DVkg6D29
         eBq0nmjYzOv1iNzBQFVgaUmlz7KxOVjyuVqqcCKTVk9dnHDw20zWKayf7Hp0NzsdnDhW
         tttzD8QHNqDVh9qChOgWZyLC4Ggo3grxNnaLOu8pyppW29DzGivAsS55Nmk6A+vwYbis
         P9pw==
X-Gm-Message-State: APjAAAWuS7KkHs+weJgwsFZP7Z475mK8PbTe9OMH9NTK7LKdis4b22dM
        AITmSnzs98Za/FSOzuqvewoFvg==
X-Google-Smtp-Source: APXvYqzMjt1OdaqNY1f3tojkMWZyYagV+dqwE2MNLCBNiHRuxvCmS8jTQnWPWnW999Z5H3so8l5PEA==
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr64294792qkn.269.1561059234931;
        Thu, 20 Jun 2019 12:33:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k5sm298816qkc.75.2019.06.20.12.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:33:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he2ok-0006eH-0K; Thu, 20 Jun 2019 16:33:54 -0300
Date:   Thu, 20 Jun 2019 16:33:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190620193353.GF19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 20, 2019 at 11:45:38AM -0700, Dan Williams wrote:

> > Previously, there have been multiple attempts[1][2] to replace
> > struct page usage with pfn_t but this has been unpopular seeing
> > it creates dangerous edge cases where unsuspecting code might
> > run accross pfn_t's they are not ready for.
> 
> That's not the conclusion I arrived at because pfn_t is specifically
> an opaque type precisely to force "unsuspecting" code to throw
> compiler assertions. Instead pfn_t was dealt its death blow here:
> 
> https://lore.kernel.org/lkml/CA+55aFzON9617c2_Amep0ngLq91kfrPiSccdZakxir82iekUiA@mail.gmail.com/
> 
> ...and I think that feedback also reads on this proposal.

I read through Linus's remarks and it he seems completely right that
anything that touches a filesystem needs a struct page, because FS's
rely heavily on that.

It is much less clear to me why a GPU BAR or a NVME CMB that never
touches a filesystem needs a struct page.. The best reason I've seen
is that it must have struct page because the block layer heavily
depends on struct page.

Since that thread was so DAX/pmem centric (and Linus did say he liked
the __pfn_t), maybe it is worth checking again, but not for DAX/pmem
users?

This P2P is quite distinct from DAX as the struct page* would point to
non-cacheable weird memory that few struct page users would even be
able to work with, while I understand DAX use cases focused on CPU
cache coherent memory, and filesystem involvement.

> My primary concern with this is that ascribes a level of generality
> that just isn't there for peer-to-peer dma operations. "Peer"
> addresses are not "DMA" addresses, and the rules about what can and
> can't do peer-DMA are not generically known to the block layer.

?? The P2P infrastructure produces a DMA bus address for the
initiating device that is is absolutely a DMA address. There is some
intermediate CPU centric representation, but after mapping it is the
same as any other DMA bus address.

The map function can tell if the device pair combination can do p2p or
not.

> Again, what are the benefits of plumbing this RDMA special case?

It is not just RDMA, this is interesting for GPU and vfio use cases
too. RDMA is just the most complete in-tree user we have today.

ie GPU people wouuld really like to do read() and have P2P
transparently happen to on-GPU pages. With GPUs having huge amounts of
memory loading file data into them is really a performance critical
thing.

Jason
