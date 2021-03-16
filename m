Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1EFC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C40864F77
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 08:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhCPIBN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:01:13 -0400
Received: from verein.lst.de ([213.95.11.211]:58903 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhCPIAz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 04:00:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AA4368C65; Tue, 16 Mar 2021 09:00:52 +0100 (CET)
Date:   Tue, 16 Mar 2021 09:00:52 +0100
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
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 09/11] block: Add BLK_STS_P2PDMA
Message-ID: <20210316080051.GD15949@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com> <20210311233142.7900-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-10-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:39PM -0700, Logan Gunthorpe wrote:
> Create a specific error code for when P2PDMA pages are passed to a block
> devices that cannot map them (due to no IOMMU support or ACS protections).
> 
> This makes request errors in these cases more informative of as to what
> caused the error.

I really don't think we should bother with a specific error code here,
we don't add a new status for every single possible logic error in the
caller.
