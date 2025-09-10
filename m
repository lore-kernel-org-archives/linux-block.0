Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116522BD597;
	Wed, 10 Sep 2025 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481985; cv=none; b=EdzSlKwlzJ4cII89OePdM1PwGHtEk+6eOGtlDQKmOr4OJkKHXuIyOAm9MymoX6k6Xx9HHeQ1L4nhrHzJ//Q8s06OuYqsSTRr38/2b3bGFm++eZ5WqrSyFCOBcI2U165WktcfR+WZ8oewc1JkbZxhGDFutLBdVduC59XpsCa8Vic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481985; c=relaxed/simple;
	bh=bqpgnX0YeaX4gP4gTelyGSzbrLPxwuSSl4ugIJkeFPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0bZuDXiBB3zpTYlTt9cGuC8/jtS0DtM7Av7SJYIuIjzM4EHBmHGS8gtdgPoouGbq6cV5Nv8hPF11UaFGZcv2ZyBVfwFPqVeLbgR7KLMKwNjNaPKzAI9uWxfpU+L8l8zmHRyHKTDaixlZfwysql032l7FHDLsZVZVO/l7ZB6pNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3++ctIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3++ctIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF34CC4CEF0;
	Wed, 10 Sep 2025 05:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757481983;
	bh=bqpgnX0YeaX4gP4gTelyGSzbrLPxwuSSl4ugIJkeFPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3++ctIiiR7UFpzqM9AUidv9AQ1n3Dz1tKeZadPk/293ETffI9nRLBp7aQx9AFled
	 M5GCYM1B4a3jkkhLPVRESnUtwcqokI2ZK9ojJ1YPCMkJpjHT45Cl+QruyYKY3aGARs
	 FpovID2F5xbpoec1xDhgC6MFSHIrXsB7JTzFkx6nfm41N+Pm3w/y/LnuGSrU2VRkhJ
	 x7tt8kh1ACIrOtgalXRNyxNgQvord1Z8/t1JGvHRdIaRHxawPvJnDmdHHJxvC9RDqD
	 RQiYwqXBRXcawbcju2eKP99VtdepUl8ofw/258NbTAl3BVZxhNFXZSkWH5N4CtNQIn
	 DIZ8LyFL6amIQ==
Date: Wed, 10 Sep 2025 08:26:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	David Hildenbrand <david@redhat.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>, kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
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
Subject: Re: [PATCH v6 03/16] dma-debug: refactor to use physical addresses
 for page mapping
Message-ID: <20250910052618.GH341237@unreal>
References: <cover.1757423202.git.leonro@nvidia.com>
 <56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>
 <20250909193748.GG341237@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909193748.GG341237@unreal>

On Tue, Sep 09, 2025 at 10:37:48PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 09, 2025 at 04:27:31PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> 
> <...>
> 
> >  include/linux/page-flags.h         |  1 +
> 
> <...>
> 
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -614,6 +614,7 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
> >   * available at this point.
> >   */
> >  #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
> > +#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))
> 
> This was a not so great idea to add PhysHighMem() because of "else"
> below which unfolds to maze of macros and automatically generated
> functions with "static inline int Page##uname ..." signature.
> 
> >  #define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
> >  #else
> >  PAGEFLAG_FALSE(HighMem, highmem)

After sleeping over it, the following hunk will help:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index dfbc4ba86bba2..2a1f346178024 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -614,11 +614,11 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
  * available at this point.
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
-#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))
 #define folio_test_highmem(__f)        is_highmem_idx(folio_zonenum(__f))
 #else
 PAGEFLAG_FALSE(HighMem, highmem)
 #endif
+#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))

 /* Does kmap_local_folio() only allow access to one page of the folio? */
 #ifdef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP


> 
> Thanks
> 
