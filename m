Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5513CC433FE
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B58461139
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbhI1UGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbhI1UGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 16:06:49 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D235C061745
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 13:05:09 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id gs10so56370qvb.13
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
        b=mXg4nC/0EIy5mcGZgRBdVGh4+PtQ/R7qKfJdIHvckLXvlCgA6RG20VZtoVAC7XwA0/
         1Q9jV1hRPeuiqNHTfiF2xEDf/GmdCrABm9VW4FZUzunFeWsbqWbu0OIpkB0K7pTzfgbd
         6AZsXvNDXNRBaOqQHwB6uloUHcpht9y8ZbZWcpcNkXzVJmyDxhAzyVOeTC4gm52ORmXN
         mB9dfyB6upC6rckPem/56kkVq6mMDb0monvwsJpjKud0G8lLORhrGaRbWZcJi7ULZ9Wj
         5fjO0VyJ8XxtZ4Gi+c3kBFto+M+PTYIof3BPLlQNFsws5BUO2HFuvQyKhOfpgnkZotGZ
         sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
        b=h7/ofhhk0xQOMmiVNPbUf6N4VPfhdZ38+o+a0iYSIdwUp7S6ItEc/Nju+y+mlWVBV/
         AEG0cYRzBV3D5uIJoyWpixoagUR4+HszJnxIs3eztV15Mr0HRpcqZVRwWn4qdVjwZaHP
         mEs8tKTAgvzLnC0+oZnQlvou+ybrJL0/2+X+fAwOdb35MdAFqq0yjivmkTMKf3pXjSf+
         /k4aR89WqVnjvzS5z+cyPkeLyRw2MzezFEy0kDDfd54NiZbVj2Z5jI2Zc1l3vPBe/MKV
         yvEhhw83qFiQ4+nF9QW+Q1yj11S+fRr5s+WgAs0ml9GEXUvI/dx6vo+yXhzrJyVcvffY
         Jx9g==
X-Gm-Message-State: AOAM5306FbBbTqhIWyiHbiPWtGTsuWWo5//TUdAS0RW1AmAr1DmH0gEZ
        7ySk44f7tBpucsJRtMKduqVNNw==
X-Google-Smtp-Source: ABdhPJzKbJYaBmt9+b2JfarRag3/wc7athe6CPjiFKF1JovwH1BSJxbPc5yOuJ/qnsZmJUt2zTx5pQ==
X-Received: by 2002:a0c:9043:: with SMTP id o61mr7850968qvo.54.1632859508704;
        Tue, 28 Sep 2021 13:05:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x125sm118440qkd.8.2021.09.28.13.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:05:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJLe-007GuE-T8; Tue, 28 Sep 2021 17:05:06 -0300
Date:   Tue, 28 Sep 2021 17:05:06 -0300
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210928200506.GX3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:

> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> +}

If this is going to rely on unmap_mapping_range then GUP should also
reject this memory for FOLL_LONGTERM..

What along this control flow:

> +       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> +                                        pdev);

Waits for all the page refcounts to go to zero?

Jason
