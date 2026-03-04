Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124B38424C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657919; cv=none; b=MMjMC6HjVsd6wxke+vAyrLtIXKNlyTKHfpvyTlsjvAHsOUUyt8dhXEX5GuiiIuE4zPAL6zNkEMCF/Vrxfw8Ia2GQGF2mxyLcl8MC2S0od7cZPd1AwenjbqZ0SPyYtHezEkIeb50Rbf0WIeN4ZHW3jhGTStUIFUxrKCH7LtEe5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657919; c=relaxed/simple;
	bh=3PGJ6mTIz433tUhRK28gmSwiQ7JacfSBsUPdNY6YnIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDKNWwawo94WtIitlYxmHcz0rLUvMnGycDe3Xb2ywjsu2vMKPmOQb0lIGLsAiOESXA7YlbODxiASkCefQq2Jb06HyqSV5t+v8A6B0CCevvJhbYW83b0aYh/t0JhI3oAnfClaZ0OzJ5iuj9nN6YFlaERS4w2ptSLIYT7xvbwyqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krms9rJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krms9rJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C903C4CEF7;
	Wed,  4 Mar 2026 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772657919;
	bh=3PGJ6mTIz433tUhRK28gmSwiQ7JacfSBsUPdNY6YnIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krms9rJ4UfvdV5jWwqLa4iAMBzBJ4si1e6nroF9mkDJgK+TunioV6//3U3H6AVCt3
	 812upfaD+44wu7x/aCeMxGT5ysZLwX4PoV3XmC47qI7FHoBNcEXzP+pg6nqHtvMM87
	 rRQ2RZGAlPQ9mFQbAJ4WMAzputx657ilWoJYQ1P4uTPg7xqf3ncst592bAbHZLH+SM
	 9OUNG5V5B/HOQ/kuYla2lkIWn+czd9iYWYPRKy5sS5SiEg3So+ac8u1mtwO864aTSb
	 PHy6QAVKPtC9sCO20cdZvEy+xxf81gsS7n88EfJJe+qU6ZxXFYN4FABXug7q9J/egp
	 VKb98lZ1w43LA==
Date: Wed, 4 Mar 2026 10:58:38 -1000
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
Message-ID: <aaic_mAZCuC0wZdX@slm.duckdns.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-4-bvanassche@acm.org>
 <aaiP-EE4M0iywHzc@slm.duckdns.org>
 <dfa02afc-b517-43cf-a136-4c5d464fc457@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa02afc-b517-43cf-a136-4c5d464fc457@acm.org>

On Wed, Mar 04, 2026 at 02:29:06PM -0600, Bart Van Assche wrote:
> On 3/4/26 2:03 PM, Tejun Heo wrote:
> > On Wed, Mar 04, 2026 at 11:48:22AM -0800, Bart Van Assche wrote:
> > > Clang is more strict than sparse with regard to lock context annotation
> > > checking. Hence this patch that makes the lock context annotations
> > > compatible with Clang. __release() annotations have been added below
> > > invocations of indirect calls that unlock a mutex because Clang does not
> > > support annotating function pointers with __releases().
> > > 
> > > Enable context analysis in the block layer Makefile.
> > 
> > Maybe I'm in the minority here but are these annotations actually useful?
> > What do these capture that lockdep can't? Can we just remove these?
> 
> Every Linux kernel release cycle new locking bugs are introduced, often
> in error paths. Clang can detect many of these bugs at compile time.

I mean, yeah, static bug detection is nice but is error-prone manual
annotation the way to do it at this time and age? These annotations have
been around for as long as I can remember and I've never once found them
genuinely useful. Sure, maybe it can flag some latent error path bugs once
in a blue moon but for the most part they're unused and unmaintained
appendages that just add to noise.

Here's a challenge. Can it reliably and in a sustainable manner capture
anything that https://github.com/masoncl/review-prompts can't capture?

Thanks.

-- 
tejun
