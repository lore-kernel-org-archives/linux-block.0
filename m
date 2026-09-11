Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DD39022A;
	Fri, 11 Sep 2026 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133161; cv=none; b=mQXd5tHqC+2DaCWiT7UoXiF37PWZF4EDMK7E82RIarYGywgLbtJtfEeg6HJO2qojAWaM99zF0kchPcxtikodkckEEGM3/PY/bqjEGX/LuWiaM4JSdluc6kAkscS3sl1W9nRMvpTWQmGBuwiDOXjkMBii2WTq/bIBiqve+SKO6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133161; c=relaxed/simple;
	bh=zFyyWzdhfFZMVM5stqf613uCaXnIeVSxmc31g5HKUZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldRG3ptfGA+efkj+hq8IbutQrj6EoFKmZYy4TUQPd3CbJaINrnr0X1GUejTi4MkQ8kVJAqaeshedy37fE2dJ0A3GtB74pNrR9SPJwAunrvBKkEcbhKjz9yuk6m38UgVgPU/ZuduFa35nQv5zZK8UnZro6CkKN63rK+wvVDmMi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXtn1fiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXtn1fiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF51F00898;
	Fri, 11 Sep 2026 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133159;
	bh=b8hBkIDR5gbaIa/OcVZo7VYHM8DXFaO8ihp5gcV65Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VXtn1fiY2o5DXMdoNaf8ZzLgSZsGCdT7ZwNY6FB4pdySVmjeQIqo+jTZLfm3/q33+
	 LnCbzK/A0d6W3mHy5MlGsh+dOBxN4T+7UuC7if51SC4Y4WOsawT4loI6z4f/cPPsPb
	 LEHZm4NM/UiYfaaDB2e8nAEDA/bUbIeD89ffVwAWP5YoZyzbml/CvceH29+Tq6pfbc
	 5OiH8ODldkyB5xaiz0JQc+5SkYuDaxk8ZB5CaqnQ1olk+xod9sHadlEIgKFs0bPhqk
	 mpWXADE1ONaJWHe+tK1DyeoOXHAnAcaBRnsz8NpG1Ysw760kl3cXOV1DCzOlIhHu25
	 jY4cewUPGE/7g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul
 <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, "Rafael
 J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski
 <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Mangold
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v21 6/9] rust: Add `OwnableRefCounted`
In-Reply-To: <aqPHvi1xFnMXvYLW@google.com>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-6-e83257373062@kernel.org>
 <or1Yx6egJPyUT07SJzH5J4d8aI6S2qOc1sfl70J55bvsy-l2H0DHJHa-MeXQIv40mrfFILbhL0uB2G0aHIYUlA==@protonmail.internalid>
 <aqPHvi1xFnMXvYLW@google.com>
Date: Fri, 11 Sep 2026 15:25:43 +0200
Message-ID: <87se3fvs14.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Thu, Sep 10, 2026 at 11:00:10AM +0200, Andreas Hindborg wrote:
>> From: Oliver Mangold <oliver.mangold@pm.me>
>>
>> Types implementing one of these traits can safely convert between an
>> `ARef<T>` and an `Owned<T>`.
>>
>> This is useful for types which generally are accessed through an `ARef`
>> but have methods which can only safely be called when the reference is
>> unique, like e.g. `block::mq::Request::end_ok()`.
>>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> [ Andreas: Fix formatting, update documentation, fix error handling in
>>   examples. ]
>> Assisted-by: LLM
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>>  /// is implemented on types from the C side.
>>  ///
>> -/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
>> -/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
>> -/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
>> -/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
>> +/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type.
>> +///  - This is useful when it is desirable to tie the lifetime of an object reference to an owned
>> +///    object, rather than pass around a bare reference.
>> +///  - [`Ownable`] types can define custom drop logic that is executed when the owned reference
>> +///    of type [`Owned<_>`] pointing to the object is dropped.
>
> This diff looks like it should be in the patch introducing Ownable.

Yes, wrong target commit for the edit.

>
>> +/// # #![expect(clippy::disallowed_names)]
>> +/// # use core::ptr::NonNull;
>> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
>> +/// # use kernel::sync::aref::{ARef, RefCounted};
>> +/// # use kernel::sync::atomic::Acquire;
>> +/// # use kernel::sync::Refcount;
>> +/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
>> +///
>
> This newline will appear weirdly in generated docs because no content is
> shown above it. Consider not hiding the imports.

Will remove.

>
>> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
>> +    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`] if that is the case.
>> +    /// Otherwise it returns again an [`ARef`] to the same underlying object.
>> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>>;
>> +
>> +    /// Converts the [`Owned`] into an [`ARef`].
>> +    fn into_shared(this: Owned<Self>) -> ARef<Self>;
>> +}
>
> This trait provides two methods that have very different conditions for
> existing, IMO.
>
> The into_shared() method is so likely to exist, that I would almost
> consider placing it on the Ownable trait.
>
> pub trait Ownable {
>     unsafe fn release(this: NonNull<Self>);
>
>     fn into_shared(this: Owned<Self>) -> ARef<Self>
>     where
>     	Self: Refcounted;
> }
>
> On the other hand, I think try_from_shared() is more likely to be a
> tricky operation you cannot necessarily implement, and as such it can be
> on its own separate trait like you have here.

Ownable does not require RefCounted, so this method is not always
implementable.

>
> At the very least, I can easily imagine that some types can never become
> unique again after having been shared.

It could make sense to split the capability in a separate trait. But
perhaps we should wait with that till we need it and not introduce
premature complexity?

Best regards,
Andreas Hindborg



