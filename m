Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FF239085
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684630; cv=none; b=aB+ijA5IS0BJwNwYqc6jtsV+6KINnCEg/tVpAvWnQseVvijNqcE+9KRWV6dbwNqUOrm+DnxKWUD9NOa9+sAu+M4LheviS1YJDaQcJZlOJ168G+7RfZwLXtbXQv/gBlkU03X4FKIc3MS9U/WIM7cFQ0HJNgxgFWU7Itn+ISEm/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684630; c=relaxed/simple;
	bh=rSFCVYBQGHYIVw4AaRKYw6Ay38HyAtjHDSJOWPLks+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrqNAMWxzlgNpJFITNNSXhXD1j7GymbosHAo7qSZCbqkSm+xgjK6MlK85lvsWF0IbcYQzVYTPHF0sq4kEYdffrH4fl4xXviigmntkfZKFSTQ9O/SoCTEGYwyPsA907qoAKkf7iLK9znN1+XWdn1KvBxHp4wiQK81m2dRJlkY7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X0nsss1q; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X0nsss1q"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8823dfa84c5so15629186d6.3
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763684626; x=1764289426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeoQ6A9zQA47pPVQ4WN0R1Mr0WB5BGBDvzJz+/SIjn4=;
        b=X0nsss1q1dQAqvVQCjfcM7UUewWlBvLurLKTQOkoLVBJ11Zbv8ClxmGVsU1Bo6EF5b
         qB1Gi2Yhtkul9cgel4Ab+PKL3kmhaxR19s/esS9Nary6n06TyegRG022N0a1RmQ8sFQJ
         Ar/lOjV0WQuho9a2OOlwX2VRTf+i183+ahDzvYQdBGOKzztulAsjTqiXgnQP438u63kz
         84HsJu/Oi7pdM7HSBpBL0ajrrzV4LFaclFsAjGqTlANxGvWpGEGC8h7B/dZ7yx5ZuK5v
         9BQIRbH7CWDiUe1Y5XDQZyyKT8tkkQWxTuthpFeNHPLVryv7gw6vE+thgY7MLcr+xgTz
         DZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684626; x=1764289426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeoQ6A9zQA47pPVQ4WN0R1Mr0WB5BGBDvzJz+/SIjn4=;
        b=NxyJqP42Cyi63hIFH3i92u5l9lx5YtLn11SjHJ7Ey4DSGVlFOSRd1Od53buwlvfiSa
         ANggu8Azrv6fmhVpAZXF609TmSEteJYAGlimrT2Bi24mKyrWtV71HcAhN9VQsstOGb/L
         qWsEGFtDKVO6nApy8kM0FYX/oEBptJPKkXw770ReXZ/DzKTLqM4NEL1NHqe4EpAU5h9K
         m9NNY+IVSSFojbbuZdsnh8x30oFPpxne4wCltwomTAMD+GoLa2AIi01A7BCy/flwelI2
         chhi3k3XBFoc/6SBj1N6PFW5tIYkLh8KDstF9kazo/pAOHxCE0CojugMBJwOkKPXWeZf
         fi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8/c1Z0aiT3yuDFV5USCvO9nvQXC9io5Avn27Tt9feq9a0t22udKiy5WNJlnNQYdS1lksYq5ltEkEEkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VrAFQgnhssC/U2ujAuZ/cQxNmG57CvqjPiPxi5blxx+aS27/
	zMW25jGbTPCBBkYsWyruRtDleCTWPrBfxTZDFkNwEX5XcgeK76+Oi++uLW2LVGxzVMY=
X-Gm-Gg: ASbGncuVnmXfgZJcWqgQUmTlAh0+BZKYaNHEQqJYEABBwDd9EVBQ7pr1zZt4J6PCl3X
	S+j6Elk11BNWLfnPKQgDU+nQuDjXQo0Sb6K3z2Uj0/wrdPJsjeZEa47rTzLkEXLi0v553WfdrxO
	CXsfuateLJ3WOXRrFyvGVJx6C6xUPBpqfEKiGCsu2yzidVjBq0sUcpDqKFn+3M0KAWUYSOly6R3
	GZsunpvrxvaD2GmS3+heHTE8+y6vnhqMyHahOH/aphxg8mu6LhgUaftaz37jb7cLOSz7m6OUZ0U
	Go3M+dOc1unex1AI7MXVMG3DQ/vItFQtF0xjL3HUMoQQxgti6Ylxix5wJsh3/9re4z5WQThAzeb
	0w1VXgx8EIsRgTX+Y4pzbAPJdH+yLQ22gNl0VKbjxw1FdnTGfylw1JPDOZv5lg5pZ/fNjlQ5LZl
	C1ZVNdSzviWx7qsIWuMHKcVec+SUCqyPVmgKdV1UnaZ3clCO0Nm4xDZddn
X-Google-Smtp-Source: AGHT+IF9fpUZC0KSEi60qYSTXqU5TN/0kv3Br6v+7st2smYcT5XQOEwOWy/F2amvDq4QuChbOli5Vg==
X-Received: by 2002:ad4:5d42:0:b0:880:2c08:88e with SMTP id 6a1803df08f44-8847c5206f8mr8425876d6.45.1763684625945;
        Thu, 20 Nov 2025 16:23:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e472ae1sm27645766d6.22.2025.11.20.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:23:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMEwC-000000016i7-2ZE0;
	Thu, 20 Nov 2025 20:23:44 -0400
Date: Thu, 20 Nov 2025 20:23:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v9 10/11] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20251121002344.GC233636@ziepe.ca>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-10-d7f71607f371@nvidia.com>
 <20251120170413.050ccbb5.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120170413.050ccbb5.alex@shazbot.org>

On Thu, Nov 20, 2025 at 05:04:13PM -0700, Alex Williamson wrote:

> @@ -2501,7 +2501,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  err_undo:
>         list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
>                                          vdev.dev_set_list) {
> -               if (__vfio_pci_memory_enabled(vdev))
> +               if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
>                         vfio_pci_dma_buf_move(vdev, false);
>                 up_write(&vdev->memory_lock);
>         }
> 
> Any other suggestions?  This should be the only reset path with this
> nuance of affecting non-opened devices.  Thanks,

Seems reasonable, but should it be in __vfio_pci_memory_enabled() just
to be robust?

Jason
