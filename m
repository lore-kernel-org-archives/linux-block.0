Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178DD19A288;
	Thu, 13 Aug 2026 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580347; cv=none; b=huKWB2XCDjnTHi6ZL7FFapICyakzbvk0i4EjS6mjZ1o3qhxDbNcd9EVrl0lghAONj/DrT9LLoDEQtyRNtAInwNm4Jm1pQ0BvnCPkRErzSp0X0wgT263gubrCB9TflDgdPtDzgek3Eyl8Zvzm1X2yxs9B1vyL9BSF8pBGP/RIa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580347; c=relaxed/simple;
	bh=p9RdFBhv1eoyUw5/knwomMhrJLw+gkl8caK5fR6eOwg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ikaYzo4wukUNe/2t6Qz4cGAe2qxg7QsTMyCLqeHYPbpt4ty1n4Wu5vpJMpa5kQpizvxJB89fii9WOCcyeQ2jJMpWhRcAuVuMm0gRCiwEngTbdWqU7Um+TUkyzWskBQ0WccdiBXiQDLburT2p+Ku39cIrmXlelEmY5W75q8HaiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1brDirC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1brDirC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C350A1F000E9;
	Thu, 13 Aug 2026 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580345;
	bh=+SlSGOuNX1TZ7M6MiLLHH9rezuBa5FVnB0SFZWu5/6o=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=N1brDirC0ImWaLb3a2YVySmvKaz7pWOflIfKKF8P0n72nR1p0zLOePB0ZKFYKqZr4
	 bunv6c/FSpcRYVq8g+YQeBLlRTeqKFQjA6HxDI8SdTL8H6d9awmOw/8MQzpr38SqjY
	 Lawp0Om/x9H4M9FT7gX7SC+6LSEehgj6QAuWW6yo4T9KMvPEEi6fKYDbZNgBta3/k6
	 GIUXRNnxXiQrJIORha31qqvLNtvvDGSHKcl+Q4C5EPelt9GeDy4C4cRExXnd9thRih
	 7i9Djv0c32P5iPz7s5DIZLPgomlJWibBbR4zWDJXxv756SliUUeCAdSYDFhxWmrNfB
	 +/8eT3reSQ3mg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 02:18:55 +0200
Message-Id: <DKNDVFGPA2T4.1VRWDIHTBOROT@kernel.org>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
 <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
In-Reply-To: <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>

On Thu Aug 13, 2026 at 1:57 AM CEST, Gary Guo wrote:
> On Wed Aug 12, 2026 at 10:53 PM BST, Danilo Krummrich wrote:
>> (Cc: Mark)
>>
>> On Wed Aug 12, 2026 at 6:33 PM CEST, Miguel Ojeda wrote:
>>> On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev>=
 wrote:
>>>>
>>>> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, t=
hreads it
>>>> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates=
 configfs
>>>> and rnull to use `this_module::<LocalModule>()`.
>>>
>>> Applied to `rust-next` -- thanks everyone!
>>
>> This series has a semantic conflict with both the driver-core and the dr=
m-rust
>> tree:
>>
>> @Mark: When you merge driver-core-next after rust-next (which I think is=
 the
>> case) then you need to include the diff in [1] into the merge.
>>
>> In drm-rust-next the build fails with:
>>
>> 	error[E0425]: cannot find type `LocalModule` in the crate root
>> 	   --> rust/kernel/drm/gem/shmem.rs:628:5
>> 	    |
>> 	628 |     #[vtable]
>> 	    |     ^^^^^^^^^ not found in the crate root
>> 	    |
>> 	    =3D note: this error originates in the attribute macro `vtable` (in=
 Nightly builds, run with -Z macro-backtrace for more info)
>>
>> which is because the kunit test in rust/kernel/drm/gem/shmem.rs uses the
>> #[vtable] macro.
>>
>> This should be fixed up with a patch on top of this series in rust-next.
>>
>> I came up with to potential solutions [2] and [3]. I think with the new =
build
>> system we want [3], but I'm not entirely sure this works correctly with =
the
>> current build system in all cases (at least it did survive my tests).
>>
>> Alternatively, we could just open-code a dummy module as in [2] for now.
>>
>> [1] driver-core-next merge fixup
>>
>> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
>> index a4927452016e..17ca504b7f8d 100644
>> --- a/rust/kernel/serdev.rs
>> +++ b/rust/kernel/serdev.rs
>> @@ -87,7 +87,7 @@ unsafe fn register(
>>          }
>>
>>          // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
>> -        to_result(unsafe { bindings::__serdev_device_driver_register(sd=
rv.get(), module.0) })
>> +        to_result(unsafe { bindings::__serdev_device_driver_register(sd=
rv.get(), module.as_ptr()) })
>
> `module.0` shouldn't be used in the first place, it just happens to be vi=
sible
> due to the unfortunate placement at crate root.
>
> Perhaps you can update driver-core tree to use `as_ptr()`? It was already=
 there
> and not newly introduced in the series.

Heh, I just remembered that patch 1 of this series did fix this in a couple=
 of
places and assumed that it was introduced in the same patch without looking
further.

In that case I can throw in a patch in the driver-core tree; will send it
tomorrow.

>>      }
>>
>>      unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
>>
>> [2] Open-coded dummy module
>>
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index c04e6c5aa7e0..274924cfcc05 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -157,6 +157,15 @@
>>  /// Prefix to appear before log messages printed from within the `kerne=
l` crate.
>>  const __LOG_PREFIX: &[u8] =3D b"rust_kernel\0";
>>
>> +/// Dummy module type for `#[vtable]` impl blocks within the kernel cra=
te (e.g. kunit tests).
>> +struct LocalModule;
>> +
>> +impl ModuleMetadata for LocalModule {
>> +    const NAME: &'static str::CStr =3D c"rust_kernel";
>> +    // SAFETY: `try_module_get`/`module_put` handle null module pointer=
s gracefully.
>> +    const THIS_MODULE: ThisModule =3D unsafe { ThisModule::from_ptr(cor=
e::ptr::null_mut()) };
>> +}
>> +
>>  #[cfg(not(testlib))]
>>  #[panic_handler]
>>  fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>
> IMO this is the correct way, also consistent with
>
> https://lore.kernel.org/rust-for-linux/20260811-fix-fops-owner-v10-3-7e71=
776f9dbe@linux.dev/
>
> It might make sense to add this to rust-next.

I feel like [3] is the superior solution (just unsure about the build syste=
m
implications); once we have the new build system some subsystem crates will=
 be
actual modules, some will be always built-in. So, in general I think we wan=
t to
use the module!() macro.
