Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF221B9C0;
	Thu,  7 Aug 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562001; cv=none; b=bndP9Quz2o5JBVAKkHfiHbaKl+8DPbBZcTfMXYoXlIDZFB5+KfLddf83+pQDIUIS0uiudLkQhEOI32L5QKg4TW9L2bCo5MMToow8G+TbebY2MLh5TUtmZV+fgw1Wn4FCGLYcEFqI3DZIt1dLjQmLIzdFJgWZr82EYyz1d8m/t+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562001; c=relaxed/simple;
	bh=g5fMARJkStIZRukybN28ZxPDEiWlSxFkOz8YjlHIsXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwnVXT5oZha9wEuqeCDtfRA/6TDUFtaVxsPuHNRt8acxnyspQGsR7szXVawro63JHWqaVpee8SzTf3Ri1rkSVVpBdKpTJAf3VoIW38ECbUirr1TvPi+uFDSXP5owj+/mrvLq+dJCi8sAzTta70OppBYP55HSKDP27t2kJgj2kWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKnROJao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKnROJao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B87FC4CEED;
	Thu,  7 Aug 2025 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754562000;
	bh=g5fMARJkStIZRukybN28ZxPDEiWlSxFkOz8YjlHIsXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KKnROJaoYnTv0vN9keIPCURYfrwib0IuDIfzzzkAt8wCfBvvALzXxjPFjwWZhMhOb
	 BdwTesh+o+tQp+8XvYNchveaHMmHdkQ5e4gCtYJ0SKqJ7Y5cwe+OLik/lPBje+9tJv
	 1rDzZDxV4FuxjDfQlnnNUDW+V3YYploYNVAUjPtniHH39fHSjrDMvFeiMe+rAAUX17
	 mvOi2/6o1dVNbDUuihsBusu1z8JtBoC5rVlfYw9Fz7t96QngdMqbJ8+akA44gzR6he
	 D8bIeBbthjU3GcEy334jQqo1Qzf/4llTGxhZyoDxRXIbhEQPQAgddB5eUQS4kPKHEu
	 CXbWXQPTJLQow==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/16] rust: block: add `GenDisk` private data support
In-Reply-To: <aHYkkQpFOIcKuK-v@google.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-13-3a262b4e2921@kernel.org>
 <-KgJHntx-n5a5umJjT0FGpcfzzMW3y5_vQAbYz3taMckXoUccILBz4xT9ZVzkRZS98UDGX4KXm7qdGK9713Iig==@protonmail.internalid>
 <aHYkkQpFOIcKuK-v@google.com>
Date: Thu, 07 Aug 2025 11:57:49 +0200
Message-ID: <87pld778te.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Jul 11, 2025 at 01:43:14PM +0200, Andreas Hindborg wrote:

..

>> @@ -97,7 +98,14 @@ pub fn build<T: Operations>(
>>          self,
>>          name: fmt::Arguments<'_>,
>>          tagset: Arc<TagSet<T>>,
>> +        queue_data: T::QueueData,
>>      ) -> Result<GenDisk<T>> {
>> +        let data = queue_data.into_foreign();
>> +        let recover_data = ScopeGuard::new(|| {
>> +            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
>> +            unsafe { T::QueueData::from_foreign(data) };
>
> I think this is clearer to read as
>
> drop(unsafe { T::QueueData::from_foreign(data) });

OK.

>
>> +        });
>> +
>>          // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>>          let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>>
>> @@ -112,7 +120,7 @@ pub fn build<T: Operations>(
>>              bindings::__blk_mq_alloc_disk(
>>                  tagset.raw_tag_set(),
>>                  &mut lim,
>> -                core::ptr::null_mut(),
>> +                data.cast(),
>>                  static_lock_class!().as_ptr(),
>>              )
>>          })?;
>> @@ -166,8 +174,12 @@ pub fn build<T: Operations>(
>>              },
>>          )?;
>>
>> +        recover_data.dismiss();
>> +
>>          // INVARIANT: `gendisk` was initialized above.
>>          // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
>> +        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the call to
>> +        // `__blk_mq_alloc_disk` above.
>>          Ok(GenDisk {
>>              _tagset: tagset,
>>              gendisk,
>> @@ -179,9 +191,10 @@ pub fn build<T: Operations>(
>>  ///
>>  /// # Invariants
>>  ///
>> -/// - `gendisk` must always point to an initialized and valid `struct gendisk`.
>> -/// - `gendisk` was added to the VFS through a call to
>> -///   `bindings::device_add_disk`.
>> +///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
>> +///  - `gendisk` was added to the VFS through a call to
>> +///    `bindings::device_add_disk`.
>> +///  - `self.gendisk.queue.queuedata` is initialized by a call to `ForeignOwnable::into_foreign`.
>>  pub struct GenDisk<T: Operations> {
>>      _tagset: Arc<TagSet<T>>,
>>      gendisk: *mut bindings::gendisk,
>> @@ -193,9 +206,20 @@ unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
>>
>>  impl<T: Operations> Drop for GenDisk<T> {
>>      fn drop(&mut self) {
>> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid
>> +        // and initialized instance of `struct gendisk`, and, `queuedata` was
>> +        // initialized with the result of a call to
>> +        // `ForeignOwnable::into_foreign`.
>> +        let queue_data = unsafe { (*(*self.gendisk).queue).queuedata };
>> +
>>          // SAFETY: By type invariant, `self.gendisk` points to a valid and
>>          // initialized instance of `struct gendisk`, and it was previously added
>>          // to the VFS.
>>          unsafe { bindings::del_gendisk(self.gendisk) };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
>> +        // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
>> +        // `ForeignOwnable::from_foreign` is only called here.
>> +        let _queue_data = unsafe { T::QueueData::from_foreign(queue_data.cast()) };
>
> Ditto here.
>
> drop(unsafe { T::QueueData::from_foreign(queue_data.cast()) });

Thanks, I agree.

>
> Also, is this cast necessary as of
> https://lore.kernel.org/all/20250711-rnull-up-v6-16-v3-13-3a262b4e2921@kernel.org/
> ?

I think you have the wrong link, you probably refer to the recent
`ForeignOwnable` change. And yes, the cast is redundant.


Best regards,
Andreas Hindborg



