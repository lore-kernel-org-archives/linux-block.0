Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AB2ECD01;
	Thu, 11 Sep 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629407; cv=none; b=PNoWpCppkbpDmsYIomnC0Ooo7H+tekXALNQeFvlhj2sfK9VPhUPP0mHOrLVahrQeOQew+mVjIm9by+NDUtH+DE4VY37R8PSA6cu+luF77175HmJ2djaZ6iPbWh5iUlMcPTn+e7LHhom7iDezOVxeUWd3jTGzKrlH6JhNaW6X6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629407; c=relaxed/simple;
	bh=On+cXG/cutfpnJd9WieYdLKcKJAFhg2OkttN+UNQ654=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UaUiZVZdAEq82Oubfzo7q4cgT46yvZdXB506mxtDsyfnVt2drTcMnhZhSDSWBCho9L9RmeLM/icCj0aronWS09fdrAqlqsqsfStkYLZkDvdHBtgw4DfqiQe0DN1q0QYf+e3qtgNTbqJ3e+/3xYnKdhAhZpg6u7S9Mp6pNKA3yNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oYf4Wl/v; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oYf4Wl/v"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250911222322euoutp011634560d57af0d6769ea82508ee6c7b3~kWqER7Qs81513015130euoutp01K;
	Thu, 11 Sep 2025 22:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250911222322euoutp011634560d57af0d6769ea82508ee6c7b3~kWqER7Qs81513015130euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757629402;
	bh=9atdt/om7OmffbDgov9WTxIsiO59X0BmEMtINP1uP9A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oYf4Wl/vK4mtCwLnlaPuk0Vbqm1kIIG4/GofumuhdavmIiBHyUZQRceOU6BgMduk5
	 UPpbMvZbaMJvAX41rCofkjz8fUum8Xd7cFaLczcWfrjE46zM7Gw77+bY+gxYbnaXwW
	 jL8zkycMTQXVpPJyDpmR0+MuvHwC/4FUakNYU3YU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250911222321eucas1p114043a72e011e2fff92df33a2133b21e~kWqDhtt8p0600006000eucas1p18;
	Thu, 11 Sep 2025 22:23:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250911222317eusmtip2aabd06b78078a7146730dff557f2cb71~kWqAG3AB-1019110191eusmtip2F;
	Thu, 11 Sep 2025 22:23:17 +0000 (GMT)
Message-ID: <5ffc63e9-19bd-4e12-92fc-57fe12d10f4f@samsung.com>
Date: Fri, 12 Sep 2025 00:23:17 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 03/16] dma-debug: refactor to use physical addresses
 for page mapping
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Abdiel Janulgue
	<abdiel.janulgue@gmail.com>, Alexander Potapenko <glider@google.com>, Alex
	Gaynor <alex.gaynor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, David
	Hildenbrand <david@redhat.com>, iommu@lists.linux.dev, Jason Wang
	<jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
	<joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross
	<jgross@suse.com>, kasan-dev@googlegroups.com, Keith Busch
	<kbusch@kernel.org>, linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael
	Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Miguel
	Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, Stefano
	Stabellini <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250910052618.GH341237@unreal>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250911222321eucas1p114043a72e011e2fff92df33a2133b21e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250910052628eucas1p160daa0dadb6f81d7831d8047628aa9d4
X-EPHeader: CA
X-CMS-RootMailID: 20250910052628eucas1p160daa0dadb6f81d7831d8047628aa9d4
References: <cover.1757423202.git.leonro@nvidia.com>
	<56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>
	<20250909193748.GG341237@unreal>
	<CGME20250910052628eucas1p160daa0dadb6f81d7831d8047628aa9d4@eucas1p1.samsung.com>
	<20250910052618.GH341237@unreal>

On 10.09.2025 07:26, Leon Romanovsky wrote:
> On Tue, Sep 09, 2025 at 10:37:48PM +0300, Leon Romanovsky wrote:
>> On Tue, Sep 09, 2025 at 04:27:31PM +0300, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>> <...>
>>
>>>   include/linux/page-flags.h         |  1 +
>> <...>
>>
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -614,6 +614,7 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
>>>    * available at this point.
>>>    */
>>>   #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
>>> +#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))
>> This was a not so great idea to add PhysHighMem() because of "else"
>> below which unfolds to maze of macros and automatically generated
>> functions with "static inline int Page##uname ..." signature.
>>
>>>   #define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
>>>   #else
>>>   PAGEFLAG_FALSE(HighMem, highmem)
> After sleeping over it, the following hunk will help:
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index dfbc4ba86bba2..2a1f346178024 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -614,11 +614,11 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
>    * available at this point.
>    */
>   #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
> -#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))
>   #define folio_test_highmem(__f)        is_highmem_idx(folio_zonenum(__f))
>   #else
>   PAGEFLAG_FALSE(HighMem, highmem)
>   #endif
> +#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))
>
>   /* Does kmap_local_folio() only allow access to one page of the folio? */
>   #ifdef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP

Okay, I will add this fixup while applying the patches.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

