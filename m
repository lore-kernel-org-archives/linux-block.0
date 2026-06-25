Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E990316192;
	Thu, 25 Jun 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420132; cv=none; b=Ca1qL2uc1gcQbVS8iqPlVTgMbLPFKo1hwv3YIaQtExN9tXl4dqTOuKxXgGTjRB3siJJYyBQiIyedQZU8YUkvqklXHnvv927ZtKj7Wou8OsJAKJA+INV+8OaUHfugW9W0eR41+0LAeQBFvtQ7tbHBxjop0eZ85mW2ua5M65+uD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420132; c=relaxed/simple;
	bh=9KmYKTZYm6BLoZCbAkb58dXWN3V3G68n8k2r+SKYfig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ojb+DNvyK8q+7NJ+HQwph4tU9YULQGntHsL1Hxx/O7yGzUuIQXxvbIgXVU7iVOgCzVNaL9tubbwu3SDdrHEgBW4EOwR3rjygyDD+Sf4gy6GBYUcU9y/MiLNuyy6P6plAYGi9VYrDLTj/7zLK4cvy6Q+B2jdt9C5pg9SB1NePUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J42nwSbC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J42nwSbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6161F000E9;
	Thu, 25 Jun 2026 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782420131;
	bh=JvlsNB+ervCF+sSkJEPbN4Ijm830xLpfVQiWgPNgpJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J42nwSbCRvM0JMjF02PGznrxY18hUTDWVZ7tp9Th64egsofZWFuK/7UwkXSOiRMWZ
	 JFb4QbKQRBo1ee2fgXL4731g8g5ZKzhOektm+yfvSxklJkQC5qdKNXM7OsyGK4z/tY
	 7jjlUpMGk4xKRsvKVa6Ep/nb13JWkOg5psKsGHVL12oqfaiiky+CVSym81jwqCaUJd
	 l0RSq4P99yJkSjwmgCdMrOVUExxK7WZ1uEcahg8Pc27XeAso/gLvzUpXefzzEJr9fg
	 eaOccN7Oxpq5Nq5P16tkAeJOKLakhws44CZBq+jtnWPcBaYjoZ+eeFOMpFoUsZb9wW
	 GGmRDKHSaUNGg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Uladzislau
 Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Igor Korotin
 <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski
 <m.wilczynski@samsung.com>
Cc: Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 driver-core@lists.linux.dev, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v18 3/8] rust: implement `ForeignOwnable` for `Owned`
In-Reply-To: <DJI5ZY2TPFSW.BEKOVZYRSTQZ@garyguo.net>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
 <DJI5ZY2TPFSW.BEKOVZYRSTQZ@garyguo.net>
Date: Thu, 25 Jun 2026 21:47:35 +0200
Message-ID: <87y0g2h06g.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Thu Jun 25, 2026 at 11:15 AM BST, Andreas Hindborg wrote:
>> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
>> places such as the `XArray`.
>>
>> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
>> implement `ForeignOwnable`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/owned.rs | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> index 7fe9ec3e55126..9c92d4a83cc1b 100644
>> --- a/rust/kernel/owned.rs
>> +++ b/rust/kernel/owned.rs
>> @@ -15,6 +15,8 @@
>>      ptr::NonNull, //
>>  };
>>  
>> +use kernel::types::ForeignOwnable;
>> +
>>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>>  /// is implemented on types from the C side.
>>  ///
>> @@ -186,3 +188,54 @@ fn drop(&mut self) {
>>          unsafe { T::release(self.ptr) };
>>      }
>>  }
>> +
>> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
>> +// pointer satisfy alignment requirements of `T`.
>> +unsafe impl<T: Ownable> ForeignOwnable for Owned<T> {
>> +    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
>> +
>> +    type Borrowed<'a>
>> +        = &'a T
>> +    where
>> +        Self: 'a;
>> +    type BorrowedMut<'a>
>> +        = Pin<&'a mut T>
>> +    where
>> +        Self: 'a;
>> +
>> +    #[inline]
>> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {
>> +        let ptr = self.ptr.as_ptr().cast();
>> +        core::mem::forget(self);
>> +        ptr
>
> I think the pattern in `into_raw` is better:
>
>     ManuallyDrop::new(self).ptr.as_ptr().cast()
>
> Or perhaps this can just use `Self::into_raw(self).as_ptr().cast()`.
>
>> +    }
>> +
>> +    #[inline]
>> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
>> +        // INVARIANT: By the function safety contract, `ptr` was returned by `into_foreign`, which
>> +        // gave up exclusive ownership of a valid, pinned `T`; we retake that ownership here.
>> +        Self {
>> +            // SAFETY: By function safety contract, `ptr` came from
>> +            // `into_foreign` and cannot be null.
>> +            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
>> +        }
>> +    }
>
> Same here, could be using `Self::from_raw`.
>
> However, the current code looks correct to me regardless, so:
>
> Reviewed-by: Gary Guo <gary@garyguo.net>

I'll defer to `{into,from}_raw`. Keeping your tag.


Best regards,
Andreas Hindborg



