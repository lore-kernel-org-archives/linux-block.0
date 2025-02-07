Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C481E;
	Fri,  7 Feb 2025 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887754; cv=none; b=nVamVha5v4zFyl3m8cqMAiFzDLzAFPGbltw89Z0jrFU8nXtLwwr7ekER+0ldDJxVfkOZ6xsJptvQl4ceXBKqqmN6Ne0DSg1pPkGH48qciRndRVzMm4MTWX3Ujjq75onN+mGThHuQKUnAbtvWUoZUbRd8x8XXbQpkQklmyPBYrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887754; c=relaxed/simple;
	bh=6b3ryVNAh20yAK7GjwDQ3dKje8y8c2XGMb6l1IDq7Zc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qszloXRL6p4fGYZBTSqRHmoUx/9w9bYOJRnu7Lohe4xkuqe7xkVx0M6aXT+U9gmcWcayGS2bzc2gSYgux7BsdGN28mFSXTwsABaqYJoMoE8kHSDTkSn4BBVDQYOCg2PNlN6cJHSViG9ULHzlDHevDTrUGxmBiXZsTrPXoUM45eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YfdshQHL; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YfdshQHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1738887743; x=1739146943;
	bh=9T7XSNw/kizcEbjL2Viub98tRwKtukopTvWu1rGwul8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YfdshQHLh09+E4e5L1Kg9RLonuPQopEj8WKC+jGe5XK8L/QIaBHZTZnh2Q5tCdMSg
	 FyVG0MxaWwBc3IrXXstl8yfE82ePHaa+jOFA3frbtwp112swXi8QLllNIW4dEjevU5
	 tI7nQVRYTlnZYDIiAGcWiG0/kN4Eibtkv/2YfwjTXTZaAaVDaTovbTVkleKMlZC3uD
	 TAQoWmFuTLm7a8R0wkLKcMTNFONfoeMFrvaALVlAhReXaFwOq1vm62+lHoxyfHBBib
	 eDS5WQ21e98c1upl7kt+v46wSWE8y+esnalim1Xa4inxKXN1IUOQW3zLwomUOFDLFI
	 8W00NKUzGnrYA==
Date: Fri, 07 Feb 2025 00:22:19 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Mitchell Levy <levymitchell0@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: lockdep: Use Pin for all LockClassKey usages
Message-ID: <7bc31b4e-cfe2-40ff-9a00-a73bff64df1c@proton.me>
In-Reply-To: <Z6UpNpefdxyvYBPe@boqun-archlinux>
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com> <20250205-rust-lockdep-v3-2-5313e83a0bef@gmail.com> <19dfbe36-237c-4da8-acfb-1d14069a8d1c@proton.me> <Z6UpNpefdxyvYBPe@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e69e7d16d99b7256a7ff876c462a0af5ee988207
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.25 22:27, Boqun Feng wrote:
> On Wed, Feb 05, 2025 at 08:30:50PM +0000, Benno Lossin wrote:
>> On 05.02.25 20:59, Mitchell Levy wrote:
>>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>>> index 41dcddac69e2..119e5f569bdb 100644
>>> --- a/rust/kernel/sync/lock.rs
>>> +++ b/rust/kernel/sync/lock.rs
>>> @@ -7,12 +7,9 @@
>>>
>>>  use super::LockClassKey;
>>>  use crate::{
>>> -    init::PinInit,
>>> -    pin_init,
>>> -    str::CStr,
>>> -    types::{NotThreadSafe, Opaque, ScopeGuard},
>>> +    init::PinInit, pin_init, str::CStr, types::NotThreadSafe, types::O=
paque, types::ScopeGuard,
>>>  };
>>> -use core::{cell::UnsafeCell, marker::PhantomPinned};
>>> +use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
>>>  use macros::pin_data;
>>>
>>>  pub mod mutex;
>>> @@ -121,7 +118,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for =
Lock<T, B> {}
>>>
>>>  impl<T, B: Backend> Lock<T, B> {
>>>      /// Constructs a new lock initialiser.
>>> -    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) =
-> impl PinInit<Self> {
>>> +    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassK=
ey>) -> impl PinInit<Self> {
>>
>> Static references do not need `Pin`, since `Pin::static_ref` [1] exists,
>> so you can just as well not add the `Pin` here and the other places
>> where you have `Pin<&'static T>`.
>>
>=20
> You're right about `Pin` not needed for 'static. However, the
> `Pin<&'static LockClassKey>` signature is the intermediate state, and
> eventually we will need to support initializing a lock (and others) with
> a dynamically allocated `LockClassKey`, and when that is available, the
> type of `key` will become `Pin<&'a LockClassKey>`, so `Pin` is needed.
>=20
> So I would like to keep this patch as it is. Works for you?

Makes sense and fine by me. It would be nice if it was also mentioned in
the commit message. Thanks!

---
Cheers,
Benno

>=20
> Regards,
> Boqun
>=20
>> The reasoning is that since the data lives for `'static` at that
>> location, it will never move (since it is borrowed for `'static` after
>> all).
>>
>> [1]: https://doc.rust-lang.org/std/pin/struct.Pin.html#method.static_ref
>>
>> ---
>> Cheers,
>> Benno
>>
>>>          pin_init!(Self {
>>>              data: UnsafeCell::new(t),
>>>              _pin: PhantomPinned,
>>> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/gl=
obal.rs
>>> index 480ee724e3cc..d65f94b5caf2 100644
>>> --- a/rust/kernel/sync/lock/global.rs
>>> +++ b/rust/kernel/sync/lock/global.rs
>>> @@ -13,6 +13,7 @@
>>>  use core::{
>>>      cell::UnsafeCell,
>>>      marker::{PhantomData, PhantomPinned},
>>> +    pin::Pin,
>>>  };
>>>
>>>  /// Trait implemented for marker types for global locks.
>>
>>

