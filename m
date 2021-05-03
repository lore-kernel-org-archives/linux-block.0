Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02BBC433B4
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E18610A7
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 18:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhECS0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 14:26:45 -0400
Received: from verein.lst.de ([213.95.11.211]:36699 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECS0p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 May 2021 14:26:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F8B568BEB; Mon,  3 May 2021 20:25:49 +0200 (CEST)
Date:   Mon, 3 May 2021 20:25:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
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
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
Message-ID: <20210503182548.GB17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com> <20210408170123.8788-3-logang@deltatee.com> <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com> <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 03, 2021 at 10:08:34AM -0600, Logan Gunthorpe wrote:
> Per above, I think the reference count is unnecessary. But I could wrap
> it in a static function for clarity. (There's no reason to export this
> function).

A well documented helper function would really help to improve the
code for the casual reader I think.
