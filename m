Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10553590DB
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559433; cv=none; b=TkBlXCysZLR0ZDDUmU+yiYetW064aVUUTpbQv4/rzO+gDFB3fIi3FPUR8Pwic3WV99oq6aGG5wm6yfrj+H6tF5wR/LSHe1ximufh+HYJAnaRlIZpN1BZdrf8O0RuBVSkUMd3XnFinQ78mWko+4S7A4xl8wOtfGnkBlJjEEa6f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559433; c=relaxed/simple;
	bh=xHij0HoeROljwYVIzlugVWfpQyDCueEmuef+LW2XwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4i6WpQHIRB2HnyCkiEnyV6CixFXDeGagvkymxXpFBQ6X9K07Q0nO13/pS/lbYLHAQrwLrSsmQ5XPmGAYsUSuwoz+wPSRwzA0Df9G0hdV+xrbbTLggDo5QGWBZleWgh/5N2mXWqCElZvHIb+I1ZeCKQRdfo8Ys0+uE08hSt0syw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fbXe4Vjx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fbXe4Vjx"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8823dfa84c5so75098826d6.3
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763559430; x=1764164230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=fbXe4VjxC23iYkeLY6whMHNkkabBkvJIbJP5uWEZ9VyfGmzFQGzB51LkWHp8IJDAfy
         bc+eLn4USPmSpsqj3w8yzTCbSWrINyQaCzhx2fEyFsGqHQot9GoulHgvevmJK/p+6YJe
         uuqgBjlYy9SZ2oFV1DyKPu/HDjlNaS7AdAB3/WXAttezKn3TRJQih2HNbzrWUBTHOeu0
         UJ2OeI0gafI/ERIzGOe9pXUqUOsEzFQpKb1VF8JKgbox0izii7oPTuI8eo/HdU9yTM8m
         sWOXfMhDn1cdFkJBrCL78GFZ1KRdezr14MAtsv1TRUBQrZyIN8Rm6LRdR8ltbAsYsTUe
         42Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559430; x=1764164230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=VZIBsoyyd9dnW78wzvwaGKZfXgrfi27qnxALdkiQDoSs/Hr67PaJedJovwmH+2MT5O
         e6/QQcuaZ3mR6nn/RqTrmbw78sUzjuk3ZNndXgM/K0+oOzl75CVMzrfFHuNF32VIaM77
         2MyIx6ZGcU5d7jp8mO5mGIQEvQUPMoE2nP5PWIrWF0ga7M1VtvDE1cN2+7IyCkMW8oHE
         29VSicrJBS9uONdN+a2iIP7n7OKWxOdv4b2vhxNCNYvKzb+0y6SL4xUott4Zj8YMCjk+
         4SB4istEqGLO8SxAE49tnLPA6+o9WlSML2M56vpYQs/1YRfLwOh2iiBFIJEW/HPw/8H2
         lU3g==
X-Forwarded-Encrypted: i=1; AJvYcCVEScJB5/gnjv8PI3JMC6JFStm14GC4048oah+qFm1UU5AogwWqQzAdiSZQgBHySNX911tcC5V2EDbunQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9jw9LYi92CdP19Ntu13QmRvR81uY0Y3m15XNNPRwQDELF+zj2
	jOI1IxX48kmsiwoUyBjt72JojyxpTQNt2HRLlc2ht09nLJdbpic73lg7vS1GUZCbv6A=
X-Gm-Gg: ASbGncuZ3HJElFu2Cic/NXfvNPJOM0GnqmNDzx0XyEAUJPyR18bd+xY52OmDuLpZTay
	lIMaZiqZcx1JYIa97ma2yw1j6C3GQxE70ACjYREI5igk/bqsfuxT692+EoJDzSyVh5ottpLMf5g
	qychaQAYbQF/fanYVca5oUbdc87Q97FGEWiqGMfqy5yDuUHCbFI5C6m+CVBRyMJ1Uhm6qrfpCtt
	6tYOSxzDvalmfUGI+ylF8+4L3+7ENo/Ro3q8jHIlHY0kC2A1owIxpe8sz3TbtaRdqvxE/kS2VDh
	nGBTyn+7KW6CooUeWaviZiAe3qCXbADKNax0JCiVgRY/6YrOnQMOXvSuZB39syoREWeEXug4vzC
	gjNJEmVCd6cWVgqfZES0ioU/SI7Da78BK+w6b72UfPawOxRzyiYBy20MZJVMHSpfb5tjbhjPZGu
	LsuVofgGa+rIWNDw+Km3nxcuofVvD/ErK6FRcMOA8DIB5k7BR7ACKViW/ymSlyoQnXBhw=
X-Google-Smtp-Source: AGHT+IGopBrMkEkq4/9KDO3x1qdzFmkcFO+Cz6Is5DlvxN8PyWRrz38DMZOLki2k1pBf80D+Z8AYkg==
X-Received: by 2002:a05:6214:419f:b0:880:22f3:3376 with SMTP id 6a1803df08f44-8845fc3e0f0mr26190076d6.10.1763559429603;
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm135128356d6.0.2025.11.19.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiMu-00000000ZAY-2EdI;
	Wed, 19 Nov 2025 09:37:08 -0400
Date: Wed, 19 Nov 2025 09:37:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Alex Mastro <amastro@fb.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <20251119133708.GM17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <BN9PR11MB5276BC3C0BDA85F0259A35058CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251119133000.GB18335@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133000.GB18335@unreal>

On Wed, Nov 19, 2025 at 03:30:00PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 19, 2025 at 05:54:55AM +0000, Tian, Kevin wrote:
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, November 11, 2025 5:58 PM
> > > +
> > > +	if (dma->state && dma_use_iova(dma->state)) {
> > > +		WARN_ON_ONCE(mapped_len != size);
> > 
> > then "goto err_unmap_dma".
> 
> It never should happen, there is no need to provide error unwind to
> something that you won't get.

It is expected that WARN_ON has recovery code, if it is possible and
not burdensome.

Jason
