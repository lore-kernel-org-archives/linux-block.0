Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B85BC2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1635C20897
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604934216;
	bh=r+Ft2tymmH5NpLInpLBcaHHGbXBmIxUIIoWZRRKi3Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ajELYBp9kGLBkLZsvQVCXBbomSDzsktXDXnXD0w/747N/pIKpSJiR3HieAdaZFwvn
	 nSWbm59TNInfJgqsMZW4owZSXywe3XDpI5P8Xyw9akaLlLM3hq6MpUMkDUmtGaNzpK
	 dcdSK6MTBFNzxx4B8AIue6AeADY4gf4/Jk5luFOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgKIPDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgKIPDa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Nov 2020 10:03:30 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D39D2083B;
        Mon,  9 Nov 2020 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604934209;
        bh=r+Ft2tymmH5NpLInpLBcaHHGbXBmIxUIIoWZRRKi3Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtPuiqROcd/6G01mEcpCI4ZkuoLNoh/cHEoW1pWvWnXrcS9oX6qi25orcEe/HD6gQ
         /2y+a50beBfImRzQnG4uTWBnNextYf4nu2KfFLXSU6AOTbMFpSso49pl+Bj1AlzYpM
         TKyuOwfpDhx5CeUMmKig1ylwMR32SikIaTFabfbU=
Date:   Mon, 9 Nov 2020 07:03:26 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
Message-ID: <20201109150326.GA2221592@dhcp-10-100-145-180.wdc.com>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-16-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
> Allow userspace to obtain CMB memory by mmaping the controller's
> char device. The mmap call allocates and returns a hunk of CMB memory,
> (the offset is ignored) so userspace does not have control over the
> address within the CMB.
> 
> A VMA allocated in this way will only be usable by drivers that set
> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
> checked the first time the pages are mapped for DMA.
> 
> Currently this is only supported by O_DIRECT to an PCI NVMe device
> or through the NVMe passthrough IOCTL.

Rather than make this be specific to nvme, could pci p2pdma create an
mmap'able file for any resource registered with it?
