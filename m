Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7383ACEFF;
	Mon, 22 Jun 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132792; cv=none; b=bCfWlcunz0K1A2WkL08LcxsISCGiqmTieMHKqUJiojWgebYBz2ylDKYFQr1SU0BYeOE+0XHLg8lXWaEKLiTwADRaEreNtggC/Nx+SI0Xg5EqeRRcPTFUoMT7E9fZI7gaAM1NEMH+nMwUsf2NuGKuE3g/g6Z37wen3Ss2EdmCirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132792; c=relaxed/simple;
	bh=oRx1ZKCS0mBIWgGBnjbLos7jhHkBOVC7VyGiMgsKJjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6kjMsOF6qN0rbExQp73y1/tnwZlKqPXo6zzhmNyAMC5ipz0+It5DC/vqN5BbIiVzxhc/kDo6gT7j0gQFvdZP/KrBJw6Nrf2XdZBfxWKrckdhOJizgP9mWI9VVHUUGoB0iQjE3WbDtrMiT0iqK4JGxxBgxTW4bDdWGVmGusZLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=go9Zeynv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="go9Zeynv"
Message-ID: <2d54f3e0-3f35-4f97-b6af-b3ceb1aca246@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782132777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYFgGrvBWo9bIuXZp9hB0JAcY8NUw9s9RkRxEN+uS9I=;
	b=go9ZeynvfCDG3FqCedt+4g4p6F7nlA60DLWKRT+icywnFf6xQYwm7i80KAQL1WzurqfcaK
	36ifq1VJnY/Vgcm0ZBi0Mk3fefk9+KsaFrlRL2RNR+eiRRxII/OUx++x7/QLI4ITC936VK
	/KQjB0n+QsnMWYnFs5g4Lu/B9QtykTw=
Date: Mon, 22 Jun 2026 20:52:30 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/6] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-1-49d45cb37032@linux.dev>
 <DJFIQPLOVO4T.1K8T0VZM30LDA@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJFIQPLOVO4T.1K8T0VZM30LDA@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/22/26 18:50, Gary Guo wrote:
> On Mon Jun 22, 2026 at 3:44 AM BST, Alvin Sun wrote:
>> Since `const_refs_to_static` has been stable as of the MSRV bump, a
>> `ThisModule` pointer can now be used in const contexts.
>>
>> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
>> can provide their `ThisModule` pointer in const contexts such as static
>> `file_operations`.
>>
>> Move the `THIS_MODULE` static from the `module!` macro into the
>> `ModuleMetadata` impl, add a `this_module()` helper, and update `__init`
>> to use it.
>>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   rust/kernel/lib.rs    |  8 ++++++++
>>   rust/macros/module.rs | 34 +++++++++++++++++-----------------
>>   2 files changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index b72b2fbe046d6..50f5a7b5f028e 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -184,6 +184,14 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
>>   pub trait ModuleMetadata {
>>       /// The name of the module as specified in the `module!` macro.
>>       const NAME: &'static crate::str::CStr;
>> +
>> +    /// The module's `THIS_MODULE` pointer.
>> +    const THIS_MODULE: ThisModule;
>> +}
>> +
>> +/// Returns a reference to the `THIS_MODULE` of the given module type.
>> +pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
>> +    &M::THIS_MODULE
>>   }
> Also, FWIW I think this should not put this in the crate root. Perhaps create a
> modules.rs?

Makes sense. I'll create a new `module.rs` and move the module-related items
(`ModuleMetadata`, `ThisModule`, `this_module()`) there, then re-export from
`lib.rs`.

Best regards,
Alvin Sun

>
> Best,
> Gary
>
>>   
>>   /// Equivalent to `THIS_MODULE` in the C API.
>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> index 06c18e2075083..b9fdee2f2af47 100644
>> --- a/rust/macros/module.rs
>> +++ b/rust/macros/module.rs
>> @@ -497,28 +497,28 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>>           /// Used by the printing macros, e.g. [`info!`].
>>           const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
>>   
>> -        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
>> -        // freed until the module is unloaded.
>> -        #[cfg(MODULE)]
>> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
>> -            extern "C" {
>> -                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
>> -            };
>> -
>> -            ::kernel::ThisModule::from_ptr(__this_module.get())
>> -        };
>> -
>> -        #[cfg(not(MODULE))]
>> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
>> -            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
>> -        };
>> -
>>           /// The `LocalModule` type is the type of the module created by `module!`,
>>           /// `module_pci_driver!`, `module_platform_driver!`, etc.
>>           type LocalModule = #type_;
>>   
>>           impl ::kernel::ModuleMetadata for #type_ {
>>               const NAME: &'static ::kernel::str::CStr = #name_cstr;
>> +
>> +            #[cfg(MODULE)]
>> +            const THIS_MODULE: ::kernel::ThisModule = {
>> +                extern "C" {
>> +                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
>> +                }
>> +
>> +                // SAFETY: `__this_module` is constructed by the kernel at load time
>> +                // and lives until the module is unloaded.
>> +                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
>> +            };
>> +
>> +            #[cfg(not(MODULE))]
>> +            const THIS_MODULE: ::kernel::ThisModule = unsafe {
>> +                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
>> +            };
>>           }
>>   
>>           // Double nested modules, since then nobody can access the public items inside.
>> @@ -616,7 +616,7 @@ pub extern "C" fn #ident_exit() {
>>                   /// This function must only be called once.
>>                   unsafe fn __init() -> ::kernel::ffi::c_int {
>>                       let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
>> -                        &super::super::THIS_MODULE
>> +                        ::kernel::this_module::<super::super::LocalModule>()
>>                       );
>>                       // SAFETY: No data race, since `__MOD` can only be accessed by this module
>>                       // and there only `__init` and `__exit` access it. These functions are only
>
