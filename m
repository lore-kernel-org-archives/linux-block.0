Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4AEC43460
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF261403
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhD0ToZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0ToX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 15:44:23 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFDEC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x27so29650207qvd.2
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
        b=M20T+1aMae4u0P7fbin4a8R02TMD5t96H2aiOMf8qw2rTRAo2RugFe0ku6l9VPeevP
         xZtgBQRLaSsu9aYFKNdNDSiFe3aolwh10xjABQqThOUIndi0+s4d+Eo1XLPCXC3nfxUm
         lD1alvOMjEL0+ef6cYE7iSz2VLoq5w2e7VmYnhskgoJag9ZejVAXw548Sw3tJzTwQ1LK
         Hq28R0ucjVcFeEwJijDgtLouLoL1kPblKx+vhiQSapRdIiXAHGIAof9xt+quTVbA5Swo
         WJ9Cx6H5u7fywz1Osz6ow6XWlpeS1lNkpzj+0hZhr2dKqs99inl2pJxQ1Z2SVZi0WDJl
         pNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
        b=IIVNlO8omdT3d6a5Rs16f5C+g7Mfdcf6pQgRj95r36syQbRApNHohbCTL5FreJvUtt
         t/bz3MznQ+uKqe93+h9xtoDi+SKLAcGspFZGIgG015Ub5m7PTPqvp89q9Xyo9fSyRYxP
         a4iXbXc2FMhMBLVkFLT7RMPyHMJagb0uowWN/foXAQGDlK6D4xizIc0Z/dn8C1ZtXOTz
         qs1wjHNoxoO3eR7jGE1Bf9a3TGLPALZNhw3jIqAiChNiZ93W/xVbO4o4Gup8kHrNpjK3
         0eaeksvVhq+TWPUl9nNpWU76sO/qufTsFNR6YesDkFKAG28fMs8ja0IztTUE45sVpWLn
         7YCg==
X-Gm-Message-State: AOAM5306A9BFK8U5ZjZPwoZO3jhIuuewnxgidyWVkk5f47kir7iV05iG
        XDq0RZ1dPZCaRuXDz/q73rSrPA==
X-Google-Smtp-Source: ABdhPJzaHrq9X7iYnbBeG48woUZiUTHE+b/d9aEc9zMuai3hrX463cNK4Akxfstc2Wbz1Cy4s9UnAQ==
X-Received: by 2002:a0c:e8c4:: with SMTP id m4mr2551153qvo.21.1619552619024;
        Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y26sm688104qtf.66.2021.04.27.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:43:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTcP-00Dh5j-HM; Tue, 27 Apr 2021 16:43:37 -0300
Date:   Tue, 27 Apr 2021 16:43:37 -0300
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
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
Message-ID: <20210427194337.GT2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:18AM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.

I expect P2P to work with systems that use ATS, so we'd want to see
those systems have the IOMMU programmed with the bus address.

Is it OK like this because the other logic prohibits all PCI cases
that would lean on the IOMMU, like ATS, hairpinning through the root
port, or transiting the root complex?

If yes, the code deserves a big comment explaining this is incomplete,
and I'd want to know we can finish this to include ATS at least based
on this series.

Jason
