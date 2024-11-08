Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534C21B427
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080330; cv=none; b=tLDq8Y8fyVjd3VYGQZ0+vIgvykBDuX2RH5p61MUevV3hytdA3mWlIyVAEVdOpBzJnMxlzrEZ7VW+df8Hbty31qmyNgt97d40GjyzRxdKRNO6yLQynnD1R7Iss+KxKsHV2ppY0rGllA5+QrykHb/0KxueYbEgIdiwzyJ+5hz5fJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080330; c=relaxed/simple;
	bh=OaBx3Fh/Km3ELqbio7v031NeuRfzJ9+4kTiWipNjW34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDT/TYddYnpiUsz+FE/ykWlkYRcra4SQAjUaPIQWVWsB6pCPWsszwxVTYADEKT5p4cdNx8WkXxClmPclNSiTHwod497QiISQiMSg5KRmOF49Zm4JoR9/+5Dle3LODNwA4cTHhTCmfc4iJ+3QgJzzRC3CWwR4C48bcZZp9ReaS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aexEmqOU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aexEmqOU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b15d330ce1so154657285a.1
        for <linux-block@vger.kernel.org>; Fri, 08 Nov 2024 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731080328; x=1731685128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=;
        b=aexEmqOUtoWo0nIxpp53mWmhgcdamtlMoWnc7v23Dq2R4nF+XhtjhKeEQukniU5tde
         Vce5KIwE2ZP9zCpfoy/YAiCAgwmM+QhLn3FHxZhCVqcMcnaWCLkDNsKSdaR7TEYQYQny
         I7V8/zeoQnhPgNDMziuf1jeRFibRMTmxh1Jfgd73c+9VMrzfs8b59x9r8L0WM1bTzHZG
         X4YyruWQtaCHeiW6iXjx8oFUyTMzlhRe6kIpwqDXRLz/HFKrM3zjhj7yegME3+gB8JUw
         w3XqR9e5cqtLx9oPgONMCEZKywjVgwCbdxTX4YQWSbGgXCYWTAg8upYA74ViTR7IznHA
         v2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080328; x=1731685128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sMW5Kuv5sIzIjhBbBygI9fJdJpSk6eqM7+xgs0I9dY=;
        b=IPLvzzwbgb6sDgzqlg3/NoP3/E66wCApUEd1/SWEtifIE6qfhNKczP7A+MMEPuC6qm
         DjAFCeAq5v4JTI2hzeEasBYlWjdiqYw+yZaIY7PB/mT30U6GCo2TDbNhg6ergRrh7eyZ
         a8drvw2GOQLh4jp19NqjZD11V4vsiMcaveVA1L2zlhN0u58vYdAO1l7c1V27xQjxDeg3
         +CrZKyPKDlncdCiqXMMj5ZPSLrXj+YCXru8Z9OrL6zuZEb+C1XXNasdyZnzOWd9TrR14
         MgG9xh8QoVRnPOiwI6TBNndrR3Qj1wshC6Hvik0UE18ch0sp+ENEVKMi43V3vhSbtWy+
         iOPw==
X-Forwarded-Encrypted: i=1; AJvYcCVTzqUBBBB5PYySk7sje+BZfyKYL0S7sszm8Fa2YITxrX6UmhXK8POnUp8oYX2PhnxLCn19yAIKIS7ICQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnOsrbks0EYzxkCk3Z2bRHgA38Lml2ZVJiT+kCKvo85hRvni2
	ZhuYDbpS3bS14drQiP/4mC59e0P2LO6TJyiE/XF/Hqwn4N9LgSAGbU4HWCk0tiU=
X-Google-Smtp-Source: AGHT+IHfTg/iLCK5GxrqZ9aoCzAZ7JH1FinF3HAR4KRwwnugOPp1CtA3KrYQyOs3W/lc98NgBjpBFQ==
X-Received: by 2002:a05:620a:1a21:b0:7ac:bb00:cd42 with SMTP id af79cd13be357-7b331dd2d55mr406755285a.27.1731080327649;
        Fri, 08 Nov 2024 07:38:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dd1fsm170869085a.15.2024.11.08.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:38:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9R4Q-00000002a9N-29Xq;
	Fri, 08 Nov 2024 11:38:46 -0400
Date: Fri, 8 Nov 2024 11:38:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241108153846.GO35848@ziepe.ca>
References: <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
 <20241108150226.GM35848@ziepe.ca>
 <20241108150500.GA10102@lst.de>
 <20241108152537.GN35848@ziepe.ca>
 <20241108152956.GA12130@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108152956.GA12130@lst.de>

On Fri, Nov 08, 2024 at 04:29:56PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 11:25:37AM -0400, Jason Gunthorpe wrote:
> > I'm asking how it will work if you change the struct page argument to
> > physical, because today dma_direct_map_page() has:
> > 
> > 		if (is_pci_p2pdma_page(page))
> > 			return DMA_MAPPING_ERROR;
> > 
> > Which is exactly the sorts of things I'm looking at when when I say to
> > get rid of struct page.
> 
> It will have to look up the page from the physical address obviously.
> But at least only in the error path.

I'm thinking we can largely avoid searching on physical, or at least
we can optimize this so there is only one search on physical at the
start of the DMA mapping. (since we are now saying all pages are the
same type)

> > What I'm thinking about is replacing code like the above with something like:
> > 
> > 		if (p2p_provider)
> > 			return DMA_MAPPING_ERROR;
> > 
> > And the caller is the one that would have done is_pci_p2pdma_page()
> > and either passes p2p_provider=NULL or page->pgmap->p2p_provider.
> 
> And where do you get that one from?

Which one?

The caller must know the p2p properties of what it is doing because it
is driving all the P2P logic around what APIs to call.

Either because it is already working with struct page and gets it out
of the pgmap.

Or it is working with non-struct page memory and has a (MMIO address,
p2p_provider) tuple that it got from the original driver that gave it
the MMIO address.

Or it really does have a naked phys_addr_t and it did the search on
physical, but only once.

Jason
