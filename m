Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A36C43461
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D731610A7
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 18:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhECSZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 14:25:35 -0400
Received: from verein.lst.de ([213.95.11.211]:36678 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhECSZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 May 2021 14:25:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C9EA68B05; Mon,  3 May 2021 20:24:35 +0200 (CEST)
Date:   Mon, 3 May 2021 20:24:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
Message-ID: <20210503182434.GA17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com> <20210408170123.8788-2-logang@deltatee.com> <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com> <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com> <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 03, 2021 at 11:17:31AM -0700, John Hubbard wrote:
> That's the thing: memory failure should be exceedingly rare for this.
> Therefore, just fail out entirely (which I don't expect we'll likely
> ever see), instead of doing all this weird stuff to try to continue
> on if you cannot allocate a single page. If you are in that case, the
> system is not in a state that is going to run your dma p2p setup well
> anyway.
>
> I think it's *less* complexity to allocate up front, fail early if
> allocation fails, and then not have to deal with these really odd
> quirks at the lower levels.

Agreed.
