Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14FC43460
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8977A613FF
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 23:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhD0XCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhD0XCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 19:02:01 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476DC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 16:01:15 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 66so22215882qkf.2
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=;
        b=mWCFLORk/JSO5hvqnSM+Tr4f5WX2JQQfM5zw3lnOqv2hI8yuK2QY2VRA4xKcfW/BBW
         7+hygn+gIdSUDWbWnu44e9xclJztFIqbTsp/9qMdRnWE354rUiO+6MGPtD09gFGZBaIy
         IMQtx4otwgxXJNa3cuXWog1ddYlO1lhhAgdkSaV16Mkmlj4d+AO8D+3Vib+IKn1kpnJh
         zB2E3oZUgKt5cnT7CqrKn19BnZSeoH4IVay80i46FytArqMCxbMFWeL7/z8Zhyn6aK1Z
         E+x0lqdvTXIEAWW5guabHeXg9VXM3pblwMdsknuFsYDM3IU6oHqS3nkBUCZzVKmLg6Hk
         fKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=;
        b=Hhd3W/AD09Jw7We3NAo/+ZJ4b3J/knO415L6BXLzk7mdKfz6+WgbtOShKCBY4kyOXl
         tPCSxfxWMNy2S8ZfkS9cFgUeWpbwsaf7iuGRAHGcXRI2/FAYdbZXu91FCS2xgwM77+nK
         4Z0ZVOKldP09RrlCCsqoNGeHr9K+TXti9/RyjOKL3G5tVwbWl/UgxegwXFxI/fWNChV+
         MlYWTBpgl47SIF9MQp058zNHRLFjCmUerR/2xstA1Ts3Phh1zJYVnsKk/4B/F35l3ZLC
         Zefyd3/p2NXNcvjawQe17FixTdWlVEnV/msSNzb0vXg4gRFhHqpFrzJX350uPPVaPPDB
         D4qQ==
X-Gm-Message-State: AOAM532atLKUpGnHCozrGRhJZwEkTxkVclft8Lkr68UI/dtXFwtFA+T8
        VceO3E8468HH5mOLTnpp+T4eEw==
X-Google-Smtp-Source: ABdhPJzddRKTQchhnx30/Xg2SkamnN6ck8rs0UJ921MDl2H1WKlMVuDanOHHUjSuQhUcGpmIX430Sg==
X-Received: by 2002:a37:a5cb:: with SMTP id o194mr13564100qke.303.1619564475032;
        Tue, 27 Apr 2021 16:01:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t23sm3730974qkg.61.2021.04.27.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 16:01:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbWhd-00Dl5Q-Jp; Tue, 27 Apr 2021 20:01:13 -0300
Date:   Tue, 27 Apr 2021 20:01:13 -0300
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
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427230113.GV2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 27, 2021 at 04:55:45PM -0600, Logan Gunthorpe wrote:

> > Also, I see only 8 users of this function. How about just fix them all
> > to support negative returns and use this as the p2p API instead of
> > adding new API?
> 
> Well there might be 8 users of dma_map_sg_attrs() but there are a very
> large number of dma_map_sg(). Seems odd to me to single out the first as
> requiring these changes, but leave the latter.

At a high level I'm OK with it. dma_map_sg_attrs() is the extra
extended version of dma_map_sg(), it already has a different
signature, a different return code is not out of the question.

dma_map_sg() is just the simple easy to use interface that can't do
advanced stuff.

> I'm not that opposed to this. But it will make this series a fair bit
> longer to change the 8 map_sg_attrs() usages.

Yes, but the result seems much nicer to not grow the DMA API further.

Jason
