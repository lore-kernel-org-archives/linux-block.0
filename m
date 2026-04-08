Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E791C8603
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616664; cv=none; b=NyaBlBe+MGUP04lTKZo+H6ib6obK4Mzv+xK8jkvLXL0BXu1PTTc82dgyQJTMxKysxyppgud86WxBZpc85oR+xhewrpNXdNF1020JIDbS25Hypnk2HslpaQB3yo407A/grlGkeZ7WedgYPiFowbvj98EDDS4QtnnCN48EQR2bN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616664; c=relaxed/simple;
	bh=de//6eLMnTh6mFhZKqOiRm+dG66v4h3yJTGvXs3V9aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnPBRQrptWx7uhCtRzG+fNUl9tsJRSkmWQU0tJynsRg4PB1m89vXijafZR1rEbVeVN6wzz+UDED3fupSHunJm91ToY5BGMBhnCeQYTe/4OnzlmvVldKO04/Se+AaZanQ94xtbRp3QG8KJ48Bb1ut3w4ZcdO8VG0RPP38UnD2pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwFUtb7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwFUtb7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775616662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfx+dKJW9ra19s0QVANTDiYj63NPZ/k2QSsIFjnOMPM=;
	b=iwFUtb7suGkQFjZ3/ielFdNKKzQIfOhPwiKLJKD4R68vvJu1GRKtFfF92vhlKjV60QeMfV
	MFDu3ThuiqLZE7l2XnIBFA9Y3hkq54P3SaStWXtMC83wyp2MGIheWuXGhBNcXRnW7LFL71
	oNC0tWy046O0rkH5Csn/bK1XX1ccD9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-GNP5EGYkO-iuPkuieQYI7w-1; Tue,
 07 Apr 2026 22:51:00 -0400
X-MC-Unique: GNP5EGYkO-iuPkuieQYI7w-1
X-Mimecast-MFC-AGG-ID: GNP5EGYkO-iuPkuieQYI7w_1775616659
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 729CD1956080;
	Wed,  8 Apr 2026 02:50:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEE6D18002A6;
	Wed,  8 Apr 2026 02:50:56 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:50:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 03/10] ublk: enable UBLK_F_SHMEM_ZC feature flag
Message-ID: <adXCiySBAocA7Cpm@fedora>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <20260331153207.3635125-4-ming.lei@redhat.com>
 <CADUfDZrFe2jWV1SpA6opQXB_Zx7COGXEeJAFNRWdMAaaDHomWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrFe2jWV1SpA6opQXB_Zx7COGXEeJAFNRWdMAaaDHomWQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 07, 2026 at 12:47:58PM -0700, Caleb Sander Mateos wrote:
> On Tue, Mar 31, 2026 at 8:32 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add UBLK_F_SHMEM_ZC (1ULL << 19) to the UAPI header and UBLK_F_ALL.
> > Switch ublk_support_shmem_zc() and ublk_dev_support_shmem_zc() from
> > returning false to checking the actual flag, enabling the shared
> > memory zero-copy feature for devices that request it.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  Documentation/block/ublk.rst  | 117 ++++++++++++++++++++++++++++++++++
> >  drivers/block/ublk_drv.c      |   7 +-
> >  include/uapi/linux/ublk_cmd.h |   7 ++
> >  3 files changed, 128 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> > index 6ad28039663d..a818e09a4b66 100644
> > --- a/Documentation/block/ublk.rst
> > +++ b/Documentation/block/ublk.rst
> > @@ -485,6 +485,123 @@ Limitations
> >    in case that too many ublk devices are handled by this single io_ring_ctx
> >    and each one has very large queue depth
> >
> > +Shared Memory Zero Copy (UBLK_F_SHMEM_ZC)
> > +------------------------------------------
> > +
> > +The ``UBLK_F_SHMEM_ZC`` feature provides an alternative zero-copy path
> > +that works by sharing physical memory pages between the client application
> > +and the ublk server. Unlike the io_uring fixed buffer approach above,
> > +shared memory zero copy does not require io_uring buffer registration
> > +per I/O — instead, it relies on the kernel matching page frame numbers
> > +(PFNs) at I/O time. This allows the ublk server to access the shared
> 
> Maybe "physical pages" would be clearer than the kernel-internal
> concept of "page frame numbers"?

OK, but it is one kernel doc, PFN shouldn't be bad.

> 
> > +buffer directly, which is unlikely for the io_uring fixed buffer
> > +approach.
> > +
> > +Motivation
> > +~~~~~~~~~~
> > +
> > +Shared memory zero copy takes a different approach: if the client
> > +application and the ublk server both map the same physical memory, there is
> > +nothing to copy. The kernel detects the shared pages automatically and
> > +tells the server where the data already lives.
> > +
> > +``UBLK_F_SHMEM_ZC`` can be thought of as a supplement for optimized client
> > +applications — when the client is willing to allocate I/O buffers from
> > +shared memory, the entire data path becomes zero-copy without any per-I/O
> > +overhead.
> 
> nit: The shmem buffer lookup still has some overhead. I think just
> "becomes zero-copy" would be fine.

Fine, mapple tree has very small depth, the lookup cost is pretty small.

> 
> > +
> > +Use Cases
> > +~~~~~~~~~
> > +
> > +This feature is useful when the client application can be configured to
> > +use a specific shared memory region for its I/O buffers:
> > +
> > +- **Custom storage clients** that allocate I/O buffers from shared memory
> > +  (memfd, hugetlbfs) and issue direct I/O to the ublk device
> > +- **Database engines** that use pre-allocated buffer pools with O_DIRECT
> > +
> > +How It Works
> > +~~~~~~~~~~~~
> > +
> > +1. The ublk server and client both ``mmap()`` the same file (memfd or
> > +   hugetlbfs) with ``MAP_SHARED``. This gives both processes access to the
> > +   same physical pages.
> > +
> > +2. The ublk server registers its mapping with the kernel::
> > +
> > +     struct ublk_buf_reg buf = { .addr = mmap_va, .len = size };
> > +     ublk_ctrl_cmd(UBLK_U_CMD_REG_BUF, .addr = &buf);
> 
> This doesn't look like valid C syntax. Maybe it could say something like:
> struct ublksrv_ctrl_cmd cmd = {.dev_id = dev_id, .addr = &buf, .len =
> sizeof(buf)};
> io_uring_prep_uring_cmd(sqe, UBLK_U_CMD_REG_BUF, ublk_control_fd);
> memcpy(sqe->cmd, &cmd, sizeof(cmd));

It is pseudocode, looks not a big deal.

> 
> > +
> > +   The kernel pins the pages and builds a PFN lookup tree.
> > +
> > +3. When the client issues direct I/O (``O_DIRECT``) to ``/dev/ublkb*``,
> > +   the kernel checks whether the I/O buffer pages match any registered
> > +   pages by comparing PFNs.
> > +
> > +4. On a match, the kernel sets ``UBLK_IO_F_SHMEM_ZC`` in the I/O
> > +   descriptor and encodes the buffer index and offset in ``addr``::
> > +
> > +     if (iod->op_flags & UBLK_IO_F_SHMEM_ZC) {
> > +         /* Data is already in our shared mapping — zero copy */
> > +         index  = ublk_shmem_zc_index(iod->addr);
> > +         offset = ublk_shmem_zc_offset(iod->addr);
> > +         buf = shmem_table[index].mmap_base + offset;
> > +     }
> > +
> > +5. If pages do not match (e.g., the client used a non-shared buffer),
> > +   the I/O falls back to the normal copy path silently.
> > +
> > +The shared memory can be set up via two methods:
> > +
> > +- **Socket-based**: the client sends a memfd to the ublk server via
> > +  ``SCM_RIGHTS`` on a unix socket. The server mmaps and registers it.
> > +- **Hugetlbfs-based**: both processes ``mmap(MAP_SHARED)`` the same
> > +  hugetlbfs file. No IPC needed — same file gives same physical pages.
> > +
> > +Advantages
> > +~~~~~~~~~~
> > +
> > +- **Simple**: no per-I/O buffer registration or unregistration commands.
> > +  Once the shared buffer is registered, all matching I/O is zero-copy
> > +  automatically.
> > +- **Direct buffer access**: the ublk server can read and write the shared
> > +  buffer directly via its own mmap, without going through io_uring fixed
> > +  buffer operations. This is more friendly for server implementations.
> > +- **Fast**: PFN matching is a single maple tree lookup per bvec. No
> > +  io_uring command round-trips for buffer management.
> > +- **Compatible**: non-matching I/O silently falls back to the copy path.
> > +  The device works normally for any client, with zero-copy as an
> > +  optimization when shared memory is available.
> > +
> > +Limitations
> > +~~~~~~~~~~~
> > +
> > +- **Requires client cooperation**: the client must allocate its I/O
> > +  buffers from the shared memory region. This requires a custom or
> > +  configured client — standard applications using their own buffers
> > +  will not benefit.
> > +- **Direct I/O only**: buffered I/O (without ``O_DIRECT``) goes through
> > +  the page cache, which allocates its own pages. These kernel-allocated
> > +  pages will never match the registered shared buffer. Only ``O_DIRECT``
> > +  puts the client's buffer pages directly into the block I/O.
> 
> One other limitation that might be worth mentioning is that
> scatter/gather I/O can't use the SHMEM_ZC optimization, as the
> request's data must be contiguous in the registered virtual address
> range.

Good catch, will document this limit.

It could be supported in future by introducing bpf, and bpf prog can use its
map(such as arena) to build iov like data to userspace.


Thanks,
Ming

