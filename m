Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22C25B673;
	Wed, 19 Feb 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005663; cv=none; b=E9VHd6BVHcWEWJo6ftOHKNzuEHbT4d5mfvJR/Kpyu9WvkTBHwPUGqkF9V/ebpiWaOESfX5EBijQ3mAOoowcYttMX/GT7BsOP3YW4WkxPuNs91+0eW6OWTgGesSLigGOo0GHOx90hGkTjt1MNm2mk/GED0sg2/UBt/qDsoRZVXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005663; c=relaxed/simple;
	bh=SmoA1B2bjsMbsG3UPv3g9ldXFZ0b6qJlnYfyzogSqf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awLp91Z5fMsueliUHW30vMrcFMZC84Y64rUq2QrbS0DLKwbr5Mp607x3c0LXL0gsbuQ72Bl2CZ1uDeyC2GbXKeGgoYoVFGqBkk+mH83U3q17dRu6nI4C8CqwPQVMyiX019C8BIvQbh/bnR/T7iHgLPF4vcooD7AtfDNWeBUbMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB82Agjr; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB82Agjr"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so2868161fa.0;
        Wed, 19 Feb 2025 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740005660; x=1740610460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHX22YNhVaSe7c/WU9hrS1iKiumjeTo7ppxuugQ7opg=;
        b=JB82AgjrKibBUROqce3TlU3Rj1UYfG+A9Mhjg0jEzPKSD5w48j9Zxey/xzNEFLa9fl
         mbRJmoOTbB8ryWsxkXIlcSPl2/sN7Ciu0BdhDYWnoarEiIbHCmNBM+j1szXLXBq1XRxR
         ZDFQQ7lgd6wgVlMdFnDOAgy06AYBSesvx5MFaJoesn3rV1Dx0Hz9oYm2+tZDYoEY2aZl
         sNmCmjEuvEoQj5v1PRrpdzQs/7v2areNH4Dk/2O+wMk1y+SsWBKJS7hx5Os1UxQ9apZV
         oAM9SokJB1qXaeD/VY29gc8xFHkL3TI2pmvH1vlJykxIa4TtUjmlGdHN9+aY1IRKMtDk
         +NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740005660; x=1740610460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHX22YNhVaSe7c/WU9hrS1iKiumjeTo7ppxuugQ7opg=;
        b=bSYPvQ6cdv1UEiuLKVocUEu/qhYy8ONggPwUs9WVaCSwGwei0Blw57tVtzADJhvEMZ
         UB7XcGD6jxeMCTQTaRmiQn9lT+4s3g98FrPsJkc5HJvIgWiUr+g/kMzLcLImIZZEW6AY
         04ljhMyXUVGRDTe0KOjqLwqf9H+guPzMojET58y88mD6o16XryjR3HMWMWatyTLwEQPW
         VrbRZOCAioqctEbZsHbQByq0G2FyPWgTWjTLZHlqElu0I04sfzm4UZJ2XnGpU9oPKB17
         fZX7zPX+1GL20Keh2yZKTRLl/T83hNQQHyaAIycuwxyLw5nFLXTTArLOt8CJKME3aqHH
         7ieA==
X-Forwarded-Encrypted: i=1; AJvYcCVMLenbY4rIjZrxzMw18Nw47VM7u+OByO2wZAggAdWHhj4WLJqF3zw+T64q0YARSTy43qPNudQTKmrEqWty@vger.kernel.org, AJvYcCX3N98eZ6Yq+G1dBfB3OtvKNwJzcZhNymSRYx/kCh+J1XZhxyiED2af/VYxp9wPQ2h8+SlOIm8qqPTT/g==@vger.kernel.org, AJvYcCXP0CkmEwAd7JD0QBKVwjGtq3WTvmUPbbnqpfVUqLslCOK/3fUzdGxoP8AUF8IqQgOzt6xmSxi6b73ZISgHkxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxub38dQn2bwnZ+SRp1Q3JY/5+zMgpJRP2EfDMmADtUBLHfu1dy
	Nur/oEPWoocQQ3GrhNhd78sXZDBk4PcElCWzGpSR2GZb8HOrzg46T1I174+kVBakg5tfOWX2gPM
	vl28Vghk4vo7EjiKwZQbKJwsW/UG2hVfb++89fg==
X-Gm-Gg: ASbGncvkcbqZ3r/0Jek7+Pn7jJ/PK2esH9kxVIX4oDs+akukKr9M/JYigrBzP7QzFji
	CmL6Q35C2dpFvYllpUeW3S/1WnCNg3l7m1rd7jJACZnK/P00xH+Dbb49qyyT2vOn3yi74RQz3jw
	9k9m/jHoi8iq/z
X-Google-Smtp-Source: AGHT+IE2jelC61hEwn+dvl25yG7wwkubV3vDVjdvhY120Rx4eaCjFgGEXaI82zIrdNnpxbF6+RzM+i4uSZQCUmoJjjA=
X-Received: by 2002:a2e:9d92:0:b0:308:e8d3:7564 with SMTP id
 38308e7fff4ca-30a44dc346emr14116751fa.10.1740005659326; Wed, 19 Feb 2025
 14:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-4-gary@garyguo.net>
 <CAJ-ks9=10h9ha403aqL20Yk+y0oXpgvR=hbxA2+6T_CvbXN2bA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=10h9ha403aqL20Yk+y0oXpgvR=hbxA2+6T_CvbXN2bA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Feb 2025 17:53:43 -0500
X-Gm-Features: AWEUYZk-F9rjXzuZ71mXS7MnLpFlmJw_JqqCoFdXsXu3B2XpuqgoBYO6YwTwJNg
Message-ID: <CAJ-ks9mEqo72Cwq5_BMtdLPjGSb_sQbm_p+TV_u=iNuYSnuPKQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rust: block: convert `block::mq` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, 
	Francesco Zardi <frazar00@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:26=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > Currently there's a custom reference counting in `block::mq`, which use=
s
> > `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> > architectures. We cannot just change it to use 32-bit atomics, because
> > doing so will make it vulnerable to refcount overflow. So switch it to
> > use the kernel refcount `kernel::sync::Refcount` instead.
> >
> > There is an operation needed by `block::mq`, atomically decreasing
> > refcount from 2 to 0, which is not available through refcount.h, so
> > I exposed `Refcount::as_atomic` which allows accessing the refcount
> > directly.
> >
> > Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/kernel/block/mq/operations.rs |  7 +--
> >  rust/kernel/block/mq/request.rs    | 70 ++++++++++--------------------
> >  rust/kernel/sync/refcount.rs       | 14 ++++++
> >  3 files changed, 40 insertions(+), 51 deletions(-)
> >
> > diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/=
operations.rs
> > index 864ff379dc91..c399dcaa6740 100644
> > --- a/rust/kernel/block/mq/operations.rs
> > +++ b/rust/kernel/block/mq/operations.rs
> > @@ -10,9 +10,10 @@
> >      block::mq::Request,
> >      error::{from_result, Result},
> >      prelude::*,
> > +    sync::Refcount,
> >      types::ARef,
> >  };
> > -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic:=
:Ordering};
> > +use core::marker::PhantomData;
> >
> >  /// Implement this trait to interface blk-mq as block devices.
> >  ///
> > @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
> >          let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
> >
> >          // One refcount for the ARef, one for being in flight
> > -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> > +        request.wrapper_ref().refcount().set(2);
> >
> >          // SAFETY:
> >          //  - We own a refcount that we took above. We pass that to `A=
Ref`.
> > @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
> >
> >              // SAFETY: The refcount field is allocated but not initial=
ized, so
> >              // it is valid for writes.
> > -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).wr=
ite(AtomicU64::new(0)) };
> > +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).wr=
ite(Refcount::new(0)) };
>
> Could we just make the field pub and remove refcount_ptr? I believe a
> few callers of `wrapper_ptr` could be replaced with `wrapper_ref`.

I took a stab at this to check it was possible:
https://gist.github.com/tamird/c9de7fa6e54529996f433950268f3f87
