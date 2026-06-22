Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49E3ACA46
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132183; cv=none; b=rJtFePtUWSNB5iHFPySONWQhZ7cK35UJUSVa6sBkg2KKHbdmEz31cqsIjnKmBxtz2fen+C4+l3cPLkLVjY/bqy8x4PzLbAPX3W3e8f63ovZcThfb29cBvzRnv4eMM/eaNWCTERz5o9aTgGytNOi0VEof7U2uDHmU+b0J1dKCK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132183; c=relaxed/simple;
	bh=utmAMcDGDjQmBDf1w/Ak2DFft5nBmi6H323DLy5kSPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7E4IMznYlay/cxaj6Rdmq1lQzZRd3xBBpDpZRI2co4FUPzwysg+NeV6PuwLlDTNIcJjH2zmGSd46eqjF2n4y894///pTbrauK9/uG5CH0ZIf3KQlY1J6TmwqkvSDUak/036/TQLxbsSkh+qHPoieZ82AdAjEIVPw5R12K2ZXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=joTryDYq; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="joTryDYq"
Message-ID: <0494d714-db5c-4358-86e1-37527f52e7f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782132179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faCZmH5g5Ta9m2J6zC+tR3/ZZXd4+AmOWxaxfSCmJCM=;
	b=joTryDYqD7RqwYRfmbnTLuKFTJVfgXhanPbTiE3S+r8y1qOVGB+xcLyAm9Fohu/5OaIr+P
	YPWhIg9XER/ei55WL2hAW8PUODttUqHpjKLmi0VbG7XKlebnd5hGUVupZIsOq7yiU71RhY
	WcpVo0P21fdV4aLrd6dNqxvzkLGcHQ4=
Date: Mon, 22 Jun 2026 20:42:27 +0800
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
 <DJFIKIXLML05.3KYOXUGZYJRDZ@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJFIKIXLML05.3KYOXUGZYJRDZ@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/22/26 18:42, Gary Guo wrote:
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
> Doesn't this break existing users of THIS_MODULE?

You are right, I missed binder. I will add a patch to update binder to use
`this_module::<LocalModule>()` in the next version.

While looking into this, I also noticed `gen_disk.rs` has a `// TODO: Set to
THIS_MODULE` with `owner` still set to `null_mut()`.

Best regards,
Alvin Sun

>
> Binder, rnull and configfs macros are using it.
>
> Best,
> Gary
>
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
