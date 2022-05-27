Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D8C433FE
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354277AbiE0TDP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiE0TDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 15:03:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE3023BEB
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 12:03:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b200so5548002qkc.7
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=;
        b=pCvvJmfpoo0WDFfVQYDyZGy4qzndOFVtgtSqVXTrWRGEyBqzBA7UAXhKvpkD0Q9/6I
         MSCpLxGE9cFQ1cGdQAtYz+UeGuecy1S3YR7ZbQ9wbQYDjQVRsaTuBol2dHTD44aSUBRR
         IycaJl0ihzjjIE0NocdjmVE2xhgAzy3ISwyDQK8gAI5+MC0ECVrWBJsD5Ckxr01Dq6tm
         NfD6L2oXhGqyHayMYe3j/EFrEVhX3h/t4cx5QraZ38JTD9HD3wAryzP4gzJYXUsnDZYo
         kHgGnIpoEzZEBX8KlbDHtvDbydY35MkFThf2P8sBKcZrGoTNzHOqvBFv/Fi48v3KK05/
         5Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=;
        b=wwBZgSjur1PPGbfUGcsNr1ZtNQKYlBYyJW67pCC+gaCEO03GADmlbmyWV68j5OOFdg
         /p/9eWFI0k2i5SIhTaW3NQPbWLLOxOBnIZSZTPAUMt2QHX54qbQPwqDwVw1Q6cEEAhRd
         nBoR5vMrt6I6Y0dXQfX8yt+IwTzYXX/PWJAXceQa7BZCLOrbqBrUeeOufOXl8a0OPRo0
         OKkVEus7fw/ZTFI4Kxwz6ENRwNtewXOCvdYu578afwsJSP+9wBRjwYIY/o3k4Odwb/sQ
         qC5hHPk8/+3aK0c8qgVNL21l0JxXixP8I3mlXN74TMpMpP1yUR2SyUCR39KSJhwO2Snu
         ih0w==
X-Gm-Message-State: AOAM533JigbXgjWLrcs7K+C0p3tB+9C5Ij789xXpl8fs7HP5HY7TjfZu
        jlISKCslB/cd+U7Df67J+Sem5w==
X-Google-Smtp-Source: ABdhPJyO25WugHG0nEenLRCgTZGSyoFZr8oLpCObiI0Q0Dbj3autEreqfFCD221s7ojQxz7nAKospA==
X-Received: by 2002:a05:620a:298e:b0:6a0:94d2:2e2d with SMTP id r14-20020a05620a298e00b006a094d22e2dmr30141554qkp.353.1653678192374;
        Fri, 27 May 2022 12:03:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a079600b0069fe1dfbeffsm3024426qka.92.2022.05.27.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:03:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nufEp-00Dd1y-Rg; Fri, 27 May 2022 16:03:07 -0300
Date:   Fri, 27 May 2022 16:03:07 -0300
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220527190307.GG2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 27, 2022 at 09:35:07AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-05-27 06:55, Jason Gunthorpe wrote:
> > On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
> >> +static void pci_p2pdma_unmap_mappings(void *data)
> >> +{
> >> +	struct pci_dev *pdev = data;
> >> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> >> +
> >> +	/* Ensure no new pages can be allocated in mappings */
> >> +	p2pdma->active = false;
> >> +	synchronize_rcu();
> >> +
> >> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> >> +
> >> +	/*
> >> +	 * On some architectures, TLB flushes are done with call_rcu()
> >> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
> >> +	 * before freeing them.
> >> +	 */
> >> +	synchronize_rcu();
> >> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> > 
> > With the series from Felix getting close this should get updated to
> > not set pte_devmap and use proper natural refcounting without any of
> > this stuff.
> 
> Can you send a link? I'm not sure what you are referring to.

IIRC this is the last part:

https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/

And the earlier bit with Christoph's pieces looks like it might get
merged to v5.19..

The general idea is once pte_devmap is not set then all the
refcounting works the way it should. This is what all new ZONE_DEVICE
users should do..

Jason
