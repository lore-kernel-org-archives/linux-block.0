Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE54C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8047864F4D
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 07:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhCPH53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 03:57:29 -0400
Received: from verein.lst.de ([213.95.11.211]:58838 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhCPH5D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 03:57:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7222268C4E; Tue, 16 Mar 2021 08:56:58 +0100 (CET)
Date:   Tue, 16 Mar 2021 08:56:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210316075658.GA15949@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com> <20210311233142.7900-7-logang@deltatee.com> <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com> <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com> <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 06:11:17PM +0000, Robin Murphy wrote:
> Sure, that's how things stand immediately after this patch. But then 
> someone comes along with the perfectly reasonable argument for returning 
> more expressive error information for regular mapping failures as well 
> (because sometimes those can be terminal too, as above), we start to get 
> divergent behaviour across architectures and random bits of old code subtly 
> breaking down the line. *That* is what makes me wary of making a 
> fundamental change to a long-standing "nonzero means success" interface...

Agreed.  IMHO dma_map_sg actually needs to be switched to return
unsigned to help root this out, going the other way is no helpful.
