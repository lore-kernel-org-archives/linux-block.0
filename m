Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18FC433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGEQaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiGEQaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 12:30:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D651CFEC
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 09:30:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id q16so14433326qtn.5
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
        b=ARfWpr8plwJhNlfMsfgbkLKFpSjayQPH+TVLj9njVh+9ZVwwYS0Q5lpx3QESUlwiJ0
         Xau0D8DTEtlBLA2TKJjGb0eWyuHzYJSySzH16w8i60Ucpq6lkPkx/9MUbSA7H8PkF9mf
         vy2eLsJPe5CP1cJVF8B6Y7AsRY7nQqxYHkWBv4hIekpX2n63jyIHOZts2vGssV+p6X7i
         o5tnF3lXu1HBK0CIU9B+BuQxS3B79T/BqxNUUNBMTSi7dFTn3cejUhBmCkHwZYPAldDy
         CzT6wuFA6Z8An5ETNanvoj5+zinJwVg3guVjtkzMtWjvDNeS+j8gPF7lh16xjKsVoTSd
         rVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
        b=JHB7EbV5p2I8qydSyrWMt/58AZE0HVrFFvETrjuDGhqkAVcuCoay848Nvs57dqAgrL
         LRb3iaVHsRGP4ihc+qVrXYNUdEXRmPBAICWnABzQ6l+95Z6Ax3IQ+1aHzYndGWa+FQel
         I1p02lQ6yI4j0vkGWawHBd3VnDXZoOYi3YSWKshLPyYDkheUopdQSIFJD35pUb3uLxGe
         jOvix77IN5pCyuD8rzaeKbhE4/p/ArkgIxX8AaBRMuT1/jwnu6Iu0HFGL66vGnkGZoyR
         1Mii2zlDPeLvyjolr8e1E/gLL2uGGWU9lR4IAFoyGdPca2Z4ozTiQZB+hEPiYR6mzMfW
         58hA==
X-Gm-Message-State: AJIora85PECqHeO4DegLfoOzO7V1flrmFE/sx515poitqepfUj9kZFHY
        +ulJ8pjvSewcfZAi/vpg/Zh4Dw==
X-Google-Smtp-Source: AGRyM1tPLgF/oa5jp6ch7h66vURUmccxqkvEu70fGN2pQIZRW9uE0+BIJoib0UJtgkigroai62+FZA==
X-Received: by 2002:a05:6214:27cc:b0:470:9aaa:94b5 with SMTP id ge12-20020a05621427cc00b004709aaa94b5mr32033702qvb.129.1657038600343;
        Tue, 05 Jul 2022 09:30:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006b25570d1c2sm11328498qkh.12.2022.07.05.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:29:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8lR1-006YYv-9I; Tue, 05 Jul 2022 13:29:59 -0300
Date:   Tue, 5 Jul 2022 13:29:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705162959.GH23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca>
 <20220705161240.GB13721@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705161240.GB13721@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 05, 2022 at 06:12:40PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
> > > In fact I'm not even sure this should be a character device, it seems
> > > to fit it way better with the PCI sysfs hierchacy, just like how we
> > > map MMIO resources, which these are anyway.  And once it is on sysfs
> > > we do have a uniqueue inode and need none of the pseudofs stuff, and
> > > don't need all the glue code in nvme either.
> > 
> > Shouldn't there be an allocator here? It feels a bit weird that the
> > entire CMB is given to a single process, it is a sharable resource,
> > isn't it?
> 
> Making the entire area given by the device to the p2p allocator available
> to user space seems sensible to me.  That is what the current series does,
> and what a sysfs interface would do as well.

That makes openning the mmap exclusive with the in-kernel allocator -
so it means opening the mmap fails if something else is using a P2P
page and once the mmap is open all kernel side P2P allocations will
fail?

Which seems inelegant, I would expect the the mmap operation to
request some pages from the P2P allocator and provide them to
userspace so user and kernel workflows can co-exist using the same
CMB.

Jason
