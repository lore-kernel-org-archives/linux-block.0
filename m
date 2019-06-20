Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03153C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D084E2083B
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aJC5IbH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFTQtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:49:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40836 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFTQtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 12:49:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so2378971qkg.7
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=829lbkNVKVvO4IPRXGAwDfDwkNN3afdAsnYF+a2YEsM=;
        b=aJC5IbH09VqJ5L3x0Q2P/vdyGVj04jt+mOrx8MojMr34HRL9FTmxFEg2TQhHifyDZQ
         zJGpxBPdLE71kW8SpPaYQSQWCVmyOhq1uOAmmKBIEN1rx7yhd1GioZ2gCS8hKvWMwuGs
         Ec0/B4GH/O+G+7ljUgQ5LlaF/Bjjq3TqiBOS0/qgjrWpIrW2VurIj26fyeXJYmhMhTCo
         cMW7nwDNhlIjYLXWE1Eg9qDAte24DnQqGNVoJKhyKGoLtKGNEVDUKEx/5jgAMHSIBGBO
         8PMOE7Csa87nMhCTnW03D69d9h7ValFpBP7C4i9r5HRnKMQV1y5wzzjsye3BHTyIMbA9
         DqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=829lbkNVKVvO4IPRXGAwDfDwkNN3afdAsnYF+a2YEsM=;
        b=E1Dt3DmoDrw1ddfVPFvyKJ3lhoxDcucTWqKUJrE/tuhms44eoS7zCT3HNOwNx8KrEw
         2xwgGB1sGeCj2WIrJXYWYQVR0b8tg1e35xLzJQMA98i5GP0XCwsPGomvN90aDLPVlDjb
         bhmS4dDTFV8swmFpA13iQ6MiNu9UZzwWIUAkvsDBuniF9kmq0pGtSKk3IfR012bMMNfU
         FsX3gfVSpTOoMVcJUOW+XnnOJKaaEvHKywOdy75Rczk33OSU0uOeKpXRUMSDECxkzjut
         jPQ5Gnfr8Ts+xG8JauBPdCxH1sUL2S0Y4AcMoaylRvYky6QvtLHo6NBs/PvldEStMiUX
         G4Ag==
X-Gm-Message-State: APjAAAUSLPNeuxvc2ir5SXLEe6Orzpd9C2drlY/U52hx/3DXG+Ogaj5+
        Xl/izYwPnCQuJptB8WZa/bUQvA==
X-Google-Smtp-Source: APXvYqw7o+HXcNgbAT7Mxcu/N67Vdjqf/udIRQ32pWb17pSApuDTFWC8DfL+yTMaUbEhp4oKyoolPg==
X-Received: by 2002:ae9:ee17:: with SMTP id i23mr1814457qkg.401.1561049350327;
        Thu, 20 Jun 2019 09:49:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u7sm94016qta.82.2019.06.20.09.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 09:49:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he0FJ-0005H9-BN; Thu, 20 Jun 2019 13:49:09 -0300
Date:   Thu, 20 Jun 2019 13:49:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 20/28] IB/core: Introduce API for initializing a RW
 ctx from a DMA address
Message-ID: <20190620164909.GC19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190620161240.22738-21-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620161240.22738-21-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 20, 2019 at 10:12:32AM -0600, Logan Gunthorpe wrote:
> Introduce rdma_rw_ctx_dma_init() and rdma_rw_ctx_dma_destroy() which
> peform the same operation as rdma_rw_ctx_init() and
> rdma_rw_ctx_destroy() respectively except they operate on a DMA
> address and length instead of an SGL.
> 
> This will be used for struct page-less P2PDMA, but there's also
> been opinions expressed to migrate away from SGLs and struct
> pages in the RDMA APIs and this will likely fit with that
> effort.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/infiniband/core/rw.c | 74 ++++++++++++++++++++++++++++++------
>  include/rdma/rw.h            |  6 +++
>  2 files changed, 69 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> index 32ca8429eaae..cefa6b930bc8 100644
> +++ b/drivers/infiniband/core/rw.c
> @@ -319,6 +319,39 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
>  }
>  EXPORT_SYMBOL(rdma_rw_ctx_init);
>  
> +/**
> + * rdma_rw_ctx_dma_init - initialize a RDMA READ/WRITE context from a
> + *	DMA address instead of SGL
> + * @ctx:	context to initialize
> + * @qp:		queue pair to operate on
> + * @port_num:	port num to which the connection is bound
> + * @addr:	DMA address to READ/WRITE from/to
> + * @len:	length of memory to operate on
> + * @remote_addr:remote address to read/write (relative to @rkey)
> + * @rkey:	remote key to operate on
> + * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
> + *
> + * Returns the number of WQEs that will be needed on the workqueue if
> + * successful, or a negative error code.
> + */
> +int rdma_rw_ctx_dma_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> +		u8 port_num, dma_addr_t addr, u32 len, u64 remote_addr,
> +		u32 rkey, enum dma_data_direction dir)

Why not keep the same basic signature here but replace the scatterlist
with the dma vec ?

> +{
> +	struct scatterlist sg;
> +
> +	sg_dma_address(&sg) = addr;
> +	sg_dma_len(&sg) = len;

This needs to fail if the driver is one of the few that require
struct page to work..

Really want I want to do is to have this new 'dma vec' pushed through
the RDMA APIs so we know that if a driver is using the dma vec
interface it is struct page free.

This is not so hard to do, as most drivers are already struct page
free, but is pretty much blocked on needing some way to go from the
block layer SGL world to the dma vec world that does not hurt storage
performance.

I am hoping that the biovec dma mapping that CH has talked about will
give the missing pieces.

FWIW, rdma is one of the places that is largely struct page free, and
has few problems to natively handle a 'dma vec' from top to bottom, so
I do like this approach.

Someone would have to look carefully at siw, rxe and hfi/qib to see
how they could continue to work with a dma vec, as they do actually
seem to need to kmap the data they are transferring. However, I
thought they were using custom dma ops these days, so maybe they just
encode a struct page in their dma vec and reject p2p entirely?

Jason
