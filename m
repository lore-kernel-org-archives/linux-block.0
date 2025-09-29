Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C225A659
	for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180674; cv=none; b=klMd6gVJUFXbb31i2OA6QRv7cpFVH/f8q21swORw0VTX9aXinBPtwZmwI+vfcDJZnBwM22pePL3kKyOhYR61thtRHNeLKF9oT5dcQN7BNDqKFXEXswRqi8ZKkKgJ/JwbzrwcD5FgXJ3x3LdnJ0r2gp9y9mvW1XnNYEI20QK7fko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180674; c=relaxed/simple;
	bh=0oSgxEnNwZj0iK2MMd9XdDjcPgJYwsCBsAngjqYdLuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWevIFXmBFxDA+H4kzFHrp2GyX4LHcb04c9tRPjn0X55fxRHOMtBlnG4F8JqaAz7m1NSJOXOf7BsYAVAhDigLe50vuL9xoekCaUy0wMu3qvY4pWRg9NF1V7ws/F5e80p5gp7YCUuktuGL4N0C0ZcleBO/MUASmHB+bNML78e5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSzIvrH3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSzIvrH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759180670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pary30BmU4/NqakwYdG1eNkY0RiL1NyFW4TmIsuJ5GE=;
	b=eSzIvrH3TgR0u/E7xT35nD+af8z61fl3d06j8oab4bPnIAOmHnplVN848Li+daD8aG2NUl
	eo9ppaNIkhWD0cfULhpqQAOKXbhi3NB/3F3Q77eGKJqGllFgASG+czUoRAp9Mk3BRKkKmM
	PaGkjgchT4tV6RFaWyNW7XHFmxsUftE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-cZECsceMPTqMYi6ezA8a4g-1; Mon, 29 Sep 2025 17:17:49 -0400
X-MC-Unique: cZECsceMPTqMYi6ezA8a4g-1
X-Mimecast-MFC-AGG-ID: cZECsceMPTqMYi6ezA8a4g_1759180668
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4248bfd20faso13820765ab.2
        for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 14:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180668; x=1759785468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pary30BmU4/NqakwYdG1eNkY0RiL1NyFW4TmIsuJ5GE=;
        b=lq9WmGYbIawpNqajdCqfBc9ylAG15bAPniMHkeAJY8Zn2t8kudaECK5JzdIm+JhzRd
         BYBxthr5t1nSH+3BdoRF5mTd2qRXqvFfuuu6CBVCV+SLYo0DEWSww7GYgjq1leZRQo0S
         G+s0DgHfim+GSuKwUWLUCs924O0fE97XHQygPDFU4lxHRfaUJStrNk0GloK5dfBDw0jw
         8wWFyaaTX0DxoT1zXsbKW4nFVyKH/9IXbOCXWF2NaDQjIsfAhBeL24AMGAOHSWDHX54/
         Y1WNu/08JTC4hN6yDutX47HSoITEuWqKqWwNMJ4qTK/f5dEntTQMlSr4mWhYG+n2E754
         kBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIa0UJsmLBp0ueG8FB4dqmHjEpNMNFuj0h3ajHH8XPI/bNDbW2/7fY7TRSYJz2fQZKJuJaaSdv5V+2sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziRYmR5qoT3RWT+fVxAgmAkiT8HevOE0Q//ifd5BZZSd4LvGP/
	WmwfTZD9XKIFpmC5pH6mdkWx6HghFO8zq9PJG/0jR04s0qXXz0TRRxQ8hqkldtnTbyXrlHC9Wuq
	UHQ1CSjNOd3BPxfcHmdSKE31/rIo9JXDPMtKio2u10afHhbjLhLsyrzH5GQ8PhGbl
X-Gm-Gg: ASbGncuc+ey0M0IOvHdqs1L8972IIIRxuAxqtcexmRFdaydAPCDNYsa6pZ7ggaqbVWE
	4ah0eEwhoFSqbnvAxoHiglIm3HrDICaQYj1WVgSEAuSJ4e5fXaaQREbMgLY+/AvxUNQhatAA6Ci
	UlTvJG/bbyVtS5/HRLP0cLPgI3hGxBV7vQWRPFM3ptzGhcnyApwfzNLGykV2pxBLrG7Qz1ymIT9
	rx9aAYEve2n7l/YkO79RTemH5CnezxYBfjk7pf8yBjK4+kIyPckXqv4zpHp3+0HwY7zmb0dBsep
	BfkPlX64az6FamNw8gFvOp20ncVwyOMwCrUCKPszy1Q=
X-Received: by 2002:a05:6e02:1b08:b0:424:6c8e:6187 with SMTP id e9e14a558f8ab-425955e4dfdmr95833915ab.2.1759180668401;
        Mon, 29 Sep 2025 14:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE31/4ZuuqxcHY5C8RvKg6dnDpxm6QWjHiIpet9IRXNGlsIsGmjCxy18kHCIW8dgbK0MWZ9w==
X-Received: by 2002:a05:6e02:1b08:b0:424:6c8e:6187 with SMTP id e9e14a558f8ab-425955e4dfdmr95833605ab.2.1759180667942;
        Mon, 29 Sep 2025 14:17:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5753c50a188sm920778173.31.2025.09.29.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:17:46 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:17:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 08/10] vfio/pci: Enable peer-to-peer DMA transactions
 by default
Message-ID: <20250929151745.439be1ec.alex.williamson@redhat.com>
In-Reply-To: <ac8c6ccd792e79f9424217d4bca23edd249916ca.1759070796.git.leon@kernel.org>
References: <cover.1759070796.git.leon@kernel.org>
	<ac8c6ccd792e79f9424217d4bca23edd249916ca.1759070796.git.leon@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 17:50:18 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that all VFIO PCI devices have peer-to-peer capabilities
> enables, so we would be able to export their MMIO memory through DMABUF,
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 7dcf5439dedc..608af135308e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,6 +28,9 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#ifdef CONFIG_VFIO_PCI_DMABUF
> +#include <linux/pci-p2pdma.h>
> +#endif
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -2085,6 +2088,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	int __maybe_unused ret;
>  
>  	vdev->pdev = to_pci_dev(core_vdev->dev);
>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
> @@ -2094,6 +2098,11 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
> +#ifdef CONFIG_VFIO_PCI_DMABUF
> +	ret = pcim_p2pdma_init(vdev->pdev);
> +	if (ret)
> +		return ret;
> +#endif
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  

What breaks if we don't test the return value and remove all the
#ifdefs?  The feature call should fail if we don't have a provider but
that seems more robust than failing to register the device.  Thanks,

Alex

