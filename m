Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81A1D9A6A;
	Fri,  4 Oct 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066857; cv=none; b=LUUMgZZGZ47Jr1KxU08EP4pGqvJAmgGCBxBj/jLc7/CIxzz/jKhrabTl8g4roXzZiEknKK+StdbbR4gQ/c0UvVS2yI/iRXVaATXfDRLm60kX7QG/CN5RMClkzlDk8Pqs/vhGgrBRIgotNczefNZdv5oSB04v1oPu+RvJpWL9fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066857; c=relaxed/simple;
	bh=fCALgWn+AAMKieHOm9t7rGua2lZHZP3fE30hTOXcTxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4I0wLU5VnJ7AbLa3pxaY8Q2JU6nig/vVc32uHwmXkXvVtw+Jvhs4b7MmsYxo8Qrvn5wUjAE9zQy3LQVAwxa2p+LL/8SHSaoJn8nYQGQon2cdYA3amwUG+Wh9RwBUAP+GSaSnMz0Ml3xCEKzmVjPYrHOQsgTfTOpTfPTlTluqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm4yskSv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm4yskSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92090C4CEC6;
	Fri,  4 Oct 2024 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066856;
	bh=fCALgWn+AAMKieHOm9t7rGua2lZHZP3fE30hTOXcTxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Tm4yskSvJwHIA5U46tAaUv15GE/tx//j+6tMKCakOUKpI7nKxZZ5ictVjYw1wOAeT
	 nkK8F3ro1pkCoO0mWVX/I/GH5SnSQi/zI1pThq+YTwaiPkUqr9EQnN097q14opLmoY
	 TVPJBlp5MQnovbEWcHtG3fkEaHJ066sv0nOmn0o/zJm2N6a6LzLmiyiVY8y8a72ygB
	 kE2/Ks4JOSyCgteaQCaT7htUbpnWjFaz3Nu32OgX+EnGsbWrgJqtu0Ohc+z++NCZ0Z
	 qmXeYJwObplzSQAOq+BCK2ca2X1Ol03C36PzweaR272u16MDWRruPkGDY6g2Q8m32m
	 HxJQNyJaPl79Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Jens Axboe" <axboe@kernel.dk>,  "Will Deacon" <will@kernel.org>,  "Peter
 Zijlstra" <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
In-Reply-To: <20241004155247.2210469-4-gary@garyguo.net> (Gary Guo's message
	of "Fri, 04 Oct 2024 16:52:24 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<Ai8LlcjRkqtugtU8IFGU53QASgH_GnKT_H3nxOjxpBnGaTTgWFUKv8lsnSPM6qzWAhq7alWhj8U6wJcGiABcpw==@protonmail.internalid>
	<20241004155247.2210469-4-gary@garyguo.net>
Date: Fri, 04 Oct 2024 20:34:01 +0200
Message-ID: <87h69rpvja.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Gary,

"Gary Guo" <gary@garyguo.net> writes:

[...]

>  // SAFETY: All instances of `Request<T>` are reference counted. This
>  // implementation of `AlwaysRefCounted` ensure that increments to the ref count
>  // keeps the object alive in memory at least until a matching reference count
>  // decrement is executed.
>  unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>      fn inc_ref(&self) {
> -        let refcount = &self.wrapper_ref().refcount();
> -
> -        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
> -
> -        #[cfg(CONFIG_DEBUG_MISC)]
> -        if !updated {
> -            panic!("Request refcount zero on clone")
> -        }
> +        self.wrapper_ref().refcount().inc();

What happened to the debug code?


BR Andreas

