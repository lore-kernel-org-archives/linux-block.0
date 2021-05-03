Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA45C43461
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587886135F
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 22:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhECW6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 18:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhECW6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 18:58:02 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748FFC061574
        for <linux-block@vger.kernel.org>; Mon,  3 May 2021 15:57:07 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v20so6848668qkv.5
        for <linux-block@vger.kernel.org>; Mon, 03 May 2021 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZZm+3MFuedFCkj1MfVgDeM954nHR/3fXds6exXmQfs=;
        b=ouRSQEEjT38vBUuV862SeUlllVCT6eH9A/DLELLKUUCUzA1ShVzuWVXQ1MBHwfUp52
         o2iY2zmGF5v6LzhQq+GBDBerKVAePtFNVbGHvM38jkoESd9bfzmAI5TW5EmfL78E08Qn
         KIGOFGei7/yO8yCpBYVzXmS09DZEEm+pTY6CGCqEpqr9/YKTEYQHHgmnMtxfiJhxhwEM
         PI6Kaqk2dLQBbp3lySC34PVTv8PJZyC4fg+IILviuxHg1B8L5kSFMxjKrsIeWCcV13AT
         K2K+mR+5wr9SajVl5e5SOe9bFPiH9IuQFOm4a7VNUrSG+YlFkkc7yhkY+MYykwPRCxJe
         dU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZZm+3MFuedFCkj1MfVgDeM954nHR/3fXds6exXmQfs=;
        b=H8A4FnKcRJFYN0mSl4yt5w69ZPzqqkwO5n1EjL9zYc3piO1ZVUwTB7gFF+nlvZ/SZ3
         y2o45cuZRZoCIQGjYwQINSfbMfZ03hRm/+qnPHX61pJ8+364vugFpALhIL2Q4IpuKmXj
         e9dUyPXU6RcNE6KqZd/phcJFsPiYdG/sDNcce68QQwoCpT6DW1JL2TtytgDm1XyUwiX+
         dqeRjn/9yy6IZRigJPr0gTMKq3B5Ds+31NywcDatIGHPPIOhxrFLC455t5WaYCmibkxt
         9SgXKGkgMypVg890mSK1qTJm2i68JuAGsrOM0cU/rXvHV6j4i3qCT49zH6Hpyv0KVztE
         WS5w==
X-Gm-Message-State: AOAM531q3SXU/5PHrQ3DkwuLk2c7Gx/Mih6NVevcu3mJyZUGvRhg/rnW
        vIYqUpAdw1nkMvlHSL/ZCY7dFw==
X-Google-Smtp-Source: ABdhPJwB6nytiC0oDMbKJRBwSIes/jqgsePpJ+MXFQRNiesNGamVx4ATl+XqEZHAz4GA6Yzrb48bvQ==
X-Received: by 2002:a37:a9c8:: with SMTP id s191mr6160737qke.430.1620082626750;
        Mon, 03 May 2021 15:57:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c17sm897865qtd.71.2021.05.03.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 15:57:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ldhUv-00H3QZ-2z; Mon, 03 May 2021 19:57:05 -0300
Date:   Mon, 3 May 2021 19:57:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
Message-ID: <20210503225705.GA2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
 <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
 <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
 <f07f0ca7-9772-5b3b-4cea-9defcefaaf8b@nvidia.com>
 <ab0e4256-79c9-c181-5aec-f6869a92a80c@deltatee.com>
 <d4f19947-d4c1-451b-311f-9e31a4ded6fc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f19947-d4c1-451b-311f-9e31a4ded6fc@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 03, 2021 at 02:54:26PM -0700, John Hubbard wrote:

> I guess my main concern here is that there are these pci*() functions
> that somehow want to pass around struct device.

Well, this is the main issue - helpers being used inside IOMMU code
should not be called pci* functions. This is some generic device p2p
interface that happens to only support PCI to PCI transfers today.

Jason
