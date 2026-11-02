Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621038;
	b=1SycwvX4IHSXW609LblNXcprkHUZd7gPazMFl1WTxfgTu3hutDujo5qvmHPBRJzN6BEI
	 1nVuN2bnmLNyqakGO4lwhEJP6tdQNXdQV91eku6bFj5KRCru3uHhBftymwc87AeXjd/lq
	 /b28ISaTkIiwQFT+08UIf/oXmOZGZW7IT1bMj0GzrcQZukYZHphONL64uV0VD0KICREPY
	 +DOs+sGOy/qe2xApgoLdq67QJlkdzuA8g2Bcu0W6rd+CPBM3Ck6T+Ohhnl/GvbxS44yJT
	 i9Ka5puWEEPXdOq+hJH1eok0w3Z9Y5UcWhEz/U0UhxcXy04BduAiZvzRDGdNj+WLScA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+KR8SSAiOleGsLcX03uUO818V65YoyqPW61dqjtr7sQ=;
	b=eY59vyfuGZbw+G6vFwfn0UIZoW7yESyUDhjfKOXK+YQYHEESl1am+Y08+Gp8MwkWCQqW
	 xbNB8ImqIcBKQV+krtmgZjbO/KWFmafRKeSIXJh2ckeWabQnbLcVgrssAl1hPQFXxVbRO
	 QJ/v7VAYoWcPLcgc4zOGRIARqk5De4C8BZvtFpzdw+IQIjH/XK2OfnQrcRIhErETlfSaf
	 RIrDf81GFxlwZK1YKuNPD5Cc8/Jbm2740xgU+j5vr6Z83mzlqMPqQTN/g+feCvWolnAh5
	 jyPQkr0Gd94njcLSV1kncliqpB3j+gHxMrteudmi1IxXge1auCYJB0e/KRTSWLXUiig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvA6Xcfz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69775606A330;
	Mon,  2 Nov 2026 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvA6Xcfz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6671F00A17;
	Mon,  2 Nov 2026 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621038;
	bh=+KR8SSAiOleGsLcX03uUO818V65YoyqPW61dqjtr7sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mvA6XcfzqKax4soyH80LdRSBHuq8X4VljXayi/hsTyvxvk55eQObNTpfwZP/YmyO5
	 bYqAJNPcZRdifl198J7tKD4/Ev55MnJz2902s1YOi7AwHU4qgZ9vCXrVMR7vN68HpC
	 8UO+4jN73AFv3cgRnwqJ0I/5AY1q453eCuRfEbhydI2E3eBm45S0Cf1rQrVJsPdYOg
	 YzCI6DTt1cFfYDqGyp9DTBHP4z5IfAxm7iIp7cPOBYg9OQRy7qpjtQCFFL5b4ix6hj
	 mCT7t6QQjsCi4583mr1LCm1tRYF3gS2QwRgUfwjfCEvpK04I8JQr65XeP5TcrFSwJm
	 w7DeFUkW4t8iQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Sasha Levin
 <sashal@kernel.org>, Emilio Cobos =?utf-8?Q?=C3=81lvarez?=
 <emilio@crisal.io>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, Linus
 Torvalds <torvalds@linux-foundation.org>, Josef Bacik
 <josef@toxicpanda.com>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
In-Reply-To: <CANiq72=jdQdNeTNoSxnMGvQ9URQ7yJjLWceYiB1ZcbpoYxj7wA@mail.gmail.com>
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
 <20261031152846.746656-1-sashal@kernel.org>
 <rREqsVQcNZyniqNmZlaG1mBye3-y0_UjxwhS7g4--vkR8TZ-umvVJl1A4VJh7Dnki4rG1Bz6yfp8rOOVq0Texw==@protonmail.internalid>
 <CANiq72=jdQdNeTNoSxnMGvQ9URQ7yJjLWceYiB1ZcbpoYxj7wA@mail.gmail.com>
Date: Mon, 02 Nov 2026 13:02:27 +0100
Message-ID: <8733tjo2zw.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Sat, Oct 31, 2026 at 4:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
>>
>> bindgen 0.73 emits the blob of some opaque types, such as ones aligned
>> to more than 4 bytes, as a `__BindgenOpaqueArray` or
>> `__BindgenOpaqueArray<align>` newtype instead of a plain array. The
>> newtype only derives `PartialEq`, `Eq`, `Copy`, `Clone`, `Debug` and
>> `Hash`, and the `MaybeZeroable` custom derive does not reach it, so a
>> struct that embeds such an opaque type is no longer `Zeroable`.
>>
>> `spinlock` is opaque (see rust/bindgen_parameters), and with lockdep its
>> blob becomes a `__BindgenOpaqueArray8<[u8; 72]>`. Commit 71ec3c7d6db8
>> ("blk-mq: quiesce a queue that joins a quiesced tag set") added a
>> `spinlock_t` to `struct blk_mq_tag_set`, so an allmodconfig build with
>> bindgen 0.73 now fails:
>>
>>   error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72=
]>: pin_init::Zeroable` is not satisfied
>>     --> rust/kernel/block/mq/tag_set.rs:41:49
>>
>> Which wrappers exist depends on the bindgen version and on the opaque
>> types of the configuration, so they cannot be covered by unconditional
>> impls in rust/bindings/lib.rs like `__BindgenBitfieldUnit` is. Derive
>> `Zeroable` for each wrapper in the generated bindings instead. The
>> pattern allows for the spacing of bindgen's output when rustfmt is not
>> available.
>>
>> Fixes: 71ec3c7d6db8 ("blk-mq: quiesce a queue that joins a quiesced tag =
set")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Applied to `rust-fixes` -- thanks everyone!
>
> I can send this to Linus in a couple days, unless Andreas shouts or
> Jens prefer to take it through his tree for some reason (now that
> v7.4-rc1 is out, it shouldn't matter).

Thanks, works for me.

Best regards,
Andreas Hindborg


