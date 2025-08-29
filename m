Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F22C374B;
	Fri, 29 Aug 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470920; cv=none; b=u2qkrKelerWOEr+3/w1QU4toRjAC8mM9oLusU5S9ah8NvNHZrZQ4N+g+M27VVQPfG477ogIBO82FZz75hcYw21JUuBtYk5EYhFM36ELQtA0RDShZ/Bpwt+/Nx+wwo15ZUuKZpBWxpsdH0tbdISFI7Hozd5YweN44p/bfDiXIqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470920; c=relaxed/simple;
	bh=fPmX8Rp8udx+VwVXpgZe9FXorpOePyV4Ef8DrCTRpmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM8AsZgtDIHkmo+3sy5AwQLqaXKvMQy/WnGeJkQ0J8n5+SL7I4q7Pwqtwq0tigwhNtKkhOFdAgAN590iWjq6l9kQ8tD59PkYO0q8jcR8RvkigW4qAnSHslXNeH1UUyHFgJNGqtSqU8qRPpysnsdTVr1IrOyR3v3sOzY8ZY6MaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxl8/qU6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxl8/qU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DF0C4CEF0;
	Fri, 29 Aug 2025 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756470919;
	bh=fPmX8Rp8udx+VwVXpgZe9FXorpOePyV4Ef8DrCTRpmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxl8/qU6Vvz0COFBLrmB8UJZ9govt1w/+9MvHsezQkHTR5DIoYs7xgXKhzSYkVOm1
	 ZyticaiPv1YXSMvOVriZNEtfWFF/4gFAB5LRbmsuDZl1qYUJ6QJjS6y5kT84iXSP4h
	 c3O0x8clzW4t74drhw57szBCRrci0dZsz7TkMKYvpu6q9eSqR6y+QLN+NF1mWqnv0Y
	 TV+utnoubo+22XzKDO5zQdJ90tzO09TUxr04pRitKlRur46am/LMf882y9Fd21W1eK
	 Oe5n+rwQMv7g1wcRBxrA0L1C89sfgumKn452/Ld/OiWS5hXm6vNk/t7OjLj/in2qzE
	 hQrPqQ39Y1fww==
Date: Fri, 29 Aug 2025 06:35:16 -0600
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
Message-ID: <aLGehMVsTEXrP_R5@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
 <20250828165427.GB10073@unreal>
 <aLCOqIaoaKUEOdeh@kbusch-mbp>
 <20250828184115.GE7333@nvidia.com>
 <aLCpqI-VQ7KeB6DL@kbusch-mbp>
 <20250828191820.GH7333@nvidia.com>
 <aLDCC4rXcIKF8sRg@kbusch-mbp>
 <20250828234542.GK7333@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828234542.GK7333@nvidia.com>

On Thu, Aug 28, 2025 at 08:45:42PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 28, 2025 at 02:54:35PM -0600, Keith Busch wrote:
> 
> > In truth though, I hadn't tried p2p metadata before today, and it looks
> > like bio_integrity_map_user() is missing the P2P extraction flags to
> > make that work. Just added this patch below, now I can set p2p or host
> > memory independently for data and integrity payloads:
> 
> I think it is a bit more than that, you have to make sure all the meta
> data is the same, either all p2p or all cpu and then record this
> somehow so the DMA mapping knows what kind it is.

Sure, I can get all that added in for the real patch.
 
> Once that is all done then the above should still be OK, the dma unmap
> of the data can follow Leon's new flag and the dma unmap of the
> integrity can follow however integrity kept track (in the
> bio_integrity_payload perhaps?) ??

We have available bits in the bio_integrity_payload bip_flags, so that
sounds doable. I think we'll need to rearrange some things so we can
reuse the important code for data and metadata mapping/unmapping, but
doesn't look too bad. I'll get started on that.
