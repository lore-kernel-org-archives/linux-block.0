Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400927A133
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679379; cv=none; b=u6Js2c+Bb7yh8ZspiJOyMZfp26eO7VwzvfKb2n3CrX/RWhD2CT+YWBJXhrLSPlRgUw7C7UF17+DNnJIO51rOPDsDSCCF8yl99XhBVkhOyQ2CMVHMVTO/q5NgNa5BfawqwJl3TN577enON4PNceZ5CzWSjbobhpzTG5UAFXZr57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679379; c=relaxed/simple;
	bh=h3bHYFpZNSoKlheI1So5je9Dk7njiTwF66sAmMSAxJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCa51yUHrBscfUdFtBx8Am9aA2dNI/eod81m5PJXnJMpXuXe9Uoz2FjhYvqD9ERVQWO+KP9Yo6Mpw5o6aotmSPE+ETA2RoM4LkWEEv0n4XDBWDZ3P4y4QXzTYlKmLy+8GX109nwp9IXkyL2TsfjCe9AP2sTMwxru/Wlz1HherhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmU8nmc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmU8nmc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30B5C2BCB7;
	Wed, 13 May 2026 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679379;
	bh=h3bHYFpZNSoKlheI1So5je9Dk7njiTwF66sAmMSAxJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmU8nmc0cO1TS+iZt6BNCEKlJRkYG+iSazhdneQIWVaG4DCr0yCvyuQoTXh5uMHOc
	 jCYrFAY6urDxOWzKfolfYzc3OyifdSPki/eN+GrNNr3/b/mbQBLwFT60vYYpnbmaJG
	 jHn2p3CgJRG4nA+lFxx7Wt67XUu/W++p70+AmNVzIgIzMS61pItbCJfM3SjhZCo9Fk
	 3U2QukofKIMGca9a8qOd2RK28bQtJngyBXDePLVuTPRBRBd+dFkbQib5LbVLwee5mR
	 jk727IeOD2/6tKxgsFMZ/pR+1qvjNkmbJTmmuaOHdBY/idXbQ2C+qi6tzwZs2Ftg9y
	 U6/T6rWJoEWNQ==
Date: Wed, 13 May 2026 22:36:14 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops
 callback functions
Message-ID: <20260513133614.GA703152@ax162>
References: <20260511163100.1887263-1-bvanassche@acm.org>
 <20260511163100.1887263-3-bvanassche@acm.org>
 <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
 <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org>
 <CANpmjNM_rCMzbz88SSmmQU2h0+OvjoyN=VapkBc4OEwF=fRcvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM_rCMzbz88SSmmQU2h0+OvjoyN=VapkBc4OEwF=fRcvA@mail.gmail.com>

On Wed, May 13, 2026 at 08:54:57AM +0200, Marco Elver wrote:
> On Tue, 12 May 2026 at 21:28, Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 5/11/26 3:19 PM, Marco Elver wrote:
> > > On Mon, 11 May 2026 at 18:31, Bart Van Assche <bvanassche@acm.org> wrote:
> > >>
> > >> The four callback functions in blk_holder_ops all release the
> > >> bd_holder_lock. Annotate these functions accordingly.
> > >>
> > >> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > >
> > > Because of this change we'll need clang 23, or you add:
> > >
> > > CONTEXT_ANALYSIS := $(call clang-min-version, 230000)
> > >
> > > .. although anything else that includes blkdev.h that has
> > > CONTEXT_ANALYSIS := y, but is compiled with clang 22 will break.
> > >
> > > Would have been good to wait for clang 23 to be released (August this
> > > year) - although if we consider the next merge window + final release
> > > of Linux 7.2, it might get reasonably close to August.
> >
> > Hi Marco,
> >
> > How about detecting whether or not Clang supports context annotations
> > for function pointers, e.g. as follows?
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 2937c4d308ae..61e592205179 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -32,6 +32,9 @@ config CLANG_VERSION
> >         default $(cc-version) if CC_IS_CLANG
> >         default 0
> >
> > +config CC_CONTEXT_ANNOTATIONS_ON_FUNCTION_POINTERS
> > +       def_bool $(success, echo 'struct __attribute__((capability("m"))) m {
> > }; struct a { void (*fp)(struct m* m)
> > __attribute__((release_capability(m))); };' | $(CC) -x c - -c -Wall
> > -Wextra -Werror -o /dev/null)
> > +
> >   config AS_IS_GNU
> >         def_bool $(success,test "$(as-name)" = GNU)
> 
> That works, but invokes the compiler every time to sync the config,
> adding a tiny bit of latency; I think we already have too many of
> those, and in this case a version check is sufficient. Clang 23 has
> not yet been released, and anyone using the current dev version ought
> to use the latest one.

Yeah, any time we do a prerelease check, we assume that people are
upgrading their prerelease compilers with regular cadence, otherwise
they are doing something wrong :)

> Maybe Nathan can keep me honest about the real overhead of this. :-)

While doing a dynamic check is more expensive than a version check, I
would not worry much about that overhead if the check is worthwhile or
valuable. In this case, I tend to agree with you that it would just be
better to bump the minimum version of Clang required for context
analysis because of the improvements (other than the function pointer
support) that you have landed in main since release/22.x. While I am
always sad to see support for older compilers dropped, I don't think
clang-22 is widespread enough for that to really matter. On the other
hand, I do worry that if we do not have a wide enough window of
supported compilers for developers / maintainers to use, we won't be
able to uncover potential problems to address in the compiler (I feel
like getting __counted_by deployed was particular painful for this
reason), if that makes sense.

-- 
Cheers,
Nathan
