Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE7FC4332F
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053B66128E
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 18:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbhI1Sua (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbhI1Sua (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 14:50:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE25C06161C
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 11:48:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c20so20865152qtb.2
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V9OdhKHkz+bDWOgw519ym53HGQqRyLuvFdP/XrS7z5w=;
        b=U6Cle1ar5YMOX4vRLBQAyCUIzflL0rP5DDqpOBJE+YXNQaN+2OCi9d0Iy1j+ZqEb0q
         ldJaiLHkalWypayZHQx3L3YPO9DcOqCmj/7fnNa9sm7+IILMYJgnEeoBHOfV3+5sIA1G
         7PoT13IhlGy54nJMnWjX2JC+DO7VxjDE7MqR0TIZG4kkDyH5MeFimp+WrD7+H8fZcSrr
         rjU6GjV1RHVgJefkq1bsjD7HjG42edUR2AMuNMVNVDWGsf2VmvclfT7eJ7t5/82dwAMV
         kHPwsALEwDASPTTgXVp7pyVtxMvNs1y+xdofJ6ktmPZVIieklzttcPQ7dqgixshVYpDP
         cjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9OdhKHkz+bDWOgw519ym53HGQqRyLuvFdP/XrS7z5w=;
        b=pP0jq5Xtt90Xt5ZZL2pvhUPlifmaMpZV6CfYzzcjfGr0lKls21Lx8D1Qr6akGMqlj5
         Ysciv0eUM346fukGQ+ToSkKPolKhB+Ph+MHAZ9eUC1jKd2j69OiKL7NokdhNvjwDFBrQ
         WOZVpjFQm2mF0rDosmqh7RW67UPF4WbHLi5wvqTok6x4xbTIMtdQV+bs0X7R8HiqJ9yb
         beRjIvMrzekSgS1RWGYrkquTPYnaiaD9ebynNs7Hll+DJaJIQYf9e5mNORj4WX/KjLV6
         OnRk20zTfiEAR1skOKwPsxHv7N9nG92hU4kxWVjYZqLssCUsrXa2sw/KPY8A5HJzRquG
         sJQg==
X-Gm-Message-State: AOAM533xNlfMTw6215Ktye/1sIt+vGCMjaLYnKM8e93XwpTmAgobBm5N
        dL1e4PNsGesBSULn21/McwEssg==
X-Google-Smtp-Source: ABdhPJxMh4uLV/Co2Bi0Uj4NMD1oETxTUQz1ehKuaeVQOMiXGKhC5tKssJhY1an+RZ/0cNTGVGgAwg==
X-Received: by 2002:ac8:46c8:: with SMTP id h8mr7389965qto.341.1632854929767;
        Tue, 28 Sep 2021 11:48:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b65sm15601470qkc.46.2021.09.28.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 11:48:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVI9o-007FZ4-5q; Tue, 28 Sep 2021 15:48:48 -0300
Date:   Tue, 28 Sep 2021 15:48:48 -0300
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
Subject: Re: [PATCH v3 03/20] PCI/P2PDMA: make pci_p2pdma_map_type()
 non-static
Message-ID: <20210928184848.GK3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-4-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:43PM -0600, Logan Gunthorpe wrote:
> +enum pci_p2pdma_map_type {
> +	/*
> +	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> +	 * type hasn't been calculated yet. Functions that return this enum
> +	 * never return this value.
> +	 */
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> +	 * traverse the host bridge and the host bridge is not in the
> +	 * whitelist. DMA Mapping routines should return an error when

I gather we are supposed to type allowlist now

> +	 * this is returned.
> +	 */
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +
> +	/*
> +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> +	 * eachother directly through a PCI switch and the transaction will

'each other'

> +	 * not traverse the host bridge. Such a mapping should program
> +	 * the DMA engine with PCI bus addresses.
> +	 */
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
> +	 * to eachother, but the transaction traverses a host bridge on the

'each other'

> +	 * whitelist. In this case, a normal mapping either with CPU physical
> +	 * addresses (in the case of dma-direct) or IOVA addresses (in the
> +	 * case of IOMMUs) should be used to program the DMA engine.
> +	 */
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
