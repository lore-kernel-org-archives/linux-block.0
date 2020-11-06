Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043DEC2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4A2151B
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 17:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aVspDJwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFRjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 12:39:35 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47DC0613D3
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 09:39:35 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i7so1317540qti.6
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2020 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqZ++Pt3MZPl0c26h7esX3kKVTLpDd4DLyuldQOeJ6E=;
        b=aVspDJwpvtyG5+kighP26kbunhoVoDrk2g+dikuA78Pm3bA2qTEMgmEOIf1kZJzMIf
         jREWUhSOExSA/q/FCxqA4XBVE24zI+bsJoB1MfEIxBjq2vdyDXVafteyCmFKOVp6mNFr
         a+tx6++MRi2ULgDc9l1aIYs8bYmkHkHdREfE1OJi7rMzsOZFvHKvzXQ7XJqg4Rv2jtLq
         /+Dlp7JoggqKZn8R6W1cCZQ0admWy+NkyCMZtOTh144o5mkYSgGm7bfVWOa4R1qrCUIm
         0U96w1WKj0KdQqF8ogG0DBvSehQPHSPP+p8q7o2QpQF4H1UThgaq/hW1ayZpgvaa/xXc
         nKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqZ++Pt3MZPl0c26h7esX3kKVTLpDd4DLyuldQOeJ6E=;
        b=WnF+ilXlY41byAS6UtPCsYj4/K/BVkmleQ7gYcT4DYwpzVGhv35TAiSbhwiipuCbtN
         XjeIqUYFL6Z21gvXOYai/nTqOHk64H/ffbyYkth1EyISps03QMoaEZUgISx0501vr5Ps
         A9zjnl+AEqzarmqj5UgeOH/me45d3ovabUR9CwkrCjjrUaYb1k4HRb6HCfYxMRlrxAlI
         pMX+AjcZXBMa7GYTS6KAaNjBQeBObvyE8SkAeuGdlDK/2ugbCDgMiI5oZ4QMw5TvMBIj
         KmCKQwuIpvgiqerGyomxfbndp18MxORT61wN6+VUV1IIpHxRjMMuh+cmX8HwnCeTaprO
         T/5A==
X-Gm-Message-State: AOAM532uNWWic2WDlreZ6XutjMruV37Xeg3RdgSdST1MIrc9poYbkqMM
        KOiYnmsspJ4t0feOltaV5M+5UQ==
X-Google-Smtp-Source: ABdhPJwk/LVr/ux401xFB0f8tEBQvqxB/lNHOmPBnGlIZGn/taGrIczG0r9kVyPbYEVYIeCjEKrF7Q==
X-Received: by 2002:ac8:1e84:: with SMTP id c4mr2651870qtm.340.1604684374450;
        Fri, 06 Nov 2020 09:39:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o19sm1032238qko.3.2020.11.06.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:39:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb5i0-000zRk-Qy; Fri, 06 Nov 2020 13:39:32 -0400
Date:   Fri, 6 Nov 2020 13:39:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
Message-ID: <20201106173932.GT36674@ziepe.ca>
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
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/core.c | 11 +++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  9 +++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f14316c9b34a..fc642aba671d 100644
> +++ b/drivers/nvme/host/core.c
> @@ -3240,12 +3240,23 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> +static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct nvme_ctrl *ctrl = file->private_data;
> +
> +	if (!ctrl->ops->mmap_cmb)
> +		return -ENODEV;
> +
> +	return ctrl->ops->mmap_cmb(ctrl, vma);
> +}

This needs to ensure that the VMA created is destroyed before the
driver is unprobed - ie the struct pages backing the BAR memory is
destroyed.

I don't see anything that synchronizes this in the nvme_dev_release()?

Many places do this by putting all the VMAs into an address space and
zaping the address space when unprobing the driver to revoke the
pages, but there is a tricky race here :\

https://lore.kernel.org/dri-devel/20201021125030.GK36674@ziepe.ca/

Jason
