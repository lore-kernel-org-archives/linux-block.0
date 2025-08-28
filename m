Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD27265CA8;
	Thu, 28 Aug 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408237; cv=none; b=mmh9V6JlSlJi1aXieXOne1CQ0XvgZMs7Dx5RGiWNMzdRYmamd2DvCi/Rz1PsdVIdAbchFlfmNIZGFpO0dWPgjmRmgg2Dgta9MuEppo+3bGB1e3cv3PRRWSYOzd5eLe9g9xd17GCV47giWPE0/yXuAZWW6ml+cL4QONi8JhPXBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408237; c=relaxed/simple;
	bh=nTTeahhIb0FZNTHkQNMJBnWQfHnp2aJ+r4oH3UJmf9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3bZyEF1JCSvrvS+iHBmIOfk6p6uSQbtcmwHZDC+Dh2SpNPOKKPYv1pBDhYTDTPh4LpEUBFEwfyMvvs/XaY1qkm1+Yq+Gfh9hL6NwAQdwuZFFlW0i9ecc/5um2RK5ynTk6xiDDmhPWT4Yhj3UDepRUeujJ0T3GD0HpzxmMS7ZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiAyKBDP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiAyKBDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBADC4CEEB;
	Thu, 28 Aug 2025 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756408236;
	bh=nTTeahhIb0FZNTHkQNMJBnWQfHnp2aJ+r4oH3UJmf9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiAyKBDPTCAig6cfYhRFzVMlXt8gF/BgqIWlzfngucl4yl5Wcl8PEMxeGxZyn4feY
	 9QNbLauol7wPo69EnbsJUOvYSMo6YfZ3+owIkOs7tkWX5BPwXZEGC9l2iz9VL73nWJ
	 LMeYGO+x9LIMWkAgoCM0LVxjf0/nrBlT574LedC07bLp9s3BQzVau6M5uUSf07U/m8
	 vqELaFQz9N5nFU8S5MsiAq/DKmR1fhhzHyINYKZV0xBuVLm5Y0saWfzSXpuLfpmwbf
	 9eS/h5nEcBCqmS1GS4AcOq4YDto3/XpsP6UcVeqRbKR8yG+flv5A1aPbY1iMmgWmoI
	 HI/G0rHOVaaNA==
Date: Thu, 28 Aug 2025 13:10:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 15/16] block-dma: properly take MMIO path
Message-ID: <aLCpqI-VQ7KeB6DL@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
 <20250828165427.GB10073@unreal>
 <aLCOqIaoaKUEOdeh@kbusch-mbp>
 <20250828184115.GE7333@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828184115.GE7333@nvidia.com>

On Thu, Aug 28, 2025 at 03:41:15PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 28, 2025 at 11:15:20AM -0600, Keith Busch wrote:
> > 
> > I don't think that was ever the case. Metadata is allocated
> > independently of the data payload, usually by the kernel in
> > bio_integrity_prep() just before dispatching the request. The bio may
> > have a p2p data payload, but the integrity metadata is just a kmalloc
> > buf in that path.
> 
> Then you should do two dma mapping operations today, that is how the
> API was built. You shouldn't mix P2P and non P2P within a single
> operation right now..

Data and metadata are mapped as separate operations. They're just
different parts of one blk-mq request.
