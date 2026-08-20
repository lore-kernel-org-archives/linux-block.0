Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44D1E505
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787188683; cv=none; b=A7oz6W5bs1zgqHZugEX/k1RnQwhBEHAedwuHrGkLtEJHOHIEKM1jiZ5uGfQYsPguv62I2YRSe7ig+N5bwviDgFdQ2nfZzqGX+5aTTsoYMT5PYtQDSx9sShJTJThkug3tLwjBHZHh0/8MciYsNoT7r9xp2W3YaFnOvvoZjamF5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787188683; c=relaxed/simple;
	bh=dXq2xBkqVKBekkyqcMRUHObpVa3If7BeltOQlMGR1XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf1QJ3xIu4kQurAtDiAARAJmaqy/z9vbYRUzTaCU3cUBsYSyqmBykjd1IfgJSVpfDJyrs/KDdqEsydOvz8LvEyhxatoPk0Z1PrEs+H3v24IZINVzRSbgLaI0lr+oNC7lGa71h8QU4CM4JS1TocNMxvqsSRaJQjRyhrHYMXRmZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jin87R6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jin87R6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76A11F000E9;
	Thu, 20 Aug 2026 01:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787188681;
	bh=RRMWsnOrJjYOHpQzC1lW+00Ol6b7hLzSQFlXR5a+i10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jin87R6HPTRUYO5aWXhLJDrEooVvLgGiUL0+J+6fuSGQUzRsJVDm6uRG6QGYEkyIN
	 mouMT9htX4FfFXOXmYjmdUr5oDvS+WufSq2zlGBTR4HWCfM26hKbzA7nDSptDrtELn
	 oFPwH+26Yef6kIUl62yHtzm0O9LZB4tvA1oo7sWucaSUBcwjxRfr354j/dhRCWmF76
	 lZLI+ZYVnVa26+kp2+wGgY6uLuedVSE0uqxwUM/IbY3RJ9eZcC70KPeSKAyoJ8j9qj
	 XnF1Ny678dKZcF9tlwYuzbMikFtuPmfwukeKB1EF1LJKihtdWCm9JRc5BHXoqCL7rL
	 VFIQPJscsGVrw==
Date: Wed, 19 Aug 2026 21:18:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block updates for 7.3
Message-ID: <aoZVyFXG3eXU5vl7@kernel.org>
References: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>
 <aoZTuDIVkY-qCE5p@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoZTuDIVkY-qCE5p@kernel.org>

On Wed, Aug 19, 2026 at 09:09:12PM -0400, Mike Snitzer wrote:
> On Wed, Aug 19, 2026 at 02:30:37PM -0600, Jens Axboe wrote:
> > Hi Linus,
> > 
> > The bulk of this is NVMe and MD, both via merges, but the core block
> > changes are the more interesting part. In detail:
> > 
> > - NVMe updates via Keith:
> >        - Enable Clang context analysis for the nvme host driver, adding
> >          context annotations across core, fabrics, rdma, tcp and pci
> >        - nvmet reservation state exposed through a new namespace-level
> >          debugfs directory, plus ABI documentation for the host sysfs
> >          and target configfs interfaces
> >        - nvme-tcp host memory disclosure fixes on the read path: reject a
> >          read that transferred too few bytes, don't accept C2HData based
> >          on blk_rq_payload_bytes() alone, and fix the R2T case for a read
> >          command
> >        - Parallelize nvme-rdma I/O queue allocation and startup (Surabhi)
> >        - Apple nvme fixes and quirks: page aligned admin queue buffers,
> >          destroy the admin queue on removal, and various DMA/NVMMU
> >          correctness fixes
> >        - A large pile of nvmet and host fixes for out-of-bounds reads,
> >          refcount/resource leaks, and NULL derefs across auth, zns,
> >          passthru, pci-epf, rdma and configfs
> >        - Various other fixes and cleanups
> > 
> > - MD updates via Yu Kuai:
> >        - llbitmap reshape support, the large series wiring exact bitmap
> >          mapping and reshape lifecycle through raid5 and raid10, growing
> >          the page cache in place, and remapping checkpointed bits as
> >          reshape progresses
> >        - raid5 fixes for lockless max_nr_stripes and recovery_offset
> >          accesses, a reshape deadlock with more failed devices than max
> >          degraded, and bitmap batch counter consistency
> >        - Atomic write handling for raid1/raid10, and removal of the
> >          REQ_NOWAIT support from raid1/10/456
> >        - raid5-ppl use-after-free fix in ppl_do_flush()
> >        - A batch of smaller fixes across md core and the bitmap code
> > 
> > - s390/dasd ESE full-track write support and the surrounding
> >   infrastructure, plus enabling CONTEXT_ANALYSIS for s390/block
> > 
> > - RWF_DONTCACHE support for block devices, built on new task-context
> >   bio completion infrastructure, and wiring it up for the iomap and
> >   buffer dropbehind writeback paths
> > 
> > - Async io_uring zone reset all, plus zone management command cleanups
> >   allowing REQ_NOWAIT and tightening conventional zone rejection
> > 
> > - Block integrity refactoring: lift BIP_CHECK_FLAGS to the shared
> >   header, handle nogenerate/noverify properly in fs-integrity, and
> >   drop the blk-integrity.h include from bdev.c
> > 
> > - Split out a new blk_plug.h header
> > 
> > - ublk improvements: add UBLK_F_IO_DESC_SIZE, split request validation
> >   from io_desc init, reject non-power-of-2 zone sizes in SET_PARAMS,
> >   and a series of hardening fixes around map/unmap and auto buf reg
> > 
> > - null_blk cleanups and configfs serialization fixes
> > 
> > - nbd queue freeze removal on the setup paths, and a new
> >   pre_defined_connections module parameter for pre-created devices
> > 
> > - blk-cgroup fixes for the race between policy activation and blkg
> >   destruction, and accounting per-cpu stats over possible CPUs across
> >   blk-stat, iolatency, iocost and kyber
> > 
> > - Various dio fixes: leak on metadata mapping error, validate user
> >   space vectors during extraction, and set dma_alignment from the
> >   backing file for loop and zloop direct I/O
> 
> Hey Jens,
> 
> I just encountered this today, so figured I'd share: I think there is
> a post-merge fixup needed once Linus were to merge your block changes,
> due to vfs iomap changes from vfs-7.3-rc1.iomap (which Linus already
> merged).
> 
> Specifically commit 36f199c8d0ee4 ("iomap: add simple dio path for
> small direct I/O") added a new caller for bio_iov_iter_get_pages and
> Keith's commit 14b007e178811 ("block: validate user space vectors
> during extraction") added a new argument to bio_iov_iter_get_pages.

Linus, Jens did already mention this conflict in his PR -- as coming
from XFS tree.

I knew it to have originated from vfs-7.3-rc1.iomap (so I didn't
notice I was raising the very same thing Jens had already pointed
out). Sorry for the noise.

Mike
