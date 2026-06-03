Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B02357739;
	Wed,  3 Jun 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481756; cv=none; b=eReOxFxnjRV3MoYiWJ5qvDqyqyTPCZPzEPSgv2FgxMQGIR7UaLRznvlTT+aaos4fcO0RaggqOkx4ytrDy+Kszo2ve0sQdXHrKoiELgBT3mJ+6orHGvyS0frF9qAlSLkiooDH60grG++zm/pzcUFcXjOitmKHT+CWD5ICZe+gevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481756; c=relaxed/simple;
	bh=9f3RQajNaDKRwzTBpBHWvm/GhKr2D2lDsgCnyLS+jfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWXH7bF/lyu5gilxKlm6Cl6wU3bDFC9gxRfyH9MuSVeES7/LZ8/wHe96GhwHt/ssIc0IqI1UkmjsmbfHVLMcmFoW5qv2pktRbcBFprbS0JZDq0f5zKCbYkLaeLTSVBWkITExuGAyRMqAj+GGTpzxeXDuvp7wbEvJKWa/TGxNsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtSSZsou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtSSZsou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8191F00893;
	Wed,  3 Jun 2026 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780481754;
	bh=/1qAgvTTvf0xlsZiADLfe2fg7WDkq6Xjj3OBNJ3gL8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gtSSZsouD8cpySavp5/KCA2H4xsJ0k33u5QsI54YwWdTBvVrwh1EQJoZKLTUcRYDi
	 nMKVQ25m+DVsx7fnEUljFRRXcSps9Wa9xplTuvBA5+rr1nNS3aWK8UBwzAydajFHxf
	 HtFrhyeERBNXQ08tv3rlbDHPQ4gXWnGgHTEbcq/9rfB6r8DVzepSZohFqaZ/SNpYym
	 4UQSfaBL0iflTvEzNtyqsATxsoImbcfFZU+5b3Nb/jW8Uhl1hxHeDtJsFffRvBG22n
	 wQBNPD6ldeFmVIinRjFx9C81t9ZjoHXZJSwCafXds57TqF+Yf4PP/248p/pEympUZF
	 kZ9QODUrn7mSA==
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
Subject: Re: [PATCH 24/79] block: rust: add `BadBlocks` for bad block tracking
In-Reply-To: <abfvrh0ObKhtsR8I@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-24-de9a7af4b469@kernel.org>
 <abfvrh0ObKhtsR8I@google.com>
Date: Wed, 03 Jun 2026 12:15:41 +0200
Message-ID: <87wlwgj5f6.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:35:11AM +0100, Andreas Hindborg wrote:
>> Add a safe Rust wrapper around the Linux kernel's badblocks infrastructure
>> to track and manage defective sectors on block devices. The BadBlocks type
>> provides methods to:
>> 
>> - Mark sectors as bad or good (set_bad/set_good)
>> - Check if sector ranges contain bad blocks (check)
>> - Automatically handle memory management with PinnedDrop
>> 
>> The implementation includes comprehensive documentation with examples for
>> block device drivers that need to avoid known bad sectors to maintain
>> data integrity. Bad blocks information is used by device drivers,
>> filesystem layers, and device management tools.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>> diff --git a/rust/kernel/block/badblocks.rs b/rust/kernel/block/badblocks.rs
>> new file mode 100644
>> index 0000000000000..a5fe0fde2e755
>> --- /dev/null
>> +++ b/rust/kernel/block/badblocks.rs
>> @@ -0,0 +1,721 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Bad blocks tracking for block devices.
>> +//!
>> +//! This module provides a safe Rust wrapper around the badblocks
>> +//! infrastructure, which is used to track and manage bad sectors on block
>> +//! devices. Bad blocks are sectors that cannot reliably store data and should
>> +//! be avoided during I/O operations.
>
> Could use a srctree link to badblocks.h here.

Will add.

>
>> +/// # Examples
>> +///
>> +/// Basic usage:
>> +///
>> +/// ```rust
>> +/// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
>> +/// # use kernel::prelude::*;
>> +///
>
> Unhide the imports or remove this empty line.

Ok.

>
>> +/// // Create a new bad blocks tracker
>> +/// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
>> +///
>> +/// // Mark sectors 100-109 as bad (unacknowledged)
>> +/// bad_blocks.set_bad(100..110, false)?;
>> +///
>> +/// // Check if sector range 95-104 contains bad blocks
>> +/// match bad_blocks.check(95..105) {
>> +///     BlockStatus::None => pr_info!("No bad blocks found"),
>> +///     BlockStatus::Acknowledged(range) => pr_warn!("Acknowledged bad blocks: {:?}", range),
>> +///     BlockStatus::Unacknowledged(range) => pr_err!("Unacknowledged bad blocks: {:?}", range),
>> +/// }
>> +/// # Ok::<(), kernel::error::Error>(())
>> +/// ```
>> +/// # Invariants
>> +///
>> +/// - `self.blocks` is a valid `bindings::badblocks` struct.
>> +#[pin_data(PinnedDrop)]
>> +pub struct BadBlocks {
>> +    #[pin]
>> +    blocks: Opaque<bindings::badblocks>,
>> +}
>> +
>> +impl BadBlocks {
>> +    /// Creates a new bad blocks tracker.
>> +    ///
>> +    /// Initializes an empty bad blocks tracker that can manage defective sectors
>> +    /// on a block device. The tracker starts with no bad blocks recorded and
>> +    /// allocates a single page for storing bad block entries.
>> +    ///
>> +    /// # Returns
>> +    ///
>> +    /// Returns a [`PinInit`] that can be used to initialize a [`BadBlocks`] instance.
>> +    /// Initialization may fail with `ENOMEM` if memory allocation fails.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```rust
>> +    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
>> +    /// # use kernel::prelude::*;
>> +    ///
>
> Ditto. (Many times throughout file.)
>
>> +    /// // Create and initialize a bad blocks tracker
>> +    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
>> +    ///
>> +    /// // The tracker is ready to use with no bad blocks initially
>> +    /// match bad_blocks.check(0..100) {
>> +    ///     BlockStatus::None => pr_info!("No bad blocks found initially"),
>> +    ///     _ => unreachable!(),
>> +    /// }
>> +    /// # Ok::<(), kernel::error::Error>(())
>> +    /// ```
>> +    pub fn new(enable: bool) -> impl PinInit<Self, Error> {
>> +        // INVARIANT: We initialize `self.blocks` below. If initialization fails, an error is
>> +        // returned.
>> +        try_pin_init!(Self {
>> +            blocks <- Opaque::try_ffi_init(|slot| {
>> +                // SAFETY: `slot` is a valid pointer to uninitialized memory
>> +                // allocated by the Opaque type. `badblocks_init` is safe to
>> +                // call with uninitialized memory.
>> +                to_result(unsafe {bindings::badblocks_init(slot, if enable {1} else {0})})
>
> I think you can just cast the boolean to an integer.

Ok.

>
> Also, formatting here is off (but ignored by rustfmt due to macro.)

Will try to fix.

>
>> +    /// Enables the bad blocks tracker if it was previously disabled.
>> +    ///
>> +    /// Attempts to enable bad block tracking by transitioning the tracker from
>> +    /// a disabled state to an enabled state.
>> +    ///
>> +    /// # Behavior
>> +    ///
>> +    /// - If the tracker is disabled, it will be enabled.
>> +    /// - If the tracker is already enabled, this operation has no effect.
>> +    /// - The operation is atomic and thread-safe.
>> +    ///
>> +    /// # Usage
>> +    ///
>> +    /// Bad blocks trackers can be created in a disabled state and enabled later
>> +    /// when needed. This is useful for conditional bad block tracking or for
>> +    /// deferring activation until the device is fully initialized.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```rust
>> +    /// # use kernel::block::badblocks::BadBlocks;
>> +    /// # use kernel::prelude::*;
>> +    ///
>> +    /// // Create a disabled bad blocks tracker
>> +    /// let bad_blocks = KBox::pin_init(BadBlocks::new(false), GFP_KERNEL)?;
>> +    /// assert!(!bad_blocks.enabled());
>> +    ///
>> +    /// // Enable it when needed
>> +    /// bad_blocks.enable();
>> +    /// assert!(bad_blocks.enabled());
>> +    ///
>> +    /// // Subsequent enable calls have no effect
>> +    /// bad_blocks.enable();
>> +    /// assert!(bad_blocks.enabled());
>> +    /// # Ok::<(), kernel::error::Error>(())
>> +    /// ```
>> +    pub fn enable(&self) {
>> +        let _ = self.shift_ref().cmpxchg(-1, 0, ordering::Relaxed);
>
> Is there not a C function you can call here? It would be simpler that
> way. Surely drivers don't do this directly.

No, this is the canonical way [1].

[1] https://github.com/torvalds/linux/blob/ba3e43a9e601636f5edb54e259a74f96ca3b8fd8/drivers/block/null_blk/main.c#L563

>
>> +    }
>> +
>> +    /// Checks whether the bad blocks tracker is currently enabled.
>> +    ///
>> +    /// Returns `true` if bad block tracking is active, `false` if it is disabled.
>> +    /// When disabled, the tracker will not perform bad block checks or operations.
>> +    ///
>> +    /// # Returns
>> +    ///
>> +    /// - `true` - Bad block tracking is enabled and operational
>> +    /// - `false` - Bad block tracking is disabled
>
> You explain the meaning of return values twice here. Just drop the
> 'Returns' section.

Ok.

>
>> +    /// # Thread Safety
>> +    ///
>> +    /// This method is thread-safe and uses atomic operations to check the
>> +    /// tracker's state without requiring external synchronization.
>
> This is implicit from the signature of the function.

Will remove.

>
>> +    pub fn set_good(&self, range: impl RangeBounds<u64>) -> Result {
>> +        let range = Self::range(range);
>> +        // SAFETY: By type invariant `self.blocks` is valid. The C function
>> +        // `badblocks_clear` handles synchronization internally.
>> +        unsafe {
>> +            bindings::badblocks_clear(self.blocks.get(), range.start, range.end - range.start)
>> +        }
>> +        .then_some(())
>> +        .ok_or(EINVAL)
>
> then_some() is quite obscure. I would recommend if/else here.

Ok.

Thanks,
Andreas

