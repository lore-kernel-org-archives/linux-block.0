Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAB377EB8;
	Wed,  3 Jun 2026 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483264; cv=none; b=sKMt4ZeazK3z/WGesX/ionNLzXq91OCPAhaVvcz1hGTVJQF4kfdfhuib7fFCmQhJ+V1/HCr5m8znGUEpAxYOeOJbfRPZ8hhN4lFaVbMSdHT74GNezatnxNkxYLXVYqYz+UeNLIyq7QbCnoLLM3Y0/Vl8lariOz5g1R73+jVahA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483264; c=relaxed/simple;
	bh=o5elUqlDQE4cP8+aQEL2ZQbecnNDIgNQQkdSV6w6nKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBehgp6WDhEEV3nevzwLKxp5/86HF/zUaUGhH+6h2rhZGZ9XOHKhV895DWBLqUxtUCd9GahvC2ogqZW6nCOu23Ema4eHMvfBaBuuZbSQCc3JyEbRsnXg2BNE3Ivr///gXRsPoZj5UYI5jGSHKTY7h72Xl0EFp7k2LixwosclyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+OYS/J/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+OYS/J/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFBA1F00893;
	Wed,  3 Jun 2026 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483263;
	bh=s7g+YgnU5mYzWEYBRa4inLWSLO7CCiRf4ByLQT5tfZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N+OYS/J/t3VZ0KZzQP4YJ7w3BTT26YT5oyBCWmyE1q1r+8mnOg1ld4b6EeAhfEAQ2
	 pKOVfEsgvxq6CHYTuRNjM/aCl1g+UUDrtSfrbHLWWldfsVfpP6duEcC+68+gwaSCaI
	 dIWSw1rsnuiHIxJLVJjZZPYrEJEQlJ6hvQvjWb36uGwEVc2z6RbBWI9jTXnMlfQ8bX
	 l1JIrwYR1XFBQ7LMeGvPkMcPdaloKd08pATKIFQuRV/nEBIrZzv3zOwPBZ3jcWC0uT
	 e6ICzSlXKZIzciWouRQiDt7rn0cphZRUkkZTLc/j87zkvtA5z9+YVAO8lHYB5DuyDv
	 mtamVBdFFBoBg==
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
Subject: Re: [PATCH 06/79] block: rust: add `Request` private data support
In-Reply-To: <abfXIqlT9qRhXssT@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-6-de9a7af4b469@kernel.org>
 <abfXIqlT9qRhXssT@google.com>
Date: Wed, 03 Jun 2026 12:40:49 +0200
Message-ID: <87se73kitq.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:34:53AM +0100, Andreas Hindborg wrote:
>> C block device drivers can attach private data to a `struct request`. This
>> data is stored next to the request structure and is part of the request
>> allocation set up during driver initialization.
>> 
>> Expose this private request data area to Rust block device drivers.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Overall looks ok. A few nits below:
>
>> ---
>>  drivers/block/rnull/rnull.rs       |  5 +++++
>>  rust/kernel/block/mq.rs            |  6 ++++++
>>  rust/kernel/block/mq/operations.rs | 24 +++++++++++++++++++++++-
>>  rust/kernel/block/mq/request.rs    | 24 +++++++++++++++++++-----
>>  rust/kernel/block/mq/tag_set.rs    |  2 +-
>>  5 files changed, 54 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
>> index 6a7f660d31998..065639fc4f941 100644
>> --- a/drivers/block/rnull/rnull.rs
>> +++ b/drivers/block/rnull/rnull.rs
>> @@ -134,6 +134,11 @@ struct QueueData {
>>  #[vtable]
>>  impl Operations for NullBlkDevice {
>>      type QueueData = KBox<QueueData>;
>> +    type RequestData = ();
>> +
>> +    fn new_request_data() -> impl PinInit<Self::RequestData> {
>> +        pin_init::zeroed::<Self::RequestData>()
>
> Simpler to just return Ok(()) here.

Not sure why I picked zeroed. Will change.

>
>> +    }
>>  
>>      #[inline(always)]
>>      fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool) -> Result {
>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>> index b8ecd69abe980..a285b753ada88 100644
>> --- a/rust/kernel/block/mq.rs
>> +++ b/rust/kernel/block/mq.rs
>> @@ -69,8 +69,14 @@
>>  //!
>>  //! #[vtable]
>>  //! impl Operations for MyBlkDevice {
>> +//!     type RequestData = ();
>>  //!     type QueueData = ();
>>  //!
>> +//!     fn new_request_data(
>> +//!     ) -> impl PinInit<()> {
>> +//!         pin_init::zeroed::<()>()
>
> Simpler to just return Ok(()) here.

Will change.

>
>> +//!     }
>> +//!
>>  //!     fn queue_rq(_queue_data: (), rq: Owned<Request<Self>>, _is_last: bool) -> Result {
>>  //!         rq.end_ok();
>>  //!         Ok(())
>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
>> index 3dea79d647ff7..cd37b939bbf30 100644
>> --- a/rust/kernel/block/mq/operations.rs
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -13,6 +13,7 @@
>>      types::{ForeignOwnable, Owned},
>>  };
>>  use core::{marker::PhantomData, ptr::NonNull};
>> +use pin_init::PinInit;
>>  
>>  type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
>>  
>> @@ -28,10 +29,24 @@
>>  /// [module level documentation]: kernel::block::mq
>>  #[macros::vtable]
>>  pub trait Operations: Sized {
>> +    /// Data associated with a request. This data is located next to the request
>> +    /// structure.
>> +    ///
>> +    /// To be able to handle accessing this data from interrupt context, this
>> +    /// data must be `Sync`.
>> +    ///
>> +    /// The `RequestData` object is initialized when the requests are allocated
>> +    /// during queue initialization, and it is are dropped when the requests are
>> +    /// dropped during queue teardown.
>> +    type RequestData: Sized + Sync;
>
> It was surprising to me that `request` is reused over many requests. I
> think it could be a bit more obvious in the wording.

I will add a bit of info in the `Request` type docs.

>
>>      /// Data associated with the `struct request_queue` that is allocated for
>>      /// the `GenDisk` associated with this `Operations` implementation.
>>      type QueueData: ForeignOwnable;
>>  
>> +    /// Called by the kernel to get an initializer for a `Pin<&mut RequestData>`.
>> +    fn new_request_data() -> impl PinInit<Self::RequestData>;
>> +
>>      /// Called by the kernel to queue a request with the driver. If `is_last` is
>>      /// `false`, the driver is allowed to defer committing the request.
>>      fn queue_rq(
>> @@ -236,6 +251,13 @@ impl<T: Operations> OperationsVTable<T> {
>>              // it is valid for writes.
>>              unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
>>  
>> +            let initializer = T::new_request_data();
>> +
>> +            // SAFETY: `pdu` is a valid pointer as established above. We do not
>> +            // touch `pdu` if `__pinned_init` returns an error. We promise ot to
>
> typo
>
>
>> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
>> index c3cf56d52beec..46481754b1335 100644
>> --- a/rust/kernel/block/mq/tag_set.rs
>> +++ b/rust/kernel/block/mq/tag_set.rs
>> @@ -41,7 +41,7 @@ pub fn new(
>>          // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
>>          // all are allowed to be 0.
>>          let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
>> -        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
>> +        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper<T>>()
>
> size_of in prelude.

Fixed.

Thanks,
Andreas

