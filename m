Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BE331209;
	Wed,  3 Jun 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479876; cv=none; b=qgmAMEPgY0XlinEGptWxMUU6CvGsQB3p17hWa5nLXd9e+Sf08xuRgkG7LC32/J8VMKAc7k3bhbKRorgAzkbFq6iwgjl+8f0ziEDUqt37VB3Do8ikC4B1O5jlnxZUXqerWOFw2AYzflPzXiWZLPkkvG2iN7OzdW++WT6hMp5f/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479876; c=relaxed/simple;
	bh=pV0rD0MfboJQ+rti8+SFCnBXwS3O5TFSRmuDULjCRUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAdxmxHv7CqfANOlK7VIq3NilwnpO+gq8yYVRlqbpnxuWCuJub+PNoYZgDszCHHkyWN0EvN4c4e8RY9wHW2Gv62ozmvvmewrmIEHxEsI3PmlpfCzZ71aVgojHWEAGIMoJcjABTyENZavep/p65UFZm9uOiBvkRld9184wHj29Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/D6RtCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/D6RtCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D521F00893;
	Wed,  3 Jun 2026 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479873;
	bh=mpJeKk9lW29/IyZp1Ki8rVBSZO0YGcY1DZO51pxg2rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Y/D6RtCNAjdz39r7jaLowrxfi2HQQ3KQ38le3EyL+0WtbqPeghH97gJ+CSbc9vp+R
	 Zel4nYP/Nc0xzRLj8kVuAeXvOxrEdeCd6WLzmpCq9ZOlbhpa1AqD6Qhj5ZVMEMpizD
	 /q2uDvTzA0sAQyrlNmNI15QT2BE1cbf0K7EonIBxe8ottQNOfMoofCDsmIn+YBNH+N
	 narLE2TYJR35kjSqv4n7osaQrTGaOvmCwdogFbKRd/rpXldw2CsKztJEYYIvSgywi2
	 yfS2mOEuKSIgHSUzqngSflMMXx0Fr/kcWYumsaTZvqmHCyntR0PvUKfJH8NjZdwDXz
	 UE5BdWHxyURhg==
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
Subject: Re: [PATCH 28/79] block: rnull: add partial I/O support for bad blocks
In-Reply-To: <abf0FHWkQzbnOtqD@google.com>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-28-de9a7af4b469@kernel.org>
 <abf0FHWkQzbnOtqD@google.com>
Date: Wed, 03 Jun 2026 11:44:19 +0200
Message-ID: <87zf1cj6vg.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Mon, Feb 16, 2026 at 12:35:15AM +0100, Andreas Hindborg wrote:

<cut>

>> +fn is_power_of_two<T>(value: T) -> bool
>> +where
>> +    T: core::ops::Sub<T, Output = T>,
>> +    T: core::ops::BitAnd<Output = T>,
>> +    T: core::cmp::PartialOrd<T>,
>> +    T: Copy,
>> +    T: From<u8>,
>> +{
>> +    (value > 0u8.into()) && (value & (value - 1u8.into())) == 0u8.into()
>> +}
>
> This is in the standard library.

But there is no trait for this, the method is defined for concrete
integer types. I would still need to define a trait and macro implement
it for all integers.

We could do this in `kernel::num`?


Best regards,
Andreas Hindborg


