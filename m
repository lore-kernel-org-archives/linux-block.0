Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D364032
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581288; cv=none; b=uFs+Mtrnx847c3IDgTQ2cK+WZYQajAQb47Gw48TBpr1ZWFRgADFxTDm9a9UaFCCEug2adsoLc9rwKyGcRXe5HHWGCiYYMzUn8Jj8eKZ0aiZy/kUdVTtpGb75ux2dQ6ClhSGSbtUtQmhe1nWwqTeqh8tabec2Uf0L+t1wpGnEJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581288; c=relaxed/simple;
	bh=McLj5MkyXM/EMQB5rQ6xp2qJjBV3WgZDPtIMlF++SQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Mbr6fiCvcYqPNNZ8m1TFZ1iC8jy256cEo7deuYT38mTsHmUDpLi9wqtf1OYwcnQJX68lSjD50pqLCiODnRS7OlwXRciEBi7sRuqOYO11ixGr+OYJ/dOdrpzi55C7LdLYqVAq3QuK0s1qQWFb6EViAZ/mG6Wjv2NUyWxpJ2OC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bPc6S0sG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bPc6S0sG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-882360ca0e2so878176d6.0
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763581282; x=1764186082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xvMcuBzJSIcfclCVWQ2hNnnKt+oezBHS+z89ygHsa4=;
        b=bPc6S0sGuHmGARD8ZnpZfpm34GFSkaMU4OFxV21xf8BCKqrDuDP5OSlnsvWhrOxRZX
         YRPZGnk4HlFvvfrXi4vurzIIFGZbdxPcBWTX8paU27knM2Uy0YyHUQaP/SbIe5tYs25M
         auLCKa71tmA4b9oRJB7tRbZCJ5gzfG5IYHiXSYTTvrXL0H7m47vcmEcSh1dC+tawQWXp
         YjgAR9cFyUPRlIPRLolCsiWYZyfCeOsDfnC5AVkjTKAOixK9O2mV1jUfpr7J66CPzf0b
         DyQjsItU8VvA+A+r0bVuLpQU8+5hX+La18EKV9zTuaWbH9eO0dxkCMXRfCZQsRcT1Z85
         Faog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581282; x=1764186082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xvMcuBzJSIcfclCVWQ2hNnnKt+oezBHS+z89ygHsa4=;
        b=G2+MJyIMopBEkr8shPPL/CGon3l8qrGvlikuY1TWkKXhtEbNruzST4rSWMMDNQ1UHk
         0LXoAq6ZsquyAQXC5R/TpOiMI3gvmZb2IkwBMoZURoybi+DikSwpR8r2yXPfBhQm8WuG
         1EPPX1B0baLQJDaOzmrpMYmPF7vZ7BtIRe5swtw/Z2B9QfTbTrth83i/fncbRPoFgIj0
         wafVj7VeEWLxhrAGZ7p1sjpjFI0RHvxnJtLHgRrrAjwEnGTx3Gy1twkGzABZWL2Jvqto
         e2PxgCnnzRkYXVD8/gB5+AIMD1M5axglP7X8kv2ZNM8lzFXygLi2enhROQV5ke8oejKj
         1zEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKj9egEheG3GZ7IHb3k35MJZORsDFR3odrCT/NXzpn5xfjTy++AyfIdSes3k1c5kL7dQtwCBiri7Hv2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq3EefStUU9f0qKiFB7BidaXx9dMcGhGyBvYeJEddl95RmP+u
	nNj4NG5qpBflNFRkD2Bu4VYWdE3RVVMypfrjM17CraLJVdQgTktn+7m5qP91AVpVs8w=
X-Gm-Gg: ASbGncuw1Fv4XiKsqX0P/X90sc55WE8v71WFFJk8HnlfnF2tt3lZ41rqvYvZqclyYwD
	IqkqKVEfJfpKkiJD7oNk3XBHbpdL6wZG1itiu3OEu8w38Tr2ltcYRnsnaHhAYSo1vq1OMsCB2i/
	lZUXDpUQG1h+7aoXXVtIWnmXCrKdCpttja1q7T9zJywpOKr7kOib9pOafTpdnOqEx+o8rkLCMi4
	5EB463sOG4D956n1F5f/K5TgSxCw+LDTzJLeQfyK3yB+uIPJclbZc2QnqG8Lqr5uAM+vrYi5tJP
	zFsC14l17cQUk8cw0nxt2zXUpIniJ0IcLmYv0mzd4slcHosev9jV2ivP8STcTJK1JnqmBSQS4AS
	U1b79Q4WrqJNA7/2uI0whzz5tqytPEWQVrmnIP7lSdIst2b5JkTWgsjShO9y86uh+eWdFmlT1Vd
	/mn8fnUwyAb68th/Q53aW+xT7PylA/LRczo1XtUWoKUuETToWkvkJHP5oq
X-Google-Smtp-Source: AGHT+IEkkwKLlD7bgArhzanqcgyJXrNkTCLmX/zPs7UZp1FVMILPKD98FXvYwEVi1NAfBqdDip+8Dg==
X-Received: by 2002:a05:6214:4a84:b0:7d2:f787:1978 with SMTP id 6a1803df08f44-8846ed7f961mr1725046d6.3.1763581281958;
        Wed, 19 Nov 2025 11:41:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e47115bsm1948696d6.21.2025.11.19.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:41:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLo3M-00000000bbB-3imG;
	Wed, 19 Nov 2025 15:41:20 -0400
Date: Wed, 19 Nov 2025 15:41:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
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
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v8 10/11] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20251119194120.GR17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-10-fd9aa5df478f@nvidia.com>
 <BN9PR11MB527610F3240E677BE9720C2B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251118142849.GG17968@ziepe.ca>
 <BN9PR11MB5276EF47D26AB55B2CD456EE8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EF47D26AB55B2CD456EE8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Nov 18, 2025 at 11:56:14PM +0000, Tian, Kevin wrote:
> > > > +	down_write(&vdev->memory_lock);
> > > > +	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm)
> > > > {
> > > > +		if (!get_file_active(&priv->dmabuf->file))
> > > > +			continue;
> > > > +
> > > > +		dma_resv_lock(priv->dmabuf->resv, NULL);
> > > > +		list_del_init(&priv->dmabufs_elm);
> > > > +		priv->vdev = NULL;
> > > > +		priv->revoked = true;
> > > > +		dma_buf_move_notify(priv->dmabuf);
> > > > +		dma_resv_unlock(priv->dmabuf->resv);
> > > > +		vfio_device_put_registration(&vdev->vdev);
> > > > +		fput(priv->dmabuf->file);
> > >
> > > dma_buf_put(priv->dmabuf), consistent with other places.
> > 
> > Someone else said this, I don't agree, the above got the get via
> > 
> > get_file_active() instead of a dma_buf version..
> > 
> > So we should pair with get_file_active() vs fput().
> > 
> > Christian rejected the idea of adding a dmabuf wrapper for
> > get_file_active(), oh well.
> 
> Okay then vfio_pci_dma_buf_move() should be changed. It uses
> get_file_active() to pair dma_buf_put().

Makes sense, Leon can you fix it?

Thanks,
Jason 
