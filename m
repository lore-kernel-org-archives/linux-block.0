Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0CF47A0D8;
	Fri,  5 Jun 2026 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644224; cv=none; b=HqjIoRYzTvDm847PLj/oOchW2qE6+ucbzHJL8g+UQuS+MTOTv3oorP26KIO8VFQceY05aoisNgWXA+UfTqVXW5MkBESkItKwCa2fMhjSsMhZoV+T/TxIDr1eUGS5ljWSFuuhSmkZJdj87nFmIMBHiGPJIa9rVpwN0/thEcwf34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644224; c=relaxed/simple;
	bh=SzEPry+LtRQK9RnenP8PEmy3kLGCRANJ0Qf7LtUgfik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJe43DpZqLpp6ZbUKhfu9cYdmdYHSXrb/ceA3AvhLExRL/8afH/ygE2MamhKxVkCaULWHW17xPdH61RPQstsGvp7YepbpTt9v6py/fVmCerqmrpHEmicn9SvJT5+/pP3sQ5W5IQlTAHuyZCyuz6NnAv2HFNw6zYZ8e48mRGuD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BDEE6732A; Fri,  5 Jun 2026 09:23:39 +0200 (CEST)
Date: Fri, 5 Jun 2026 09:23:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Brendan Gregg <brendan.d.gregg@gmail.com>,
	GOST <gost.dev@samsung.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: configurable block error injection
Message-ID: <20260605072338.GA26929@lst.de>
References: <20260602054615.3788425-1-hch@lst.de> <e4c653ec-dfb4-4dce-a565-2a43520fc44f@kernel.org> <20260602150503.GA6887@lst.de> <d9a5b911-7692-4df2-b67c-c33bc80b61aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a5b911-7692-4df2-b67c-c33bc80b61aa@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 04, 2026 at 01:06:13PM +0200, Daniel Gomez wrote:
> IIU the series correctly, and oversimplifying: when
> injection is enabled and a bio matches, the block layer completes the
> bio inline with the chosen blk_status_t (the status= rule from debugfs)
> via bio_endio_status(). The submission path returns to the caller
> immediately, with the bio already in the error state. Nothing is ever
> sent to the device, but the completion path sees the injected error.

Yes.

> > I'd have to allow access to certain bio
> 
> With struct_ops the bio is passed to the ebpf side as read-only, bio 
> fields can be read to decide the policy but cannot write them. Is 
> read-only access to bio fields itself a concern?

Yes, for the reason state below.

> 
> > fields and would have create a stable UAPI for commands and status
> > using the fake BTF struct access which really would not be a good
> > idea here as we need to be able to change internals.  
> 
> That should not be a problem at all. With CO-RE (compile once, run
> everywhere) the program resolves the bio field offsets against the
> BTF of the kernel it loads on, so it adapts dynamically if the layout
> changes. The contract is just the struct_ops callback signature: a
> struct bio * argument and a blk_status_t return. And that doesn't imply
> any UAPI commitment AFAIK.

That assumes the fields even exists in this form.  And we definitively
need to do things about the iter going ahead.  In other words we have
to build up a huge abstraction here first.

> > Additionally
> > having fully BTF-enabled toolchains in test VMs is not great either.
> 
> Are you referring to the old BCC toolchain requirements [1]? This is
> solved in CO-RE [2]. The toolchain (Clang/LLVM, pahole) stays on the
> build host; the test VM only needs the prebuilt BPF object, libbpf at
> runtime, and the kernel's own BTF (CONFIG_DEBUG_INFO_BTF). No compiler
> or BTF toolchain is required inside the VM. Clang/LLVM 10+ is enough to
> build CO-RE libbpf tools [3].

libbpf and BTF support is what I mean.  And of course whatever code
you write to communicate with it as a simple shell script won't work
any more.

> Are you referring to the bio sector range comparison in
> __blk_error_inject()?

Yes.

> I don't think that needs to be delegated to a
> BPF map (Documentation/bpf/maps.rst). The ebpf side has direct access
> to the bio fields, so it can apply the same sector/op filtering
> __blk_error_inject() does today. That match is already a linear list
> walk, so the ebpf program just runs the same [start, end] condition
> check.

Which means I need to write eBPF code for every specific range I
want to inject, which makes the thing very hard to use.

> In summary: what do you think of evolving this series
> into eBPF, but BPF_PROG_TYPE_STRUCT_OPS instead of
> ALLOW_ERROR_INJECTION/bpf_override_return()?.

As said before, I prototyped it and it was a mess.  Having about 300
lines of simple code that can be directly used from a shell script
seems much preferable.

