Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDEC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D0061425
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 22:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347350AbhI2WuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347352AbhI2WuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 18:50:15 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F8C061767
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 15:48:34 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f130so3961621qke.6
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
        b=P9N1xixIbU2CQZqPgthtCxabWVb1WaKJas+T5Bbtlr4fD7rztRWCIEl7HQ9hsYT8aF
         41wF7TSRaJ3f9seP9f0KrtpHt8gvV/9kf7XUzRs3fIottSWd5Jos1b7FSN+JKsFTdWUh
         cQmc0BxR1at5W66It0VtetEvP3kxr6TgFG71lefSWpCHrqHfP2E1T4XXYFzcdwOAnPpb
         WlKs8E3Ae/btD+bQUn9uA6WCV6uRLRFmutfEb0Vg/FCMMltR8qwOKBC/i/xs0Mi5ciI7
         QAuN+ydzCbvdhC6HuPboTTSd7wkOyLMNyDUAGQreZfH9ZakjqoboD9OYItawKLMdXBtS
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
        b=mHrL5hWbmgEfobskQDYstqNm91tuVlCJrnt8MEi8m6ydZxMNVnn+C9eR0Zuard9wm9
         3QZxe3Y3xtQz3w5+g8CI5FPOVSQSXDwSgIhAAhO+jt0PPaaE73rPpifKX/f/VTxPnVgi
         c9P7Iowq6Lpof+NJYRD56NYtbORHbFUjUxsGKiA75j3S6lM8f6ktymiiNh3/8jfIKt5G
         y41ZQPNQMIiEjH6GqVgRftX4LeCEnNLxI5Lm4mmXOQLZlZp744gSbfx6xCHRVb3mswF9
         rLMOp+daSTiBM+6etogDkGuKEiLKq4F72Vdjbj89ZQJqgHspYJ+y0AtfW6yJMDBnk0Sc
         3xdQ==
X-Gm-Message-State: AOAM530NNMsfRh8Tdfy+WRm6FALDKIkNEToLmSOVCMS8ws12sxjGuNUI
        Zj02l9CGcw34rxi5UyKEHCer7Q==
X-Google-Smtp-Source: ABdhPJzspya2uDxnOQP6RHXKg0GJNOh86aMtX4Pki+BqPF0YRta2WtTuRpyPIif49H7Hs8Tu/MZ3xw==
X-Received: by 2002:a37:8ec6:: with SMTP id q189mr2083152qkd.145.1632955713476;
        Wed, 29 Sep 2021 15:48:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q14sm748591qtw.82.2021.09.29.15.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:48:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mViNL-007i7c-U2; Wed, 29 Sep 2021 19:48:31 -0300
Date:   Wed, 29 Sep 2021 19:48:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210929224831.GA3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
 <20210928194707.GU3544071@ziepe.ca>
 <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 03:34:22PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-09-28 1:47 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> >> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> >> allow obtaining P2PDMA pages. If a caller does not set this flag
> >> and tries to map P2PDMA pages it will fail.
> >>
> >> This is implemented by adding a flag and a check to get_dev_pagemap().
> > 
> > I would like to see the get_dev_pagemap() deleted from GUP in the
> > first place.
> > 
> > Why isn't this just a simple check of the page->pgmap type after
> > acquiring a valid page reference? See my prior note
> 
> It could be, but that will mean dereferencing the pgmap for every page
> to determine the type of page and then comparing with FOLL_PCI_P2PDMA.

It would be done under the pte devmap test and this is less expensive
than the xarray search.

Jason
