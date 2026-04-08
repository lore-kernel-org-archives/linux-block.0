Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9518C933
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617448; cv=none; b=O0TZS4fNwZ9t91RGKuhNBYjrZEPBew7pUtJkLMpLJ16K+EVceJd/NRxI5JRewXU5wpRj+gYLAROi1EnBFe5j3pRXWLpCp48V/SvI4GOjyXkGEabHsODTNVUlXMUajZInP8EoK+0oGuSavjFbgkNDF3g5IepRZw3ehNxTdH+DPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617448; c=relaxed/simple;
	bh=60IPHAMf37o4fDEXfENxitomoaA19qF8HOrGyeh20o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oni6MQNPStT55X1NH81AR98yhvDoNauBwCEbSwG3+5Avdn8HqT5eGOeSg5f7+RuH2IoOw3PMhYsaCpZeJv9hEyCX58/36krOYfzEyzop+EBuM2vOzBk5JnlU8rBZ9MwNjzsCaSbAJLJ9TKOU82ppH+pGjaPMOWhiK/sx8Ruxl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDfP7UHB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDfP7UHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775617446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+GTBeTINRK0yggK7J4ebQHOU3Ko6csPMHhu3mAv35E=;
	b=TDfP7UHBaThnNV/+ck0r+CssuVLzJ/rUh+rQRqLmiFtITIfcpjU8duYrXTTRObwKMhTmeG
	WhHbQLfQ1cReojFu27LTxxPLe8tVxctYsXaQmKk1YzBPqEqkdsuPeJFGPwAmfeXs7+2mpN
	DuQid0GRT8PlFEI4B4OHYjb6fxbZQqA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-TFr2aEIaMF29egXBlfoMLw-1; Tue,
 07 Apr 2026 23:04:04 -0400
X-MC-Unique: TFr2aEIaMF29egXBlfoMLw-1
X-Mimecast-MFC-AGG-ID: TFr2aEIaMF29egXBlfoMLw_1775617443
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B4FA1956056;
	Wed,  8 Apr 2026 03:04:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8160C18002A6;
	Wed,  8 Apr 2026 03:04:00 +0000 (UTC)
Date: Wed, 8 Apr 2026 11:03:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
Message-ID: <adXFm1dlDzcikarF@fedora>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <adRuN7V2KDbTJLqd@fedora>
 <CADUfDZoGGUcZ1_ifsXrh_8uy-7DVH30xrbaA+sH8ftwYxB-0Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoGGUcZ1_ifsXrh_8uy-7DVH30xrbaA+sH8ftwYxB-0Hw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 07, 2026 at 12:29:39PM -0700, Caleb Sander Mateos wrote:
> On Mon, Apr 6, 2026 at 7:39 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Mar 31, 2026 at 11:31:51PM +0800, Ming Lei wrote:
> > > Hello,
> > >
> > > Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
> > >
> > > The ublk server and its client share a memory region (e.g. memfd or
> > > hugetlbfs file) via MAP_SHARED mmap. The server registers this region
> > > with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
> > > builds a PFN maple tree. When I/O arrives, the driver looks up bio
> > > pages in the maple tree — if they match registered buffer pages, the
> > > data is used directly without copying.
> > >
> > > Please see details on document added in patch 3.
> > >
> > > Patches 1-4 implement the kernel side:
> > >  - buffer register/unregister control commands with PFN coalescing,
> > >    including read-only buffer support (UBLK_SHMEM_BUF_READ_ONLY)
> > >  - PFN-based matching in the I/O path, with enforcement that read-only
> > >    buffers reject non-WRITE requests
> > >  - UBLK_F_SHMEM_ZC feature flag
> > >  - eliminate permanent pages[] array from struct ublk_buf; the maple
> > >    tree already stores PFN ranges, so pages[] becomes temporary
> > >
> > > Patches 5-10 add kublk (selftest server) support and tests:
> > >  - hugetlbfs buffer sharing (both kublk and fio mmap the same file)
> > >  - null target and loop target tests with fio verify
> > >  - filesystem-level test (ext4 on ublk, fio verify on a file)
> > >  - read-only buffer registration test (--rdonly_shmem_buf)
> > >
> > > Changes since V1:
> > >  - rename struct ublk_buf_reg to struct ublk_shmem_buf_reg, add __u32
> > >    flags field for extensibility, narrow __u64 len to __u32 (max 4GB
> > >    per UBLK_SHMEM_ZC_OFF_MASK), remove __u32 reserved (patch 1)
> > >  - add UBLK_SHMEM_BUF_READ_ONLY flag: pin pages without FOLL_WRITE,
> > >    enabling registration of write-sealed memfd buffers (patch 1)
> > >  - use backward-compatible struct reading: memset zero + copy
> > >    min(header->len, sizeof(struct)) (patch 1)
> > >  - reorder struct ublk_buf_range fields for better packing (16 bytes
> > >    vs 24 bytes), change buf_index to unsigned short, add unsigned short
> > >    flags to store per-range read-only state (patch 1)
> > >  - enforce read-only buffer semantics in ublk_try_buf_match(): reject
> > >    non-WRITE requests on read-only buffers since READ I/O needs to
> > >    write data into the buffer (patch 2)
> > >  - narrow struct ublk_buf::nr_pages to unsigned int, narrow struct
> > >    ublk_buf_range::base_offset to unsigned int (patch 1)
> > >  - add new patch 4: eliminate permanent pages[] array from struct
> > >    ublk_buf — recover struct page pointers via pfn_to_page() from the
> > >    maple tree during unregistration, saving 2MB per 1GB buffer
> > >  - add UBLK_F_SHMEM_ZC to feat_map in kublk (patch 5)
> > >  - add new patch 10: read-only buffer registration selftest with
> > >    --rdonly_shmem_buf option on null target + hugetlbfs
> >
> > Hello,
> >
> > Ping...
> 
> Sorry I didn't get a chance to look at this earlier. It looks really
> nice, thank you for implementing it! I have just a few comments. One
> is about the UAPI (can we just use virtual addresses instead of buffer
> index + offset), so I might wait on landing this patchset until we've
> finalized that.

Hi Jens,

Can you drop V2 from for-7.1/block so that we can polish up it in V3?

Or I am fine to cook up a followup for misc clean & fix?

Thanks,
Ming

