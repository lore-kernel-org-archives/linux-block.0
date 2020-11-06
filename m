Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA10C388F2
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 17:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F1E217A0
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 17:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MOCiBjSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFRm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbgKFRm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 12:42:26 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B12C0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 09:42:25 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i21so1794898qka.12
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2020 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
        b=MOCiBjSN2a1hPwUL+FJFYuzQlwO8wmt6NgCt9FaTyLzUmSuNFZ8pJFJjnpYDGgsQ26
         a8j6AjUBHGPJgl1+H9vdmuYPkKU68pFmYfvE9HQawmCY4vIz+ZApkGBVOkd9dWhh0DXa
         q56QEyRr53QyWSixEoTgaJPahFsdyxl3XbdZlglN7e+iI0rw/ar1o9FTO4zJteIHNrs9
         fCSMQ6f2iYfcLKZJGeHkqKVzX2CdNVjmmqzCZDSDIw8FQ5JzVVCMMhMKmUFdxYZt2g0v
         2SDXecJEMacL6cL9Se7kxpJ/LhH+/YR2QfiDFmQPiXf/MhTYpep4QtUSKXYnfiMtIam2
         37AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
        b=ullCbv7c7GOc7PyMpa4g0n+EoNdBsEjygkNhVqb7Uv/gk1A4h2cvOHO6QLQS4hk8aq
         aG96dXy+rAwP9GiqgT4/6ntFizY8DPuj/bjWQMfDPkD5vs8t/2u9JGZcawFjOimDgsUx
         XiQcOAihubvgBzTw8ietyCuwUGUFmNJo40tWPQbxXQ4ZE76o3ywECz3FRfJpbT2FbhQa
         OmPUQB+779Z5dqfWmIddYHCTErOAhMBUIMBbmBUdaUQvhvTl0UbYMOmRuWvrubqt0M57
         RPeTCAao5ApfSC4ZLMZ3ocIv/vIh5ouDSIxCSxCRG072gcm2O+neWz+fpHOekqHMgL2U
         obXw==
X-Gm-Message-State: AOAM532HWOcG1Cfphi/L/CB1/2gUuRQ0CeDL1sStPy8PLeI/Hwm0FtRV
        F7FBx7Z3xnc+YvuNaWe3uwFIsg==
X-Google-Smtp-Source: ABdhPJyPUMTPAlvbc5F9DgPZcTHH53XJriCxbWePpFu8+RK+GJP/zdnWVlnoJA0LQqWFmkayCjYz/g==
X-Received: by 2002:a37:9441:: with SMTP id w62mr2652751qkd.474.1604684545012;
        Fri, 06 Nov 2020 09:42:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t65sm1006283qkc.52.2020.11.06.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:42:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb5kl-000zVc-Ja; Fri, 06 Nov 2020 13:42:23 -0400
Date:   Fri, 6 Nov 2020 13:42:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106174223.GU36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
> > On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> >> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> >> a hunk of p2pmem into userspace.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/pci-p2pdma.h |   6 +++
> >>  2 files changed, 110 insertions(+)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 9961e779f430..8eab53ac59ae 100644
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/genalloc.h>
> >>  #include <linux/memremap.h>
> >>  #include <linux/percpu-refcount.h>
> >> +#include <linux/pfn_t.h>
> >>  #include <linux/random.h>
> >>  #include <linux/seq_buf.h>
> >>  #include <linux/xarray.h>
> >> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> >>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> >> +
> >> +struct pci_p2pdma_map {
> >> +	struct kref ref;
> >> +	struct pci_dev *pdev;
> >> +	void *kaddr;
> >> +	size_t len;
> >> +};
> > 
> > Why have this at all? Nothing uses it and no vm_operations ops are
> > implemented?
> 
> It's necessary to free the allocated p2pmem when the mapping is torn down.

That's suspicious.. Once in a VMA the lifetime of the page must be
controlled by the page refcount, it can't be put back into the genpool
just because the vma was destroed.

Jason
