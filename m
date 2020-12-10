Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8592FC4167B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 04:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587E323BA7
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 04:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgLJEEw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 23:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbgLJEEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 23:04:44 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFFC0613D6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 20:04:03 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ga15so5378347ejb.4
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
        b=V12HS7Wn+bctaIkufygbNwtKV1pkBbE9hHZV8Lf9tSE5VPt6nBit0Nb1HWPIB+8XdO
         UwbjHDBYoCvlSOrafC5rCuQbCx1D+/3PDyFehNe398RSQzHQ1rPu9pgXYXyg3wMVKY7l
         FuBEUYEFzcobG0z1knWel86vWiyTyuA3aX6iyNBGyPUSEugrsJ77EmD5w3Zhr4gllpgD
         NDD0P3wO1Rjasg3bPJKXdNNtxJFUZzyODiRBozAcezwWwmKvGT1tnVg88ssqoLYPKQyE
         vxZa8+AdNxohhjfYmcfYxPAKri7o/zxhpGNApPEe/Ugj0ylq5uh8h/HdVnA0K5L3ljWV
         0UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
        b=ZxzjfhQXcbeGoxKwJ5/i6QFgUTm5ihwC2/Te+QKiEp4n8rbvvydUsYr6uizE0KIiMW
         8XooAJikwv6BySd/ypozFIDtQjKxWH/WZRVunEP0LWvcy5cmJLM02e7EkivNESxmMXf4
         E9QYWY9toSaPwGYoJpRz7NkmENBkwE4/Ce0wi2btCaBKiYGErjSldt36ag7QsKA/FWga
         6IfT5l5dDePXtxhSgSWvz+Y3Lf5R8mXFrdZeMI11yZTa1gCszr183kFUoJU7bJ8CQLk5
         hrvGqpc2BcOfbjaVb23FTBOs2JmLDgsjv/UE1SpVqrJqMHx4O6HnnckxCZ/QJzLDob5h
         wRHg==
X-Gm-Message-State: AOAM531kOa6kfqYLa/ak9WpXrLQAlgLsvd7qybtYzZVykC1vcEVbGoUs
        Q9n2h1Ioz8sjh5WecCx3p2xQjTuF1j8amBHl5O/AZA==
X-Google-Smtp-Source: ABdhPJz4kqsM2zajOVSAKgswV7LD/u9Of8EB4mcOSELuzl9N3rbE8Zn+Vb136NhMCEF83xMViBOj9nm8pJkMBp6g77Y=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr4811157ejk.323.1607573042542;
 Wed, 09 Dec 2020 20:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com> <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de> <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
 <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com> <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
In-Reply-To: <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 20:04:00 -0800
Message-ID: <CAPcyv4hr=kM6--OUdK+6XAAEVzENJmy-uD78yK-p62bW8vbu9g@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 6:07 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-12-09 6:22 p.m., Dan Williams wrote:
> > On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> >>> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >>>> We make use of the top bit of the dma_length to indicate a P2PDMA
> >>>> segment.
> >>>
> >>> I don't think "we" can.  There is nothing limiting the size of a SGL
> >>> segment.
> >>
> >> Yes, I expected this would be the unacceptable part. Any alternative ideas?
> >
> > Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
> > segment-pages for is_pci_p2pdma_page()?
>
> Because the DMA and page segments in the SGL aren't necessarily aligned...
>
> The IOMMU implementations can coalesce multiple pages into fewer DMA
> address ranges, so the page pointed to by sg->page_link may not be the
> one that corresponds to the address in sg->dma_address for a given segment.
>
> If that makes sense -- it's not the easiest thing to explain.

It does...

Did someone already grab, or did you already consider the 3rd
available bit in page_link? AFAICS only SG_CHAIN and SG_END are
reserved. However, if you have a CONFIG_64BIT dependency for
user-directed p2pdma that would seem to allow SG_P2PDMA_FLAG to be
(0x4) in page_link.
