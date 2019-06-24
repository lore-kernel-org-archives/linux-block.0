Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63120C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F64208E4
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 13:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dy6wSAbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfFXNqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:46:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51499 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfFXNqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 09:46:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so12892341wma.1
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fHFQYC4IHk3DGA5SJeJSRcnBstbORPkvgUXGBQflcbU=;
        b=dy6wSAbb5K7xDqB+qIUCmnIAgBnIXnelPM2aUTAgaGv7Z/NwA+zSpgAUfMS9EKnB/+
         +jj7JCp465Y0rsmu4RcnTqmWLrwgYq05636vIGBfDYDKB9piVBgk3sYP3vO8O80X5Ppi
         gXr/EmPgtc+YIs7rxsHSu+tsA2DF8jL90FXxaqGLvXS7oLANJUDvhJHNsVoOv99U4/mU
         sWnSluDSDrpB/EEW9PGatqncUzFY2NrOlsDe7sfTqvDPc8e8tDQ6fx1eZaoms2T8YD7x
         GUnijP4PW6FidRXywDiiWKdcmqDowPtjb7eRZz0QEhOw0Zj/S4RIfCuqo0pSkTI13xYP
         kC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fHFQYC4IHk3DGA5SJeJSRcnBstbORPkvgUXGBQflcbU=;
        b=omrEx42w53QrBo68HvDzO2MkLrdcBTa1PdIa7eke5k82wHqusc5mdEqSyIwJkvojPZ
         BrIUbRm+GhLc6lyJ8CrXNckJaEn27SGMk+qMmbMDh0JNGkEpIwISqw6G+RaIN96Il2RW
         tQIhu6Nt/sK+IoBAlwmXk8SXNPhZgh+7bdBF4Nrb819I5vC0VSxFJdvryQ/ZvrCxm5rE
         TIiYJa9piMn9UeTrLHb34X7zJZ06LNeiw8VpRfN3A3wZjWuEA0dINX5AbpdU2ozNkIM1
         AVPrH1gvS+0MP9l5frjxC0cXipr0Xiy1+ysqG77qBk8vLQVB2syKCRa45VjsJoeaAVWf
         EADA==
X-Gm-Message-State: APjAAAVOZxpaRdTr6NEYld86GsumeufSiBV0hHUW+BHFEirfyGtLFdsh
        tP4oREml+CgFpf8S74Q3z8qD0A==
X-Google-Smtp-Source: APXvYqxH/orChM1UzN6yhkjM24At3V8ziMHSnQNkMtcNe8WEW+S3OTMlvLt8dP4L6baO7ZUaKVoRkg==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr15948959wmb.17.1561384003630;
        Mon, 24 Jun 2019 06:46:43 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id y2sm9626575wrl.4.2019.06.24.06.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 06:46:42 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfPIv-0002E2-9A; Mon, 24 Jun 2019 10:46:41 -0300
Date:   Mon, 24 Jun 2019 10:46:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624134641.GA8268@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
 <20190624073126.GB3954@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624073126.GB3954@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 24, 2019 at 09:31:26AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 20, 2019 at 04:33:53PM -0300, Jason Gunthorpe wrote:
> > > My primary concern with this is that ascribes a level of generality
> > > that just isn't there for peer-to-peer dma operations. "Peer"
> > > addresses are not "DMA" addresses, and the rules about what can and
> > > can't do peer-DMA are not generically known to the block layer.
> > 
> > ?? The P2P infrastructure produces a DMA bus address for the
> > initiating device that is is absolutely a DMA address. There is some
> > intermediate CPU centric representation, but after mapping it is the
> > same as any other DMA bus address.
> > 
> > The map function can tell if the device pair combination can do p2p or
> > not.
> 
> At the PCIe level there is no such thing as a DMA address, it all
> is bus address with MMIO and DMA in the same address space (without
> that P2P would have not chance of actually working obviously).  But
> that bus address space is different per "bus" (which would be an
> root port in PCIe), and we need to be careful about that.

Sure, that is how dma_addr_t is supposed to work - it is always a
device specific value that can be used only by the device that it was
created for, and different devices could have different dma_addr_t
values for the same memory. 

So when Logan goes and puts dma_addr_t into the block stack he must
also invert things so that the DMA map happens at the start of the
process to create the right dma_addr_t early.

I'm not totally clear if this series did that inversion, if it didn't
then it should not be using the dma_addr_t label at all, or refering
to anything as a 'dma address' as it is just confusing.

BTW, it is not just offset right? It is possible that the IOMMU can
generate unique dma_addr_t values for each device?? Simple offset is
just something we saw in certain embedded cases, IIRC.

Jason
