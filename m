Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0B2343C0;
	Thu, 29 May 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548501; cv=none; b=QhRN3L5klSyUoeKHd5YyQpw2L/+GOXvTjda9QHat4+QE9veNw+fc6mlL0oGBB/ogagGRBUwzHPHtcItVG5xNL/PZBx6EbjYT0Hq8SpzaW7wuIJ4+9NSZjNHjjWLlCilSso5a6RBhNRh5oc6DWVV2aIyH1pJwkvuUWyOTDNFaiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548501; c=relaxed/simple;
	bh=D8SsvetF0LkwPwk/o2VLlKNb33N8511Oz+YkmPV8GUY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DqhpmBVBpvxYSDY/O3GoJGCW7/sm7RwxDtDWbRy4+13ofx15g3iWA9Up8hazjhGKgk6W9iTJdxKDantwIyaF3ANvGG1l5jfvkQDhf6Vv/KHN9sX4uRMj4QFfoc7ceVZ0DwqbPW95kNFQ9zMRJWbPaMK4+eYpmbVuJjb6hZdN2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO8snhQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO8snhQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34FCC4CEE7;
	Thu, 29 May 2025 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748548501;
	bh=D8SsvetF0LkwPwk/o2VLlKNb33N8511Oz+YkmPV8GUY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oO8snhQswGTgq78meJIA9ZSu9eqOFykj215dnh4QwmSV+epEYU7IN6EzWpf7CZNNJ
	 7vPEKCAzuq7hYpTn6yZavGV1hJzBXnVsB1G+OzyF8phQ+TmtPQAmfFBzHSJeAndtkh
	 DHlEig9beK9+TTZtwIgTnbLseZji0SvEZS4ErDh0RqeHnIGR6ESNjhZACG/ydXcuC2
	 0QfamjvRgYjtiLdMsn4t2hoho0R2KXX+IgRONNvkwQ7YJ2OcPEIHuiyHA3oK+g+y32
	 EDxAzWY8nRcwV2lQOTU2zL7Uwb3NQl+tAhqAvVfvHX/wMY/y/ILi7TXCtuhAoY9xHr
	 C8VzEvj6NRxvw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 May 2025 21:54:56 +0200
Message-Id: <DA8WPLS2R7K3.2T94MJM71BXI0@kernel.org>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Fiona Behrens" <me@kloenk.dev>, "Christian
 Schrefl" <chrisi.schrefl@gmail.com>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] change blanket impls for `[Pin]Init` and add one
 for `Result<T, E>`
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250529081027.297648-1-lossin@kernel.org>
 <20250529081027.297648-2-lossin@kernel.org>
 <aDixS9Fp-fZxet7m@winterfell.localdomain>
In-Reply-To: <aDixS9Fp-fZxet7m@winterfell.localdomain>

On Thu May 29, 2025 at 9:11 PM CEST, Boqun Feng wrote:
> On Thu, May 29, 2025 at 10:10:24AM +0200, Benno Lossin wrote:
>> Remove the error from the blanket implementations `impl<T, E> Init<T, E>
>> for T` (and also for `PinInit`). Add implementations for `Result<T, E>`.
>>=20
>> This allows one to easily construct (un)conditional failing
>> initializers. It also improves the compatibility with APIs that do not
>> use pin-init, because users can supply a `Result<T, E>` to a  function
>> taking an `impl PinInit<T, E>`.
>>=20
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Link: https://github.com/Rust-for-Linux/pin-init/pull/62/commits/5861251=
4b256c6f4a4a0718be25298410e67387a
>> [ Also fix a compile error in block. - Benno ]
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>
> The patch title is missing a "rust:" tag... but you can fix that in PR.

Good catch, I originally ported this patch with my script, but then I
decided to squash upstream and then copied the commit message from
there, removing the prefix...


> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

---
Cheers,
Benno
