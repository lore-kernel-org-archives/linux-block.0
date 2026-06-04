Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E525487C;
	Thu,  4 Jun 2026 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571179; cv=none; b=W0C2D6FC8FzoAYE1rSb8QsstXrjRJ3tpALoGQCx7NhZ+GtOPbEqLveCtA9ar/Nx5mTmKZ3Phf0iT3a0AkFrI/5Tje9nqBzMh7lWP6CLYmwjHXyV2r93lfd2I4SWnJeOPVA/tXFx80Wf0iuzpq6QghGrEcW+HZFCqXQJ7DhqaKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571179; c=relaxed/simple;
	bh=dH+wiHkP8iEzh5gjrFU7ky8o47LBkOK8WqG8Ty8gAms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpgxSahhTfrtzZSc+kvAuV70v1LFfhI+Lmsr6e1aPrZy0GpwRkCJSzxWrHVBgIsuDeGL89AgTGU71qPUEIDWuPqs6EJuISjG/YsfrGmhhZbHtrnt3+N/RKoJZ9FPFBaEYBPFqFZuLOExCAPa3Z3CX/ZDx6E3JFEbwbsWjb9sM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej8KZlE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej8KZlE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161461F00893;
	Thu,  4 Jun 2026 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780571178;
	bh=79aCtUFvNEq/48Dn+njy/SJ3Q9e631A8d0gXU4oyCMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ej8KZlE7ixNLHhWexR/7SMz1WYRbidIsd/ciNFKyVssHeMx1PvCR6YtbOf3ojXq61
	 G6cqaJK4TdCE2st/1CInbVwy+xANj09bCZ5Zd3xaSBUmS9/FiH/CrgE0+LBbk1t50w
	 B++d1O8j+hpsqCj04LEeRwITFMuyv9hKqai/CiDFDy29lXSK+5NIs+pMNm15KIkSaZ
	 PPbtw7AIvHPoxyJd73isoN9LwjzhBBpaCwZ2QGdFyy8DPEP6xXua5c4kpKCh25cTkJ
	 KwvBbfcQyYqROPZcPaae61Wgs7UdsFL2nalr4kKMWNUAXM/8ObwIdM06aBoya4WM/7
	 jMIyWP5kAe22A==
Message-ID: <d9a5b911-7692-4df2-b67c-c33bc80b61aa@kernel.org>
Date: Thu, 4 Jun 2026 13:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: configurable block error injection
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Brendan Gregg <brendan.d.gregg@gmail.com>, GOST <gost.dev@samsung.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260602054615.3788425-1-hch@lst.de>
 <e4c653ec-dfb4-4dce-a565-2a43520fc44f@kernel.org>
 <20260602150503.GA6887@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
In-Reply-To: <20260602150503.GA6887@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2026 17.05, Christoph Hellwig wrote:
> On Tue, Jun 02, 2026 at 11:58:25AM +0200, Daniel Gomez wrote:
>> I wonder if the block layer would be interested in moving block error
>> injection off the should_fail() fault injection framework and extending
>> the ALLOW_ERROR_INJECTION annotation instead and offloading all the
>> debugfs configuration logic (block/error-injection.c) into eBPF?
> 
> I've looked into plain ALLOW_ERROR_INJECTION-based injection and it
> is not very useful.  I didn't even now eBPF could use it, 

For context: Josef Bacik introduced it first for BPF only
(BPF_ALLOW_ERROR_INJECTION). Masami Hiramatsu then generalized it into
the error injection framework, renaming it to ALLOW_ERROR_INJECTION
and adding the fail_function debugfs interface (which calls
should_fail()). So annotating a function with ALLOW_ERROR_INJECTION
gives you both backends at once: debugfs (fail_function) and eBPF
(bpf_override_return()).

> but I
> looked into other eBPF injections and at least for my uses cases
> it was a bit of a mess.  

Agreed, and I had not looked closely enough at the series
before proposing the wrong primitives. ALLOW_ERROR_INJECTION /
bpf_override_return() are not sufficient here: bpf_override_return()
cannot set bio->bi_status or call bio_endio(), which I think is the
key operation here.

IIU the series correctly, and oversimplifying: when
injection is enabled and a bio matches, the block layer completes the
bio inline with the chosen blk_status_t (the status= rule from debugfs)
via bio_endio_status(). The submission path returns to the caller
immediately, with the bio already in the error state. Nothing is ever
sent to the device, but the completion path sees the injected error.

submit_bio() -> submit_bio_noacct() -> submit_bio_noacct_nocheck()
      +-- Path 1: no match -> continue normal IO submission
      +-- Path 2: match (diskN) -> blk_error_inject()
                     -> bio_endio_status(bio, inj->status)
                          -> bio_endio()
                     // error injected. bio completed

So this is bio mutating + a bio_endio() call, not a return override.
That can't be solved with ALLOW_ERROR_INJECTION. But we can use
BPF_PROG_TYPE_STRUCT_OPS instead: the kernel keeps ownership of the
bio_endio_status() call, and the eBPF program only drives the policy,
ie. which blk_status_t to return for a given bio, based on whatever 
heuristics it implements.

> I'd have to allow access to certain bio

With struct_ops the bio is passed to the ebpf side as read-only, bio 
fields can be read to decide the policy but cannot write them. Is 
read-only access to bio fields itself a concern?

> fields and would have create a stable UAPI for commands and status
> using the fake BTF struct access which really would not be a good
> idea here as we need to be able to change internals.  

That should not be a problem at all. With CO-RE (compile once, run
everywhere) the program resolves the bio field offsets against the
BTF of the kernel it loads on, so it adapts dynamically if the layout
changes. The contract is just the struct_ops callback signature: a
struct bio * argument and a blk_status_t return. And that doesn't imply
any UAPI commitment AFAIK.

> Additionally
> having fully BTF-enabled toolchains in test VMs is not great either.

Are you referring to the old BCC toolchain requirements [1]? This is
solved in CO-RE [2]. The toolchain (Clang/LLVM, pahole) stays on the
build host; the test VM only needs the prebuilt BPF object, libbpf at
runtime, and the kernel's own BTF (CONFIG_DEBUG_INFO_BTF). No compiler
or BTF toolchain is required inside the VM. Clang/LLVM 10+ is enough to
build CO-RE libbpf tools [3].

Link: https://ebpf.io/what-is-ebpf/#how-are-ebpf-programs-written [1]
Link: https://nakryiko.com/posts/bpf-portability-and-co-re/ [2]
Link: https://github.com/libbpf/libbpf#bpf-co-re-compile-once--run-everywhere [1]

> 
> I've also not actually found any good map type for range lookups,
> which is kinda essential here.

Are you referring to the bio sector range comparison in
__blk_error_inject()? I don't think that needs to be delegated to a
BPF map (Documentation/bpf/maps.rst). The ebpf side has direct access
to the bio fields, so it can apply the same sector/op filtering
__blk_error_inject() does today. That match is already a linear list
walk, so the ebpf program just runs the same [start, end] condition
check.

In summary: what do you think of evolving this series
into eBPF, but BPF_PROG_TYPE_STRUCT_OPS instead of
ALLOW_ERROR_INJECTION/bpf_override_return()?. The configurable debugfs
injection is a nice enhancement over what we had, but the matching is
static (op/start/nr_sectors/status/chance) per gendisk. A struct_ops
hook would expand the failure model to anything derivable from the bio
(plus any state the program keeps), with the kernel still owning the
bio_endio_status() mutation and only the policy moving out of the tree.
The benefit is the flexibility to express the policy without hard-coding
the model in the kernel.

The open question is whether programmable injection is something we want
to support in-tree, or whether more debugfs knobs suffice. Thoughts?
