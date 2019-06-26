Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B08C48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB402086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OBEQAdaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZUVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:21:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFZUVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:21:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so5451011wme.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OEhwVsMA3XIUpQpge8sgosocEMtryj/JM+GB3rxyxT0=;
        b=OBEQAdaamQq8DPC1D4CThjy6eV1PBaNXcwZ+5jy2E8475I+WlimCxcgC3HJrBb4Iz4
         0dVkwRaL7lX/ctEdlDzagRE1VjUA7WgtIyx9GWUJ9NC106rOa7MKYzwoHJ2RscAOG+kh
         liv+OYx3WzQdJn1mrZtCIdVHhASpUGnRNKNhiZ7r/v5geqVaTiphTa45C/tD01oSWo5h
         QTrSESIxcee5CT0pENaIxan0g84iO6+Gu//kRQzqTrgZKveJizs6i+Yea/t5c+iH4IKc
         klNTP6r9pOee8VKujHJlPdpJFTYHtk11YSZvgxxI84b3uC0Vv/4Zf/sKzq4cF6jKoHjF
         Kqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OEhwVsMA3XIUpQpge8sgosocEMtryj/JM+GB3rxyxT0=;
        b=FE7zl0L7Oje0GhOq+IGV29WUvIt0Iwt8BgyHdGp85cI9nM+UlTnoI3gTTN8flFHPBw
         tIG9XBvSgju7IknynTR8EfgjP5FUoq/KV84w4396bJqDXNSXi6zEKFwWy+nvQ8TCJbnc
         bdT299i7XOkByB4hAfc61YrOcdxpcGrfjbfv+cr6gf9+Sc04ZBgO2kcz7c0kxhsdj/iB
         YeS4d+dMiHn+nod20nreL1ruUV04JM6V2imQ1TaXLO72XiXA9ESCKKOsLnHrcWzI42nh
         4I2ptS3KcpxolHDdND+TJhOAnqhhIpAktmcL4JDdJcH7Yd6K0AgeVAYjpXH4kYdMUAnX
         NK5Q==
X-Gm-Message-State: APjAAAUreMgXjjY50Vf5N7C0QtNn2LFmT0iBbzCitSfuLUjnK+vEspGK
        phdIoPeKC4I+KdJ7gnVVQqi2RA==
X-Google-Smtp-Source: APXvYqxSlsbE0PgFuCvLKbN06OJ5ff+z7EepoAOuIIAuuzNl3RxOn4db108Jy3bqKOnIlDRyHb96EQ==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr446698wmg.134.1561580471033;
        Wed, 26 Jun 2019 13:21:11 -0700 (PDT)
Received: from ziepe.ca ([148.87.23.38])
        by smtp.gmail.com with ESMTPSA id r5sm38908409wrg.10.2019.06.26.13.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:21:10 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgEPk-0001YU-12; Wed, 26 Jun 2019 17:21:08 -0300
Date:   Wed, 26 Jun 2019 17:21:08 -0300
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
Message-ID: <20190626202107.GA5850@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 26, 2019 at 12:31:08PM -0600, Logan Gunthorpe wrote:
> > we have a hole behind len where we could store flag.  Preferably
> > optionally based on a P2P or other magic memory types config
> > option so that 32-bit systems with 32-bit phys_addr_t actually
> > benefit from the smaller and better packing structure.
> 
> That seems sensible. The one thing that's unclear though is how to get
> the PCI Bus address when appropriate. Can we pass that in instead of the
> phys_addr with an appropriate flag? Or will we need to pass the actual
> physical address and then, at the map step, the driver has to some how
> lookup the PCI device to figure out the bus offset?

I agree with CH, if we go down this path it is a layering violation
for the thing injecting bio's into the block stack to know what struct
device they egress&dma map on just to be able to do the dma_map up
front.

So we must be able to go from this new phys_addr_t&flags to some BAR
information during dma_map.

For instance we could use a small hash table of the upper phys addr
bits, or an interval tree, to do the lookup.

The bar info would give the exporting struct device and any other info
we need to make the iommu mapping.

This phys_addr_t seems like a good approach to me as it avoids the
struct page overheads and will lets us provide copy from/to bio
primitives that could work on BAR memory. I think we can surely use
this approach in RDMA as well.

Jason
