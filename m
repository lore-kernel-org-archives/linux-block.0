Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262554F95;
	Sat,  5 Oct 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122969; cv=none; b=FNtPj6diBcWcy6P2YT1D+peXAlt+oSf5xMKHzIUXDunFrN2RCJrZYGsRkKrbrve7SU2YAqvQh7irjbEybkUQ34UZ76pWqjLmvlW+nSENfA+2/yK632sSO3saTHWg/akl2uXKUHZrWZXvR8iBK5R3kvtIHyJp+oEhR0+V2GP86mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122969; c=relaxed/simple;
	bh=TnRcpkwpz5aNkDxAHuYe0cHS9vM36cfXz3vpnQCKMMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWgoILL6l9XAD386yVp+O/MRYl/npd0oR4kE8QO0OAR00HVUmr3fkKIykkkhjVbr0cujcuxzgkfdLRIADmQxsDjxTG6f+yqAeVpREsdpQTH97CD4uwkt4jqb8cpXs7lwFKGbVkpRLFUTx4UthMV87te0MBYvsbqhjOgJfTD4U/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJ1716tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJ1716tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E35C4CEC2;
	Sat,  5 Oct 2024 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728122968;
	bh=TnRcpkwpz5aNkDxAHuYe0cHS9vM36cfXz3vpnQCKMMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJ1716txygf8g9tKb23L/yBrrhQorx4JDnAsD5l1uUn60oLJM+I3vB1K9bdn9yVCU
	 sYHN6q9aC/Dax9nTnJ3nySXLkn/lXfld108amxzxpdlwwquYl3MaPILrKC7lz2F0UE
	 qszb5gKTgmUFKkFBRTlvpVVZLMRJ517772bh9B5o=
Date: Sat, 5 Oct 2024 12:09:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <2024100555-used-omnivore-0c9d@gregkh>
References: <20241004155247.2210469-1-gary@garyguo.net>
 <20241004155247.2210469-4-gary@garyguo.net>
 <OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
 <2024100507-percolate-kinship-fc9a@gregkh>
 <87zfniop6i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfniop6i.fsf@kernel.org>

On Sat, Oct 05, 2024 at 11:48:53AM +0200, Andreas Hindborg wrote:
> Hi Greg,
> 
> "Greg KH" <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
> >> There is an operation needed by `block::mq`, atomically decreasing
> >> refcount from 2 to 0, which is not available through refcount.h, so
> >> I exposed `Refcount::as_atomic` which allows accessing the refcount
> >> directly.
> >
> > That's scary, and of course feels wrong on many levels, but:
> >
> >
> >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
> >>      /// C `struct request`. If the operation fails, `this` is returned in the
> >>      /// `Err` variant.
> >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
> >> -        // We can race with `TagSet::tag_to_rq`
> >> -        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
> >> -            2,
> >> -            0,
> >> -            Ordering::Relaxed,
> >> -            Ordering::Relaxed,
> >> -        ) {
> >> +        // To hand back the ownership, we need the current refcount to be 2.
> >> +        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
> >> +        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
> >> +        // atomics directly.
> >> +        if this
> >> +            .wrapper_ref()
> >> +            .refcount()
> >> +            .as_atomic()
> >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Relaxed)
> >> +            .is_err()
> >
> > Why not just call rust_helper_refcount_set()?  Or is the issue that you
> > think you might not be 2 here?  And if you HAVE to be 2, why that magic
> > value (i.e. why not just always be 1 and rely on normal
> > increment/decrement?)
> >
> > I know some refcounts are odd in the kernel, but I don't see where the
> > block layer is caring about 2 as a refcount anywhere, what am I missing?
> 
> It is in the documentation, rendered version available here [1]. Let me
> know if it is still unclear, then I guess we need to update the docs.
> 
> Also, my session from Recipes has a little bit of discussion regarding
> this refcount and it's use [2].

Ah, ick, that's crazy, ok, good luck!
