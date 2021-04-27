Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DB4C43461
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF6A61177
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhD0T3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbhD0T3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 15:29:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B8CC061756
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 12:28:41 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id t21so9917489iob.2
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=;
        b=d1W1Aqvy0WDQgLHfXd6KVJkwoZwwpQfM3q3r5Boe9IMOb1Ks78SGk5p7ivRqzqy7BA
         gSU82n1JTpmb9daPjD5Irwhh8B8KTsNa9G4UpI9HD9aQfAMHpjP5UnmkWK6P30EssgPr
         qJxOA1NOdKo9K00d+kPRugkI7hzjIwbR6beAJw47nAWJhCVUyqPECz8ykdHt9yMZoQDf
         ogK6wY42jY6a/WZjKm0cnc2nvFx8F0yTrlY8RDJ+yRE9tNcvkLbJZ6C9WY9hob38kSQH
         OkOHfjfKQxlSWxbGIOGwjc5CcjsPzLBsDhznnnN1CnbOGBl9wX3p6dSPxI4qPEJLDYmB
         oq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=;
        b=N7Rf/6k+fmsa8AYqpSu0nE2ESdRrF8htyF+lJXOgh6kNcll7/gRGBwvhma+0T/8bsr
         WgyogQqEWVLqYuJdPJECQdYJ/S0NzSjEoVK1p/wScH7ErL/OOrJ4AJCq4hF6ETXilW1V
         URzJD8FDqk2ohMlIfVNAE/g1+sT9D6wqgIxn0zHuQ2oho8co0TfStbGYhrAPpAT3EDkz
         2azj7V+5+wGnCmHEQWa4bkPqQ63C4pmEHoHfDGpSAnMze6pgoEr/qm1Ni0L+dl7pqqoG
         jkozNuJMkQQl4r+2eeytIeVbqyPlMXj+KFRsHcIiUH7NZLzRm4a6s1siGv5m7CeKTKDp
         q6Gg==
X-Gm-Message-State: AOAM531L/5+R19RwENUu5Gitk41KaYDW/JE+yBr2K1F7XlXNOw0oXUgA
        O7dJjDYx1THlTz9vNnnaH4LDSg==
X-Google-Smtp-Source: ABdhPJwQwDDELwuTsaB4Sx8qcFBGHVeacGfq4J3MKE4o16MniIdqkGIoAquFFRl+dmeSeAYT8wzXKQ==
X-Received: by 2002:a6b:3bcd:: with SMTP id i196mr20979811ioa.121.1619551720518;
        Tue, 27 Apr 2021 12:28:40 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d16sm1715512ils.48.2021.04.27.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:28:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTNu-00DgsM-R2; Tue, 27 Apr 2021 16:28:38 -0300
Date:   Tue, 27 Apr 2021 16:28:38 -0300
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
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
Message-ID: <20210427192838.GP2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to to add P2PDMA support to the common
> dma map operations. This allows for creating SGLs that have both P2PDMA
> and regular pages which is a necessary step to allowing P2PDMA pages in
> userspace.
> 
> The earlier RFC[1] generated a lot of great feedback and I heard no show
> stopping objections. Thus, I've incorporated all the feedback and have
> decided to post this as a proper patch series with hopes of eventually
> getting it in mainline.
>
> I'm happy to do a few more passes if anyone has any further feedback
> or better ideas.

For the user of the DMA API the idea seems reasonable enough, the next
steps to integrate with pin_user_pages() seem fairly straightfoward
too

Was there no feedback on this at all?

Jason
