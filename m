Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80537F01B
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654586; cv=none; b=Emj0+G1BIJFsgF2mhfnztOeaUap3SNmgAea0o/Qu6nnvq6BBZLT5+bjG/J7kNvpEBDHdfMjAIGiFlHGM8VZcQ6Kl99Bpd+dQ6cBXDQndRd8ErcoGNA6eVTRvR4DEcxNEPZhaKfYee7Ysg9fL+Rb9FZcD7nng/5gUOCeVwX36A64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654586; c=relaxed/simple;
	bh=nA4zOBCWQkC/vTv/BJx3UGuWeQgrnYrttiTfVjudGo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmxlaAURptAeK85DKC7zKridOA3Fe8vP7EcUx1oQ1ysGMhd3GrtooXVUoaM8YOCsbeLp3RQaC8wnd1kJvAaMKm/XZg/AgVirNVD7pZ/SYkbkoUn/MPKobqKWGnT2WcR0DVW+H+SL5FQAWLCPOqCxRUD53QlZCB20SkwoSDqWPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJuVzfHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJuVzfHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F341C4CEF7;
	Wed,  4 Mar 2026 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772654585;
	bh=nA4zOBCWQkC/vTv/BJx3UGuWeQgrnYrttiTfVjudGo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJuVzfHP3jPUYzYqnkusz9d21upFG8/VdWxd+L50WPX2MtJV9phiB/Ulw9bNsbnqn
	 GcSgaxiUYdiiBrL/fOZmRmpKKTUTuJR3TRF2IMhsn1f6yBUpn9uCJTzK1wjL+WhY+V
	 21g21d6u9fLxLGnnlXgYzxAKJbZgLfVZ8zOLZewMlc+znA4bWuyzOJeZX7qYfKOXjH
	 KaNytuBLv+ChMkCBU0OLwT78HTSQ5+ZaM1V6MFGy0jZgzSCHHOotJ5FV1OERqVuPua
	 nWFwX8AbWoKgq7E6rItgxfeZJW3rMYHCmSYtmSJH6Cp3g1jERQu5nPTmL7GLGEa3/1
	 r7o/mxhfIsWSg==
Date: Wed, 4 Mar 2026 10:03:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 03/14] block: Make the lock context annotations
 compatible with Clang
Message-ID: <aaiP-EE4M0iywHzc@slm.duckdns.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304194843.760669-4-bvanassche@acm.org>

On Wed, Mar 04, 2026 at 11:48:22AM -0800, Bart Van Assche wrote:
> Clang is more strict than sparse with regard to lock context annotation
> checking. Hence this patch that makes the lock context annotations
> compatible with Clang. __release() annotations have been added below
> invocations of indirect calls that unlock a mutex because Clang does not
> support annotating function pointers with __releases().
> 
> Enable context analysis in the block layer Makefile.

Maybe I'm in the minority here but are these annotations actually useful?
What do these capture that lockdep can't? Can we just remove these?

Thanks.

-- 
tejun
