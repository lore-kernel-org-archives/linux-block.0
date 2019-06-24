Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C6DC43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CB1213F2
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 13:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfFXNu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:50:59 -0400
Received: from verein.lst.de ([213.95.11.211]:55239 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfFXNu7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 09:50:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E2349227A82; Mon, 24 Jun 2019 15:50:24 +0200 (CEST)
Date:   Mon, 24 Jun 2019 15:50:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20190624135024.GA11248@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com> <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com> <20190620193353.GF19891@ziepe.ca> <20190624073126.GB3954@lst.de> <20190624134641.GA8268@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624134641.GA8268@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 24, 2019 at 10:46:41AM -0300, Jason Gunthorpe wrote:
> BTW, it is not just offset right? It is possible that the IOMMU can
> generate unique dma_addr_t values for each device?? Simple offset is
> just something we saw in certain embedded cases, IIRC.

Yes, it could.  If we are trying to do P2P between two devices on
different root ports and with the IOMMU enabled we'll generate
a new bus address for the BAR on the other side dynamically everytime
we map.
