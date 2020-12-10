Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041EBC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 01:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB30223B45
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 01:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbgLJBXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgLJBWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 20:22:52 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25637C0613D6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 17:22:12 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id n26so4989592eju.6
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RvR2QPPiPyu+6Jv4jWyGokFplcRpCGGMGXA++YNtNY=;
        b=hLlhVWiZHkRszGDN0QvNv3k5cDa7NBwZGJhnG+u6snpj/DqWm97HsIYwTJsnjvT1vM
         lqLgTToh0Yl0+7UdLKf0OJc3R9/7th3uREf05mUHcpVQ/dGI9wmQMaG7b8tJQr7VzCU6
         n7TG/Q+F4n+X2SsRVoAlKSheAcmCFeTxkrOIXFDWuvtQdZWTf7ANt2zcUkpZxBGmjkXa
         wO9mFNtjhCJhXDZ9MpC+XSEcdnWG+j3g1YG8jxS+Jo15C0UFtAA2umrf/tujow1hZuMc
         f9OtadNZ60HDDPjDjL1evB3x/w7Ymxm2RXqqrVLk5LCk3Du/muGWXQQZ7gJkcfcPQvRI
         RABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RvR2QPPiPyu+6Jv4jWyGokFplcRpCGGMGXA++YNtNY=;
        b=mvMykfBHtrL+wVNjve7B03tambu7Tj+f6Kej54wJGKfEIIF49Rz2jP9DasTvua4pcQ
         mYXR3Q0gaHTdu8n0ooio65u8+swSqemDkEl702Vy018EgBND0zmJ15LxwWvtzmLxhtPW
         HxDyXeTOtb2hM03bYfxQY7Q1GCyyDpvkfG36umkIca80EWBFenOAk8bPAiPmBjOiPl1D
         b9qguW9Xx4vJuv7vMER9fa/ZnMz83VKsaBWigtfWYZdGaYm+L/uHKRlws7JmVX0q+3XU
         UYnTJZudWQp7HQtL+1Tyy0z3CEfMMrW8+ZRQY8RL1xGa8IE3j5msg3VXyhiHtw65Mud9
         OE5A==
X-Gm-Message-State: AOAM532zLTKBYKEdsQIDBR4SPGaQBVUrj+97g50pxUGAj0S+Ff7GMfDY
        pRrQAM2FwZCpjRsgueVebfLYUROBaEUrAdj9drNx9A==
X-Google-Smtp-Source: ABdhPJyAwcrv2J7//UeT/BRlFkXF6BfuHfPDxCDsLChk0w8jJb7pNGsjyGRaIu9jO63Jp7V2CJR6QsUNyeoJndfV6A8=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr4331316ejz.45.1607563330752;
 Wed, 09 Dec 2020 17:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com> <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de> <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
In-Reply-To: <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 17:22:09 -0800
Message-ID: <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Stephen Bates <sbates@raithlin.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> > On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >> We make use of the top bit of the dma_length to indicate a P2PDMA
> >> segment.
> >
> > I don't think "we" can.  There is nothing limiting the size of a SGL
> > segment.
>
> Yes, I expected this would be the unacceptable part. Any alternative ideas?

Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
segment-pages for is_pci_p2pdma_page()?
