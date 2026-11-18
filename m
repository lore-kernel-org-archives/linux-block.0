Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015436;
	b=RaRpuE+g1mqQAbH/quDoWEuwMwyvsNlAKzJNgwHW2AfAlTEILKqsJlV7uhh4FzuJ4SDh
	 IIb/EQf0GU4eTbgWIdjsYwc8qw5C1k7k2vpo35oqHden5zZRsPeGV4Pbk+ram4LuTPiuk
	 11aIaRM9it28jCrtaL5RPinK3wLwCFnz755oNYA4viZfjYhKuVt7zPHN1RU5BCL8QB0TQ
	 R7sGul4hzDPBcU6RcIk8DMfKpJoD0QqSRyae0VtrZOkS09iZOuOrKpstNruYBxJvE0ASu
	 yGnyJi38fq5ZoYFKDA+28yA4ajfXUh3gQOQeMNNEqdZraovH9THJzMpJ1iMW5mVe8wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=/wWuoNoKhTnCurVf+R9Dm8cUyc6MlIAKk64n3z/RBEY=;
	b=MxgHQHnbuupE9+AFd9kK90gW/qVM1uXfC3sxGuW9G6dVxijc7AAxei0JOmS+Mfx6XUdo
	 KaapKDS9e8GSOBkEb4vyQ0DmAr9/TIiVc8/PnwwTnlE4aUpK+82c6fBY/yxAUnDhWHcZ7
	 ruS//3ICbC5pHY2euiMSc8by9Xa9sQF5qs2qxbqq6KoTPBh6L2jyMI49dXIplbVtisfxR
	 Z8Mkb8fkZ/fj14+9yYpUZn68/GupPvaYsAzUtHu5yIjRlZcrKt/+/XMqC+rw39fNnvraR
	 JGYZe0Cp85cyku+JJLsmgjjla6S1Qsu02pofYyjcKPSNg+cdCt49X2MEPe/f8KveR5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpWF6okg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65760A2611;
	Wed, 18 Nov 2026 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpWF6okg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03411F000C5;
	Wed, 18 Nov 2026 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015436;
	bh=/wWuoNoKhTnCurVf+R9Dm8cUyc6MlIAKk64n3z/RBEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VpWF6okg+6brufuDUnD/0rcm3ikR/TGcAO2b+kf1nmmezjf+ioumZyaJ/hW1XAXHc
	 i8+zQr8ldIQD0EwrkfLPgRuItBcHyIZGOM9ZjDoPmyJ1lmnkSn4IWArch/xtz+If9D
	 DG3rxW6pXD2Lxv1OKCtUjy80q7COvdcFrxOToK+yGr980IxJ1Q+I/s65bGLw80Gp98
	 fgGv05L88j/j0lYcRWqAAwMUORJzu7XIZ7ttOGLTRaeCxIqA75DJOHItpxUN0JKiXG
	 ilTvBNtJXKBxAAwlwwkJ6flU0YBv1XT+qIIumi2wFcjWs/rqbqqj1cif+sSDD0fUkB
	 i1OiklgN/SJsg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>, Jens Axboe <axboe@kernel.dk>,
 Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R
 . Howlett" <liam@infradead.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Igor B <igor.b@beldev.am>, Vitaly Wool
 <vitaly.wool@konsulko.se>
Subject: Re: [PATCH 1/3] rust: block: add bio segment iteration and request
 accessors
In-Reply-To: <20261117233211.3137168-2-vitaly.wool@konsulko.se>
References: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
 <3wemO2s0BrkamlAGBfPqORofFz9yCXPMZUZ0-dUQxmJmEhmz2T2yaCjcaTVXEB_gwLj8SdBNjkOR8r6aERjk9Q==@protonmail.internalid>
 <20261117233211.3137168-2-vitaly.wool@konsulko.se>
Date: Wed, 18 Nov 2026 16:19:13 +0100
Message-ID: <87a4n6upzi.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Vitaly,

"Vitaly Wool" <vitaly.wool@konsulko.se> writes:

> From: Igor B <igor.b@beldev.am>
>
> The Rust blk-mq abstractions only cover what the null block driver
> needs: requests can be started and ended, but a driver cannot find out
> what a request asks for or reach its data.
>
> For a driver that actually transfers data we need:
>
> - A `bio` module with a `Bio` wrapper, an iterator over the bios of a
>   request and an iterator over the single-page segments of a bio, the
>   equivalent of rq_for_each_segment(). Segments can be copied to and
>   from a `Page` and zeroed, with bounds checks. Iteration goes through
>   two new C helpers wrapping bio_iter_iovec() and
>   bio_advance_iter_single(), so the multi-page bvec handling stays in
>   C.
>
> - `Request::command()`, `Request::sector()`, `Request::bytes()` and
>   `Request::bio_iter()`, exposing the operation, start sector, length
>   and bios of a request. REQ_OP_MASK is added as a constant helper,
>   since bindgen cannot evaluate it.
>
> - `GenDiskBuilder::max_hw_discard_sectors()` and
>   `GenDiskBuilder::discard_granularity()`, so drivers can advertise
>   discard support.
>
> These are used by the rbrd driver added in forthcoming patch.
>
> Signed-off-by: Igor Belousov <igor.b@beldev.am>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

I already submitted this [1]. I have a version rebased on v7.4 if you are
interested.


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org/

