Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A61A5BBC;
	Fri, 29 Aug 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466044; cv=none; b=ZwjWSAKKkBeShDYwiz/RuFJlw2B+vo5PnGnFjm53mEHTdyqfJv/0Otb1aGxWa3ZiKv0GrV3eIO3RKymdfRIMdNSbSiqe//zP/+5gjGc+UUXEZXnKV+Akwc3WRb46fx4HpdTLxjfrUcxCNSUYoNRAYwYBZSP90fUPDYS9r1QHSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466044; c=relaxed/simple;
	bh=D8QpsTzerQkyc45PTp7MiEiKx9yCbePfnN03lPXuB4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVtFplxlDiV1dq8Eu5VdTa10bu8IRt+28TxCP2NW8+Wa3BAIlRAAxfuitLflliYpoQzu8BDwtoJ827GrxsHcBpdlAoL6Fj7r3+o9tNa+iO0ASvcHQanvjbeL1dWj4tCsNdTbRIxTH8auW7KveQHqg4MWr2I8lv+fmE60d6Uqxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+9P8RN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+9P8RN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C81C4CEF0;
	Fri, 29 Aug 2025 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756466044;
	bh=D8QpsTzerQkyc45PTp7MiEiKx9yCbePfnN03lPXuB4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T+9P8RN9V1zNo2Ob6aqREAjt4PzvVQIlT215MkyPZVB4670kPWVLzkYvS39NkJTVz
	 A8XxiuGnaSYHY4NQ8wlAEu/gFXBieDK+9xZ6fJsNSjyw9OUiSOcEILVW0x2C9f2CV2
	 tpYz4LPqzeXSLQOMhxotK50aYb4I6IVnyMolLNWapeEe4jKZAtgGhXyYMQ2AonfVhz
	 0vb2gWa8tT56h+QnQRZPJOEvpPb687UUpubxhHsQpfMWICzeoUtVk2qL+g/cOrtocc
	 zUJKy1UIk4Ezayz933+2eSMsu3vx5IFxCckJeJWPJqROmTAeN3gZcZEdnKJ1ltyFfV
	 kT5v/J2NSujFg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao
 <leitao@debian.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 17/18] rust: block: add remote completion to `Request`
In-Reply-To: <680BB9D0-3720-44EC-A25D-83806F635D8D@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-17-ec65006e2f07@kernel.org>
 <R-quyDdhLT8rgM7vBTBx_6hUbT6VXlKvJ0ueHYeoye0JcLGz6WqNuPJQGEn3yBbnokSWZaUWbsLlh-bVJQeSpQ==@protonmail.internalid>
 <680BB9D0-3720-44EC-A25D-83806F635D8D@collabora.com>
Date: Fri, 29 Aug 2025 13:12:51 +0200
Message-ID: <877bymidos.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Allow users of rust block device driver API to schedule completion of
>> requests via `blk_mq_complete_request_remote`.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> drivers/block/rnull/rnull.rs       |  9 +++++++++
>> rust/kernel/block/mq.rs            |  6 ++++++
>> rust/kernel/block/mq/operations.rs | 19 +++++++++++++++----
>> rust/kernel/block/mq/request.rs    | 17 +++++++++++++++++
>> 4 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
>> index 8255236bc550..a19c55717c4f 100644
>> --- a/drivers/block/rnull/rnull.rs
>> +++ b/drivers/block/rnull/rnull.rs
>> @@ -82,4 +82,13 @@ fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Res
>>     }
>>
>>     fn commit_rqs(_queue_data: ()) {}
>> +
>> +    fn complete(rq: ARef<mq::Request<Self>>) {
>> +        mq::Request::end_ok(rq)
>> +            .map_err(|_e| kernel::error::code::EIO)
>> +            // We take no refcounts on the request, so we expect to be able to
>> +            // end the request. The request reference must be unique at this
>> +            // point, and so `end_ok` cannot fail.
>> +            .expect("Fatal error - expected to be able to end request");
>> +    }
>> }
>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>> index 6e546f4f3d1c..c0ec06b84355 100644
>> --- a/rust/kernel/block/mq.rs
>> +++ b/rust/kernel/block/mq.rs
>> @@ -77,6 +77,12 @@
>> //!     }
>> //!
>> //!     fn commit_rqs(_queue_data: ()) {}
>> +//!
>> +//!     fn complete(rq: ARef<Request<Self>>) {
>> +//!         Request::end_ok(rq)
>> +//!             .map_err(|_e| kernel::error::code::EIO)
>> +//!             .expect("Fatal error - expected to be able to end request");
>> +//!     }
>> //! }
>> //!
>> //! let tagset: Arc<TagSet<MyBlkDevice>> =
>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
>> index 6fb256f55acc..0fece577de7c 100644
>> --- a/rust/kernel/block/mq/operations.rs
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -42,6 +42,9 @@ fn queue_rq(
>>     /// Called by the kernel to indicate that queued requests should be submitted.
>>     fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
>>
>> +    /// Called by the kernel when the request is completed.
>> +    fn complete(rq: ARef<Request<Self>>);
>> +
>>     /// Called by the kernel to poll the device for completed requests. Only
>>     /// used for poll queues.
>>     fn poll() -> bool {
>> @@ -143,13 +146,21 @@ impl<T: Operations> OperationsVTable<T> {
>>         T::commit_rqs(queue_data)
>>     }
>>
>> -    /// This function is called by the C kernel. It is not currently
>> -    /// implemented, and there is no way to exercise this code path.
>> +    /// This function is called by the C kernel. A pointer to this function is
>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>     ///
>>     /// # Safety
>>     ///
>> -    /// This function may only be called by blk-mq C infrastructure.
>> -    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request) {}
>> +    /// This function may only be called by blk-mq C infrastructure. `rq` must
>> +    /// point to a valid request that has been marked as completed. The pointee
>> +    /// of `rq` must be valid for write for the duration of this function.
>> +    unsafe extern "C" fn complete_callback(rq: *mut bindings::request) {
>> +        // SAFETY: This function can only be dispatched through
>> +        // `Request::complete`. We leaked a refcount then which we pick back up
>> +        // now.
>> +        let aref = unsafe { Request::aref_from_raw(rq) };
>> +        T::complete(aref);
>> +    }
>>
>>     /// This function is called by the C kernel. A pointer to this function is
>>     /// installed in the `blk_mq_ops` vtable for the driver.
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
>> index 3848cfe63f77..f7f757f7459f 100644
>> --- a/rust/kernel/block/mq/request.rs
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -135,6 +135,23 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>>         Ok(())
>>     }
>>
>> +    /// Complete the request by scheduling `Operations::complete` for
>> +    /// execution.
>> +    ///
>> +    /// The function may be scheduled locally, via SoftIRQ or remotely via IPMI.
>> +    /// See `blk_mq_complete_request_remote` in [`blk-mq.c`] for details.
>> +    ///
>> +    /// [`blk-mq.c`]: srctree/block/blk-mq.c
>> +    pub fn complete(this: ARef<Self>) {
>> +        let ptr = ARef::into_raw(this).cast::<bindings::request>().as_ptr();
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct request`
>> +        if !unsafe { bindings::blk_mq_complete_request_remote(ptr) } {
>> +            // SAFETY: We released a refcount above that we can reclaim here.
>> +            let this = unsafe { Request::aref_from_raw(ptr) };
>> +            T::complete(this);
>> +        }
>> +    }
>> +
>>     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
>>     /// of the request structure.
>>     ///
>>
>> --
>> 2.47.2
>>
>>
>
> I had another look here. While I do trust your reasoning, perhaps we should
> remove the call to expect()?
>
> If it is not called ever as you said, great, removing the expect() will not
> change the code behavior. If it is, be it because of some minor oversight or
> unexpected condition, we should produce some error output instead of crashing
> the kernel. Maybe we should use a warn() here instead? Or maybe dev/pr_err as
> applicable?

I think for the example, I would like to keep the `expect`. For
demonstration purposes.

We could do `warn!` instead for the rnull driver I guess. But the IO
queue that would hit this code would start to hang pretty fast, since no
IO would complete. I don't think the kernel can recover from this hang.


Best regards,
Andreas Hindborg





