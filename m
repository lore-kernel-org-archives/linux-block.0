Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862622D7B6;
	Thu, 14 Aug 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193419; cv=none; b=ClCHMjkwkV9gKMTAh8/p+/8Y6Hr7D1Qz6Zt9tf8ZFEMNwAB65O8nJInvEhAIQ/oMFkfg5iPdZMDPhtGWEgjtjzekKgfGeEjNtX0hcmNpnx0lWPMM6+cf5sew2oJY0UzcN2FbEzzNrguUq4ft2BV54noYMFIJktaMoefurzgW7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193419; c=relaxed/simple;
	bh=NtGaXEt/rCXZbH6AhRXhKag5AQfcAprg8g7HcBf4fa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxyWF9vgbQiArA75Sa2Fz0DIijUFb9mZgoY+0KAMaOeLiGzGRuMVuag5nJ5Uk/a4W7NmK6Rfwo/tkybFmHBVzSrDFxEPiFtup22yXWyu1feieOeYsUDyNpMRDAm3BVN6oPVrpDFDDZpf58IjXQAtSgZfLUa4NOyYPhiVStMdtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qET8o0Xv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qET8o0Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66588C4CEED;
	Thu, 14 Aug 2025 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755193419;
	bh=NtGaXEt/rCXZbH6AhRXhKag5AQfcAprg8g7HcBf4fa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qET8o0XvKzXdUiWMSbCsLL3eECdWZ/AbT+J3b7auosgo7K/gf6rt6x3D6UTI76iqO
	 ti/iGG5xkCHTOQimoWMmFfEnk9qKFL2quOO5nh0SiN+AtdcIknOOMaCwhWCHlP4gMD
	 ykB+wRt62M5cjTVShpIgxGBKujUJevNaAvQmESCXsgTaz6eSAmBzP6Np2+HWgacd/i
	 ptn2QT+kSVgRjXKbq92+rFZQUf9rAqUBC2DFgoqq/jRE8er78UlpXtOrVW/WVebQgm
	 oscioXsT1akK/vdGGIJZToP0KYoeWZGwANzuVPBNp0BvFFlINHo65cmqBExc85Nyt2
	 XqGc4T1I2WbCQ==
Date: Thu, 14 Aug 2025 20:43:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 01/16] dma-mapping: introduce new DMA attribute to
 indicate MMIO memory
Message-ID: <20250814174333.GA8427@unreal>
References: <cover.1755153054.git.leon@kernel.org>
 <f832644c76e13de504ecf03450fd5d125f72f4c6.1755153054.git.leon@kernel.org>
 <c855a4f9-4a50-4e02-9ac6-372abe7da730@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c855a4f9-4a50-4e02-9ac6-372abe7da730@infradead.org>

On Thu, Aug 14, 2025 at 10:37:22AM -0700, Randy Dunlap wrote:
> Hi Leon,
> 
> On 8/14/25 3:13 AM, Leon Romanovsky wrote:
> > diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> > index 1887d92e8e92..58a1528a9bb9 100644
> > --- a/Documentation/core-api/dma-attributes.rst
> > +++ b/Documentation/core-api/dma-attributes.rst
> > @@ -130,3 +130,21 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
> >  subsystem that the buffer is fully accessible at the elevated privilege
> >  level (and ideally inaccessible or at least read-only at the
> >  lesser-privileged levels).
> > +
> > +DMA_ATTR_MMIO
> > +-------------
> > +
> > +This attribute indicates the physical address is not normal system
> > +memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
> > +functions, it may not be cachable, and access using CPU load/store
> 
> Usually "cacheable" (git grep -w cacheable counts 1042 hits vs.
> 55 hits for "cachable"). And the $internet agrees.
> 
> > +instructions may not be allowed.
> > +
> > +Usually this will be used to describe MMIO addresses, or other non
> 
> non-cacheable
> 
> > +cachable register addresses. When DMA mapping this sort of address we
> 
> > +call the operation Peer to Peer as a one device is DMA'ing to another
> > +device. For PCI devices the p2pdma APIs must be used to determine if
> > +DMA_ATTR_MMIO is appropriate.
> > +
> > +For architectures that require cache flushing for DMA coherence
> > +DMA_ATTR_MMIO will not perform any cache flushing. The address
> > +provided must never be mapped cachable into the CPU.
> again.

Thanks, I will fix.

> 
> thanks.
> -- 
> ~Randy
> 
> 
