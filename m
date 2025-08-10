Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F40238C2A;
	Sun, 10 Aug 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810474; cv=none; b=XsWPZulguAfwanJRLQdehK8Wit6rd9Z+g5Eshed2ri0DKjYYD28QaR1FxT6UnH8hVFdvLZsZFVjUma5Q0iy/3lOKETaKNY4EwYBKZ9aT0ynpRaJWSJWclA2mbV06iUHv/Ob3b1+zjeW6t+hz2p0kbJ4kALp/jE/ceevmrIOxUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810474; c=relaxed/simple;
	bh=RUDthSGl1MKPcrT7uoeIfZPY6P/+5lVlzzR7S8uN2hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qsP1BKC+Br4ccN3irVPs4JTr4h3gEZ4uyL+FcxsOF7GzV2d5siTXqZjViaRYZZTQnlRwmdZMXu1rRq9aevvYQV3J7tFYL8JFkpzULcIeuIxKfz/exFqH8nUHMsiKMbWNG8INql/TyNeARkDabfAb6cI6U3RFJqVxmVC/uCePxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvLVZbk0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvLVZbk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A11C4CEF0;
	Sun, 10 Aug 2025 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754810473;
	bh=RUDthSGl1MKPcrT7uoeIfZPY6P/+5lVlzzR7S8uN2hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tvLVZbk0usREInDbPZ21ebu08cJKtPWuyWuuLiGR/2Heajam2Se3XqbFmIhL6TobB
	 nZEEfdwXMtx/bh1N3NZKpn7k5/n/Q94Gt3WpGAg25SI+ArgRn3R+eXdLmPaZ7TAGa6
	 odUzQk/O1H30aThLwiRpT/y+zz5018V/Y+0nFJc9Q69UdkpxQlH2FsQu0ZkgHauv5X
	 1CLZi5+hCfTrivU7JPVzm13hwe51ycVHZYVqyHC4x/xXPs/PZp5AV0/nnl7mTz4Bzq
	 pNGPOklXeq/SlR1rNbRFOWrWauLBeflb4KBR0XYGlvb3sifZWts75hnBG4AhuhKodl
	 yM9tUKYf42Z8g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Yutaro Ohno
 <yutaro.ono.418@gmail.com>, Xizhe Yin <xizheyin@smail.nju.edu.cn>, Manas
 <manas18244@iiitd.ac.in>, Fiona Behrens <me@kloenk.dev>
Cc: Lyude Paul <lyude@redhat.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] rust: block: replace `core::mem::zeroed` with
 `pin_init::zeroed`
In-Reply-To: <DBXC9DNUC9F0.2WUOVY87GAA4X@kernel.org>
References: <20250523145125.523275-1-lossin@kernel.org>
 <ygVv2TD4X8QxR1siVW36cSGzeG722j-diB-TA2u1vdX6T_J-hb_dKDiU5vqAhccX3PrLw8yIbuHrgoz2aH-dbw==@protonmail.internalid>
 <20250523145125.523275-12-lossin@kernel.org> <87ms8a5f7b.fsf@kernel.org>
 <2yeRfzu6TlmaFLopKKmkgCjPM8Q1zo-YY5zgWjrbr00Bd8EwX2husSNSthkSujwznGxXmqteH00Apemot4z77w==@protonmail.internalid>
 <DBXC9DNUC9F0.2WUOVY87GAA4X@kernel.org>
Date: Sun, 10 Aug 2025 09:21:03 +0200
Message-ID: <87frdzhcbk.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Fri Aug 8, 2025 at 11:35 AM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>>> All types in `bindings` implement `Zeroable` if they can, so use
>>> `pin_init::zeroed` instead of relying on `unsafe` code.
>>>
>>> If this ends up not compiling in the future, something in bindgen or on
>>> the C side changed and is most likely incorrect.
>>>
>>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>>> ---
>>
>> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Thanks, this one was already picked & the PR that included it contains
> your Acked-by (it couldn't be rebased since I noticed it too late). Let
> me know if you need any pointers.

Right, I remember now that you point it out. It's just because I got a
new fancy email filter (lei q dfn:...). Hopefully I will miss fewer of
these in the future.


Best regards,
Andreas Hindborg



