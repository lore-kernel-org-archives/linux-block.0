Return-Path: <SRS0=Y6k2=EN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5CC2D0A3
	for <linux-block@archiver.kernel.org>; Sat,  7 Nov 2020 00:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D17E20867
	for <linux-block@archiver.kernel.org>; Sat,  7 Nov 2020 00:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aokkElWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgKGAPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgKGAPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 19:15:00 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F745C0613D2
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 16:14:59 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so2098580qts.5
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2020 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xP+5n8avN9R0PMRHtfY/hU7jf10h4hT8Klf4TvQEgQ=;
        b=aokkElWMyWDPsBa6alzqFjXX6Ty/GtCdSx9WukymLV2/BbaYYEQkA6h6NtXkVdapG2
         f4KRlQs9Y+5DAc9+pE/HHKpJIyuCn91sXpwCSZ+08lhM8dAiFiLN7V2xrbpk6hfNSKic
         ieoBgAnzjzjw2iZmefkEtA4fme7kItwUr5LmWc4Urv+NDQjlRSC80EXdjXFB3UnTz0qc
         xUHsKwFfqKXXKxkjKflCvn5HeQw2iywmUCXpbij/QRJ/D8iwlPNvI/Ibqockn0S2v+qQ
         EoTvzw1G3AJLPsWVsVolt0ALyaAOomLE+whBhiXSdjlB8hbwuoItdTWe41htAX37ZvKD
         VHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xP+5n8avN9R0PMRHtfY/hU7jf10h4hT8Klf4TvQEgQ=;
        b=ohKKZXGsgRm+iVi4Sczgle+9c/ULu2hgF1BnPON5ASbN7q83x3BBsQnHcmqm1oKLYw
         rbpCXdjxNv8OPqoUzWP/ijlnAhNlpKe3peAoc7sucQH1SwsiwwdmwSBjWthT188HVcF9
         3RxVZRneZZeGm+hRDrl1DDQnPgoQZPb9xzRv1VpkuRktNQ4QQN5mjd0EhLQHmDH58xAB
         3On4WVfDnFxRsGoXslqUT7QI2j0W5+0Tnzs66MgIp6EzQXcfnWDH0C4N40Y1p4bztJxY
         xfY1+/znCtDGVQ0EXy+8nWA5GTBIlaTM+lDmeCAdwZAQkZdLstEN+NjDa47EfO5D41v9
         7Jsg==
X-Gm-Message-State: AOAM531PFr0bIHVMjAJ/7AM/hFlHZvxqUoTTvu2KT0sw2fLMwYBqOstK
        i8lkQ9ztgJog7h6nmjZyHBmnEg==
X-Google-Smtp-Source: ABdhPJxMxLKgSiQ4x1Of97Fg4BcrbjDaTMOumnt9gw+omdxttGmxoTEsM80CNgLqS0LcZZvrtkPZNw==
X-Received: by 2002:aed:2c02:: with SMTP id f2mr4176029qtd.48.1604708098335;
        Fri, 06 Nov 2020 16:14:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u5sm1592838qtg.57.2020.11.06.16.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:14:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kbBsf-0015Rr-2V; Fri, 06 Nov 2020 20:14:57 -0400
Date:   Fri, 6 Nov 2020 20:14:57 -0400
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
Message-ID: <20201107001457.GB244516@ziepe.ca>
References: <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
 <20201106195341.GA244516@ziepe.ca>
 <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 06, 2020 at 01:03:26PM -0700, Logan Gunthorpe wrote:
> I don't think a function like that will work for the p2pmem use case. In
> order to implement proper page freeing I expect I'll need a loop around
> the allocator and vm_insert_mixed()... Something roughly like:
> 
> for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
>         vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
> 	ret = vmf_insert_mixed(vma, addr,
>   		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
> }
> 
> That way we can call pci_free_p2pmem() when a page's ref count goes to
> zero. I suspect your use case will need to do something similar.

Yes, but I would say the pci_alloc_p2pmem() layer should be able to
free pages on a page-by-page basis so you don't have to do stuff like
the above.

There is often a lot of value in having physical contiguous addresses,
so allocating page by page as well seems poor.

Jason
