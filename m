Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07495223DDD;
	Thu, 28 Aug 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414482; cv=none; b=o27mp3fSJ7+lhArDJEfixvWqnu9kJ5R28lVrlDvH5JnANODNuOHJ/M8XqMstnx3+u7pZ09TapZXqOdJpdkOR5T+LhptjT0sYmKFj2SghSndic4OvAu3iQRpmXCXvWU9Acc9htSde+FBaZ8KHpptfWaSIYLELYRkPj2lqQwZy7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414482; c=relaxed/simple;
	bh=G+6sPUUIFuKNkRdpDGh7oyzJRLExx6mM3Rr0TsrNav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJW2k16/lx3tF73mcM3NJo3nTqKqXeeoz6Un3pBSVZoeHksTZ5pOD27trkunvUBkmh6qw6Q/bF+ky/y2+I71iVzUPmp3NAov6uJ9KwqqYGjzoInKW/Afx/l0OsyPCJ77N1t+HjnMXmCm9JqIwj7KxhqAFsS7UA3p8s55i2f0I70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCjN9TPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCjN9TPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF632C4CEEB;
	Thu, 28 Aug 2025 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756414481;
	bh=G+6sPUUIFuKNkRdpDGh7oyzJRLExx6mM3Rr0TsrNav4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCjN9TPmsmkv2CErZmw7eY4jhfo/PPQcCij3sdHoAaturic23UjSbV5/eD841QBrO
	 q5lqa5UXldETsQDMVxoOfW90mr401cd2aNU4qwzO6IO/5MHaurrX5r01OojjZShQEf
	 15Kqtld44h3aDOleBeJLOpcwjkQTTYAEhyrx8SC3goTrfnxyjVjHpigzIsE/EQK5r7
	 FqO3qkArHFFA2cKutZwYB5+zz+dbLtckQEfa3MaBKs+Sg/PNA0jXRALMJBXOlqNLWJ
	 BYklmKx3JSZ1NevsWbUBFS2Jp771ITiW6KubcU3EOHWT7p/JyrZiu2Mj04cW80QHY7
	 3fGPgcRndIPdQ==
Date: Thu, 28 Aug 2025 14:54:35 -0600
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
Message-ID: <aLDCC4rXcIKF8sRg@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
 <20250828165427.GB10073@unreal>
 <aLCOqIaoaKUEOdeh@kbusch-mbp>
 <20250828184115.GE7333@nvidia.com>
 <aLCpqI-VQ7KeB6DL@kbusch-mbp>
 <20250828191820.GH7333@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828191820.GH7333@nvidia.com>

On Thu, Aug 28, 2025 at 04:18:20PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 28, 2025 at 01:10:32PM -0600, Keith Busch wrote:
> > 
> > Data and metadata are mapped as separate operations. They're just
> > different parts of one blk-mq request.
> 
> In that case the new bit leon proposes should only be used for the
> unmap of the data pages and the metadata unmap should always be
> unmapped as CPU?

The common path uses host allocated memory to attach integrity metadata,
but that isn't the only path. A user can attach their own metadata with
nvme passthrough or the recent io_uring application metadata, and that
could have been allocated from anywhere.

In truth though, I hadn't tried p2p metadata before today, and it looks
like bio_integrity_map_user() is missing the P2P extraction flags to
make that work. Just added this patch below, now I can set p2p or host
memory independently for data and integrity payloads:

---
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..cf45603e378d5 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -265,6 +265,7 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	unsigned int align = blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages = stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec = stack_vec;
+	iov_iter_extraction_t extraction_flags = 0;
 	size_t offset, bytes = iter->count;
 	unsigned int nr_bvecs;
 	int ret, nr_vecs;
@@ -286,7 +287,12 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	}
 
 	copy = !iov_iter_is_aligned(iter, align, align);
-	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset);
+
+	if (blk_queue_pci_p2pdma(q))
+		extraction_flags |= ITER_ALLOW_P2PDMA;
+
+	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
+					extraction_flags, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
 
--
