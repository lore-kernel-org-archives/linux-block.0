Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E7A95E;
	Sat,  5 Oct 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728114449; cv=none; b=jKUPtL3yyJM1phsqDhUTIqzgU/xE//HJ89Oh2++mFfA8PAcO4Ne/DWhp/J7ChpwZJiDG80eNzZMs9TXuG1JYj+TMzURAVFD57hmeNNHp/Tl/BR6sdRBBtlRUams9YPI2TpPCJGXM1UV0sr/ErYijGEpex8IwN6ooikxRIwWgM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728114449; c=relaxed/simple;
	bh=NE+U0XsqJwmk9/zbDIP/+qotFb3/e5RIM/DoXNIHs/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhbZM2e39gKRuDFF3ox80EDlK88YHXmxQsrADPgCAxRHYUeePptEUty/CMBFhp/yQ51tEzMhzdb9uXEcvAyy696MOpB2nZhaBp1nAm3GyGxtlQcOki9EW/wg2FTMbZl5n0negxgWKiA/z8pke+JRVYV2dILfsQ9qB4VJj+nIKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rr6rILnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rr6rILnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7D2C4CEC2;
	Sat,  5 Oct 2024 07:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728114449;
	bh=NE+U0XsqJwmk9/zbDIP/+qotFb3/e5RIM/DoXNIHs/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rr6rILncCZvm0wTZfXXgFYDww657ANTyDYMrIt9jDf2CyxLMbn5szhzGH/91opOUQ
	 pesFfvQ37ddvt0ty9GyqDjSNP78M19S+mJoHDJa9r5idcin+vJj7wwaUvM2RzDJxkd
	 1tQ7byVpOHsQMkFkjAOZWkWZpSkTbYSo7jvz2ujw=
Date: Sat, 5 Oct 2024 09:47:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <2024100507-percolate-kinship-fc9a@gregkh>
References: <20241004155247.2210469-1-gary@garyguo.net>
 <20241004155247.2210469-4-gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004155247.2210469-4-gary@garyguo.net>

On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.

That's scary, and of course feels wrong on many levels, but:


> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>      /// C `struct request`. If the operation fails, `this` is returned in the
>      /// `Err` variant.
>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
> -        // We can race with `TagSet::tag_to_rq`
> -        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
> -            2,
> -            0,
> -            Ordering::Relaxed,
> -            Ordering::Relaxed,
> -        ) {
> +        // To hand back the ownership, we need the current refcount to be 2.
> +        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
> +        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
> +        // atomics directly.
> +        if this
> +            .wrapper_ref()
> +            .refcount()
> +            .as_atomic()
> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Relaxed)
> +            .is_err()

Why not just call rust_helper_refcount_set()?  Or is the issue that you
think you might not be 2 here?  And if you HAVE to be 2, why that magic
value (i.e. why not just always be 1 and rely on normal
increment/decrement?)

I know some refcounts are odd in the kernel, but I don't see where the
block layer is caring about 2 as a refcount anywhere, what am I missing?

thanks,

greg k-h
