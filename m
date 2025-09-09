Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E5303A21;
	Tue,  9 Sep 2025 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446673; cv=none; b=QMIENappSzMzwE3tsCbeYlAzwWpGty8pwrW7hR+W/O1/GWNHyrClRtiB5iOYSqNtR5TWHstscdlKj/2hRaUjoCb7PD7pt3zSayKVSfq/RhfcefSSmqZreLjv7GZQ9i31h9s8eMr5pWUJCZqbdZ6kGHUQOAyWch/oIgb87dNUMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446673; c=relaxed/simple;
	bh=Vkfs1C2Q/m2ciXngYEnMywKI/5g7jYuOYmYnMi4Z+6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm4LUgXeKAsTGWx/ZlACaduok0nVUObGFx9OsGPz6taAPydSRUvc4WtNHB+WR2CZEAtihAnoMa8W3oiqdVtvLrPDtqXLI8U553y93eLI+rxkVKWhQlpfVw0KEv0J25lpUWW9/gJfGRmd+nb2hmHabdPbGIP3eIlgGskjtnG3s9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK33sGpV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK33sGpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BB1C4CEF4;
	Tue,  9 Sep 2025 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757446672;
	bh=Vkfs1C2Q/m2ciXngYEnMywKI/5g7jYuOYmYnMi4Z+6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK33sGpV6gJZdNQka35B5igzFncF6O4QoVJduYx5uymEwm19+Pae/Y8Ji2ztm6vFh
	 Of79hrgQzN752E6kK9Pd6CitdpQ05JM71b0yY2nJK5WUadz3JmWI4AqHd+rhRkpPML
	 jPSesTwS7Zw48bKNgh3AxJtfj3r28MMf09jWFv3Lide1Ok8C5lkasp0zoJfr6zuOnF
	 N5cxlSvTSt07fnYvpbKZtFqt6TP2eL80kCSBPIQL9mOveIT/STSyNFrSlP91N6uUF+
	 FdL0uwcDH/ATxbhiykxuiJP1XMjnnp4vhtxpR+0sRrU4PCEIaA22KI5S4HXWZpjWlB
	 smMV1bUYsFvcA==
Date: Tue, 9 Sep 2025 22:37:48 +0300
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
Message-ID: <20250909193748.GG341237@unreal>
References: <cover.1757423202.git.leonro@nvidia.com>
 <56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>

On Tue, Sep 09, 2025 at 04:27:31PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>

<...>

>  include/linux/page-flags.h         |  1 +

<...>

> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -614,6 +614,7 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
>   * available at this point.
>   */
>  #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
> +#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))

This was a not so great idea to add PhysHighMem() because of "else"
below which unfolds to maze of macros and automatically generated
functions with "static inline int Page##uname ..." signature.

>  #define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
>  #else
>  PAGEFLAG_FALSE(HighMem, highmem)

Thanks
