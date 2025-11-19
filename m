Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A6351FDE
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559334; cv=none; b=cV0nPdwRqhWGuPVEuUu5gMJ6tcThshhVCou7dvrnbt7COYb1PQAOVS/+yH8HDfapOnLnHiR7IIWoGTzvTFyTwuQMuO2Ql+9lf/GfWZXRnSlwVzIzLtQ4fxMtQz3XUCA3jBiiLdHpE9l2y10Tqf3uh9Ez8Lf8gP6JGcsBc8ayV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559334; c=relaxed/simple;
	bh=JbbhmQiTlI31d28XPGRBqj9eq2p7XGaOpuCDuXLlBNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABinw5B/kUvhOhKEqy+opI24sUlBtdHlDTZroQJg8C21xkk3rMos0wbZoE5eUyCgyz8bt4C2FUGzOBRdQcOVrXxuRiClD5nsKsfHwwk283zc0isOVe9wLXeCCBjv6ikAz96UgpqUerZV2vk//0KL9+MWHRYYKRMZLpIqmSqZ8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q0A2KJ7+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q0A2KJ7+"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed82e82f0fso62605161cf.1
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763559331; x=1764164131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72A2miNlT6HYTvn6gfrMP1LsN3+/rcjlJPwocEiTvrs=;
        b=Q0A2KJ7+QNz7Du+Iu0DMoQYF9BPquUCs/jIMwr6j8yjAJYCoUd2gtuG8vQUjR8XFmz
         BWU0OXFasN+uYXzui5ccF9deC4HtKGvvT+DRuxn1jSOtubFSQSTLMDOCI0v+OkrmnQo9
         j30dh3Ui+99KMkOenB22DloIr/bkj7hqXrn/VjYcH8e78vnEJUMWflxtjGpc5bOYPhAo
         KXmcPuwjhRA8P5J/K6B3nGGLubDNoWabMG9R/EXoYaFsaHe68biGjnve1stMiZBlv7Em
         nn9dpCi4NhEsLSnTb4JJW9K645HB/HQBjJ/ZBpJ8CfKLpA3GNs2AkNnBXK9kcFhw5d1U
         l8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559331; x=1764164131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72A2miNlT6HYTvn6gfrMP1LsN3+/rcjlJPwocEiTvrs=;
        b=Gb1YRC7zhmvJdThOW7Aww/XYC9yfxboa+CT9mhWBt0JpX5aDHt5IhiQ3PLVIb11mvo
         VsNGbHWxpvb6xW2Y9xc9vRGxzAcvO4gT5Lo18DsEb7WBmZb9G3df0iCaPFQeO5KhQeSu
         6fybqj+5e6UTaN8nySZQDJFi+8XXSSfrKbxoI2IJRkJC95dwA370ABcBPhPGy4dqkUh0
         OqoB3BNlt4bXpDimgPLFoyTzCwVYlwAq523hfParbi5l7IS0rlFmckun4Jx5SDcBk1pu
         RBOsxFlkOKSnN4OpT8ldgsH1bn0h89NctAGQIlvyrs+dVtJyoNeURrWuxeber5pNRXDk
         V0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUKaRTgcGFap497xkxs0sHdfYVJjqqKZqG5EP2d+f1kMX+4k/EGxI0Qg+YrLJb5ahL6v0WcDVHEvUhs2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyt9HAaossvLV+/jCXtBoA3c2idmo3DbS0zJei0lBaPU/gQY2X
	OrzfRzqxH2PFHXUj+1WM5z6U7zvNlAU9h7yXBOikTHvcTDossASKBpqjwJuwqGwZvAg=
X-Gm-Gg: ASbGncsYC9WAsDNnz22wo60Y275yNSW/O7t6BDZqK4t0NkSSfhuGZMZXwaX6h7kZitS
	2aeJnDgNZMZEE65RQ0TxUkQvNJtNQCpAq6kXfja1O0AVrzx0REOn30regs7N81O4ReQbMV6GU06
	Ltsd7B4OHAWVOUdmYk6UWdnCw+QxmQXietlkg09yhQtxDR+jcrey8wzVe5RbWgGjviWD1uZ7vZ1
	mYEaTUqpWod8EHzw+8tU+8fxqRO0c6pMATfmWGeInZvC01tvQ9EIJ8Nr4mnfT+yH3/3nFw0Tqye
	6pPbvo4lNbjd2SjGaQaQnpXAgntN+HVWn6asDye6iPulvMxz00M1szuh5/L5um9ZjVSZFKOoVe9
	FMvwq4WFhO32K0mhySjowyuEJn1I0b4ng1Bn3GpLxDD5nKqN+BpcFOVZbispfSpDskBPcOgeJtM
	1OulmozkmRgziWATv575T3Rp/5iUW42n7XNFPJcPsB/g54G1se4nSAkpV/
X-Google-Smtp-Source: AGHT+IE7dgToIwQMvgHU78QddWp+ZiJRe5Ch8SPXRMVN2DOwf2T1NT7zeC+YapS6FYUcpx8f/T/2tw==
X-Received: by 2002:a05:622a:256:b0:4ee:16a8:dd0 with SMTP id d75a77b69052e-4ee16a8d595mr193299331cf.53.1763559331028;
        Wed, 19 Nov 2025 05:35:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b376dsm127986771cf.7.2025.11.19.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:35:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiLJ-00000000Z9b-1C3G;
	Wed, 19 Nov 2025 09:35:29 -0400
Date: Wed, 19 Nov 2025 09:35:29 -0400
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
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 05/11] PCI/P2PDMA: Document DMABUF model
Message-ID: <20251119133529.GL17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-5-fd9aa5df478f@nvidia.com>
 <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>

On Wed, Nov 19, 2025 at 10:18:08AM +0100, Christian König wrote:
> > +As this is not well-defined or well-supported in real HW the kernel defaults to
> > +blocking such routing. There is an allow list to allow detecting known-good HW,
> > +in which case P2P between any two PCIe devices will be permitted.
>
> That section sounds not correct to me. 

It is correct in that it describes what the kernel does right now.

See calc_map_type_and_dist(), host_bridge_whitelist(), cpu_supports_p2pdma().

> This is well supported in current HW, it's just not defined in some
> official specification.

Only AMD HW.

Intel HW is a bit hit and miss.

ARM SOCs are frequently not supporting even on server CPUs.

> > +At the lowest level the P2P subsystem offers a naked struct p2p_provider that
> > +delegates lifecycle management to the providing driver. It is expected that
> > +drivers using this option will wrap their MMIO memory in DMABUF and use DMABUF
> > +to provide an invalidation shutdown.
> 
> > These MMIO pages have no struct page, and
> 
> Well please drop "pages" here. Just say MMIO addresses.

"These MMIO addresses have no struct page, and"

> > +Building on this, the subsystem offers a layer to wrap the MMIO in a ZONE_DEVICE
> > +pgmap of MEMORY_DEVICE_PCI_P2PDMA to create struct pages. The lifecycle of
> > +pgmap ensures that when the pgmap is destroyed all other drivers have stopped
> > +using the MMIO. This option works with O_DIRECT flows, in some cases, if the
> > +underlying subsystem supports handling MEMORY_DEVICE_PCI_P2PDMA through
> > +FOLL_PCI_P2PDMA. The use of FOLL_LONGTERM is prevented. As this relies on pgmap
> > +it also relies on architecture support along with alignment and minimum size
> > +limitations.
> 
> Actually that is up to the exporter of the DMA-buf what approach is used.

The above is not talking about DMA-buf, it is describing the existing
interface that is all struct page based. The driver invoking the
P2PDMA APIs gets to pick if it uses the stuct page based interface
described above or the lower level p2p provider interface this series
introduces.

> For the P2PDMA API it should be irrelevant if struct pages are used or not.

Only for the lowest level p2p provider based P2PDMA API - there is a
higher level API family within P2PDMA's API that is all about creating
and managing ZONE_DEVICE struct pages and a pgmap, the above describes
that family.

Thanks,
Jason
