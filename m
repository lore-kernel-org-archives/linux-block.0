Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015441;
	b=TwrGCAB9hNB9uDA2BXUysQSDy4yGTc/ydFGvgLiF7+V54sRsTaSNIXHM43G9x1XzzLgj
	 YYySSaqkfQE6kNWaRWdcIrKBrRLTCkGQdk3AZf1tKwV4MtfmWcfSv9mMK4uuEv+sdJtoe
	 JRwZLGrXcqUFryFaQ41AnLBJ9y+gMsxzMJz1F0/W81zzIHY4uXY5wRGRsw8ND2Tih3nk7
	 I+/jCCpBBA6z5zm1o2eY2s5K7Hca0Wqi5PwmD5WkTdyTWmfm8zcR/tAnd0fyejMp9M3aD
	 ZOogO7SGY77/3V1+m7uRDYaOE2rIY4UDNGGoBEEa71BTyyq3V3whinYpjhApu8EWr1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=RQcOM5LZ+A50DskRP5nF4QpJYB2S5F35ZVxDxecyXLE=;
	b=rgHW1tL4MkYAjshT3r5BdRlR6C2KtZ+ooxD73/BDYbD4CgHXHRN1lmDswZrOWyoeHAzY
	 Cd/h2sGBP/w2GnmM4KnnRvNxs2+AwkMEJUGQZh8R7PHT0UmKZtiMTYtdjVQkveHd4HZVb
	 CTsXsIecK4U53Y0xYbNhBlqyJ6IU4GvTG/kYoMcYXT+fOwqtBOpJ3EoUUmJbOpkss3pY2
	 nYMWOGielhn0FSNujjAetg0sUrlUsGaZZK0VIca33PnwBMZBjia6mB0G/OAg5TFjk8Max
	 PPW2a579j0885OBw8XZhSuhTyaDiNehmGds4jug0U8AjSL8WSng4TjFT7Gltbln5y/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAu+g7DZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A3606A32A;
	Wed, 18 Nov 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAu+g7DZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C755F1F000D0;
	Wed, 18 Nov 2026 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015441;
	bh=RQcOM5LZ+A50DskRP5nF4QpJYB2S5F35ZVxDxecyXLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bAu+g7DZw3J/d5gjI5fKw3TQ5XEKjEBdA61DLneCyxO9RyQFJT6NDl4rp2J/zIrby
	 UTRU6hZ4OvYXpq9U96p5J+Jp0RqsBkW0dTjYTMVk1ETfP71i70Qnb9En+xPV1yXXsM
	 5MPUfHlg8dz8XISX3fRv5jql4mAeUyn4Tlx/96Xz6lR1VVeDlDm4SXsJO7iB0jBfqG
	 iACcY4jLn1auGGi1XCeSv4z5KNXdBIdEAld5BQoR4aTSY6tmKz9mgq8ojXPiafJAk1
	 II6HR8YBy70CWBDAWiWqZVZxI7NoTPmt+kZQo2OSHntI+1N6AGCuaBk5PS6wXtHDQ3
	 KVcn3u0OBQG1Q==
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
Subject: Re: [PATCH 2/3] rust: page: add reference counting, raw pointers
 and a private bit lock
In-Reply-To: <20261117233211.3137168-3-vitaly.wool@konsulko.se>
References: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
 <nJAtLmDmAV24rOe6aN54vqMAgr06LVJtplZTvmqfydTzMhml3convxW0wdHq0nMHqmRM7qsioK1kV78UIwCkzQ==@protonmail.internalid>
 <20261117233211.3137168-3-vitaly.wool@konsulko.se>
Date: Wed, 18 Nov 2026 16:23:40 +0100
Message-ID: <877biaups3.fsf@t14s.mail-host-address-is-not-set>
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

"Vitaly Wool" <vitaly.wool@konsulko.se> writes:

> From: Igor B <igor.b@beldev.am>
>
> A `Page` always owns its page exclusively, with no way to take another
> reference or keep it as a raw pointer. Add:
>
> - `Page::get()`, which takes another reference with `get_page()`;
> - `Page::into_raw()` and `Page::from_raw()`, to convert a `Page` to and
>   from the `struct page` pointer it holds a reference to;
> - `Page::try_get_raw()`, which takes a reference from a possibly stale
>   pointer with `get_page_unless_zero()`, for lock-free lookups like
>   brd_lookup_page(). This is sound because a `struct page` is never
>   freed, even once its memory is;
> - `Page::lock_private_bit()`, which takes a bit spinlock in the page's
>   `private` field and returns a guard that releases it. This gives a
>   page used as plain memory a lock of its own at no memory cost.
>
> Add Rust helpers for `get_page()`, `get_page_unless_zero()`,
> `bit_spin_lock()` and `bit_spin_unlock()`.
>
> This patch was tested with the help of  Claude Code AI coding assistant.
>
> Signed-off-by: Igor Belousov <igor.b@beldev.am>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

I already submitted most of this as part of the `Ownable` work [1]. I
sent v22 of the `Ownable` series a few days ago [2]. I stripped out the
page stuff to send as a separate series. I plan to send the page things
this week. It covers both reference counted pages and frozen pages.

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/all/20260910-unique-ref-v21-0-e83257373062@kernel.org/
[2] https://lore.kernel.org/all/20261116-unique-ref-v22-0-12029383206d@kernel.org/

