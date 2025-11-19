Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1136828C
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581514; cv=none; b=h8bO2FrjxgpgbiyV3kyczVUKIFrC0pzN0yKpM4p1xVhSXB3TjqBtVYxZ+ECltanCYOS1fHo17htUpT16Asn6P1NcuRUkh+di3QI7IbLKHj+ESVkB0YH4OQlokMHgP14WA27LB5Nc/kwjbAWVPMasJjW/AOagwUnKqzUmlennBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581514; c=relaxed/simple;
	bh=ez/Kk64Qkn4faxtP6x8udD23BDfPOJ9+UM/Y/c2urgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO3udr41vnR2tYjwy97IlGFq5k2ns41+/7vOBOVn0llikLujlMce0LhVEa3e2w/txi15fFcmO6/fBD+JXHmggEVPD+RrFMzF0puwQ8GYrDoD06SEd1R5qk6RZ5wt7gUyJtElV7ZC2cL2yg/RuxYrdj+CEIop48rUo95CVL+NXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L4UMvPAP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L4UMvPAP"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b0f54370ecso9306785a.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763581508; x=1764186308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngigizqFoW1/n7l/UtYTJcb/TxX1OBEkHcoOUDKA/VA=;
        b=L4UMvPAPhzDYWioXgmQd8KhZiNE1H6762XCtFNAqx3wKKkmE3xDSf3bYqxSobinIuO
         ffuwmZf4NzL4SQmiwAjzsu/ZOlG/SbwHH1tHGDRnLj1H1TlRcyZMIZC/BRgq4dfjlO3U
         ESSlmjSDSIMhj9vvFDraaZfgHrBPSBuhAP5sEf0rU9NEWTaa/MMIeM9OGXcBCaJR6aCu
         5/d2TA8eKJeVFBWRihAEOITWaxSWulToVPH//ismSQUnwpXZ6weHPTMfogbiigG9Rd9l
         3feBMqmQlMibdreY9QRmN8pwc1fk5yAOrG6R8cYPL9V3odhMjgag3rVKkdIy2DY7Ob+f
         Ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581508; x=1764186308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngigizqFoW1/n7l/UtYTJcb/TxX1OBEkHcoOUDKA/VA=;
        b=fHX41IyB0hSKGg4DRGBJ/ksVkMkitympVyNEkYRuW0whNFKdZBCeERXH4dMmjOH09o
         LbLS7cdgoyre642h0HkqpQAWjZkBP1OHaIiX7J2wpxXLEVVrHmZLFo4ZIxnDuNlNisnm
         CGLZfjcsq5rME7M2X8Z6u54ldQxJew5yX6R6kKaGlREe2rLZiIWbTlz8MzXlsU/W8W+w
         6vqxvwZCjivm+cLhwQ9UjgqvsWhtqGRSWBRfT+77UFqM2KJ2bANSyA70IinO3DDYbAkn
         6tw+TPT0Aq/wwlKgHnYwYfLqQB4f8nxRndXskvtphHm0eb3Qb7PwJmfpSvvgPe5sVLvI
         SaXg==
X-Forwarded-Encrypted: i=1; AJvYcCWJmB65nz/XHB0kSH4TciCCXvw/j9P4WQm/1xmncJPqydWPJrx6DxjubGxX4alvLXGx0dsxXgd8wtAvAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmUXXDvGy2fynLHAMyy5o8NrzsNNzSQs9B/38esCYfqwwlvwA
	EB1rEWxurBHBeR93HTTTlh6Yvxz2mP+VC99rmxO9JKAP05njjh/2i1MhJqWJ6MJDY0+V2sv2xUD
	c6JnA
X-Gm-Gg: ASbGnctCQBJwRwmuI3dsdodINjf29pS+JhITioErMFNPLKf3rfnS4EtfUxwAO6nclrX
	XN8zZ7xsEepOSOtYyC6F7vX2kGAQ6IfDf/2JTTjX6maXmcu2TK3JCTe16+lriacK7LiCX6ysGeF
	MiubzSZYonOcMeBAR/YAf4LgGASvbf07mij59r7NwQw8cbqDlEaAK4ahvWQWkhgqKbM0c3Lskdf
	gXY8Sv1QLbCp3DoWxAZ3sfApaoCtSpt91Y5rDAkk2n26qy2MG1SbmQ6/Fk3ys6+AH3GBGWa6nC3
	N+FRO2JmeDKrI0NXq1VbTbrShIJpqvJOGxHhgFlarKZYbA2NdnAm0JBl5GovdMhclfPMfV0Q0nq
	EAE4t6vVhuDIWXxYZlaWR0u5AVBpRxQTutU9/PNaJIyd6V3Dp+/yzYDo45ebQ9ot66p+NsZRc95
	P5IIZmbTft4SZnLmRNKXKSsYi8BOThgj4vMWEdK9bI1TzsJ0BlZfU1+pxQ
X-Google-Smtp-Source: AGHT+IHM2All3T5KCtKB0YCjHC7VAw8938Pjcsqc0YyXScERh5oSqA8kZNdUfx1RTYUHZ+fIhtYAoA==
X-Received: by 2002:a05:620a:44d4:b0:893:31da:1028 with SMTP id af79cd13be357-8b3274b5313mr86654885a.90.1763581507903;
        Wed, 19 Nov 2025 11:45:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447272sm1944186d6.5.2025.11.19.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:45:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLo70-00000000bcb-3TE0;
	Wed, 19 Nov 2025 15:45:06 -0400
Date: Wed, 19 Nov 2025 15:45:06 -0400
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
Message-ID: <20251119194506.GS17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-5-fd9aa5df478f@nvidia.com>
 <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>
 <20251119133529.GL17968@ziepe.ca>
 <ad36ef4e-a485-4bbf-aaa9-67cd517ca018@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad36ef4e-a485-4bbf-aaa9-67cd517ca018@amd.com>

On Wed, Nov 19, 2025 at 03:06:18PM +0100, Christian König wrote:
> On 11/19/25 14:35, Jason Gunthorpe wrote:
> > On Wed, Nov 19, 2025 at 10:18:08AM +0100, Christian König wrote:
> >>> +As this is not well-defined or well-supported in real HW the kernel defaults to
> >>> +blocking such routing. There is an allow list to allow detecting known-good HW,
> >>> +in which case P2P between any two PCIe devices will be permitted.
> >>
> >> That section sounds not correct to me. 
> > 
> > It is correct in that it describes what the kernel does right now.
> > 
> > See calc_map_type_and_dist(), host_bridge_whitelist(), cpu_supports_p2pdma().
> 
> Well I'm the one who originally suggested that whitelist and the description still doesn't sound correct to me.
> 
> I would write something like "The PCIe specification doesn't define the forwarding of transactions between hierarchy domains...."

Ok

> The previous text was actually much better than this summary since
> now it leaves out the important information where all of this is
> comes from.

Well, IMHO, it doesn't "come from" anywhere, this is all
implementation specific behaviors..

> > ARM SOCs are frequently not supporting even on server CPUs.
>
> IIRC ARM actually has a validation program for this, but I've forgotten the name of it again.

I suspect you mean SBSA, and I know at least one new SBSA approved
chip that doesn't have working P2P through the host bridge.. :(
 
> Randy should know the name of it and I think mentioning the status
> of the vendors here would be a good idea.

I think refer to the kernel code is best for what is currently permitted..

> The documentation makes it sound like DMA-buf is limited to not
> using struct pages and direct I/O, but that is not true.

Okay, I see what you mean, the intention was to be very strong and say
if you are not using struct pages then you must using DMABUF or
something like it to control lifetime. Not to say that was the only
way how DMABUF can be used.

Leon let's try to clarify that a bit more

Jason
