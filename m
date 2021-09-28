Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85187C433FE
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6405961350
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbhI1UD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbhI1UD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 16:03:58 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099DC061745
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 13:02:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id gs10so51046qvb.13
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ofNzGMHz0Qp7Vb1PEGbzr+csLxgvNVMaUgwkeEL8ao=;
        b=BTYTlYEgPWO99OPBZyk/cDtFjiKDi6RUgSJ31zCZYRP6tGSCQBiYMS+UXlfSM0VbBD
         6Tu9VdA0CwUny5io4aMB9uF5u1nLSiIwBCKDebs10z/0ZskvnJP7PB1zZvCzBpBiEt29
         qhHuWeg3mDcttX2rZBXbRiaPEQPfCC27N6qrBwkEJroXzsejH0SCT2whj/UIzgeE8KCq
         G0HlbMZZCKbHxBZ07c9L+w8YU9ao1gj0SAdqI8eVVGNZyalMrwaQSzOBrWoj283raOhh
         fjZPTOhOgCStfsb2qPWpV+p11BFXZXufzBmGMyAwN31llm3krg0lMdM93E/edRRHHsRz
         HR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ofNzGMHz0Qp7Vb1PEGbzr+csLxgvNVMaUgwkeEL8ao=;
        b=v2Q0aALJY5tgvhRnmoSKsk6IrN3eHoAaUq1Lg4Iay7hgctQobviP9hXP2d8MYwQp4V
         6a85u6C1QRkFASAYV3FTb6N0WmuCIBdbkxu95dFng/tWm3xTnRA9VEOtb5AsJQbKcIgc
         4/oP+/1JbzsCW89J73sAXmL6JmrYNnJFQFvGJAobb/FckLTEn/0RFqxE9jtLcVE02bd5
         l3G//xxATZyn8Ui9wXKDbu2o8WeUgpla/TMB/eIiNq4HjAhb3DOFWu4wPw6QPwOAgUNb
         mRpwwrg3tAPWkO6EKaxYELIhX/pYPYyLklrxSdMjq1IEj/osow669mabEXk88PSA4NRH
         CcXA==
X-Gm-Message-State: AOAM531ZSsvzD4cCCcVZZxbyHAto2smHDz9+ClTFNP1HFdRkEKrYQ9FJ
        2Rd9O2DysAk00Ets8cDw64U/NQ==
X-Google-Smtp-Source: ABdhPJw+cOaZtO6fam+GTeKC9NFUKJArkBLrl4fnuqh08VULcSHQpo9t4cj7egTNmbgVzUNdTaqNrg==
X-Received: by 2002:ad4:54cd:: with SMTP id j13mr7586675qvx.4.1632859337946;
        Tue, 28 Sep 2021 13:02:17 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t17sm98562qtq.56.2021.09.28.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:02:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJIu-007GrC-E4; Tue, 28 Sep 2021 17:02:16 -0300
Date:   Tue, 28 Sep 2021 17:02:16 -0300
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
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210928200216.GW3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to add userspace P2PDMA access using
> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> patches in this series, but the early P2PDMA cleanup and map_sg error
> changes from that series have been merged into v5.15-rc1. To address
> concerns that that series did not add any new functionality, I've added
> back the userspcae functionality from the original RFC[2] (but improved
> based on the original feedback).

I really think this is the best series yet, it really looks nice
overall. I know the sg flag was a bit of a debate at the start, but it
serves an undeniable purpose and the resulting standard DMA APIs 'just
working' is really clean.

There is more possible here, we could also pass the new GUP flag in the
ib_umem code..

After this gets merged I would make a series to split out the CMD
genalloc related stuff and try and probably get something like VFIO to
export this kind of memory as well, then it would have pretty nice
coverage.

Jason
