Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49103C43217
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2898C6124A
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 18:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbhI1S7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbhI1S7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 14:59:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C4C061749
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 11:57:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kn18so2690249pjb.5
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oHaryRFi/fpZmucH1uQxicsHfaWcwCrvG9TbLYxvHTw=;
        b=Jx2GOuLqIF/s/mi2Zrk/xAaRKuyWPWZHCfm+XwkC1Yr0Dv0vjM+OfZQXVIMiJLsjmt
         UrV/wXbA0S/kA8NHbPEFpp1dbqLg5YihHJ0daxdbRmoiYipdrvH9aE1GR+5dg2ru+RLb
         D9RlleKhxyRZz7x683IeC5JDgX+RCiwr9h+iGzv5av3RkyBoFDWC4oGW5kDI8NZqd+wU
         GG0wiVbU0tcwD2OsUIWVh8MXHIcG0Qmyu9kG4Cl/ZJH0N5wnluQLcxjz6xhITElaiUL1
         soubsWJ2CeaU97V7PVulKA29iDPu0PVzaYdGQFsHPsL8RlHji5XVx44zUSja9oX1iGFJ
         ehCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHaryRFi/fpZmucH1uQxicsHfaWcwCrvG9TbLYxvHTw=;
        b=vABWHTJKJqEvZJerDV79xuAJ8e0FbczK+ju+hrYCkg53wWWcMzFX9V/cbjuI9ei6p8
         H+lXlMYK96loysTGl+qTwVtj5OSCg4lBZgvn2GSsfWNxCpSVNjF408pQqbe5kjmCcEq7
         F77j1/5ofdcv7DTqUzki7bQ5iRI8WB8QLs10uvdKm//0EDzVUHgFkbrZRHiuCohHZlvM
         PnDvgtYveV+PFZwaYO+DmatH/0O4G6aaDqsWAypXlvlk+f7nrZS5U7gEw61/+jsjE0aV
         iDd3kiyxoXgHSdWoGtK4ZVtEe22UfoxzSXwiWDOGqI2BhOSwSI8sNB49db4A4gqrFXpg
         WCBg==
X-Gm-Message-State: AOAM530y9Bo5NDYgdaZ/z2RUx2qjsfeK6db0nlsPauJLXcSm7rV0H5ss
        lF6IRju2PLtmf8QtmRUqgcTLYQ==
X-Google-Smtp-Source: ABdhPJx53FQmydkeg1NJ3LXDS/rZkMGUByvF4f/aWGCpIOOYUi1lNT78rKchyK327J3h0Fhk9/CHgw==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id u4-20020a170902a604b029012cdda230c4mr6060505plq.73.1632855477627;
        Tue, 28 Sep 2021 11:57:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id o20sm22682349pgd.31.2021.09.28.11.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 11:57:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVIId-007FjO-20; Tue, 28 Sep 2021 15:57:55 -0300
Date:   Tue, 28 Sep 2021 15:57:55 -0300
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
Subject: Re: [PATCH v3 05/20] dma-mapping: allow EREMOTEIO return code for
 P2PDMA transfers
Message-ID: <20210928185755.GM3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-6-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:45PM -0600, Logan Gunthorpe wrote:
> Add EREMOTEIO error return to dma_map_sgtable() which will be used
> by .map_sg() implementations that detect P2PDMA pages that the
> underlying DMA device cannot access.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  kernel/dma/mapping.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
