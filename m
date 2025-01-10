Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253720FAA8;
	Fri, 10 Jan 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518255; cv=none; b=j99E10KhmOyKP78sBZshXgEE+9IlAwdXoZEp3ugVnQDSevLbhZ4aHtMrV36tf9ilIDQkZ/dbNq2Od2Yt5l6baNwkQTAtowolbIUxYyg5fNpYodUQxca6m2O4MnwxLItciPzjYzloUILIU/21CN5ncHAFwXVrvfuzFPjOnRdhlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518255; c=relaxed/simple;
	bh=prYE8lJKBKfZFFTkbJhe+mbET5uq2vtviQ3+iBLCXgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKtf5TEmQxiTTWEUz7tS2RszaG4TgiINcLJgvaqcv+QGTXiC9slLZdssQKHHNiDNJuenvaofcIzBw346g5f7oksLxmBBoKK9CTj2VsRoLykowctotRwlRGXeV0pnuG9/RG843QbcDllAdQkoYmgFivnDpr2Y+EnBmUNeHW41V9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kltxmgQO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kltxmgQO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6c3629816so114035585a.1;
        Fri, 10 Jan 2025 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736518252; x=1737123052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n25fGlO9SMtdY7i71AsvjTmeLMMpMqqv9HUeRX+xSdE=;
        b=kltxmgQOdWyXyPTR7V+EDwzh7prYT0xGePdUiESIB60k0N+7LbSro3EjUrCDssnC01
         Yydlq1EZcZnhWTtguF2iX3fjHN1K9TUuSI04/xTKDUbRHb6IpCX6vdXPUM8zMw5S8+zu
         fjEDfkfiI4uPihf5rwak7oADYIbSVKRfyvmvC+u+3XCl54eYSe5MUCP1mrteKgYukllg
         wDSYZ59okrZF/LIb2StrYOa4mjylkUQeqXkK9suyaLFWabvgKOaWjqh3SB2mOcoDTVis
         2J7bQNEKz9DWerpFtr7RTFyx6b+ftdAHtcskQNLYHr+HcjnU178yC/cb2p1iViMOkgdX
         aCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518252; x=1737123052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n25fGlO9SMtdY7i71AsvjTmeLMMpMqqv9HUeRX+xSdE=;
        b=w1JqC3EXdEV2YMwa4P9AG0U6qVDksqA1a2p6aoitDllBPifHCr6ZwDtYqFh3FHb+tW
         n4/hv16fDPzMHsuHHB5CmY6ZH5wGL9nO5pBACuWazTvYzkuc/cF6QnlOgsrh5oHEkvy2
         cRdOcgoRxa7o7u1IZ1OaQiSr6ieF9YSUlEjjWQmpLJ8aBWe7/Pp+k+z3gvOSQ9bnmn4J
         9xUnJ8xZybV53SZpU/Fk/ty9coJ4UhS0Qq9WT0TUCS08OKqDhyaW6sXxtk5ijn4ua0fD
         fSP3+opGCozDTdyPYU/GIFBMn/H/MAwWY/aK1Z0ocVSPLeDFTyW+/qL6UvFkA00q2A5A
         l0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbrdJD6lBcoBd4yrEiGt7Q6XwovcfpDPl0fksMwnvw9zPKYy/Z7lHT8N5cicjrPlVOtfP7L30O1TDFfA==@vger.kernel.org, AJvYcCWf5FPyYuufmpuazxpN1pnmaCzYa3TcaFPlp+HgyTf3UXjoftMaqIwi5EATa/kqeDmTNEoLoLCZLBon0qwH@vger.kernel.org, AJvYcCX9d80sV4YTeDQkUZXF/jn7GJrdH60GmfIGPGzHPiuKvITrHcNmSljkF+gVn4PaCJW4nJEe4P86+2TOFObgK8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YybeZ0UevZejEkglmxRbVl3cBtT7+yxjnk18Aqq3AqZbzDlx8pP
	Wi/wvF0m83LGpz/nb2Nt7fB3IVVv+2DoyVClXK4UF4TstFMmT8JB
X-Gm-Gg: ASbGnct+YglhWNls2fiAOVZWkzIn14BziLX3SrrTCERV88Y4Zs8rI6Pr7/HNBCzyMEC
	WueUGJy44CUuFb3hgeA7xNScpCVAE9B90DXVDaPlnrOMNgqOGCfgrkZ6bRRmAlw6quPEyQq/RT1
	vMdVk1G/SpaZ13wpqiBJ+Ac8QjAstMX/Yj3LW/mR5s390c5KWcdHWU2f7YFV+R5BcJQjYzCeohJ
	/T85/U3QtHvAwWxZc0NlOgpcw9QUMaY0y1ZrCQjmYuPDkfeCqw8+rfq2cc/cnqpOF/9mHAAMB4r
	aUbzzzzWCiN8bm0uOiWcO+58bK8QX0ZSn2oqi7JEbi85Ku0=
X-Google-Smtp-Source: AGHT+IExxyfyP3pzF/qLgEJzag8KrRVXiPeoKTsSEhGVAiY9TgR2Lu0YsU2BSoEv8zo/4k9I/qCoQQ==
X-Received: by 2002:a05:620a:4095:b0:7b6:6b88:cc00 with SMTP id af79cd13be357-7bcd96e8d37mr1905707685a.5.1736518251914;
        Fri, 10 Jan 2025 06:10:51 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce32381absm176809885a.8.2025.01.10.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:10:51 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EB2C4120006D;
	Fri, 10 Jan 2025 09:10:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jan 2025 09:10:50 -0500
X-ME-Sender: <xms:aiqBZ9gv4sVXb0bEJQsPpmhMT4Xkh93NnPdVCx05o8NOmrVTxaI3fg>
    <xme:aiqBZyCLYCs8Q2zy3DNJE2hnQai9bKK-3ku_JooqZ05Ytms38lNfFXKXvdqcXDUb9
    5b_PPh0F7yF63zNDg>
X-ME-Received: <xmr:aiqBZ9FU-i2R9RMBGDKTkLZmmjLzQse4ez0Jg0oEi8F9-mYJviEPsMtaDko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefh
    hffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgvvhihmhhithgthhgvlhhltdesghhmrghilhdrtghomhdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnh
    efpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhho
    shhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:aiqBZyRPWS82oF8ulKg7_2pGKl4fydTndM2AxPGKK3WWw_01DXHzhg>
    <xmx:aiqBZ6zOlM9lcskOYZYYm2eIvCh5UiJFechm9PNGwKneIffVlelCyA>
    <xmx:aiqBZ44jgUOzPv3I2kCEeNCYtiPo-v9fsbYU_Z0zBvd25zNQ1ZWdnA>
    <xmx:aiqBZ_xIcyGBrMjfolFTqh6b4Jo64ByMTKyp3EGLKSJoAsaQgK2buA>
    <xmx:aiqBZyhIqao_p2g1pn1pBfzrfqp2-dc6TuVN599lE6zU5d8oGeO03U7p>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 09:10:50 -0500 (EST)
Date: Fri, 10 Jan 2025 06:09:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: lockdep: Use Pin for all LockClassKey usages
Message-ID: <Z4EqKlucyepSsENy@boqun-archlinux>
References: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
 <20241219-rust-lockdep-v2-2-f65308fbc5ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-rust-lockdep-v2-2-f65308fbc5ca@gmail.com>

On Thu, Dec 19, 2024 at 12:58:56PM -0800, Mitchell Levy wrote:
> Reintroduce dynamically-allocated LockClassKeys such that they are
> automatically (de)registered. Require that all usages of LockClassKeys
> ensure that they are Pin'd.
> 
> Closes: https://github.com/Rust-for-Linux/linux/issues/1102
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/sync.c             | 13 ++++++++++
>  rust/kernel/sync.rs             | 57 ++++++++++++++++++++++++++++++++++++++---
>  rust/kernel/sync/condvar.rs     |  5 ++--
>  rust/kernel/sync/lock.rs        |  9 +++----
>  rust/kernel/sync/lock/global.rs |  5 ++--
>  rust/kernel/sync/poll.rs        |  2 +-
>  rust/kernel/workqueue.rs        |  3 ++-
>  8 files changed, 79 insertions(+), 16 deletions(-)
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index dcf827a61b52..572af343212c 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -25,6 +25,7 @@
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> +#include "sync.c"
>  #include "task.c"
>  #include "uaccess.c"
>  #include "vmalloc.c"
> diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
> new file mode 100644
> index 000000000000..ff7e68b48810
> --- /dev/null
> +++ b/rust/helpers/sync.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/lockdep.h>
> +
> +void rust_helper_lockdep_register_key(struct lock_class_key *k)
> +{
> +	lockdep_register_key(k);
> +}
> +
> +void rust_helper_lockdep_unregister_key(struct lock_class_key *k)
> +{
> +	lockdep_unregister_key(k);
> +}
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index ae16bfd98de2..13bfdc647c5b 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,8 @@
>  //! This module contains the kernel APIs related to synchronisation that have been ported or
>  //! wrapped for usage by Rust code in the kernel.
>  
> +use crate::pin_init;
> +use crate::prelude::*;
>  use crate::types::Opaque;
>  
>  mod arc;
> @@ -22,15 +24,64 @@
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>  #[repr(transparent)]
> -pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> +#[pin_data(PinnedDrop)]
> +pub struct LockClassKey {
> +    #[pin]
> +    inner: Opaque<bindings::lock_class_key>,
> +}
>  
>  // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
>  // provides its own synchronization.
>  unsafe impl Sync for LockClassKey {}
>  
>  impl LockClassKey {
> +    /// Initializes a dynamically allocated lock class key. In the common case of using a
> +    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
> +    ///
> +    /// # Example
> +    /// ```
> +    /// # use kernel::{c_str, stack_pin_init};
> +    /// # use kernel::alloc::KBox;
> +    /// # use kernel::types::ForeignOwnable;
> +    /// # use kernel::sync::{LockClassKey, SpinLock};
> +    ///
> +    /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
> +    /// let key_ptr = key.into_foreign();
> +    ///
> +    /// // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose `from_foreign()` has
> +    /// // not yet been called.
> +    /// stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
> +    ///     0,
> +    ///     c_str!("my_spinlock"),

Clippy complains the following unsafe block doesn't have a safety
comment, please move the above safety comment here.

> +    ///     unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
> +    /// ));
> +    ///
> +    /// drop(num);

Also clippy doesn't like using drop() on types that don't impl `Drop`,
we may need to create an extra scope to make clippy happy (in the same
time it makes no user on `key` anymore, like:

    /// {
    ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
    ///         0,
    ///         c_str!("my_spinlock"),
    ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose `from_foreign()` has
    ///         // not yet been called.
    ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
    ///     ));
    /// }

Make sure to update the comments and format the code afterwards.

Thanks!

Regards,
Boqun

> +    ///
> +    /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
> +    /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
> +    /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn new_dynamic() -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            // SAFETY: lockdep_register_key expects an uninitialized block of memory
> +            inner <- Opaque::ffi_init(|slot| unsafe { bindings::lockdep_register_key(slot) })
> +        })
> +    }
> +
>      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> -        self.0.get()
> +        self.inner.get()
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for LockClassKey {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
> +        // hasn't changed. Thus, it's safe to pass to unregister.
> +        unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
>      }
>  }
>  
> @@ -43,7 +94,7 @@ macro_rules! static_lock_class {
>          // lock_class_key
>          static CLASS: $crate::sync::LockClassKey =
>              unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
> -        &CLASS
> +        $crate::prelude::Pin::static_ref(&CLASS)
>      }};
>  }
>  
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 7df565038d7d..29289ccf55cc 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -15,8 +15,7 @@
>      time::Jiffies,
>      types::Opaque,
>  };
> -use core::marker::PhantomPinned;
> -use core::ptr;
> +use core::{marker::PhantomPinned, pin::Pin, ptr};
>  use macros::pin_data;
>  
>  /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
> @@ -101,7 +100,7 @@ unsafe impl Sync for CondVar {}
>  
>  impl CondVar {
>      /// Constructs a new condvar initialiser.
> -    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
>          pin_init!(Self {
>              _pin: PhantomPinned,
>              // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 41dcddac69e2..119e5f569bdb 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,12 +7,9 @@
>  
>  use super::LockClassKey;
>  use crate::{
> -    init::PinInit,
> -    pin_init,
> -    str::CStr,
> -    types::{NotThreadSafe, Opaque, ScopeGuard},
> +    init::PinInit, pin_init, str::CStr, types::NotThreadSafe, types::Opaque, types::ScopeGuard,
>  };
> -use core::{cell::UnsafeCell, marker::PhantomPinned};
> +use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
>  use macros::pin_data;
>  
>  pub mod mutex;
> @@ -121,7 +118,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
>  
>  impl<T, B: Backend> Lock<T, B> {
>      /// Constructs a new lock initialiser.
> -    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
>          pin_init!(Self {
>              data: UnsafeCell::new(t),
>              _pin: PhantomPinned,
> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
> index 480ee724e3cc..d65f94b5caf2 100644
> --- a/rust/kernel/sync/lock/global.rs
> +++ b/rust/kernel/sync/lock/global.rs
> @@ -13,6 +13,7 @@
>  use core::{
>      cell::UnsafeCell,
>      marker::{PhantomData, PhantomPinned},
> +    pin::Pin,
>  };
>  
>  /// Trait implemented for marker types for global locks.
> @@ -26,7 +27,7 @@ pub trait GlobalLockBackend {
>      /// The backend used for this global lock.
>      type Backend: Backend + 'static;
>      /// The class for this global lock.
> -    fn get_lock_class() -> &'static LockClassKey;
> +    fn get_lock_class() -> Pin<&'static LockClassKey>;
>  }
>  
>  /// Type used for global locks.
> @@ -270,7 +271,7 @@ impl $crate::sync::lock::GlobalLockBackend for $name {
>              type Item = $valuety;
>              type Backend = $crate::global_lock_inner!(backend $kind);
>  
> -            fn get_lock_class() -> &'static $crate::sync::LockClassKey {
> +            fn get_lock_class() -> Pin<&'static $crate::sync::LockClassKey> {
>                  $crate::static_lock_class!()
>              }
>          }
> diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
> index d5f17153b424..c4934f82d68b 100644
> --- a/rust/kernel/sync/poll.rs
> +++ b/rust/kernel/sync/poll.rs
> @@ -89,7 +89,7 @@ pub struct PollCondVar {
>  
>  impl PollCondVar {
>      /// Constructs a new condvar initialiser.
> -    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
>          pin_init!(Self {
>              inner <- CondVar::new(name, key),
>          })
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 1dcd53478edd..f8f2f971f985 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -369,7 +369,8 @@ unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
>  impl<T: ?Sized, const ID: u64> Work<T, ID> {
>      /// Creates a new instance of [`Work`].
>      #[inline]
> -    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self>
>      where
>          T: WorkItem<ID>,
>      {
> 
> -- 
> 2.34.1
> 
