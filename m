Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D60390C87
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662131; cv=none; b=dURSEgb7nFbRlPOLtUNPDV5t4u+21tjX6xLMWxcpPtxLwiCmSd6QUj572E6mf8jONOni2ho/jsQyjzTXzjDLpDm4VcdGbTeAgYpJDnTHqm5U71msuxvGZzN/27cvOLfHgfioaw1hjyBenZADkowNvPw7F72MEeOlI9lf8qbd43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662131; c=relaxed/simple;
	bh=yJP54nruYNhofJzmaTkgLS9aZcjVp3qA0UJSc13Kp24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oeH9F8+QE98/LTLKe66qP1D0KYXrYRMHQNzdwr7tK/rLVpHzvAzFKKpXTujKfWeGe1+oeGWHgbOMSQ6wUsqqCsA8uZJJh+ttOURMjfLB9xUd/ppqRlZNOba3Gj7pRSucjAc0qn0HLnJb3eeuEg1eey/zWS6mmunOFHO7iy//gWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emvdX+2u; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emvdX+2u"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso61668625e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773662128; x=1774266928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob9tzx0aj2zeHdgbk4mDLaOraCCBLId3s0T7A6CDOE4=;
        b=emvdX+2uOEc2kmkIU3/yOp+rMddbQBN4NUPqAuaRCk9nlex1NleCVWZGJRH9Ylyklc
         NBKbVorgi6zLDMiUompJ9boEdUqatngT0YFZhlPZudr5zNnDK4RbPCPZDBlV3URs4w/+
         Ym9TeutAvnulKb8IfuuQdad5UMKa84ch2jMbWnmPtKE51WnMMM/2BZhW3e9zB+7oRBxW
         35ty3XgMbQ2v2JE7o18Y5A90A4nZic4D0QgsfZ/nORoObhWv9JV1JlXf+nyhMtsD36Cs
         qBXUFXLZH7BaH0f3pKF3UfBeV87a6UxyU4C3lLnPE9QjfJhtImkdfzwYz1SOQdw5Tl+Q
         x5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662128; x=1774266928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob9tzx0aj2zeHdgbk4mDLaOraCCBLId3s0T7A6CDOE4=;
        b=frvRyd7/mH/heOcA3LvBqhnqWYv9rlvmrcF9Z3aLrIfXpCZVTFMLOpSId09GwKxmIO
         PBy/HTYmzmdcB5bDA5yDswSwK2ZBGxX3eCnMsuc6WSC2mvOkbI+cVuezZ1zzK+wce8BH
         9Hy7jpZXa5NhbHigrSX0++Z6ChYp1spFmf8++1qCNvFBYQQBJh5SJEl5jH+ZSmXuu/RW
         77PXuatPp9Zp6ldCPAf5liXfpXeI3PSFWEniFHsy63N55uMwiMPrU1qAdRrnT7y3xN1q
         E0n5jtSf0/b87r7nun6DuZhOhK9DAB0lvv/ydNgP5ItxyNUxat4vMRX4sddAdiSVzUo9
         45EA==
X-Forwarded-Encrypted: i=1; AJvYcCUsUNjG9WJIdn/ArQVbYqpsSc726qVWiWgrBjohA/fL+wKRngqUa6AxjpUYcdFd46KVgw4cLnsMGcvu/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfX0HfL9ukIdTFwmUyN5opqHC4GxbqwgXsHdLVJhPpsE6QGAZ
	1f5qHsCaatWnlXNqObQnlxUOyO8zdkd2+ZqceClro13gopcKHvVU625XcCIidbyvWTK26IKwZ1O
	E29EazaAQnhfVHaU77A==
X-Received: from wmbfc7.prod.google.com ([2002:a05:600c:5247:b0:485:3ddc:f27c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3515:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-485567066a8mr212492925e9.16.1773662127851;
 Mon, 16 Mar 2026 04:55:27 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:55:26 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-24-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-24-de9a7af4b469@kernel.org>
Message-ID: <abfvrh0ObKhtsR8I@google.com>
Subject: Re: [PATCH 24/79] block: rust: add `BadBlocks` for bad block tracking
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:35:11AM +0100, Andreas Hindborg wrote:
> Add a safe Rust wrapper around the Linux kernel's badblocks infrastructure
> to track and manage defective sectors on block devices. The BadBlocks type
> provides methods to:
> 
> - Mark sectors as bad or good (set_bad/set_good)
> - Check if sector ranges contain bad blocks (check)
> - Automatically handle memory management with PinnedDrop
> 
> The implementation includes comprehensive documentation with examples for
> block device drivers that need to avoid known bad sectors to maintain
> data integrity. Bad blocks information is used by device drivers,
> filesystem layers, and device management tools.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> diff --git a/rust/kernel/block/badblocks.rs b/rust/kernel/block/badblocks.rs
> new file mode 100644
> index 0000000000000..a5fe0fde2e755
> --- /dev/null
> +++ b/rust/kernel/block/badblocks.rs
> @@ -0,0 +1,721 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Bad blocks tracking for block devices.
> +//!
> +//! This module provides a safe Rust wrapper around the badblocks
> +//! infrastructure, which is used to track and manage bad sectors on block
> +//! devices. Bad blocks are sectors that cannot reliably store data and should
> +//! be avoided during I/O operations.

Could use a srctree link to badblocks.h here.

> +/// # Examples
> +///
> +/// Basic usage:
> +///
> +/// ```rust
> +/// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
> +/// # use kernel::prelude::*;
> +///

Unhide the imports or remove this empty line.

> +/// // Create a new bad blocks tracker
> +/// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
> +///
> +/// // Mark sectors 100-109 as bad (unacknowledged)
> +/// bad_blocks.set_bad(100..110, false)?;
> +///
> +/// // Check if sector range 95-104 contains bad blocks
> +/// match bad_blocks.check(95..105) {
> +///     BlockStatus::None => pr_info!("No bad blocks found"),
> +///     BlockStatus::Acknowledged(range) => pr_warn!("Acknowledged bad blocks: {:?}", range),
> +///     BlockStatus::Unacknowledged(range) => pr_err!("Unacknowledged bad blocks: {:?}", range),
> +/// }
> +/// # Ok::<(), kernel::error::Error>(())
> +/// ```
> +/// # Invariants
> +///
> +/// - `self.blocks` is a valid `bindings::badblocks` struct.
> +#[pin_data(PinnedDrop)]
> +pub struct BadBlocks {
> +    #[pin]
> +    blocks: Opaque<bindings::badblocks>,
> +}
> +
> +impl BadBlocks {
> +    /// Creates a new bad blocks tracker.
> +    ///
> +    /// Initializes an empty bad blocks tracker that can manage defective sectors
> +    /// on a block device. The tracker starts with no bad blocks recorded and
> +    /// allocates a single page for storing bad block entries.
> +    ///
> +    /// # Returns
> +    ///
> +    /// Returns a [`PinInit`] that can be used to initialize a [`BadBlocks`] instance.
> +    /// Initialization may fail with `ENOMEM` if memory allocation fails.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
> +    /// # use kernel::prelude::*;
> +    ///

Ditto. (Many times throughout file.)

> +    /// // Create and initialize a bad blocks tracker
> +    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
> +    ///
> +    /// // The tracker is ready to use with no bad blocks initially
> +    /// match bad_blocks.check(0..100) {
> +    ///     BlockStatus::None => pr_info!("No bad blocks found initially"),
> +    ///     _ => unreachable!(),
> +    /// }
> +    /// # Ok::<(), kernel::error::Error>(())
> +    /// ```
> +    pub fn new(enable: bool) -> impl PinInit<Self, Error> {
> +        // INVARIANT: We initialize `self.blocks` below. If initialization fails, an error is
> +        // returned.
> +        try_pin_init!(Self {
> +            blocks <- Opaque::try_ffi_init(|slot| {
> +                // SAFETY: `slot` is a valid pointer to uninitialized memory
> +                // allocated by the Opaque type. `badblocks_init` is safe to
> +                // call with uninitialized memory.
> +                to_result(unsafe {bindings::badblocks_init(slot, if enable {1} else {0})})

I think you can just cast the boolean to an integer.

Also, formatting here is off (but ignored by rustfmt due to macro.)

> +    /// Enables the bad blocks tracker if it was previously disabled.
> +    ///
> +    /// Attempts to enable bad block tracking by transitioning the tracker from
> +    /// a disabled state to an enabled state.
> +    ///
> +    /// # Behavior
> +    ///
> +    /// - If the tracker is disabled, it will be enabled.
> +    /// - If the tracker is already enabled, this operation has no effect.
> +    /// - The operation is atomic and thread-safe.
> +    ///
> +    /// # Usage
> +    ///
> +    /// Bad blocks trackers can be created in a disabled state and enabled later
> +    /// when needed. This is useful for conditional bad block tracking or for
> +    /// deferring activation until the device is fully initialized.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// # use kernel::block::badblocks::BadBlocks;
> +    /// # use kernel::prelude::*;
> +    ///
> +    /// // Create a disabled bad blocks tracker
> +    /// let bad_blocks = KBox::pin_init(BadBlocks::new(false), GFP_KERNEL)?;
> +    /// assert!(!bad_blocks.enabled());
> +    ///
> +    /// // Enable it when needed
> +    /// bad_blocks.enable();
> +    /// assert!(bad_blocks.enabled());
> +    ///
> +    /// // Subsequent enable calls have no effect
> +    /// bad_blocks.enable();
> +    /// assert!(bad_blocks.enabled());
> +    /// # Ok::<(), kernel::error::Error>(())
> +    /// ```
> +    pub fn enable(&self) {
> +        let _ = self.shift_ref().cmpxchg(-1, 0, ordering::Relaxed);

Is there not a C function you can call here? It would be simpler that
way. Surely drivers don't do this directly.

> +    }
> +
> +    /// Checks whether the bad blocks tracker is currently enabled.
> +    ///
> +    /// Returns `true` if bad block tracking is active, `false` if it is disabled.
> +    /// When disabled, the tracker will not perform bad block checks or operations.
> +    ///
> +    /// # Returns
> +    ///
> +    /// - `true` - Bad block tracking is enabled and operational
> +    /// - `false` - Bad block tracking is disabled

You explain the meaning of return values twice here. Just drop the
'Returns' section.

> +    /// # Thread Safety
> +    ///
> +    /// This method is thread-safe and uses atomic operations to check the
> +    /// tracker's state without requiring external synchronization.

This is implicit from the signature of the function.

> +    pub fn set_good(&self, range: impl RangeBounds<u64>) -> Result {
> +        let range = Self::range(range);
> +        // SAFETY: By type invariant `self.blocks` is valid. The C function
> +        // `badblocks_clear` handles synchronization internally.
> +        unsafe {
> +            bindings::badblocks_clear(self.blocks.get(), range.start, range.end - range.start)
> +        }
> +        .then_some(())
> +        .ok_or(EINVAL)

then_some() is quite obscure. I would recommend if/else here.

Alice
