Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537722ED87F;
	Tue, 17 Feb 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322083; cv=none; b=pBwkJMl7UubKPjWkVLs4HxRAJHz2OjEzDwILoJcjTtkH0UYlxOtvzOGPlBuIczt/GHrAdKpiPKLEMKe99QEW4bgFV+y+/R0m6YwNCuH5z36UayNxBm4BPola2q0G1r/gcIhiQg1/R2BXvYhAEu+ZsV/qyoQDc0b0S4Ym4DxnS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322083; c=relaxed/simple;
	bh=OvhRtzauUYE1vtiYM7Ck4byDcsw4wUNWtgU3sMsXlvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVWe/ynCmBc/REhHvppJrKN2KHbcroAnOB3OgZHZA5LvyiD1AF/z+f89a8KfYXUxan4pP/5M6iouftAdyxpdg69Lb+b4eKO5b7iHbMIbEts8mjssz+MeQWN6dCkAmiSDqHmTP5aoBy3B6d29PolnxrfLsGPc2R5Akv4snXRDZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/yigSBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/yigSBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E98C4CEF7;
	Tue, 17 Feb 2026 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771322083;
	bh=OvhRtzauUYE1vtiYM7Ck4byDcsw4wUNWtgU3sMsXlvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e/yigSBhw5HsG6R95eIIT87pjgr6Q12VzafeNce1IeQ3E0SxOAZ6GtUNpjXzmeZNl
	 mjr+WkX1Zu5qrOg0llSZa8uupppQw8nO0ddWc4CgVhZrhzo3rAtQPOKeqDXqNHw06l
	 mhW7Ht+9FtfsnFWmtp3+U4tasPucTG/Qql+0Of+QzY7lv88ZWR7Mr563HC/XcuFYgR
	 TZAILEzOpUcWJHN7t1If1tB18PZTVODae7G+wN5/xmICPuiOOIOQ9c91q4CKeBi2bW
	 URhQMuesFJfkU19AlWcaiMX1pP7PR77p8xHDsH24C91g2EVWlrg5SEL7hNzUAznvi/
	 Xynrlrb8dHlPA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Ken Kurematsu <k.kurematsu@nskint.co.jp>, Boqun Feng
 <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel Ojeda
 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, Thomas Gleixner
 <tglx@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Ken Kurematsu
 <k.kurematsu@nskint.co.jp>
Subject: RE: [PATCH 62/79] block: rust: add `TagSet::update_hw_queue_count`
In-Reply-To: <TYRP286MB59951867FB2026AAB52DA80FDB6CA@TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-62-de9a7af4b469@kernel.org>
 <DlelngRf2sXB2dUQOltrLhHN_bPwumkBYEef-iGa_6HSHxyilar1tt87eOVUD7v667_I--EPwiAeRc2-rA1jZA==@protonmail.internalid>
 <TYRP286MB59951867FB2026AAB52DA80FDB6CA@TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM>
Date: Tue, 17 Feb 2026 10:54:30 +0100
Message-ID: <87seazd7ah.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Ken Kurematsu" <k.kurematsu@nskint.co.jp> writes:

> Hi Andreas,
>
>> -----Original Message-----
>> From: Andreas Hindborg <a.hindborg@kernel.org>
>> Sent: Monday, February 16, 2026 8:36 AM
>> To: Boqun Feng <boqun.feng@gmail.com>; Jens Axboe <axboe@kernel.dk>;
>> Miguel Ojeda <ojeda@kernel.org>; Gary Guo <gary@garyguo.net>; Bj=C3=B6rn=
 Roy
>> Baron <bjorn3_gh@protonmail.com>; Benno Lossin <lossin@kernel.org>;
>> Alice Ryhl <aliceryhl@google.com>; Trevor Gross <tmgross@umich.edu>;
>> Danilo Krummrich <dakr@kernel.org>; FUJITA Tomonori
>> <fujita.tomonori@gmail.com>; Frederic Weisbecker <frederic@kernel.org>;
>> Lyude Paul <lyude@redhat.com>; Thomas Gleixner <tglx@kernel.org>;
>> Anna-Maria Behnsen <anna-maria@linutronix.de>; John Stultz
>> <jstultz@google.com>; Stephen Boyd <sboyd@kernel.org>; Lorenzo Stoakes
>> <lorenzo.stoakes@oracle.com>; Liam R. Howlett
>> <Liam.Howlett@oracle.com>
>> Cc: linux-block@vger.kernel.org; rust-for-linux@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-mm@kvack.org; Andreas Hindborg
>> <a.hindborg@kernel.org>
>> Subject: [PATCH 62/79] block: rust: add `TagSet::update_hw_queue_count`
>>
>> Add a method to `TagSet` that allows changing the number of hardware
>> queues
>> dynamically.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/block/mq/tag_set.rs | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/block/mq/tag_set.rs
>> b/rust/kernel/block/mq/tag_set.rs
>> index 4d00979a83dbd..47a162360e628 100644
>> --- a/rust/kernel/block/mq/tag_set.rs
>> +++ b/rust/kernel/block/mq/tag_set.rs
>> @@ -8,6 +8,7 @@
>>      bindings,
>>      block::mq::{operations::OperationsVTable, request::RequestDataWrapp=
er,
>> Operations},
>>      error::{self, Result},
>> +    prelude::*,
>>      try_pin_init,
>>      types::{ForeignOwnable, Opaque},
>>  };
>> @@ -34,7 +35,7 @@ pub struct TagSet<T: Operations> {
>>  }
>>
>>  impl<T: Operations> TagSet<T> {
>> -    /// Try to create a new tag set
>> +    /// Try to create a new tag se }t
>
> Is this a typo?
> It looks like an unnecessary ' }'.

Yes, that is a mistake. Thanks!


Best regards,
Andreas Hindborg



