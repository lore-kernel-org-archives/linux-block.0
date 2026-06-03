Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773746AEF2;
	Wed,  3 Jun 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487414; cv=none; b=XGbD+UREqRLb5wvWJsLxa6cNgtk4XI78f+WK9S4a5NiNwPutaKj5Le1C6lskIDu3rx7wWelcjTsRNXDqh8iNf0vpCxhjRPytUeBlpLhWe1ciJLrk9yHLIGyq+Bc5rI198FsDxHUeyG5MIedvhLS+AhLpeN+InOHQg8DG0z4y4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487414; c=relaxed/simple;
	bh=ngmyoHpUY5cQdGpUC3hqp+46Z7a2/n5kQyYdpSzVMCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NrH9g1VePcqCbyv/yRxAgRoRgzKTieb62XfFs0EwunFrc8rVrOnbw0oRNXJV1FPE+L6xNySXH3/SsnOUx+9KQtHM9wAvXRWW57cJrPVF2pYc0gCN2ZLgCbrfB0+qQWBtrZptXzjSLmDvD/LbBVXaFog09m/sMZyPhUmdxtm/XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhNJgko2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhNJgko2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF871F00893;
	Wed,  3 Jun 2026 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780487413;
	bh=g4Ne4AcnEVQJPDihAVbQKtYCONwWtwV6iW3rmzq4/l4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mhNJgko2iFrHnbrI9QLu/kPDYQAZDmWDKHZRVl3SPfbMAk1ZB4tR5upjdM8eH8wZU
	 caoE4IfkoWclszuykFOh61zvf/+Y7hCWEMJF10hzwrey3DSRb/i3rMFVWow8mqfC2a
	 ULL/udCkGCSKRA1ELKoWAjlNDsyrna8gbDBhwLxvcAgrZAR4TrigM8brab6sWPw4a8
	 m9KLsEjmeZzuSE9Pat6lW2Mow0flA/pAIhrhhDAAnG7TUUSHxJIV0x2q0UfkU1YBb9
	 ADXYoRF1UfFbWFlPcELNtmMYBGemS7ymRWCgoMUT0U4rrpdCj+1VMJCjoEBmUdFWy2
	 NlTHDJ8yC6HXw==
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
Subject: Re: [PATCH 10/79] block: rust: add `command` getter to `Request`
In-Reply-To: <abfbuJVbPtIEyweC@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-10-de9a7af4b469@kernel.org>
 <abfbuJVbPtIEyweC@google.com>
Date: Wed, 03 Jun 2026 13:50:01 +0200
Message-ID: <87mrxbkfme.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:34:57AM +0100, Andreas Hindborg wrote:
>> Add a method to extract the command operation code from a request. The
>> command is obtained by masking the lower bits of `cmd_flags` as defined by
>> `REQ_OP_BITS`. This allows Rust block drivers to determine the type of
>> operation being requested.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> With the nit below fixed:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>>  rust/kernel/block/mq/request.rs | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
>> index b49197a0c66d7..0dd329ae93dfc 100644
>> --- a/rust/kernel/block/mq/request.rs
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -78,6 +78,12 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
>>          unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
>>      }
>>  
>> +    /// Get the command identifier for the request
>> +    pub fn command(&self) -> u32 {
>> +        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
>> +        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
>
> Nit: scope of unsafe
>
> 	unsafe { (*self.0.get()).cmd_flags } & ((1 << bindings::REQ_OP_BITS) - 1)

The `&` is parsed as reference operator with this change. But we can do
this:

        use core::ops::BitAnd;
        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
        unsafe { (*self.0.get()).cmd_flags }.bitand((1u32 << bindings::REQ_OP_BITS) - 1)

Best regards,
Andreas Hindborg


