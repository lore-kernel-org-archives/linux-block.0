Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F792AE74;
	Fri,  8 Aug 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645817; cv=none; b=bEGTbRBLCqSklYp59dZM22Y8MP6i7WGHGWzCBhlM1Fifmm/KSG/qyYmlJKKK/dT91nvheuNsu6iiViz1fHUOPnolUTPbeh14fiIaZ3moC9/ITRTilD4gZZTvf8wpRudVIXZfnPjzGNf+wZ+7TFGhFPK+PzevJJLYdhvJyu3lEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645817; c=relaxed/simple;
	bh=al/iObMczjpm4VX9XgQiZo/h+mnI8uLsIGdUYDDhiac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eddyL5wfErT4i4cmVzeAtUg4RZoEc/5kRNi3Dl/4sGcH5AwdjXwr5Ini2zJfJtIILYt5U98rRcCQoD+ZeI5V/F0u3DrrloLijsqR8RH8JbtGDrKJgzJ6CVC9g+b9XeQPJImw0dSNySZ6gVJbOGdiGQ5EUAUicWP3+MCl1S3+DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbnkeF9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbnkeF9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C11C4CEF0;
	Fri,  8 Aug 2025 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754645816;
	bh=al/iObMczjpm4VX9XgQiZo/h+mnI8uLsIGdUYDDhiac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tbnkeF9i/CKN3dqiPJCr8laz+m53wjZypW/ri64L1HI36xJhovfZnzAr+EysxcAmX
	 oB7wa3DJbHcNKEgKbIpPML6AJiOiWSxvRT386quPflKJ2RBAvPTvtuXJIj0xhVNH1V
	 TN5I/I6Emue4F1tbZKZOg4GAPGZnltfIdVdjCunDr5taDLD6oNx2Id44stMGCn1uII
	 mPBXc9jQ9hqCZ2d9XPxQviF2uTrgxndLg3ZK4903yoaAPwXplHkMH4k6+zq8bP3sxr
	 EMsn/oSiVtve5VFVk59sj7mJikL4+dV7HfPkUpNyGZKBZ9Uxjt8vXhkqSr8vTYUj4R
	 ToQdjTvfFewAQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Yutaro Ohno <yutaro.ono.418@gmail.com>, Xizhe Yin
 <xizheyin@smail.nju.edu.cn>, Manas <manas18244@iiitd.ac.in>, Fiona
 Behrens <me@kloenk.dev>
Cc: Lyude Paul <lyude@redhat.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] rust: block: replace `core::mem::zeroed` with
 `pin_init::zeroed`
In-Reply-To: <20250523145125.523275-12-lossin@kernel.org>
References: <20250523145125.523275-1-lossin@kernel.org>
 <ygVv2TD4X8QxR1siVW36cSGzeG722j-diB-TA2u1vdX6T_J-hb_dKDiU5vqAhccX3PrLw8yIbuHrgoz2aH-dbw==@protonmail.internalid>
 <20250523145125.523275-12-lossin@kernel.org>
Date: Fri, 08 Aug 2025 11:35:04 +0200
Message-ID: <87ms8a5f7b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



