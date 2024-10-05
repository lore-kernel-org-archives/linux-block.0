Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0414B061
	for <linux-block@vger.kernel.org>; Sat,  5 Oct 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728129601; cv=none; b=Nee0xQWDfp6iwa9JNljj7aH7CQQL73RPtLqzYLoKyLGFSD9gNWYyv25oO6zIERywDAih2D9Wymr73awML9Ozttxa28zCtpZu2fxHltRC2l5/gy2g0ncEEYpcG7GNaYAU3DQI962TIw08zjRFfGC5SrbUlOKgOQM7c1xHtkVE+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728129601; c=relaxed/simple;
	bh=B9ie2ibbvUeA8qv7/cm4Mu4ucpj9+ZbfFtIGNqzy5lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+i4YjfsjR4AI1ehsdvkwqwjEIC1eB+BSySrxfL63RqWzXH+SyipJXfoylboKuad7B5JqwCb7vKxzH3ftvYAgPUnpDIbva8f2wh0ozPbDZSdpzkdE5rhJ6s4iwE3JlmYvj1g86yIrjbkjGfqsoYko+BN0jQJwXA6YNriHJfi+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQoRkPvG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQoRkPvG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so29779745e9.1
        for <linux-block@vger.kernel.org>; Sat, 05 Oct 2024 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728129597; x=1728734397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT4JN1wYGFSh5zRwCmPA1K5txyLYW2kiaQGQVe7qZpc=;
        b=ZQoRkPvG8JYddDJBRt1qZ38fVwhdKC5m//WrmJu5ZOWPtAtLyjs4sxFS5kXawJ97q/
         nzz/AWRjq5M0z39UXuMmMoRg7wAbxjkZJtsrcw5/TKhObIT2rRWrBAhBQCfhC6HpsqFb
         id0afgsOdwJUt7IoUVYPRLy5DdvfZzpOVVWRQQqnKD9Hyzcixe5iOl/bQ42nWCSV8qA/
         g4Z6RgF/M5XVuI+blhveRscLNBWMY7pcviPsZkKJqfmGofxQeq2tG39NeiFHnKjwtw9f
         Fk8C7GnHKt+bp5haZo0+sRirrhzi4WgQzTOZu/Hz5MS+dLhdxC3ksz4LE0nRiYNzjY14
         VzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728129597; x=1728734397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT4JN1wYGFSh5zRwCmPA1K5txyLYW2kiaQGQVe7qZpc=;
        b=f0rYFszYYwrQjlaynDQjnLf1a8U+7JrA3l5kM5spCQEkDNcGcAID6reorP4Tdz3oOO
         QJgJRYjp1Hj//PEoYNRPUhBGBSJSFptC52ISB0uzf9QTIDm7wcTcK4pHh6ZXYXkoXpjL
         AY+Ljf2Xu1GtAMZKdLXLX0402/eItfmtIwFp2AD7nvLDoqV9F3FiTROHI+VabvuMqakl
         /e4q9RpsxGlwalQPZYlJeRDuXqHO/0zWo/7XcEEYecf0N+GRNE76x6MywM2WRIHpfVLw
         QVMrMwjiUZT12QJVe9ipyp0rEK2xM6d2BYIr+VVsq+ZuZqcKhnCwVo/FKU8i18jOc+HE
         DhNg==
X-Forwarded-Encrypted: i=1; AJvYcCUy1sHerkTBGz9peXq32iSyJDMdXJEYUz7qE7jt1R34G+tlLHd3vA4VGIZze97bwcQwQ0PHUI9gn5wyXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSs2UZqTOfO2kkVieHx/gTF7bAMaVb6NL3Tp+rCblSm7ixClrT
	rqBzPwUbf7kptQU083IHq5F+idTfzAbX1H4ImZ3MON8hqtWYwngvCnGiAwjxtYPmzA8Fq4j+Pv4
	T8DJfyhv4B1OVvjD8c9WDjcTYMtadnlC8q7Zg
X-Google-Smtp-Source: AGHT+IG31cBDoRhFPWScbaQzOpQcmmZdOGEaWuSuXkGk1VAZd2FBlgLkb0o49Dh412K3nfiMQSovCDPdJDa1N7PAv9c=
X-Received: by 2002:adf:fdd2:0:b0:37c:c5da:eaf7 with SMTP id
 ffacd0b85a97d-37d0e7a18dcmr4568091f8f.31.1728129597120; Sat, 05 Oct 2024
 04:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155247.2210469-1-gary@garyguo.net> <20241004155247.2210469-4-gary@garyguo.net>
 <OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
 <2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org>
In-Reply-To: <87zfniop6i.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 5 Oct 2024 13:59:44 +0200
Message-ID: <CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Gary Guo <gary@garyguo.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
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
> >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<S=
elf>) {
> >>      /// C `struct request`. If the operation fails, `this` is returne=
d in the
> >>      /// `Err` variant.
> >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request=
, ARef<Self>> {
> >> -        // We can race with `TagSet::tag_to_rq`
> >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_ex=
change(
> >> -            2,
> >> -            0,
> >> -            Ordering::Relaxed,
> >> -            Ordering::Relaxed,
> >> -        ) {
> >> +        // To hand back the ownership, we need the current refcount t=
o be 2.
> >> +        // Since we can race with `TagSet::tag_to_rq`, this needs to =
atomically reduce
> >> +        // refcount to 0. `Refcount` does not provide a way to do thi=
s, so use the underlying
> >> +        // atomics directly.
> >> +        if this
> >> +            .wrapper_ref()
> >> +            .refcount()
> >> +            .as_atomic()
> >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Rela=
xed)
> >> +            .is_err()
> >
> > Why not just call rust_helper_refcount_set()?  Or is the issue that you
> > think you might not be 2 here?  And if you HAVE to be 2, why that magic
> > value (i.e. why not just always be 1 and rely on normal
> > increment/decrement?)
> >
> > I know some refcounts are odd in the kernel, but I don't see where the
> > block layer is caring about 2 as a refcount anywhere, what am I missing=
?
>
> It is in the documentation, rendered version available here [1]. Let me
> know if it is still unclear, then I guess we need to update the docs.
>
> Also, my session from Recipes has a little bit of discussion regarding
> this refcount and it's use [2].
>
> Best regards,
> Andreas
>
>
> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#impl=
ementation-details
> [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685

So it sounds like there is one refcount from the C side, and some
number of references from the Rust side. The function checks whether
there's only one Rust reference left, and if so, takes ownership of
the value, correct?

In that case, the CAS should have an acquire ordering to synchronize
with dropping the refcount 3->2 on another thread. Otherwise, you
might have a data race with the operations that happened just before
the 3->2 refcount drop.

Alice

On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
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
> >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<S=
elf>) {
> >>      /// C `struct request`. If the operation fails, `this` is returne=
d in the
> >>      /// `Err` variant.
> >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request=
, ARef<Self>> {
> >> -        // We can race with `TagSet::tag_to_rq`
> >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_ex=
change(
> >> -            2,
> >> -            0,
> >> -            Ordering::Relaxed,
> >> -            Ordering::Relaxed,
> >> -        ) {
> >> +        // To hand back the ownership, we need the current refcount t=
o be 2.
> >> +        // Since we can race with `TagSet::tag_to_rq`, this needs to =
atomically reduce
> >> +        // refcount to 0. `Refcount` does not provide a way to do thi=
s, so use the underlying
> >> +        // atomics directly.
> >> +        if this
> >> +            .wrapper_ref()
> >> +            .refcount()
> >> +            .as_atomic()
> >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Rela=
xed)
> >> +            .is_err()
> >
> > Why not just call rust_helper_refcount_set()?  Or is the issue that you
> > think you might not be 2 here?  And if you HAVE to be 2, why that magic
> > value (i.e. why not just always be 1 and rely on normal
> > increment/decrement?)
> >
> > I know some refcounts are odd in the kernel, but I don't see where the
> > block layer is caring about 2 as a refcount anywhere, what am I missing=
?
>
> It is in the documentation, rendered version available here [1]. Let me
> know if it is still unclear, then I guess we need to update the docs.
>
> Also, my session from Recipes has a little bit of discussion regarding
> this refcount and it's use [2].
>
> Best regards,
> Andreas
>
>
> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#impl=
ementation-details
> [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685
>
