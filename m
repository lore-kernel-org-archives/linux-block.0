Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA13A2E0A;
	Mon,  1 Jun 2026 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312618; cv=none; b=BdFaurjJfaW93Vu7kvmhhqWxFb9Nw/y7VbSJ80HrSN8cd/87ESEk+9pZieV5R2oCxKT91T11Ra/bvaYBfXKtaebMFr19B6IIchwPak+gpWZCqIjn84YY6zAz8c/cNQ/gSjHvd/GYzgNYNc3H6/pQvTo2Anwy6gLcFSJYk2TSWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312618; c=relaxed/simple;
	bh=CRHoP5VdkIAyG5qDOl9IysDCvNb5MiyLvpUd9S+gzQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aaBp3CKVdFEOrL3Xcg/AKFAPslPwaCO17xrWWzOKUvAghF+ZnN6kW3pj4hRH0eXcxiYSwEGbNHz+KiwKuTf0pihBLt2FjO0HM847/Mq2JwUAO8pT4KqPU7noMQ6nulthXHtHHNG2CFVccCNLD9bPW/Z2hh6x6tg3w6TTxmqumko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8uki+OG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8uki+OG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86091F00898;
	Mon,  1 Jun 2026 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780312616;
	bh=CRHoP5VdkIAyG5qDOl9IysDCvNb5MiyLvpUd9S+gzQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G8uki+OG4nJXKcRZtOFdjfuVaje7IhPsSBlyQxDVK6rQ2U2XfNst+LmO0FDBhPdXO
	 S09iAU4U8VXKGMxtoIGANyksSGGohF++3CaROL4ZLv35QNRbjgTN7rdFwI2udY/yGB
	 MlSzA2LgcqfOXO8ZeuobJNEqbV3AjxWUeDbFUynLg9wmnrD1qtE7iJ+3sCn7vj5gWn
	 k+/0phmTAOUi1PJrkemVvfv1wuJkLg3+nfOLY1HRONfiINTWcn/IB4to5JOUD+BLda
	 6KSEpSUYUbufzVG9aM3tzf6WzRvhetNrL3fEil0hi7jD6r5dRl7YswnbbOgM8JSKFJ
	 X9/wW7jFtnY7g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/79] block: rust: fix generation of bindings to
 `BLK_STS_.*`
In-Reply-To: <CAH5fLgi+K_5So-kLwyZGhaagEx-rRXPmk=zCOTqG3yh=bSe9Ww@mail.gmail.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-4-de9a7af4b469@kernel.org>
 <abfNByL15D4s69Al@google.com>
 <CAH5fLgi+K_5So-kLwyZGhaagEx-rRXPmk=zCOTqG3yh=bSe9Ww@mail.gmail.com>
Date: Mon, 01 Jun 2026 13:16:35 +0200
Message-ID: <875x427bos.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Mar 16, 2026 at 10:27=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
>>
>> On Mon, Feb 16, 2026 at 12:34:51AM +0100, Andreas Hindborg wrote:
>> > Bindgen generates constants for CPP integer literals as u32. The
>> > `blk_status_t` type is defined as `u8` but the variants of the type are
>> > defined as integer literals via CPP macros. Thus the defined variants =
of
>> > the type are not of the same type as the type itself.
>> >
>> > Prevent bindgen from emitting generated bindings for the `BLK_STS_.*`
>> > defines and instead define constants manually in `bindings_helper.h`
>> >
>> > Also remove casts that are no longer necessary.
>> >
>> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> It'd be ideal to change the C header to use an enum, but that may not
>> work as I'm not sure you can specify the integer width you want for an
>> enum.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Honestly, it might be better just to declare a Rust module somewhere
> with each constant redeclared:
>
> const BLK_STS_FOO: blk_status_t =3D bindings::BLK_STS_FOO as blk_status_t;

As it turns out, `bindgen` only emits a binding for `BLK_STS_OK`. It
cannot parse the rest, because they are declared as `((__force
blk_status_t)<N>)`. So in order to avoid special casing the `BLK_STS_OK`
constant, I think we should just keep the patch as is. I don't think we
will gain much from re-declaring all these in a local module.

I will update the comment on the `blocklist-item`:

+# Bindgen cannot extract values from the `((__force blk_status_t)N)`
+# CPP-macro form used by most of these and emits the few it can extract
+# as `u32`. Block them entirely; the `RUST_CONST_HELPER_BLK_STS_*`
+# definitions in `bindings_helper.h` expose them as `blk_status_t`.


Best regards,
Andreas Hindborg


