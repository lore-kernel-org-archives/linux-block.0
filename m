Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511DCA6B
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787188154; cv=none; b=VAARYxtK5b2AVPsscFDOtYQVnAbBWdG0RQKVXrguEtnbaeOWYKjKroTGuWHPr0oap9UedewFwtmRmNKeza9p0aUISL4Eex2zR9CKcawNgTH4Kpf2xkp70rV3BpgLmWetkZZFsgAh7KgeRh+ODtocIzM6xOL1WLnoZ1FTDCu/Sh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787188154; c=relaxed/simple;
	bh=H9Dw27MoJUOXtKhToUDXu4yxZ8/SwzD/kZPyQC6UXq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpd+cdhctVWdjfBCQAmktv2dFbP9mnxS7IQe8dyPtSLpngOPyC1VMPbaVyhF3R2876NHaGq4R2Wf6S6f9ox+resR0rEjofiz7pEdEim3g5nDm4c86t7yb9ifkFbb7By9SJWQqrWS4mtVUTMDCYXZ4cIEsPDDkVMNdxcu9ZMaE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbc2j+0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbc2j+0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A3C1F000E9;
	Thu, 20 Aug 2026 01:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787188153;
	bh=MrNDTOGNGZZIPMFkB7HdjVIz/nvAF3TkAeN5zA8lkfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wbc2j+0eXbXatWLVo6gqXOVtEFSkhnUKupYmXlCaHj2oy6sBo/kwtQV2eGobBc9Oe
	 3LYFzTevP595pDYb5+lNRkDdoeY/LdXtjNtuxf0MKLQNnDCOkOQJX/Jg9Lf8uPJCEz
	 +Q/CNSu1WgG7qjDEE8EyYg0fcqkZCFktup1/F8xyarZCR8LDSVZG3IFwspCwLW3vEg
	 Pv3gTyDX2YzNBoHf/YgSKhvjs9WXES03JQpYKttJ+tnNh1vRDmdPdZjOjsja5ydsjI
	 ZS7K2c3Q6xShISoGMZFuBbG/+7N0ScsLa+S4JirFT2lInyJFLu4MqFhjBW7m8g9GdZ
	 M1ec2eTQpqwbQ==
Date: Wed, 19 Aug 2026 21:09:12 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block updates for 7.3
Message-ID: <aoZTuDIVkY-qCE5p@kernel.org>
References: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>

On Wed, Aug 19, 2026 at 02:30:37PM -0600, Jens Axboe wrote:
> Hi Linus,
> 
> The bulk of this is NVMe and MD, both via merges, but the core block
> changes are the more interesting part. In detail:
> 
> - NVMe updates via Keith:
>        - Enable Clang context analysis for the nvme host driver, adding
>          context annotations across core, fabrics, rdma, tcp and pci
>        - nvmet reservation state exposed through a new namespace-level
>          debugfs directory, plus ABI documentation for the host sysfs
>          and target configfs interfaces
>        - nvme-tcp host memory disclosure fixes on the read path: reject a
>          read that transferred too few bytes, don't accept C2HData based
>          on blk_rq_payload_bytes() alone, and fix the R2T case for a read
>          command
>        - Parallelize nvme-rdma I/O queue allocation and startup (Surabhi)
>        - Apple nvme fixes and quirks: page aligned admin queue buffers,
>          destroy the admin queue on removal, and various DMA/NVMMU
>          correctness fixes
>        - A large pile of nvmet and host fixes for out-of-bounds reads,
>          refcount/resource leaks, and NULL derefs across auth, zns,
>          passthru, pci-epf, rdma and configfs
>        - Various other fixes and cleanups
> 
> - MD updates via Yu Kuai:
>        - llbitmap reshape support, the large series wiring exact bitmap
>          mapping and reshape lifecycle through raid5 and raid10, growing
>          the page cache in place, and remapping checkpointed bits as
>          reshape progresses
>        - raid5 fixes for lockless max_nr_stripes and recovery_offset
>          accesses, a reshape deadlock with more failed devices than max
>          degraded, and bitmap batch counter consistency
>        - Atomic write handling for raid1/raid10, and removal of the
>          REQ_NOWAIT support from raid1/10/456
>        - raid5-ppl use-after-free fix in ppl_do_flush()
>        - A batch of smaller fixes across md core and the bitmap code
> 
> - s390/dasd ESE full-track write support and the surrounding
>   infrastructure, plus enabling CONTEXT_ANALYSIS for s390/block
> 
> - RWF_DONTCACHE support for block devices, built on new task-context
>   bio completion infrastructure, and wiring it up for the iomap and
>   buffer dropbehind writeback paths
> 
> - Async io_uring zone reset all, plus zone management command cleanups
>   allowing REQ_NOWAIT and tightening conventional zone rejection
> 
> - Block integrity refactoring: lift BIP_CHECK_FLAGS to the shared
>   header, handle nogenerate/noverify properly in fs-integrity, and
>   drop the blk-integrity.h include from bdev.c
> 
> - Split out a new blk_plug.h header
> 
> - ublk improvements: add UBLK_F_IO_DESC_SIZE, split request validation
>   from io_desc init, reject non-power-of-2 zone sizes in SET_PARAMS,
>   and a series of hardening fixes around map/unmap and auto buf reg
> 
> - null_blk cleanups and configfs serialization fixes
> 
> - nbd queue freeze removal on the setup paths, and a new
>   pre_defined_connections module parameter for pre-created devices
> 
> - blk-cgroup fixes for the race between policy activation and blkg
>   destruction, and accounting per-cpu stats over possible CPUs across
>   blk-stat, iolatency, iocost and kyber
> 
> - Various dio fixes: leak on metadata mapping error, validate user
>   space vectors during extraction, and set dma_alignment from the
>   backing file for loop and zloop direct I/O

Hey Jens,

I just encountered this today, so figured I'd share: I think there is
a post-merge fixup needed once Linus were to merge your block changes,
due to vfs iomap changes from vfs-7.3-rc1.iomap (which Linus already
merged).

Specifically commit 36f199c8d0ee4 ("iomap: add simple dio path for
small direct I/O") added a new caller for bio_iov_iter_get_pages and
Keith's commit 14b007e178811 ("block: validate user space vectors
during extraction") added a new argument to bio_iov_iter_get_pages.

Mike
