Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A520232368;
	Thu, 29 May 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545873; cv=none; b=tMqEmyWHeiCGkpR4D88HLi4s/xxmwcMpEsRevF0evxWewtSHmPTcClK0w7SS3ox/KWkrilq+E530+fRJ8/IF0zia1xM68BuHKccNCFhO3ESivaUloi020y7SEdc8kJSGGInwVrMWv3kSRUTeO7BVOQIdI2M8VnbMBQ5LxjSdu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545873; c=relaxed/simple;
	bh=ewfvm9AG10NcpYFLSBRgReLeChzHJXRTqAPWFu8ltYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMGbkp0sMRQWP9KAw9IiGYp+PpvEnlAj6GiB4U5RsE3vQ1ycpNakIXx5P/+zZbm6VzsTZAxDCMonzyAXL56H29a66+7KGnmkus17+uD61yj9jjK0Vnl+96kFa21FdZsRjgbVJnfDxZh1hZXyNrXTn4WRq9B7UqaMVvrjzu1YeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV0HGoae; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV0HGoae"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6faa60c983fso11729926d6.2;
        Thu, 29 May 2025 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748545870; x=1749150670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeLAlwcVXUCxgZFIZN3PbutPoyXtuBhygdYPZ4P8Nqk=;
        b=OV0HGoae8++qEfYqsee9oA37dtfWCRYKaCKIR6WlAakynCH7BcNeTVNUHlu/9eqSL8
         dX+MAxTzkT4BcSlfODdzdYPx8Fy9EfKGOOlLHGcHFisICYhqkhUeHvZ+lG+/cQNMxfK1
         atswy3RQ054jLQ3vzYh7vKrutl4Ak/1I/WV61HKHhhpeSbCIejVaB8ODPjBQe15GNL6n
         vcRPLgtFhHWllxjssO44SRwz9cogAFrgHBczy7e8NuXtyoeJBu5oTGdDsdJvzH5xP7nN
         0r9kIOGMG7IAFLyFjw1aT1BAD5Q+e1sw323rxHCjsKNqcPAzssrtQXFtOxO5Hh6A6TBE
         6UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748545870; x=1749150670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeLAlwcVXUCxgZFIZN3PbutPoyXtuBhygdYPZ4P8Nqk=;
        b=wM/WB6wwyI8qQcjWo2sKiDI2fzmwHW3gkdyshmuCnt8Y1jekTLNfeklWHwNZWBXtZk
         Gpt3NuoUH0mTQ38V1iATlb8l2jvDhaWJlNjXRbfnkdnINBxQZl/q6gayR/tve3PzgM7/
         PIMSdtJnozaBdZRduxl9a3ocY74Ym5cpfEF9W7g4yMo40zox4RzWzFkudt2KgBAWUbVY
         fxjEF1SLnKUBazJcOvExoXLUwhvYmbkm2hCO25deXvrbpogkAwz4h+kKkosALmB0o1z+
         EIMPgrjuoB5yMmDNE1P/3ntdudp5Vh54zMM8ZZd8LBSP+uOnfHAY7dH6cgxbxVevSL28
         lPRg==
X-Forwarded-Encrypted: i=1; AJvYcCURWWD15I1PYwHRLW7SpU+XNGU0dRDoVoGvnno69sMG/GpbeP+g1c6u0jc9wPdVqXFZFGYBX5qxQ/cPrA==@vger.kernel.org, AJvYcCUovHyBTvg7q0Ooa7TSzhrPyp9xQIojhteTiacSyb+WIJTn8NvwtyyLj07GOMKDAj/yKB07yU30ZItYyl4l9VQ=@vger.kernel.org, AJvYcCXlyH/VtycsSjFou6xsblh2qjT4Fm1MjyOWnKbgIulG8zpgo2BnIGTLvQ1KUY33AeeFdyi65N9pWXv660zz@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4QxvZUkzXhijVNnS9MYp8eYvLdO+CA3YkLWAkOdQE3lcTakQ
	m75GG/uj4fuLk5iClKX/bjGJYXItGzMXct37FM5vXT7iKYkd9vTxwAXo
X-Gm-Gg: ASbGncs36WvlJ+s0KJ7j4rLDgsLzl8oa2yvkdeMpSG3rcXylAlW/tuGGSCCMLSZAWQe
	X7J5S6eYZ5c5bunJ6CkZ4I24rFgYAFxhzRM+sXY3+kZfa0Z0UM3MZ8p2AMJaWCP4T6LGt8JJugT
	rPLWwR0jd3pvtQY6wPqFBsLzuNkZGTgkvh0DBoHZC3p/MOuzN4qYhiyMue7wNhlQgfPemqks7bw
	JoSuINwObQj1Ovx9iY3TXY9QFtDxPHuFTKr3bp8PU7ZFXNu573mND176YBK3RTvW3yo1pedMEAl
	qfORB9jnrGWnZsFySMvD2Y4aIJmDZYIWCv+Q74jaYRVu4/EJSmME/kgwvUk1tJI6wE4zFW0UDeJ
	DOc/0jQaK66b3OZPKGVsX45p1ZSzGj4gK2lhrx5E1QQ==
X-Google-Smtp-Source: AGHT+IGWjPMtZyJ9npuW5Lc/hC7qcjejDjWYBlfk45fCEcDAzlnVNwVeJ1/HJYt3wXHFINYEIQGsOQ==
X-Received: by 2002:a05:6214:c62:b0:6fa:ce87:2302 with SMTP id 6a1803df08f44-6facebf5b9fmr10913356d6.40.1748545870146;
        Thu, 29 May 2025 12:11:10 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b139sm12470196d6.53.2025.05.29.12.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 12:11:09 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5C0E1200043;
	Thu, 29 May 2025 15:11:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 29 May 2025 15:11:08 -0400
X-ME-Sender: <xms:TLE4aIfy4JC4A5njVtsuPX04aKrnjTaNZQclWKA5MNtXuz1jDEdPiA>
    <xme:TLE4aKOpFrhiHlFTG79IgOKl7fBP0K79ga7OKdQHxble8y8YijXAGKaqRZQOpF-jv
    4NPZWIc4nFzXbfWHQ>
X-ME-Received: <xmr:TLE4aJgEs3GOdYvXG4AF8MJTdpuVi5Qz3PDoEPM9b1sBD4bCR4sQcvXJhJtwjbqrVdDW3IL9f78N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieelgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffdtiefhieeg
    tddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedtieeghedvnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojh
    gvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtg
    hpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthht
    oheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhroh
    hsshesuhhmihgthhdrvgguuhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TLE4aN_wXJBg9GxWKCWGZ-5uMT5wEMWzA7uaHIT4IBhXhjp35vToKQ>
    <xmx:TLE4aEut0qO6qsitJG0yBitd9jM4zTAmQCvLGsRkvXRylt7-f2InqA>
    <xmx:TLE4aEHHb1SklZBlkrGbMuAj8lS16uZ3DoZWYNPyFiAFU0Rw0Ckcww>
    <xmx:TLE4aDPOJeEZwW-b7d7PiyLrDOKlff5NRCxc5_Rncxc2Td6_kXcWsA>
    <xmx:TLE4aJNqDy5ARXMMz7SKP2NAb0yF4lMd5uzm8k9EU-bNErEBpEahGbjJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 15:11:08 -0400 (EDT)
Date: Thu, 29 May 2025 12:11:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] change blanket impls for `[Pin]Init` and add one for
 `Result<T, E>`
Message-ID: <aDixS9Fp-fZxet7m@winterfell.localdomain>
References: <20250529081027.297648-1-lossin@kernel.org>
 <20250529081027.297648-2-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529081027.297648-2-lossin@kernel.org>

On Thu, May 29, 2025 at 10:10:24AM +0200, Benno Lossin wrote:
> Remove the error from the blanket implementations `impl<T, E> Init<T, E>
> for T` (and also for `PinInit`). Add implementations for `Result<T, E>`.
> 
> This allows one to easily construct (un)conditional failing
> initializers. It also improves the compatibility with APIs that do not
> use pin-init, because users can supply a `Result<T, E>` to a  function
> taking an `impl PinInit<T, E>`.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/62/commits/58612514b256c6f4a4a0718be25298410e67387a
> [ Also fix a compile error in block. - Benno ]
> Signed-off-by: Benno Lossin <lossin@kernel.org>

The patch title is missing a "rust:" tag... but you can fix that in PR.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> 
> This patch is also needed by Danilo for initializing `Devres`
> ergonomically.
> 
> ---
>  rust/kernel/block/mq/tag_set.rs | 12 +++++++-----
>  rust/pin-init/src/lib.rs        | 30 ++++++++++++++++++++++++++----
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
> index bcf4214ad149..c3cf56d52bee 100644
> --- a/rust/kernel/block/mq/tag_set.rs
> +++ b/rust/kernel/block/mq/tag_set.rs
> @@ -9,7 +9,7 @@
>  use crate::{
>      bindings,
>      block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
> -    error,
> +    error::{self, Result},
>      prelude::try_pin_init,
>      types::Opaque,
>  };
> @@ -41,7 +41,7 @@ pub fn new(
>          // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
>          // all are allowed to be 0.
>          let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
> -        let tag_set = core::mem::size_of::<RequestDataWrapper>()
> +        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
>              .try_into()
>              .map(|cmd_size| {
>                  bindings::blk_mq_tag_set {
> @@ -56,12 +56,14 @@ pub fn new(
>                      nr_maps: num_maps,
>                      ..tag_set
>                  }
> -            });
> +            })
> +            .map(Opaque::new)
> +            .map_err(|e| e.into());
>  
>          try_pin_init!(TagSet {
> -            inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_set?), |tag_set| {
> +            inner <- tag_set.pin_chain(|tag_set| {
>                  // SAFETY: we do not move out of `tag_set`.
> -                let tag_set = unsafe { Pin::get_unchecked_mut(tag_set) };
> +                let tag_set: &mut Opaque<_> = unsafe { Pin::get_unchecked_mut(tag_set) };
>                  // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
>                  error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
>              }),
> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index d1c3ca5cfff4..f4e034497cdd 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -1391,8 +1391,8 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
>  }
>  
>  // SAFETY: the `__init` function always returns `Ok(())` and initializes every field of `slot`.
> -unsafe impl<T, E> Init<T, E> for T {
> -    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
> +unsafe impl<T> Init<T> for T {
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
>          // SAFETY: `slot` is valid for writes by the safety requirements of this function.
>          unsafe { slot.write(self) };
>          Ok(())
> @@ -1401,14 +1401,36 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
>  
>  // SAFETY: the `__pinned_init` function always returns `Ok(())` and initializes every field of
>  // `slot`. Additionally, all pinning invariants of `T` are upheld.
> -unsafe impl<T, E> PinInit<T, E> for T {
> -    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +unsafe impl<T> PinInit<T> for T {
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), Infallible> {
>          // SAFETY: `slot` is valid for writes by the safety requirements of this function.
>          unsafe { slot.write(self) };
>          Ok(())
>      }
>  }
>  
> +// SAFETY: when the `__init` function returns with
> +// - `Ok(())`, `slot` was initialized and all pinned invariants of `T` are upheld.
> +// - `Err(err)`, slot was not written to.
> +unsafe impl<T, E> Init<T, E> for Result<T, E> {
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
> +        // SAFETY: `slot` is valid for writes by the safety requirements of this function.
> +        unsafe { slot.write(self?) };
> +        Ok(())
> +    }
> +}
> +
> +// SAFETY: when the `__pinned_init` function returns with
> +// - `Ok(())`, `slot` was initialized and all pinned invariants of `T` are upheld.
> +// - `Err(err)`, slot was not written to.
> +unsafe impl<T, E> PinInit<T, E> for Result<T, E> {
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        // SAFETY: `slot` is valid for writes by the safety requirements of this function.
> +        unsafe { slot.write(self?) };
> +        Ok(())
> +    }
> +}
> +
>  /// Smart pointer containing uninitialized memory and that can write a value.
>  pub trait InPlaceWrite<T> {
>      /// The type `Self` turns into when the contents are initialized.
> -- 
> 2.49.0
> 
