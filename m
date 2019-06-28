Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07312C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 04:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B4720656
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 04:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knQXOlDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF1E5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:57:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35521 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfF1E5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 00:57:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so2032335pgl.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 21:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=40otFp6F7wYNIWaw/L8cC57SBD2LZP+aE8/JoUmprMs=;
        b=knQXOlDKBpBtHrf+czhnvWYdz1+B5psqY/9VBnD5Bll42lCBz4ch413YItZFEx3az1
         ISaGOSH+9ewkyDPJmxpQbLOsHIo4j45b3b+bHlKbx3IC6VXuuHxvXwxYYjK6i+1yY3WO
         tnVerVdRLkJu1JQfvf1X89e6/XyVnX5bpxBuBnWwezmVJFldo6pt/YPKJkfMX2mhqiO7
         a1XAbS3B4mVVfwpLReE0DlrQwGmstqPTi1PaquRmBP8Mw+ZJqDqT5JecqvmSHEpolzBb
         zfsyGOWbgiu8k3yofhq3zpKynkFNg+JuHq+anDOUA3PRiTHXg4T0v5euRw4sm2s0YxMe
         Sf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40otFp6F7wYNIWaw/L8cC57SBD2LZP+aE8/JoUmprMs=;
        b=ZCsj/5wkD2LWKEnVCg6H3ACGEHSG2zmAy1eVrobN/pj/INCbj4mdiXUqDIqvmIjriv
         c5eeuPNzyPXDYCe8dADVk8HKQTuSTvKLTcl7kZBC0XUSOM25q6RJctJ9QvvdCxFH+ROd
         kK90e+NJadgdIvPcFAzl6ZcYDQ0ZMWQX/uM4C+smHjbUL1xYL+2stzZdCakPyB4fL3Y4
         qSXSaCK39aG5PrU3Ar+TJ8iWbp0gVnou+b51QhgypdpVAYULK+o3KOhz6aHS0Buadf1a
         2JEUGB3HXorgv9vut55ZTsPcxRpIhQ7BH+cVUNdhJuALij+lFZGEWiSjcBsKNOu4TF9+
         YEbA==
X-Gm-Message-State: APjAAAW/YqHNVtT02L4+1kyo0oJx6CeJcrTov0GjaiGPlxwFM0qgb/BM
        88wKaR9kFuZ05SzjOXuCydOtVg==
X-Google-Smtp-Source: APXvYqxTBH0nvx29YJYThIHjGxJ954k/GtXrMkQAHpN5aViwJe/lSkpGTzLn6t61soW4ouOasFHRtg==
X-Received: by 2002:a17:90a:3ac2:: with SMTP id b60mr10815350pjc.74.1561697827207;
        Thu, 27 Jun 2019 21:57:07 -0700 (PDT)
Received: from ziepe.ca ([38.88.19.130])
        by smtp.gmail.com with ESMTPSA id t24sm721884pfh.113.2019.06.27.21.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 21:57:06 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgiwb-000123-Lo; Fri, 28 Jun 2019 01:57:05 -0300
Date:   Fri, 28 Jun 2019 01:57:05 -0300
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
Message-ID: <20190628045705.GD3705@ziepe.ca>
References: <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
 <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 10:49:43AM -0600, Logan Gunthorpe wrote:

> > I don't think a GPU/FPGA driver will be involved, this would enter the
> > block layer through the O_DIRECT path or something generic.. This the
> > general flow I was suggesting to Dan earlier
> 
> I would say the O_DIRECT path has to somehow call into the driver
> backing the VMA to get an address to appropriate memory (in some way
> vaguely similar to how we were discussing at LSF/MM)

Maybe, maybe no. For something like VFIO the PTE already has the
correct phys_addr_t and we don't need to do anything..

For DEVICE_PRIVATE we need to get the phys_addr_t out - presumably
through a new pagemap op?

> If P2P can't be done at that point, then the provider driver would
> do the copy to system memory, in the most appropriate way, and
> return regular pages for O_DIRECT to submit to the block device.

That only makes sense for the migratable DEVICE_PRIVATE case, it
doesn't help the VFIO-like case, there you'd need to bounce buffer.

> >> I think it would be a larger layering violation to have the NVMe driver
> >> (for example) memcpy data off a GPU's bar during a dma_map step to
> >> support this bouncing. And it's even crazier to expect a DMA transfer to
> >> be setup in the map step.
> > 
> > Why? Don't we already expect the DMA mapper to handle bouncing for
> > lots of cases, how is this case different? This is the best place to
> > place it to make it shared.
> 
> This is different because it's special memory where the DMA mapper
> can't possibly know the best way to transfer the data.

Why not?  If we have a 'bar info' structure that could have data
transfer op callbacks, infact, I think we might already have similar
callbacks for migrating to/from DEVICE_PRIVATE memory with DMA..

> One could argue that the hook to the GPU/FPGA driver could be in the
> mapping step but then we'd have to do lookups based on an address --
> where as the VMA could more easily have a hook back to whatever driver
> exported it.

The trouble with a VMA hook is that it is only really avaiable when
working with the VA, and it is not actually available during GUP, you
have to have a GUP-like thing such as hmm_range_snapshot that is
specifically VMA based. And it is certainly not available during dma_map.

When working with VMA's/etc it seems there are some good reasons to
drive things off of the PTE content (either via struct page & pgmap or
via phys_addr_t & barmap)

I think the best reason to prefer a uniform phys_addr_t is that it
does give us the option to copy the data to/from CPU memory. That
option goes away as soon as the bio sometimes provides a dma_addr_t.

At least for RDMA, we do have some cases (like siw/rxe, hfi) where
they sometimes need to do that copy. I suspect the block stack is
similar, in the general case.

Jason
