Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBC3E075C;
	Tue,  2 Jun 2026 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412710; cv=none; b=qyW37YLtJwun/pu8veSQAV0VglK1v70VRs6IRez0VUP77GTZfehT8PZoNHG+bRNhVQF9Bevk9jiiQ44Yu53gIHytN384yBiP/6bDQD8jZ0k+xkFMI6JdSUOjOx8CPyjTjJrx58t1UASEUgBiK9AN84v0IR1+9zMJ8xGlJop030M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412710; c=relaxed/simple;
	bh=DKoJemVjl8bEGdCqk5pT7C6Kowrn/eXqCAZhd+bX10g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tndXK7/jyBK6iXfBqoW8ySNs7oE7pfR6uTfZGo1K2g3BJoEqIegB2nqsPna+XZv8JgaAdsfA54+uAgJIW9UOfWNFhOZSUw4z19ddigtGnC+m1ojveJB9ZZsDM1EogKeEI1j5CHbaKqVmYMuzkVb1SSZjI14h6Bu+SnxFSO4Wf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C3A9A6732A; Tue,  2 Jun 2026 17:05:04 +0200 (CEST)
Date: Tue, 2 Jun 2026 17:05:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Brendan Gregg <brendan.d.gregg@gmail.com>,
	GOST <gost.dev@samsung.com>
Subject: Re: configurable block error injection
Message-ID: <20260602150503.GA6887@lst.de>
References: <20260602054615.3788425-1-hch@lst.de> <e4c653ec-dfb4-4dce-a565-2a43520fc44f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c653ec-dfb4-4dce-a565-2a43520fc44f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 02, 2026 at 11:58:25AM +0200, Daniel Gomez wrote:
> I wonder if the block layer would be interested in moving block error
> injection off the should_fail() fault injection framework and extending
> the ALLOW_ERROR_INJECTION annotation instead and offloading all the
> debugfs configuration logic (block/error-injection.c) into eBPF?

I've looked into plain ALLOW_ERROR_INJECTION-based injection and it
is not very useful.  I didn't even now eBPF could use it, but I
looked into other eBPF injections and at least for my uses cases
it was a bit of a mess.  I'd have to allow access to certain bio
fields and would have create a stable UAPI for commands and status
using the fake BTF struct access which really would not be a good
idea here as we need to be able to change internals.  Additionally
having fully BTF-enabled toolchains in test VMs is not great either.

I've also not actually found any good map type for range lookups,
which is kinda essential here.

> I talked about moderr [1] at LPC 2025. It's a simple error injection
> tool in eBPF for the module subsystem. The suggested direction there was
> to generalize the tool to ideally to no tool at all, and leverage
> bpftrace to describe the error injection conditions a given
> subsystem needs to be tested under. That would let blktests, for
> example, absorb that and simplify the configuration logic this series
> adds in the kernel for debugfs.

I don't think pulling in ebpftrace for simple error injection is a
winning proposition..

> 
> A previous attempt to add inline error injection [2] was rejected as too
> intrusive / source-polluting;

I'm not sure a single hand waivy comment counts as rejection, although
I'm not a huge fan of setup_fault_attr - it makes a mess of debugfs and
creates a lot of boilerplate for a single not very much configurable call
site.  That might be ok for something like the make_request case
(although I think we can do better as shown in this patch), but for
making random functions fail it is a lot of overhead.  These injections
points also are not anywhere near stable enough to be exposed.

