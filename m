Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97336CDE3
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580685; cv=none; b=looaUMyZbpcxwYuCyVFz9oH0cEb892Wip9GXPIkEsUDCazL7CbF0crrOjXYm2OWXQF250ID2fzHiMfqBaM7AXXxouBfXnrSQVYzNf5Z4T3NLx4grTcynfQMU5oL+vxkEoLDcyhWQGEQWpNB8x0T1rn0hUoI76Uv96TYs3E+m1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580685; c=relaxed/simple;
	bh=31o43Jiq7+42iBKuCHD0EJijctYU11Xzmoh7F9+p7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVTpvNzZEVFvhBtb+88oQd1qvnJmh68mhO2CDLJXOP8vp1QKO9x7dhgssuczIOoqaZvpvscHNnkVpi918KWIGYWlwNGNml2ZDG05/qrwBjToKRbn61iHkdj2UL/Jd5i/xELCaCTtGbpXU+NsL3D4uwy7yVyjDMW0mQYFg+nKZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XdlJDak+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XdlJDak+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee2014c228so741441cf.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763580676; x=1764185476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7MnLKcAx1SQL4BtR2OdhLpsdZ14wJj1fNMBVXMaHpI=;
        b=XdlJDak+5BK913SU3JuefgTys0Pu3jagmK7yJRyg0hso6vBbEnNWrP/4T4ol0frYeQ
         v72slbgWiUzUkvc5J9nruxngr4U8bjd49BPaZVmvFk3nVkQeWMFAA9u86tKqv9X1hNhK
         MlqYYLa9OWUP32XsBcZxKrfLx3/P5R6PJ+h5hBO1AY350/0bZcNA4a3VB+Mm2EZq+tuy
         2zW8VsnOjICqJWrFFskAlkKYKVrHI+m3LVPh9ZWULCzK0B6ii9jOvGUvNr+rAbET5gKT
         aIqFqtGZMVR1/oWhdLlQH/aHK4RI3YFZ+ToY0lGX/NpOTOSRqsVtdilqIlqws45I3kGI
         vpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580676; x=1764185476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7MnLKcAx1SQL4BtR2OdhLpsdZ14wJj1fNMBVXMaHpI=;
        b=r98aCPNxXpIC7Cn8gYwfuTgzAvvSLA/PSe+r+EUsJXOtVb2tIRnO0Ck50ptYj5z2rD
         8xed7G2c0e5bpOoUcT23YPeevly20M4iJrsCyYd5kgHVwWJF5iLAYyURI9pVyNzOeLVv
         jfLeiSt9Eth95/p9jTmhcuf/kbvz9zk6kYA1M+fE9hry9lYYayHmMIkKeEJuZ72y6YyC
         4uBIzPkbhJo95nKnKUUPUC3WmZFoTjmJPfTEzoc1Huie7ygW1FvfSeYYhbHDuxuYsaEL
         LskNhS2yLz4UKurFjq1Ij444zkjADiU+m/0Q2pP+iXY39Il1ATMUDYX7OcsFYtfvgfNV
         uflQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC8GMGdYT++Bfbqt7phi2j0MTfE+bT0BBQjHbqAOMnu5qDIJTlKjYryUC1fYx4X3nGoZ2aUS+3lVlNOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3r0m7/UJocKilNJFsS5SjjulVe5RCEtBa3heNtHPVVHqpAw2Z
	Z6EjvtU4TmAvb+njAKqzaLqfedO1Q75wwyQ857FvF0OA69lHNNxHcd2neQVng5Rupkc=
X-Gm-Gg: ASbGnct7q+JbTa7dSK9u6RtdAdjubSPMpvKjLHXyFeaqSmhE+Wjb24zpiLrew+WT6F8
	zPBZzBBhtnF9lu8ZHkRQP7BCPQmH8DViI3Ng0bgDHGmFCZQyGa8VV4AgVVdlaBeA78k/OJtBZwB
	1gPAOvnVFTPR4M4vqWVSeCVbpQxURWv4V7UpXe8++6m2Fmk/tCLuCoMHndgGjUT801ZEloeuX4p
	CkTDavcIXniykRQUF068spOKOsTgKEVrJlPC38X4TwaQ9/MOWVhXp0QZEV9ofB5+1MCkZOIPFHN
	ygzadT1lNKOI7Xz+2HvffkML8Jmt+XwUnNtLCFQCtVqwe13tVKApfnStFHhvekJu3kgp9B+6xcH
	NZGVLE32SU2wsLpNlyjocP2UejhOBCtePlOEtt45NziGVRKK4PoEMXByB6JTdrBCC0L4T1DpZ86
	YuKUurOc+XmLs6ONseb31NfJRcCjmZtp/Fr5Q9QS9lDyo7CztD6J1utcluXa4nHlvhk8Y=
X-Google-Smtp-Source: AGHT+IH0hpvR5twkqRmVGMRtAcrCxesRIOb4Xizv2z5I0TXHRJV8nSPA0Y9PLt873fJAl178vHWixw==
X-Received: by 2002:ac8:7e4c:0:b0:4ee:4a3a:bd18 with SMTP id d75a77b69052e-4ee4a3abe64mr1136891cf.76.1763580675980;
        Wed, 19 Nov 2025 11:31:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e46ed0sm2807721cf.20.2025.11.19.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:31:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnta-00000000bWq-3r3x;
	Wed, 19 Nov 2025 15:31:14 -0400
Date: Wed, 19 Nov 2025 15:31:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119193114.GP17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>

On Wed, Nov 19, 2025 at 02:42:18PM +0100, Christian König wrote:

> >>> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> >>> +		dma->state = kzalloc(sizeof(*dma->state), GFP_KERNEL);
> >>> +		if (!dma->state) {
> >>> +			ret = -ENOMEM;
> >>> +			goto err_free_dma;
> >>> +		}
> >>> +
> >>> +		dma_iova_try_alloc(attach->dev, dma->state, 0, size);
> >>
> >> Oh, that is a clear no-go for the core DMA-buf code.
> >>
> >> It's intentionally up to the exporter how to create the DMA
> >> addresses the importer can work with.
> > 
> > I can't fully understand this remark?
> 
> The exporter should be able to decide if it actually wants to use
> P2P when the transfer has to go through the host bridge (e.g. when
> IOMMU/bridge routing bits are enabled).

Sure, but this is a simplified helper for exporters that don't have
choices where the memory comes from.

I fully expet to see changes to this to support more use cases,
including the one above. We should do those changes along with users
making use of them so we can evaluate what works best.

> But only take that as Acked-by, I would need at least a day (or
> week) of free time to wrap my head around all the technical details
> again. And that is something I won't have before January or even
> later.

Sure, it is alot, and I think DRM community in general should come up
to speed on the new DMA API and how we are pushing to see P2P work
within Linux.

So thanks, we can take the Acked-by and progress here. Interested
parties can pick it up from this point when time allows.

We can also have a mini-community call to give a summary/etc on these
topics.

Thanks,
Jason
