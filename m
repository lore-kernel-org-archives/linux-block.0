Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3EEC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DD0208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 17:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XYoROQr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF1R33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:29:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40179 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF1R33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 13:29:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so2882248pgj.7
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rma7fKPl8WRrgspEuPOD2qANxVH7cGLiOLxSkWJa8ic=;
        b=XYoROQr0/ERbcbKHajZ9Ao3WWSavmnOg/Y1z8MrsPjnp/F3Mz4YCfc1CESGqd6xvqp
         G/h60ThiovpqKD4QdExA6FuXtxhUcEQN+2U/+tsZcCmKTft/Z3BVxcRSXu5AYrGtSqEt
         l66sDEwjFyZseeRQhhjOI2oAzYb7ShiVd70Qc5r4FBXt77QBTckVjCvftyqonWfZqoEB
         eYXCjr1MHIbZowSaRL54JLuZ7Tt9Ga6wnKoJx84slf19tjTeG3Woch/+c01ImrrI21mt
         43UwLOJYZ8no5rburHx8FYkfKFAzZ+oMF2zUO4JZ/STiuIyyPJ/xC586TAhOxAbO1Dd6
         XAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rma7fKPl8WRrgspEuPOD2qANxVH7cGLiOLxSkWJa8ic=;
        b=DJZ1/NkKDPGwP5I4FO73qszlTY7X0Nl+PBiOq0JjMxnz7Tx+UJC4xNSco3R5DdsSyU
         e8+g9sANTPWONdMts2xYW8PDEIUet058a3FqSPbTfFBVZ0zMkR2wpi8oY6KdxYxJTBCE
         kr/FE7D8IY3FFGYuLrTt+l9UmD6ceQuEW5HG99XlZngiJa49NNx6FIUxLDVMbvsiQxau
         3L/FnahdsyuMp8Oc3kg384SWxaA5KKPo3253H5m7JWBr1k5ozRhkLuFN0gM0NXFBqXZs
         eUMAj6tdQQoO6tHNNJC0xmgzo5uczDHygIlcozsOqFKFENXPEuJy840iv4ckv4QzeHkj
         Oc7Q==
X-Gm-Message-State: APjAAAUIRaOP6qdXs23Rry63XFywk7v1ZFumKeTLx1IyNWIINtde6XCk
        IKNP1bn1jdeTZiW91Pf5sMNi7g==
X-Google-Smtp-Source: APXvYqynICMG9uwmXh/mYczktdhjlf/b/oAI8FqIWjcwxPV0uEU4Ql2AIiqWQC9VF6cvDKyRwxevBg==
X-Received: by 2002:a63:4105:: with SMTP id o5mr10706003pga.308.1561742968383;
        Fri, 28 Jun 2019 10:29:28 -0700 (PDT)
Received: from ziepe.ca ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id d6sm2257715pgf.55.2019.06.28.10.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 10:29:27 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgugg-00015s-PF; Fri, 28 Jun 2019 14:29:26 -0300
Date:   Fri, 28 Jun 2019 14:29:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190628172926.GA3877@ziepe.ca>
References: <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
 <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
 <20190628045705.GD3705@ziepe.ca>
 <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 28, 2019 at 10:22:06AM -0600, Logan Gunthorpe wrote:

> > Why not?  If we have a 'bar info' structure that could have data
> > transfer op callbacks, infact, I think we might already have similar
> > callbacks for migrating to/from DEVICE_PRIVATE memory with DMA..
> 
> Well it could, in theory be done, but It just seems wrong to setup and
> wait for more DMA requests while we are in mid-progress setting up
> another DMA request. Especially when the block layer has historically
> had issues with stack sizes. It's also possible you might have multiple
> bio_vec's that have to each do a migration and with a hook here they'd
> have to be done serially.

*shrug* this is just standard bounce buffering stuff...
 
> > I think the best reason to prefer a uniform phys_addr_t is that it
> > does give us the option to copy the data to/from CPU memory. That
> > option goes away as soon as the bio sometimes provides a dma_addr_t.
> 
> Not really. phys_addr_t alone doesn't give us a way to copy data. You
> need a lookup table on that address and a couple of hooks.

Yes, I'm not sure how you envision using phys_addr_t without a
lookup.. At the end of the day we must get the src and target 'struct
device' in the dma_map area (at the minimum to compute the offset to
translate phys_addr_t to dma_addr_t) and the only way to do that from
phys_addr_t is via lookup??

> > At least for RDMA, we do have some cases (like siw/rxe, hfi) where
> > they sometimes need to do that copy. I suspect the block stack is
> > similar, in the general case.
> 
> But the whole point of the use cases I'm trying to serve is to avoid the
> root complex. 

Well, I think this is sort of a seperate issue. Generically I think
the dma layer should continue to work largely transparently, and if I
feed in BAR memory that can't be P2P'd it should bounce, just like
all the other DMA limitations it already supports. That is pretty much
its whole purpose in life.

The issue of having the caller optimize what it sends is kind of
separate - yes you definately still need the egress DMA device to
drive CMB buffer selection, and DEVICE_PRIVATE also needs it to decide
if it should migrate or not.

What I see as the question is how to layout the BIO. 

If we agree the bio should only have phys_addr_t then we need some
'bar info' (ie at least the offset) in the dma map and some 'bar info'
(ie the DMA device) during the bio construciton.

What you are trying to do is optimize the passing of that 'bar info'
with a limited number of bits in the BIO.

A single flag means an interval tree, 4-8 bits could build a probably
O(1) hash lookup, 64 bits could store a pointer, etc.

If we can spare 4-8 bits in the bio then I suggest a 'perfect hash
table'. Assign each registered P2P 'bar info' a small 4 bit id and
hash on that. It should be fast enough to not worry about the double
lookup.

Jason
