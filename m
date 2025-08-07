Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5B23A98D;
	Thu,  7 Aug 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553835; cv=none; b=npHcmUdPTW9LW1lBTZxrMLL8ct67n/dYlXg3zV97rVnbPa01hcSqXFqQgqTTeKHALom7TyVF57tY1bH5zssIg3Dr2/3i9cLS5PvIu/TM1n70mjcwNoE9GxkMWUL7VVIr1VR8I/jHrOIb5yOlIlot5YKhcWSYndUh9wnXQsWInyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553835; c=relaxed/simple;
	bh=7RIeFKXx+V7kZidyJJc//ST8NllIMveQacSADLAJKhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6yfzHjCdGM/Y2iSd1M4a7B1OXUKV+bykDPBKroCujNnnCkvVMxqdKVC0SivzbUIYLgUO+ysRe5j5uY6hjQ6qQkbhZeM5GwHrf2lx3J73SqR/PuWGW3OJQzWLLUIPZMjfHM/zv4b2MSoZjK3LaH+jJz8RmLndZB8K7bw0+zxS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7CZTkbF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7CZTkbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B0C4CEED;
	Thu,  7 Aug 2025 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754553835;
	bh=7RIeFKXx+V7kZidyJJc//ST8NllIMveQacSADLAJKhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c7CZTkbFCCZ56pGA9EGZBuXHDSDUcYlOl8q8WPUKCc1vRAOqYQOw9US4uXtmHUyQw
	 h87RwmWLmyoiugdNpWxVjohyYnG/phjp8VV29/kH8Rp0UhnsPkIy9+LNJNdEOjExCt
	 /0g9FpgdsQyVnBU++QaKCRU/ZX7A6HL8ou0fU4MXgCM/eq4PuzYOH0j0R5L/r47UiZ
	 o24AXV+t/e63e16hO/j5pJWet+/iK51IphlXvY4yq80QrHq/xn04/Djay8PDJVP0O6
	 EkyeZuEy7sTlBagHGxRnIAMiwlskqvW+otF1qqaaCqYf8IIihviPjgYj1jnAbMW1nW
	 w7CQ7CHh/XcRQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/16] rust: block: add block related constants
In-Reply-To: <8CD9F17A-0F1C-4EDC-A63D-F6A0EAC75F35@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
 <26Qee_40jnYM_I3VKYZXkC6A09oh2MrlsQbBEhm4bwcBhoM0nqHPvHm4APDGXsNQl6y07zuVne3-cfbI31KPpw==@protonmail.internalid>
 <8CD9F17A-0F1C-4EDC-A63D-F6A0EAC75F35@collabora.com>
Date: Thu, 07 Aug 2025 09:26:07 +0200
Message-ID: <87y0rv7fu8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Add a few block subsystem constants to the rust `kernel::block` name spa=
ce.
>> This makes it easier to access the constants from rust code.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/block.rs | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>
>> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
>> index 150f710efe5b..7461adf4d7e0 100644
>> --- a/rust/kernel/block.rs
>> +++ b/rust/kernel/block.rs
>> @@ -3,3 +3,15 @@
>> //! Types for working with the block layer.
>>
>> pub mod mq;
>> +
>> +/// Bit mask for masking out [`SECTOR_SIZE`]
>
> Missing period.

Thanks.

>
>> +pub const SECTOR_MASK: u32 =3D bindings::SECTOR_MASK;
>> +
>> +/// Sectors are size `1 << SECTOR_SHIFT`.
>> +pub const SECTOR_SHIFT: u32 =3D bindings::SECTOR_SHIFT;
>> +
>> +/// Size of a sector.
>> +pub const SECTOR_SIZE: u32 =3D bindings::SECTOR_SIZE;
>> +
>> +/// Power of two difference in size of a page and size of a sector.
>
> A bit hard to parse this.
>
> Maybe =E2=80=9CThe difference between the size of a page and the size of =
a sector,
> expressed as a power of two=E2=80=9D ?

OK.

>
>> +pub const PAGE_SECTORS_SHIFT: u32 =3D bindings::PAGE_SECTORS_SHIFT;
>>
>> --
>> 2.47.2
>>
>>
>>
>
>
>  let sector: usize =3D something;
>  let page_offset =3D (sector & block::SECTOR_MASK as usize) << block::SEC=
TOR_SHIFT;
>
>
> Wait, the parenthesis evaluate to usize, and the shift is a u32. How does=
 this compile?

That is all good. `Shl` has a ton of impls for integers [1].

Shifting more than 64 spaces on 64 bit system makes no sense anyway.

Best regards,
Andreas Hindborg


[1] https://doc.rust-lang.org/std/ops/trait.Shl.html

