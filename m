Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE3C433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhLUJF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:05:57 -0500
Received: from verein.lst.de ([213.95.11.211]:46048 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236041AbhLUJF4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 04:05:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D4A5B68B05; Tue, 21 Dec 2021 10:05:52 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:05:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v4 17/23] block: add check when merging zone device
 pages
Message-ID: <20211221090552.GD7949@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com> <20211117215410.3695-18-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117215410.3695-18-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/*
> + * Consecutive zone device pages should not be merged into the same sgl
> + * or bvec segment with other types of pages or if they belong to different
> + * pgmaps. Otherwise getting the pgmap of a given segment is not possible
> + * without scanning the entire segment. This helper returns true either if
> + * both pages are not zone device pages or both pages are zone device pages
> + * with the same pgmap.
> + */
> +static inline bool zone_device_pages_are_mergeable(const struct page *a,
> +						   const struct page *b)

Merging is only really a use case here.  This really checks if they
belong to the same pgmap, so I suspect that should be in the name.
