Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7442069;
	Fri,  7 Feb 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738969799; cv=none; b=TOrGAbMsnE3tRtKPhuWd6Getnst7wJZVavDOuvRCAP72jHlfuESCaO1/Yg2cuRgEWYbEvzMST16OAAlUFqCO/6NkdBeEs+Pt5uyEjRFLHcZzcMAZPfe+ktKowZWYgyVnUhlez6LH+Aq2Vuhxstx9WQ25xuyEDUn+wHl6mDoMoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738969799; c=relaxed/simple;
	bh=/Yp7ZJpGPQmp4bEwda1sB9l/+PqFgbJYDa39eFAXlVo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCInZ+2G4VOPcE60JbPAJoL0vS/g3GSQsnyRoiaWtZCGvx6M1kTdGmdSIA+n2iKN8XXaIIGRRd4od1xwhpJXB6VdKk8Y3Wv5x2x7FlLfYpWpE8rfAku0XOEopwk2c6Yt+TMg0Kp9FlWZkz9fbkufYxjqOkws1iWudQ6R8QlETyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKnGVuOC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKnGVuOC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f62cc4088so12096605ad.3;
        Fri, 07 Feb 2025 15:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738969797; x=1739574597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MhO99/eteMaPIVe6GI+++EyOVf+2+1bV62N2Jw9ys84=;
        b=HKnGVuOC0lLqiitSXtufoyprVmc29gQb6In1WjHgmbi4PPU2Mf1fixei/G6NPp5ciT
         1Dn+LQLmv9aCjJ7qwkaMu64kWw0zMjIBdEu43mX9NdiOp8z0Pks+/WrlthQJ3hfKrjpX
         n/7pVke8NlizLI6jETbT9EAofv9krloh56ljBFHiSjJRv9ijnET0xEI/dr5ctq8rIVJ2
         Qq731Piib5Z9Zva7vbCy5dyODlA2yaez8kfOwrV/olWtf+3AEoTftDul8hjDqIoG5GJq
         JR4m1zG95khlBNo3knVEYQoyPqreQvywDqH3U5VregjMCVPghYkassU64F3CDrLyAv/8
         fD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738969797; x=1739574597;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhO99/eteMaPIVe6GI+++EyOVf+2+1bV62N2Jw9ys84=;
        b=c8i30KkAsna6CZ7WDQ+QmJ9UjjuSPDdCuxhdnS2ebI8nCC0wF1ALzGuCXdWCtfkmm8
         Vd5nnlVAjRjTqmcxD343iqz5F0chv7000AA+DnmM2Rl71fHRUxaFcaXbYg/Z26nLkVlX
         bUo2eGJEPAFSc5kEPGhL+qSJP/h8SgXd5p8s0zPDp4XcZzO4F9TZLmAQiM2vK4kfqMN7
         WoZ5nje8Vce+Ebn51Tk7pHM1+Vtt1q6c54rqoaVBBcc1GJHiR8m9LRDz6vVglAu6NTGx
         /L64dmnZHS+ED/i+srMJaDBmlT6ppupAykvOTjY1c17rC0hEoM58t1vPCB5eixAsL/Zw
         h2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWChqUzUNjWTJLKPJplsevC4vpmxH+OsbilzoSUUuw3cU2A4QZ5c+TNDFoeDZonjNa/yRPXKmJORZZJNzqA@vger.kernel.org, AJvYcCWkfZu8GzW9f7HXPI6oo5Y3h0OIJWlDIAP6XXI4IQF13fFNlnE/tto8lu6KQmuTelKCL5BuOgOLKcJ+qq6EW64=@vger.kernel.org, AJvYcCWm8IgK7nei5X1TqT2vR6ucZuOsRIUFWovv0m9Okl0pXt3FVHNK3cSax6yVLuGr6w54gDgeLvKQ4pyOIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySXFhmYsvNOnGlk7LN2G9Wrr0HgNheAmmpbLGGxRtWG4bQYICE
	olLhF5JNuBnY/lU9nBmSaK7sUxJS1fqeZdDQ7ouYoybDCaQ7Di7d
X-Gm-Gg: ASbGncuTp46zAc02SrSx1t8cI2VBAKCGkA5b7/8I1x5YhObz3JDr/fYdMGyVZ6ukAcT
	M/XScgUlLXwwjL+cGxNfu8hM8YQdAIUSra9/m37HR8/Mabo6EPJScQUEPYd6rrJz/7P67zuMFe9
	Hqrp0w63WG5QQ7TypNv8EN6Do6d9Q6/mTn9GBimNA1yKwR69aFUKY73nxw+YL48kTA5YGa8NZE1
	Eo9AMlpomrQGkQFdu1VKir+odrZTe0WI7M0VYynjk9lN168vHoAAVPF35Q9SjJ2Re1Pk5UQm/Up
	ibRTHTw3jj771HO0Tejth5YYgaYLzrYuAF7BDW6MwCvi1fNqjg==
X-Google-Smtp-Source: AGHT+IGbDFlwC8N9VIVqNQfx3apRhN3KFYWk764cgpokFTV4t2pm1BwPud+R0YDG6Ie3Vh4P96rU7Q==
X-Received: by 2002:a05:6a21:a342:b0:1ed:e7f0:312d with SMTP id adf61e73a8af0-1ee03b605a5mr9932598637.35.1738969796976;
        Fri, 07 Feb 2025 15:09:56 -0800 (PST)
Received: from Cyndaquil. (203.sub-174-224-192.myvzw.com. [174.224.192.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f84sm3548355b3a.80.2025.02.07.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:09:56 -0800 (PST)
Message-ID: <67a692c4.a70a0220.387922.d940@mx.google.com>
X-Google-Original-Message-ID: <Z6aSwnyUNDG85sNB@Cyndaquil.>
Date: Fri, 7 Feb 2025 15:09:54 -0800
From: Mitchell Levy <levymitchell0@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: lockdep: Use Pin for all LockClassKey usages
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
 <20250205-rust-lockdep-v3-2-5313e83a0bef@gmail.com>
 <19dfbe36-237c-4da8-acfb-1d14069a8d1c@proton.me>
 <Z6UpNpefdxyvYBPe@boqun-archlinux>
 <7bc31b4e-cfe2-40ff-9a00-a73bff64df1c@proton.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc31b4e-cfe2-40ff-9a00-a73bff64df1c@proton.me>

On Fri, Feb 07, 2025 at 12:22:19AM +0000, Benno Lossin wrote:
> On 06.02.25 22:27, Boqun Feng wrote:
> > On Wed, Feb 05, 2025 at 08:30:50PM +0000, Benno Lossin wrote:
> >> On 05.02.25 20:59, Mitchell Levy wrote:
> >>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> >>> index 41dcddac69e2..119e5f569bdb 100644
> >>> --- a/rust/kernel/sync/lock.rs
> >>> +++ b/rust/kernel/sync/lock.rs
> >>> @@ -7,12 +7,9 @@
> >>>
> >>>  use super::LockClassKey;
> >>>  use crate::{
> >>> -    init::PinInit,
> >>> -    pin_init,
> >>> -    str::CStr,
> >>> -    types::{NotThreadSafe, Opaque, ScopeGuard},
> >>> +    init::PinInit, pin_init, str::CStr, types::NotThreadSafe, types::Opaque, types::ScopeGuard,
> >>>  };
> >>> -use core::{cell::UnsafeCell, marker::PhantomPinned};
> >>> +use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
> >>>  use macros::pin_data;
> >>>
> >>>  pub mod mutex;
> >>> @@ -121,7 +118,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
> >>>
> >>>  impl<T, B: Backend> Lock<T, B> {
> >>>      /// Constructs a new lock initialiser.
> >>> -    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> >>> +    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
> >>
> >> Static references do not need `Pin`, since `Pin::static_ref` [1] exists,
> >> so you can just as well not add the `Pin` here and the other places
> >> where you have `Pin<&'static T>`.
> >>
> > 
> > You're right about `Pin` not needed for 'static. However, the
> > `Pin<&'static LockClassKey>` signature is the intermediate state, and
> > eventually we will need to support initializing a lock (and others) with
> > a dynamically allocated `LockClassKey`, and when that is available, the
> > type of `key` will become `Pin<&'a LockClassKey>`, so `Pin` is needed.
> > 
> > So I would like to keep this patch as it is. Works for you?
> 
> Makes sense and fine by me. It would be nice if it was also mentioned in
> the commit message. Thanks!

This makes sense and is a good point. Will resend with a fixed commit
message.

Thanks,
Mitchell

> ---
> Cheers,
> Benno
> 
> > 
> > Regards,
> > Boqun
> > 
> >> The reasoning is that since the data lives for `'static` at that
> >> location, it will never move (since it is borrowed for `'static` after
> >> all).
> >>
> >> [1]: https://doc.rust-lang.org/std/pin/struct.Pin.html#method.static_ref
> >>
> >> ---
> >> Cheers,
> >> Benno
> >>
> >>>          pin_init!(Self {
> >>>              data: UnsafeCell::new(t),
> >>>              _pin: PhantomPinned,
> >>> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
> >>> index 480ee724e3cc..d65f94b5caf2 100644
> >>> --- a/rust/kernel/sync/lock/global.rs
> >>> +++ b/rust/kernel/sync/lock/global.rs
> >>> @@ -13,6 +13,7 @@
> >>>  use core::{
> >>>      cell::UnsafeCell,
> >>>      marker::{PhantomData, PhantomPinned},
> >>> +    pin::Pin,
> >>>  };
> >>>
> >>>  /// Trait implemented for marker types for global locks.
> >>
> >>
> 
