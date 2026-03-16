Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C638F24A
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656962; cv=none; b=dShi0scVjeB4+rB/f88kE7oigzcBDHzyzZ/9TkhSvQno6I9L1T5pskow7cxYyVPFwuau0fX7F9RJHq3GfOX/EOc3sJngz8jyw+qreTwNiAsCCDGqNOrQO6NXOciXLJfk9DAkgQ8dcIn4Q7IWBGt+1feAGh1DZImHWnWhhxC6u94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656962; c=relaxed/simple;
	bh=nzSt/SS7U23C4jMIx88oozGAYkx7KQLAwx5r3lcnu+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fwGo+3PMeAaaOnEAfuO3DQY6ucGpsP8HyTZYDUSCuhscvH6sLQwZsSODQuJ9ULRHcERJ4FAqt+fRNDJJR5gHe5AAb2bDFk6S17TdiTq1gGuuc6pNpvOza0zc+iSH0OUqiIDip2wKt7eQc4l/HLE0jmNsYXe8yfNdGqlq5QrBPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDIfcJBu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDIfcJBu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so51360435e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773656959; x=1774261759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgj71Xi0TqNeZ1561j+9Q4P6kO5QDeyHGgeliIn9S4M=;
        b=XDIfcJBuuG0AQ/MHB4EwNq82Jy/4X4YdMiyeHuZwq3e0YLvDbWiD6ABoErZ4PW8DVs
         SLLBz+TzXg3rkZu2rvdDaAehtuzg2gr1ntUGMMW1GUUWr82QxOgbI8NpXghYK87r7cs4
         nMVqlDQd16t3qO5tSNjCYbj/Q9D8J7w0oq8KZRIJ5oGq+vYnxEYSDv8AmK1Wf2euVXPc
         MWRzlMUyE5WAmBebssSKt++d6ODAjLUW31GXCcy1PxPgrLjZx/tBadCh1HE5JSWv/t++
         8V6Ti/Eu2XzMk9tXFHsJtGH4Gr2ts/xyrFSQbdJr3Cujw3I9iGyNKgYYpEua9aS65dDO
         Hz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773656959; x=1774261759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgj71Xi0TqNeZ1561j+9Q4P6kO5QDeyHGgeliIn9S4M=;
        b=E+EXU2uZSGdR5dqgABzkBDPj5z7TOiSALueD/v7bULwNMjTkKfxQRBGXy3DOAI7Pbt
         fRsb/mTWMKmFGR0HZNY/8g3jLfd9EZJZwwR38pKKUwdV8kDwjnffXeeHyhBOvffAbqDq
         4MzjnSDsk53wkZbqwq1dtssI1NwYBRlBqGsFVlQMzu0LkK7+2gKZCsnNbrdyo9H1OBnV
         VaDL8uu5AigB9XaJ7/P5Zxmih1cZejHHAg176I3Yi26KB4AWiMKMIySkinH23KnjGDaS
         A4K1hZm/F9nH/iEtsQhRpnhoHMEqAT5AN5MrYURnM6wHBb6yGGpxMXqSXWbXmPcy+r2X
         vcDA==
X-Forwarded-Encrypted: i=1; AJvYcCW8S+lve70IskRPrBy8Uv1Z7PKjDrBhBNJ+u0B/QEg1kSvawmEJw1kpP2XvfReuEKQtwMhinoPErwSruw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhEVZ6HNZ+keG1SAhpZmxo2xrPH1bMTdTZBh4kluTmolfOtar
	nMy4/ksIXWomolbNTFCIMafGMucqHOCKxwAI7ufWCgPJtczJgK/ENhzIHUWFQprGoKxj0++fN89
	sluFKCj2aJcyvlUpS9w==
X-Received: from wmco7.prod.google.com ([2002:a05:600c:a307:b0:485:3a48:d6c5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd5:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48555b2c8fbmr205265065e9.11.1773656958664;
 Mon, 16 Mar 2026 03:29:18 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:29:17 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-9-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-9-de9a7af4b469@kernel.org>
Message-ID: <abfbfV6-FXnVT9Ud@google.com>
Subject: Re: [PATCH 09/79] block: rust: introduce `kernel::block::bio` module
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

On Mon, Feb 16, 2026 at 12:34:56AM +0100, Andreas Hindborg wrote:
> Add Rust abstractions for working with `struct bio`, the core IO command
> descriptor for the block layer.
> 
> The `Bio` type wraps `struct bio` and provides safe access to the IO
> vector describing the data buffers associated with the IO command. The
> data buffers are represented as a vector of `Segment`s, where each
> segment is a contiguous region of physical memory backed by `Page`.
> 
> The `BioSegmentIterator` provides iteration over segments in a single
> bio, while `BioIterator` allows traversing a chain of bios. The
> `Segment` type offers methods for copying data to and from pages, as
> well as zeroing page contents, which are the fundamental operations
> needed by block device drivers to process IO requests.
> 
> The `Request` type is extended with methods to access the bio chain
> associated with a request, allowing drivers to iterate over all data
> buffers that need to be processed.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/helpers/blk.c              |   8 +
>  rust/kernel/block.rs            |   1 +
>  rust/kernel/block/bio.rs        | 143 +++++++++++++++
>  rust/kernel/block/bio/vec.rs    | 389 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/block/mq/request.rs |  46 +++++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/page.rs             |   2 +-
>  7 files changed, 590 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
> index cc9f4e6a2d234..53beba8c7782d 100644
> --- a/rust/helpers/blk.c
> +++ b/rust/helpers/blk.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/bio.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blkdev.h>
>  
> @@ -12,3 +13,10 @@ struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
>  {
>  	return blk_mq_rq_from_pdu(pdu);
>  }
> +
> +void rust_helper_bio_advance_iter_single(const struct bio *bio,
> +					 struct bvec_iter *iter,
> +					 unsigned int bytes)
> +{
> +	bio_advance_iter_single(bio, iter, bytes);
> +}

__rust_helper

> diff --git a/rust/kernel/block/bio.rs b/rust/kernel/block/bio.rs
> new file mode 100644
> index 0000000000000..94062ea5281e6
> --- /dev/null
> +++ b/rust/kernel/block/bio.rs
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for working with the bio layer.
> +//!
> +//! C header: [`include/linux/blk_types.h`](../../include/linux/blk_types.h)

srctree/

> +/// A block device IO descriptor (`struct bio`).
> +///
> +/// A `Bio` is the main unit of IO for the block layer. It describes an IO command and associated
> +/// data buffers.
> +///
> +/// The data buffers associated with a `Bio` are represented by a vector of [`Segment`]s. These
> +/// segments represent physically contiguous regions of memory. The memory is represented by
> +/// [`Page`] descriptors internally.
> +///
> +/// The vector of [`Segment`]s can be iterated by obtaining a [`SegmentIterator`].
> +///
> +/// # Invariants
> +///
> +/// Instances of this type is always reference counted. A call to
> +/// `bindings::bio_get()` ensures that the instance is valid for read at least
> +/// until a matching call to `bindings :bio_put()`.

Refcounted? None of these methods are called anywhere, and you do not
implement AlwaysRefcounted.

> +#[repr(transparent)]
> +pub struct Bio(Opaque<bindings::bio>);
> +
> +impl Bio {
> +    /// Returns an iterator over segments in this `Bio`. Does not consider
> +    /// segments of other bios in this bio chain.
> +    #[inline(always)]
> +    pub fn segment_iter(&mut self) -> BioSegmentIterator<'_> {

Not `self: Pin<&mut Self>` here?

> +    /// Create an instance of `Bio` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must ensure that the `ptr` is valid for use as a reference to
> +    /// `Bio` for the duration of `'a`.
> +    #[inline(always)]
> +    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::bio) -> Option<&'a Self> {
> +        Some(
> +            // SAFETY: by the safety requirement of this funciton, `ptr` is
> +            // valid for read for the duration of the returned lifetime
> +            unsafe { &*NonNull::new(ptr)?.as_ptr().cast::<Bio>() },
> +        )
> +    }
> +
> +    /// Create an instance of `Bio` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must ensure that the `ptr` is valid for use as a unique reference
> +    /// to `Bio` for the duration of `'a`.
> +    #[inline(always)]
> +    pub(crate) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::bio) -> Option<&'a mut Self> {
> +        Some(
> +            // SAFETY: by the safety requirement of this funciton, `ptr` is
> +            // valid for read for the duration of the returned lifetime
> +            unsafe { &mut *NonNull::new(ptr)?.as_ptr().cast::<Bio>() },

Why the Option? I imagine every caller has a non-null pointer?

> +        )
> +    }
> +}
> +
> +impl core::fmt::Display for Bio {

We have our own fmt trait now, right?

> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(
> +            f,
> +            "Bio({:?}, vcnt: {}, idx: {}, size: 0x{:x}, completed: 0x{:x})",
> +            self.0.get(),
> +            self.io_vec_count(),
> +            self.raw_iter().bi_idx,
> +            self.raw_iter().bi_size,
> +            self.raw_iter().bi_bvec_done

This reads the entire `bi_iter` field three separate times. A local
variable may be a good idea.

> +/// An iterator over `Segment`
> +///
> +/// # Invariants
> +///
> +/// If `iter.bi_size` > 0, `iter` must always index a valid `bio_vec` in `bio.io_vec()`.
> +pub struct BioSegmentIterator<'a> {
> +    bio: &'a mut Bio,
> +    iter: bindings::bvec_iter,
> +}
> +
> +impl<'a> BioSegmentIterator<'a> {
> +    /// Creeate a new segemnt iterator for iterating the segments of `bio`. The

typo

> +impl<'a> core::iter::Iterator for BioSegmentIterator<'a> {
> +    type Item = Segment<'a>;
> +
> +    #[inline(always)]
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.iter.bi_size == 0 {
> +            return None;
> +        }
> +
> +        // SAFETY: We checked that `self.iter.bi_size` > 0 above.
> +        let bio_vec_ret = unsafe { self.io_vec() };
> +
> +        // SAFETY: By existence of reference `&bio`, `bio.0` contains a valid
> +        // `struct bio`. By type invariant of `BioSegmentItarator` `self.iter`
> +        // indexes into a valid `bio_vec` entry. By C API contracit, `bv_len`
> +        // does not exceed the size of the bio.
> +        unsafe {
> +            bindings::bio_advance_iter_single(
> +                self.bio.0.get(),
> +                core::ptr::from_mut(&mut self.iter),

Creating this BioSegmentItarator copies the bvec_iter from the Bio, and
then here you modify the copy. Is that the intent? Is the C type such
that copying it is always okay?

Also, is the C type such that moves are ok? It's playsible that the
answer is yes - the same applies in rust/kernel/iov.rs but it could be
clearer in e.g. "Invariants" that this is the case.

Nit: core::ptr::from_mut(&mut self.iter) -> &raw mut self.iter

> +    /// Get a mutable reference to the first [`Bio`] in this request.
> +    #[inline(always)]
> +    pub fn bio_mut(&mut self) -> Option<&mut Bio> {
> +        // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
> +        // is safe.
> +        let ptr = unsafe { (*self.0.get()).bio };
> +        // SAFETY: By C API contract, if `bio` is not null it will have a
> +        // positive refcount at least for the duration of the lifetime of
> +        // `&self`.
> +        unsafe { Bio::from_raw_mut(ptr) }

Surely &mut requires refcount == 1, not just positive refcount?

Alice
