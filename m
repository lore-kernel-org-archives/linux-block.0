Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D13C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EC46105A
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356274AbhJAWsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356321AbhJAWsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 18:48:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2370C0613B6
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 15:46:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f15so10456670qtv.9
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tnXGytG/2aEvcazdaoXj71bXQnwjyukOXIDiPveIZXA=;
        b=pOTSnHYVXRz06VuaU1BDucThq3XLijVNOmqw8gUYgVjcX4bjaU1DPW80GPFpz1Bry3
         5Izso0qtrLy+uxnjkbarKVIHYAhUgvRAYbABr2JkvP9GCyg+7YRvw6KqUUc7seGsa9fH
         KzDaVUI4r8DRENRxq0vwC8QCWDmKp8VauDJh3yS5lxyhzeb0C6mReZGMghzJA7mUDjLv
         3H6R6bTZK2L5cSKTP/HRhXJP2RtP51MG45N0gotai5Ttri7QJaEBuKZ8DLCGMwehfYns
         QMf6evJgsJzNYeGrSyM/G3W4DM7LKIUGIRGLmulP3Gv60VEJqAsqbGSn5orZIQ0iTuZ9
         WZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnXGytG/2aEvcazdaoXj71bXQnwjyukOXIDiPveIZXA=;
        b=VFkok3PIXptfSk4j9FGFdhvF9dr+NwWyELImivmgNWS3+T7XnWXlEFM38LlPMRyS8i
         AJ+GjB62NqDNeYMzOSYSgglfJfTiGT3g/l5QD7uiFrM4PdVC86skARQbVVFuoab/sed8
         WhEBf8oyUxMDWTl2dKw5giQM/f9VYejfki4vusZ/vpgKLjaZFJmzvYlTRt+Xn7DmCfUa
         me5rTR4nLPaBi8YfRCEoRG5Qe1ODCS/4dlp87WxozZN2cKi9tjahGCr0w5lLhOIYFssK
         nBPm+1AmwWAzr/tMBHFCXAzMIFm8aWe0/niCW9DbCt4CSGg/80lBxzqaKkN+AVgBVvAj
         ZYyw==
X-Gm-Message-State: AOAM530xOeT7oDFat7PhEgH5xixrbOF0UsbOgq4VI3nq/PonZ1OK9Mh/
        c+OgTzWFwEIz0Wse97mR+nDQqA==
X-Google-Smtp-Source: ABdhPJwIsqD13TKJo7mm1SIikHRk6qEvBFD6JpS7ZAJB6SMruIQLkql7OpNf4qMoVFvzMVj7AMSNJA==
X-Received: by 2002:ac8:7dc1:: with SMTP id c1mr551179qte.289.1633128366918;
        Fri, 01 Oct 2021 15:46:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p187sm3759342qkd.101.2021.10.01.15.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:46:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWRI5-009Y55-Ly; Fri, 01 Oct 2021 19:46:05 -0300
Date:   Fri, 1 Oct 2021 19:46:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
Message-ID: <20211001224605.GS3544071@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
 <20211001221405.GR3544071@ziepe.ca>
 <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 01, 2021 at 04:22:28PM -0600, Logan Gunthorpe wrote:

> > It would close this issue, however synchronize_rcu() is very slow
> > (think > 1second) in some cases and thus cannot be inserted here.
> 
> It shouldn't be *that* slow, at least not the vast majority of the
> time... it seems a bit unreasonable that a CPU wouldn't schedule for
> more than a second. 

I've seen bug reports on exactly this, it is well known. Loaded
big multi-cpu systems have high delays here, for whatever reason.

> But these aren't fast paths and synchronize_rcu() already gets
> called in the unbind path for p2pdma a of couple times. I'm sure it
> would also be fine to slow down the vma_close() path as well.

vma_close is done in a loop destroying vma's and if each synchronize
costs > 1s it can take forever to close a process. We had to kill a
similar use of synchronize_rcu in RDMA because users were complaining
of > 40s process exit times.

The driver unload path is fine to be slow, and is probably done on an
unloaded system where synchronize_rcu is not so bad

Anyway, it is not really something for this series to fix, just
something we should all be aware of and probably ought to get fixed
before we do much more with ZONE_DEVICE pages

Jason
