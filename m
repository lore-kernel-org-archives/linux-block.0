Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB2270553;
	Fri, 15 Aug 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249038; cv=none; b=R4KwqP+0+RxnUjqS6WmmkbY6ssLXgQFZk9EglrzXJC6PComQh3/DJMReWF8uVCFtGP713vrLnwiGJt6h+JBebzS4S34YNH2ERnlCJfT6O1Kx69AK8YX2jX0lNWeb6HsMC+c1kYu1HMwylBfGGmtrI1a4Rm9UvAoVkXcslyGj090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249038; c=relaxed/simple;
	bh=1Ha9xTn3T01Z4w9TlI+3LodHQqvdp4I2XLyHH/S4Gkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TkFhKubWy8VzxyvPwK8EUrt5AnT20c2aSx6t2/5ug9V1kydyVubPZMCDyPwkOdGD02oL4OUCtUkiOdfwXR8NvkJJsEyEXZK7fdesIe3HF5AOkoKTPsAE99Oat8AaR6g+31fe1hxAEQHVmpUKst7f9kz68JGf/4oAuYxhmeCGVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkNesCAs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkNesCAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B89C4CEF4;
	Fri, 15 Aug 2025 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755249036;
	bh=1Ha9xTn3T01Z4w9TlI+3LodHQqvdp4I2XLyHH/S4Gkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WkNesCAskg/QW2w1/FQNss4Hvhyeo1cnDm4vhZ1e8fHwu5HbEu77kiCxKax7CVTWL
	 SQqYQFFy/7REIced2yy5XNSP+8FkcOUHISBZJuOfikgXY4PL0sVw4IxQTRudC6WPIC
	 ihFFSy669LVtWhnHeDzGfi8x1MMaqoG8t/5R2JKnfShIpr6FxjDXfaMhJ1oBneM/D3
	 XsHvXZpgU82rs4Z1LUsQ+espPx+BUmvjBRzwcafMbLGq3otLPGFssSKaotaWoPi8KP
	 lrNVDwW4TSCJmb68ZIpF4qkL89yNBw7gjtPhdkzcE+23B7SBPi2PXRkgYCBe6dUTiW
	 eL2nSEGTQW+CQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/18] rust: block: add `GenDisk` private data support
In-Reply-To: <aJ7tcmOHfFmHgrY9@google.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-15-581453124c15@kernel.org>
 <Addn5RH8T6dPmcfVeF6HXK4Q3rVuAz-0N8es2JtgnRl3UhXIJhicxoB5Ns_F8aD2-sflnPXC6oeBQDLtCfXtLA==@protonmail.internalid>
 <aJ7tcmOHfFmHgrY9@google.com>
Date: Fri, 15 Aug 2025 11:08:59 +0200
Message-ID: <87cy8xdk9g.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Aug 15, 2025 at 09:30:50AM +0200, Andreas Hindborg wrote:
>> Allow users of the rust block device driver API to install private data in
>> the `GenDisk` structure.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>>          self,
>>          name: fmt::Arguments<'_>,
>>          tagset: Arc<TagSet<T>>,
>> +        queue_data: T::QueueData,
>>      ) -> Result<GenDisk<T>> {
>> +        let data = queue_data.into_foreign();
>> +        let recover_data = ScopeGuard::new(|| {
>> +            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
>> +            drop(unsafe { T::QueueData::from_foreign(data) });
>> +        });
>> +
>>          // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>>          let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>>
>> @@ -113,7 +121,7 @@ pub fn build<T: Operations>(
>>              bindings::__blk_mq_alloc_disk(
>>                  tagset.raw_tag_set(),
>>                  &mut lim,
>> -                core::ptr::null_mut(),
>> +                data.cast(),
>
> Is the cast necessary?

Not any longer, no.


Best regards,
Andreas Hindborg


