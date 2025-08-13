Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381D72612;
	Wed, 13 Aug 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092821; cv=none; b=R572mxmP+tW1CVgtmzY6uww8c8Yu6izmd8ZZBjBm5xEcc0B1O4Ydm9LV2WdNVfnTiiwQnq+KeQwyEeLsZtb7yHZk2393BGYtVYiZFSNoqmFHCzROnFr/1FDsuFKIVPgN4cTe2xspwuBEQDpY1Cp6SH5LhH7E7/KYJd2BjfjQaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092821; c=relaxed/simple;
	bh=EJYyeOv5ZSaTNdX5BL2jh/SZksaRmpZRfnRTezj2Irs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLFmywO+fm8oQWJfOqLgmYd7HsGzb54qRYS6e0R+xZC/T9DmHITFWVAKs02Xv63NfsGy6jHIYNM5rvjtDspI2Xs+a5vYJwm+7OH+dPleQF822fKD3flbHf9N3bN6YMcvTfkZnSYP4h9EPWgmKuD8y87V91Cy04gbog9f1FXQM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFJaXswK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFJaXswK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F879C4CEF6;
	Wed, 13 Aug 2025 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092820;
	bh=EJYyeOv5ZSaTNdX5BL2jh/SZksaRmpZRfnRTezj2Irs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EFJaXswKUs3cDdFU19fktK4ee4MHO1Ci8TCx4IVbq4J3ZHqAaeXNmj/f9SW7eCNtt
	 CGgSm8zhUIk6cC0LdcrD0ZhFw0zRPuPrt3WxF8Nu39Ojbur1sHYU0aFA65pK37S1Lc
	 0Ovd6PBZ4QV8T6/De/vletNvtURR012xCaMjxFZalIpr5tnJ1/ZvoN22WYgVM0KEX3
	 Y+n9+EinU1bgK4r6RKv7rjQROew+l+UtCioC5vYV16dzoxkkls/5Dgck0U21Q8KavX
	 DHM9VsPGFzeXO6ffB6Nf/hP+1ec5TCB28AMZLTpLNitOys/58AaNk4a7Ol3zYywNMA
	 aznm89cr+uhIw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/15] rust: block: add `GenDisk` private data support
In-Reply-To: <aJw_I-YQUfupWCXL@google.com>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-12-ed801dd3ba5c@kernel.org>
 <I-QXOGdDtTAVOcFvHZksoPqkYUZThmxrTUNw1h_MEGXdk_X_dc2txQdKJPMLz-yPmqL956iydAqVD9D5aL2SDQ==@protonmail.internalid>
 <aJw_I-YQUfupWCXL@google.com>
Date: Wed, 13 Aug 2025 14:56:58 +0200
Message-ID: <87a543fkh1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Aug 12, 2025 at 10:44:30AM +0200, Andreas Hindborg wrote:
>> Allow users of the rust block device driver API to install private data in
>> the `GenDisk` structure.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Overall LGTM.
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>>          self,
>>          name: fmt::Arguments<'_>,
>>          tagset: Arc<TagSet<T>>,
>> +        queue_data: T::QueueData,
>>      ) -> Result<GenDisk<T>> {
>> +        let data = queue_data.into_foreign();
>> +        let recover_data = ScopeGuard::new(|| {
>> +            drop(
>> +                // SAFETY: T::QueueData was created by the call to `into_foreign()` above
>> +                unsafe { T::QueueData::from_foreign(data) },
>> +            );
>
> This is usually formatted as:
>
> // SAFETY: T::QueueData was created by the call to `into_foreign()` above
> drop(unsafe { T::QueueData::from_foreign(data) });

I don't really have a preference, my optimization function was to
minimize distance to the unsafe block. Are there any rust guidelines on this?

>
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
>> +        drop(
>> +            // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
>> +            // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
>> +            // `ForeignOwnable::from_foreign` is only called here.
>> +            unsafe { T::QueueData::from_foreign(queue_data) },
>> +        );
>
> Ditto here.
>
>>          //    reference counted by `ARef` until then.
>>          let rq = unsafe { Request::aref_from_raw((*bd).rq) };
>>
>> +        // SAFETY: `hctx` is valid as required by this function.
>> +        let queue_data = unsafe { (*(*hctx).queue).queuedata };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
>> +        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
>> +        // `ForeignOwnable::from_foreign()` is only called when the tagset is
>> +        // dropped, which happens after we are dropped.
>> +        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };
>
> Is this cast necessary? Is it not a void pointer?

Leftover from old `ForeignOwnable` I think. I'll remove it.


Best regards,
Andreas Hindborg


