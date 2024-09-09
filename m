Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAD1487E2
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899840; cv=none; b=Z9YwKemnahMaEsmyXs3U6hHUHnG+IqmsQSSMOo6ny6Q24+Bb96+rcDPmiODvXXzpTuEWdRp+QfT5m8b6KhfzgT6t9f18cVE6VcP2gul3IuUNZO2zvRsO1Ql2Anct+zE3c/RDrgE+aHATCfCPJfKncUjZ8v+UFVclzqTrG3Onzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899840; c=relaxed/simple;
	bh=Vor9A51MY4LbHBQym1omjXXtWBlRMHBeYzCg0Ctn6GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMuYZSrp6h6HySUR1Ix02mKWx6rmH6pwDGIyBkyijBma6cR+x9kBgHVntO0EN16eHcQPd/DvVXJT72VPMkEs+/p5r/+iUAMtk1X9j1GqfSQxt3zJ1xYyqiSsEx82OI9XT+tYqulkMIv/hSgkPH8GotV5vrz9nh3Ee6MLZxT9MA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyMk5ex8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyMk5ex8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb2191107so13031185e9.1
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2024 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725899836; x=1726504636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVb7FZalp+hymwW1x9wgZGuiq1blreq92SNrbnhzt/U=;
        b=HyMk5ex8ajDB02NENOTjzqHs6Q87jKZQHT/TsJsGbjSjx+fcVy/wSoRv0pM0LzgoIe
         Zftjt+EFR9hfpTHdxG23nM64LdlC166ccGN+XKoe5Ehlpgmux2CmYGqZf9bkAElx+u7h
         OC+Fjo2Ki20yIMaOLZ8FwVB5OtH/ZwEJL7OOf7fI0SQECcTPyVljCaTNbCLgKHBB2wLT
         jeYZxafML4M5ap1/99RmvoT+RaVHsEryZab00PjxhX+RbMbS9PVF8sm74NaTw5UPWAQG
         coAmlAMmw70B7daoPIMCXubUbKKDOAr4PENt5yYDL7c7V29vskeGpcakMSQfUEkn1ex4
         eOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899836; x=1726504636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVb7FZalp+hymwW1x9wgZGuiq1blreq92SNrbnhzt/U=;
        b=r9I5s8uaTf4TuVj0Fvfwfo1SY9PAFKCnPf/o5IhosnzhrlZjvJbzAZUGYYj8ZPyntM
         rWTwecUrLBvJ46CIi4uqp9etMgmvndooToJtlGY/QSC4nXkGBQuoSpouf/M1DfOr0w64
         I6GzL4ojsLc0msbq7tSCIqHQXAAK87gnWkpWR0NEmk/zDkM8Cd48dmNuQWtlK8OLCISN
         lf0itbRLcpDmxYLZ4AaCgpdN6ewT1qRWt51YEYyvRbvzu4YOYPr5djmaD/C0y9KJxVEr
         OAH3Q2keYHKTFg4QpZ09AJ4/5Pj2mM4Hwu4OMjYu1QiyzV9uWmjY3mv0/wHFW9Nfsyq7
         VhOw==
X-Forwarded-Encrypted: i=1; AJvYcCUIaxpWB88fXBnR5JuTqwDDkIsyhiN097jjIV/uE/qsll7R8rnXCSLs/iQdWIwhERtlTD7+81AfR6Qofg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GoE+bpEwQN2wjNsN404LoQSxPcmhnelzHWM7NZDy+fXlCq79
	cTCGVNFNqqZ/JYfMyQyiSRkYHm8R5xzcSo6HWhvX9km5wDuHoO4z2H1bjq0QjLKz9fVn6SRUjtt
	dkLotc4KA83G+zcBpTYXClynj+dgm++pkECRTQMLdFqztElcTpIyTjyQ=
X-Google-Smtp-Source: AGHT+IFqGpX0VmbgWSC7nk1slW1l+OrKUWEzp/PMlH2GO3N0F90G8DHQsjE9OjeSQ5wBmNMyvA/uZ9VRq3o5WHdPitE=
X-Received: by 2002:a05:6000:d8d:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-378926858a7mr5320757f8f.5.1725899836155; Mon, 09 Sep 2024
 09:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
In-Reply-To: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Sep 2024 18:37:04 +0200
Message-ID: <CAH5fLgj6aCNxXfANt-0duhMfujQdOip9AjtX5yRraXQ5QaDReA@mail.gmail.com>
Subject: Re: [PATCH RFC] rust: lockdep: Use Pin for all LockClassKey usages
To: levymitchell0@gmail.com
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:13=E2=80=AFAM Mitchell Levy via B4 Relay
<devnull+levymitchell0.gmail.com@kernel.org> wrote:
>
> From: Mitchell Levy <levymitchell0@gmail.com>
>
> The current LockClassKey API has soundness issues related to the use of
> dynamically allocated LockClassKeys. In particular, these keys can be
> used without being registered and don't have address stability.
>
> This fixes the issue by using Pin<&LockClassKey> and properly
> registering/deregistering the keys on init/drop.
>
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-1-nmi=
@metaspace.dk/
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
> This change is based on applying the linked patch to the top of
> rust-next.
>
> I'm sending this as an RFC because I'm not sure that using
> Pin<&'static LockClassKey> is appropriate as the parameter for, e.g.,
> Work::new. This should preclude using dynamically allocated
> LockClassKeys here, which might not be desirable. Unfortunately, using
> Pin<&'a LockClassKey> creates other headaches as the compiler then
> requires that T and PinImpl<Self> be bounded by 'a, which also seems
> undesirable. I would be especially interested in feedback/ideas along
> these lines.

I think what should happen here is split this into two commits:

1. Get rid of LockClassKey::new so that the only constructor is the
`static_lock_class!` macro. Backport this change to stable kernels.
2. Everything else you have as-is.

Everything that takes a lock class key right now takes it by &'static
so they technically don't need to be wrapped in Pin (see
Pin::static_ref), but I don't mind making this change to pave the way
for LockClassKeys that don't live forever in the future.

The patch *does* introduce the ability to create LockClassKeys, but
they're only usable if they are leaked.

Alice

> -        T: WorkItem<ID>,
> +        T: WorkItem<ID>

Spurious change?
