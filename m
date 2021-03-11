Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54757C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 00:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4BA64F86
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 00:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhCLAAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhCKX7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 18:59:46 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDFC061574
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 15:59:46 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f12so2555476qtq.4
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
        b=Sht35sRAWhjUnG/vlACxlUdN1NXxZ2hn78xSNsQrOQiOnK1nALUmlUGHUAK1T+DYhZ
         MX3lwQI/UxwTrkQv8d3kMYROr1PLyoiqVafUPMi7P056ufFmL/tRZlvShlZxbmxqDyNW
         NLKw5iBy24OxHbW+DCJ1DQJfzdSe8iTc3c8sHbtF9tFwbdZcos5KLgrKfPlUhIrDUvII
         vIew7klGAO8Wn/28Da6K3YhKEWpKl3Z8yXO4c0K2hvWjTBIXhDYwZP0hefzSiur217jB
         Lo+rOwqj5lF4a/tIzhlWfi67C2vz4vtRgSFudHgU/4CmiKi4zEw8bQzulGoxFckdnomp
         ZbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
        b=ttKHLpZVJNYF8rwFF8SsSb34/LlZbpmcqylWw0gRcOa1iyuW+vua4rl4+e58pi/uv0
         G8OEAnfWNGcRZ0JD4tvJZG3hxYjBcrt6+uajWm4iJ6KBA4NVfkn4d/jyMo3vmPrplsjp
         byPKxrBA86DNsPbwtBbzGOOxEjjYft+ZWVyh3QfPe5WO4jToH5LUwcabFMueZjTLnxpE
         eSgASGO+1sAf8yyaC7uXwHNaZBsyBHzZXHC52OFEZo9JIWbZfcYB+ONxWIUFKOQNu7Qf
         5J/xe79vBbhUlInwo+k+pMkF/rmIbTYHGUWSXJvczb3Buh8HqKXu/T3OWZN2cIFjt9jD
         gRIQ==
X-Gm-Message-State: AOAM533yeD/c2+D1pg3Cig+/3mco5IrG3u+IOT6sQQCe7iKmClG92tYy
        HwUV/syeVrgVbWLFekdM0DWOaQ==
X-Google-Smtp-Source: ABdhPJxiCSaM0aAia7Gh2ystvnvxFkgXLtQu1szm+rOtvCsRMIOPRh5BDiwH0XxEbvHajGL8eIa3Yg==
X-Received: by 2002:aed:20cd:: with SMTP id 71mr9996620qtb.346.1615507185328;
        Thu, 11 Mar 2021 15:59:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z89sm2953405qtd.5.2021.03.11.15.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:59:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lKVDT-00BbRW-RG; Thu, 11 Mar 2021 19:59:43 -0400
Date:   Thu, 11 Mar 2021 19:59:43 -0400
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
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 11/11] nvme-pci: Convert to using dma_map_sg for
 p2pdma pages
Message-ID: <20210311235943.GB2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-12-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:41PM -0700, Logan Gunthorpe wrote:
> Convert to using dma_[un]map_sg() for PCI p2pdma pages.
> 
> This should be equivalent, though support will be somewhat less
> (only dma-direct and dma-iommu are currently supported).
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/pci.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7d40c6a9e58e..89ca5acf7a62 100644
> +++ b/drivers/nvme/host/pci.c
> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>  
>  }
>  
> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> -				    rq_dma_dir(req));
> -	else
> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> -}

Can the two other places with this code pattern be changed too?

Jason
