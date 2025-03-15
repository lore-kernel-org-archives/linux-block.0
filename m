Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C471C84C6
	for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032079; cv=none; b=h/Fch4c19taLpKo3Tafkg+VD9dEknidA3iY8Yf88zLBE96CpN0bsXdMe1sEhfqrWBusGpMccCw3gGS+2mFW+2R9xhfyWzQHPMLjc4he4O0/JJrpM7AFojNWlU8Wwr1J55ukALpuWd6Q6+Uo3imkrVzq9pbqJcdHZUMGIbyhbv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032079; c=relaxed/simple;
	bh=7CqIO2/a0U9+oy6kNqO6XNpT52/jDsv0DiXJpmmUevA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfuuOR1x6/ld/PtseLd+CEbysXKVAnGHVlgkJt/TE+uR663RSvkLLPSDgu4p9Z2XWQy3M37ScEo1za74IzcmPNRtAgUvTa1nd9X+V/FPjtdCegmjn+doddRInECTR7d7HGW+yzjh9NwsAFuH3uIdlwtihHbwz5PZVatU4j+C/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=huhRdlgp; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="huhRdlgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742032075; x=1742291275;
	bh=YpMrKdCi6avddH9GQIVObLt9iwLl9bTrbYaJbhO6aWs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=huhRdlgpk0zebEQhrgVrn61dI92d0m27GER/kzfWLJ8X2bK9QJPTc/zEU3l6MM8PE
	 msflN1IByzbQOCx08jmvjixBLTxEHezv+d/ex8q5RTv5oOpStFdobWgHZnpCglf+GW
	 4SrFNcTURHgHO2DOyu9KgU6JUp4WH0S0V0LGOcJr/gD6p8t94++9hTf7fNYNC91dud
	 fRB4ASTPQxXB1mizw+ZsaimzeDbgp2NQqN4i3LI2Ts5UbBTcnoJUOZAb6rNlz9T6VS
	 YM/iPt0GO2hfhA+6BwNtjMhQvGBMWTgrhImtggYdXQfKctdtaPspGUlbxHQNj18xLZ
	 OWuYN4da9wX6g==
Date: Sat, 15 Mar 2025 09:47:51 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Antonio Hickey <contact@antoniohickey.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
Message-ID: <D8GQTTOG3YEA.L56HVS2ZWZMK@proton.me>
In-Reply-To: <67d4c889.050a0220.35d7ce.b4b0@mx.google.com>
References: <20250314234148.599196-1-contact@antoniohickey.com> <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com> <67d4c889.050a0220.35d7ce.b4b0@mx.google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f41ba0e3cf90358c69c91d746250ed35f9c78c43
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 1:23 AM CET, Boqun Feng wrote:
> On Fri, Mar 14, 2025 at 11:41:55PM +0000, Antonio Hickey wrote:
> [...]
>> @@ -541,7 +541,7 @@ macro_rules! stack_try_pin_init {
>>  ///
>>  /// ```rust
>>  /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
>> -/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
>> +/// # use core::marker::PhantomPinned;
>>  /// #[pin_data]
>>  /// #[derive(Zeroable)]
>>  /// struct Buf {
>> @@ -554,7 +554,7 @@ macro_rules! stack_try_pin_init {
>>  /// pin_init!(&this in Buf {
>>  ///     buf: [0; 64],
>>  ///     // SAFETY: TODO.
>> -///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
>> +///     ptr: unsafe { &raw mut (*this.as_ptr()).buf.cast() },
>
> This should be:
>
>
> ///     ptr: unsafe { &raw mut ((*this.as_ptr()).buf).cast() },
>
> , right?

I'd say it has to be `ptr: unsafe { (&raw mut ((*this.as_ptr()).buf)).cast(=
) }

---
Cheers,
Benno

