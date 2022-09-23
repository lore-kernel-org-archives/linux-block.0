Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E9ECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 08:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIWIQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiIWIQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 04:16:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33AB115A7A;
        Fri, 23 Sep 2022 01:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0358B825C6;
        Fri, 23 Sep 2022 08:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18903C433C1;
        Fri, 23 Sep 2022 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663920962;
        bh=bPVCAPpOlqysgdRjqbXO/X4KjONzytDj+4d25vTPS08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFCgceMrCjNaFpcCwlwlTgsF5RM4Z41Qsy5jLwSHgDt/de2BtGvojz58AaIfL8ZfS
         BBIcjTSAQLPym+hEvSSlQCoy0aOYUD9ckT2A1iu+syML9qBDSBSsKumT85+IjlnHq8
         z+IReMS4RejydfYZfHdLonAiTZ7nMggb2glIqDvs=
Date:   Fri, 23 Sep 2022 10:15:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
Message-ID: <Yy1rP4JwzxqwMGhc@kroah.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-9-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 10:39:26AM -0600, Logan Gunthorpe wrote:
> Add documentation for the p2pmem/allocate binary file which allows
> for allocating p2pmem buffers in userspace for passing to drivers
> that support them. (Currently only O_DIRECT to NVMe devices.)
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
