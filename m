Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6C382F38
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655847; cv=none; b=PQJMeCkF3dt7b/DfV3PXRDoJjOS6NKqZlhF8rWzw9Rb8bJQkjQBILb5AWtulSPVdVi1dGcs+vWdfBeiIFbjjiZe2o0gBcIHkHgR9EzOjsQ+Fwzbg0pBKEsoz28bWmKvImvZ+sk+aU3Y4VfRdQVEptdoOepgE6Z4bELTqLBnLv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655847; c=relaxed/simple;
	bh=byUyunm8qHyLwa9x8rkOXLitjXRMBluztOzbk+P6BEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHUX+oGT1nkfIagjbvcDUGD1nYWqv4PBHxjOb+h3NDbBHDcrWK3Wson7oxc/lwyNYGfDy730lGL2niHqIojsLqHafDNFg8Ryvx7jYdh8GET3aDGInjKgYazT+o3aLuEMON0dAwMX3OEIYl0Z8/Xs4fK9uCub5G/hfXxe80PW6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqC0t4kA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqC0t4kA"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48378df3469so33625755e9.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773655844; x=1774260644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3ZhqgEQpEubXh2g+cxD+FKnnV49bXXiNz3andESbr8=;
        b=qqC0t4kATDPtN0BwncnD6cxbmEzOTia3gagsRQho+1MIYW4ZKZw16t8Fd+cxDFGrqT
         3zyGxizwQQhX7CSczSlce6hMykj9mHpVpAb6IZuKCxH5wCXgGGXA65gAI2weBHuGrO2u
         toyTH1uzBbmj2VJff033+zR87MHcjV2J6lHUBJ1noN928QTJZ7CT3GhdakmgA+E2VODn
         t3TifFUuxKzXTExjEWKn6Z+atVyeaGNFSF/5dIIfS7HvU0d03EgrwOdbaf9DxPo6x4Ga
         Vhbd2alU6L8HDfKk+uFCKUgwkd7kfKQIBrYVSl8jzyo5TzrMXF4Tgk/RXjmikwjPJjSc
         IUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655844; x=1774260644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3ZhqgEQpEubXh2g+cxD+FKnnV49bXXiNz3andESbr8=;
        b=lC2NyfqGW7Sb3aSN+GQOhprVVyuXUtVHfb6f084R1uVkuQnND9cjD2+b4fo4OtNNa7
         ZSyq/XNLfkK7eDN3A7RCpMn0/TCU0dTLiZPn0pUAwz3a4EtW0+ToXBMaro2+PXI835Sa
         eyQPqfuITIrdOnT4ipxAL54RMpDcdFjTGrp3ASy+gqlLN+LjxPQugkef82vcDHqSx/5x
         fIX3CNlXiToJZgctiNhGrDWitNlE/yH+y46/c8ZA/s6Utmzd3bDUTbDku2oeZxHMpTmK
         M8qt77HTb8dOY+R91HnKNuFg9qoy/g+vMXuV8mIkUbUlYQ7pRCoTM8K8ycvmD9qo2JfV
         5CdA==
X-Forwarded-Encrypted: i=1; AJvYcCW964LHQT8q36cJnvspWf+6Ym3qsbCQ3mbwzGAcXsdP9jSG889VYvTQEw8xLXoewAeEZsXdrAtYVdnf5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JSa8Xtx196az04fh2e6IGA2VPmP6wnECOJmBfGOIVcYWtujv
	Cb0+fPlufaid8UI38VI1yqA0gBiik8F27H+YaNjzCBDzUXWw4f7nIRJ0v3CLbjTxjxPhh6xTyXR
	jk6uRsWrWC1E0gfZ2Og==
X-Received: from wmbd13.prod.google.com ([2002:a05:600c:58cd:b0:485:3b8d:c995])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b07:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-48555ac5e34mr195198785e9.6.1773655843552;
 Mon, 16 Mar 2026 03:10:43 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:10:42 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-6-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-6-de9a7af4b469@kernel.org>
Message-ID: <abfXIqlT9qRhXssT@google.com>
Subject: Re: [PATCH 06/79] block: rust: add `Request` private data support
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

On Mon, Feb 16, 2026 at 12:34:53AM +0100, Andreas Hindborg wrote:
> C block device drivers can attach private data to a `struct request`. This
> data is stored next to the request structure and is part of the request
> allocation set up during driver initialization.
> 
> Expose this private request data area to Rust block device drivers.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Overall looks ok. A few nits below:

> ---
>  drivers/block/rnull/rnull.rs       |  5 +++++
>  rust/kernel/block/mq.rs            |  6 ++++++
>  rust/kernel/block/mq/operations.rs | 24 +++++++++++++++++++++++-
>  rust/kernel/block/mq/request.rs    | 24 +++++++++++++++++++-----
>  rust/kernel/block/mq/tag_set.rs    |  2 +-
>  5 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index 6a7f660d31998..065639fc4f941 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -134,6 +134,11 @@ struct QueueData {
>  #[vtable]
>  impl Operations for NullBlkDevice {
>      type QueueData = KBox<QueueData>;
> +    type RequestData = ();
> +
> +    fn new_request_data() -> impl PinInit<Self::RequestData> {
> +        pin_init::zeroed::<Self::RequestData>()

Simpler to just return Ok(()) here.

> +    }
>  
>      #[inline(always)]
>      fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool) -> Result {
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index b8ecd69abe980..a285b753ada88 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -69,8 +69,14 @@
>  //!
>  //! #[vtable]
>  //! impl Operations for MyBlkDevice {
> +//!     type RequestData = ();
>  //!     type QueueData = ();
>  //!
> +//!     fn new_request_data(
> +//!     ) -> impl PinInit<()> {
> +//!         pin_init::zeroed::<()>()

Simpler to just return Ok(()) here.

> +//!     }
> +//!
>  //!     fn queue_rq(_queue_data: (), rq: Owned<Request<Self>>, _is_last: bool) -> Result {
>  //!         rq.end_ok();
>  //!         Ok(())
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index 3dea79d647ff7..cd37b939bbf30 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -13,6 +13,7 @@
>      types::{ForeignOwnable, Owned},
>  };
>  use core::{marker::PhantomData, ptr::NonNull};
> +use pin_init::PinInit;
>  
>  type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
>  
> @@ -28,10 +29,24 @@
>  /// [module level documentation]: kernel::block::mq
>  #[macros::vtable]
>  pub trait Operations: Sized {
> +    /// Data associated with a request. This data is located next to the request
> +    /// structure.
> +    ///
> +    /// To be able to handle accessing this data from interrupt context, this
> +    /// data must be `Sync`.
> +    ///
> +    /// The `RequestData` object is initialized when the requests are allocated
> +    /// during queue initialization, and it is are dropped when the requests are
> +    /// dropped during queue teardown.
> +    type RequestData: Sized + Sync;

It was surprising to me that `request` is reused over many requests. I
think it could be a bit more obvious in the wording.

>      /// Data associated with the `struct request_queue` that is allocated for
>      /// the `GenDisk` associated with this `Operations` implementation.
>      type QueueData: ForeignOwnable;
>  
> +    /// Called by the kernel to get an initializer for a `Pin<&mut RequestData>`.
> +    fn new_request_data() -> impl PinInit<Self::RequestData>;
> +
>      /// Called by the kernel to queue a request with the driver. If `is_last` is
>      /// `false`, the driver is allowed to defer committing the request.
>      fn queue_rq(
> @@ -236,6 +251,13 @@ impl<T: Operations> OperationsVTable<T> {
>              // it is valid for writes.
>              unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
>  
> +            let initializer = T::new_request_data();
> +
> +            // SAFETY: `pdu` is a valid pointer as established above. We do not
> +            // touch `pdu` if `__pinned_init` returns an error. We promise ot to

typo


> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
> index c3cf56d52beec..46481754b1335 100644
> --- a/rust/kernel/block/mq/tag_set.rs
> +++ b/rust/kernel/block/mq/tag_set.rs
> @@ -41,7 +41,7 @@ pub fn new(
>          // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
>          // all are allowed to be 0.
>          let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
> -        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
> +        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper<T>>()

size_of in prelude.

Alice
