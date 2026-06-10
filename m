Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387CD3BB9E3
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082913; cv=none; b=U+a1CGjlElYbPvO1rLmLGjFAzucft1KNzpn4kHF8qvR2TpSfgz/BwJCxZARj5ChSi+Z+zL3YQfPZhzWwySSd8y1ip7Agc4yCU63T/+FDgsbsQ6qcB3VQvcPasYWg0UDS1SRsgZf5NpURsaGcjNfVB2Sz9ty1jdROvk+1mNse4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082913; c=relaxed/simple;
	bh=1JkR1hbOCLJZoR7hn6Vgwz397nHxcU8TBPRKLnXrRlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa4hfWCGkrWUEUbIeARRm9JuO4/5Z8llDNPViuhGIA/520tccgIPSKLi7nILeMZBKArZeMBzRIvqw8JWkpCpTMsrbJsS/lqegk1iBuGJf1q70wxUk+zL6cf8zxHw33L5O63UAqfptxWPcXhZ18JZ+9BnEvAEnABRJSTg8+7Q7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsP9UB1M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsP9UB1M"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso34121915e9.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082907; x=1781687707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5Prh1dokxwNfkvG5vetqS1haHW2YH34Ns7htP9isiQ=;
        b=lsP9UB1MimVu07WpHdjyfBn7NUeruDL5RHFL6tq2/uLal5I7ZELwbBnePNcSDFkybf
         tUc8wXgiGQDUMB2zFmAzSOwjv3PZRTaLbLy8Xp9pfgqcdI/Qcxyr6niaGf4f6VUymvMs
         xOnrq9EM54gEHkPbvAUkJ9vLfCUOVOmD9ftCrtLXXQIwPaNjGQMhkQVXf0AHnIX+51Gl
         KWAj3wlMtm6cuoIHnTVFxkq6gG0NwhutKb9375fGTfT6Mh9KKjQBDH7+KfKjsrqqfgBn
         KmacWK4JaSyGrfSbsoD0oUQgQ1Wp+Fch3CChPq4iYxzb7aBhbzcKLVfsj6hiL8Hvu8FK
         bSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082907; x=1781687707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5Prh1dokxwNfkvG5vetqS1haHW2YH34Ns7htP9isiQ=;
        b=mjSs1O9T+2L5N43QahvggFiWiNAajTjMwnLJ29hw8qoQIdTJJcZVD5HQi2K/v7z6lk
         ryqJCLItEmaqa+Tcr8qUlX03qaPC6v6ONDls3kXxhaXiCbSmC15RwK1oqIHBFHfu6Stf
         YTzaj915aKsH292OnbbO+0VU0SwMCDMb91pe5x4KA9fmYmFurzcDtcZfN+eps6GhxuRr
         0VgEYEiFydjDAaq54mCv/cuKjE15cJ78EQZwVC0EKaiuHhSYZu4wE0Z6IRVOVCu1whXs
         OLGW9bMBl4RymEey8Jxg5qQowE8xCZUwO7uw6/I/5r50yath8MFijT0yONRBZIWSWDqO
         bruQ==
X-Forwarded-Encrypted: i=1; AFNElJ/at+n2topjkEC2UTMjBiWIlzSbw1pmriUBGZtLtV6I+/YOl2oKcxG5uuYjYFm1kyZ9zlv2mz3toSdiIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLVlyRI21a/IQNYSfPucewK5w5ZrnoSY50tLGQAHGqKXapyJl
	hdUkKqYuBYb8wTHj5qiv/eo3aGLasH5DlUKoku167qJIBtbIUeNO2BH4
X-Gm-Gg: Acq92OGoUCYwx33i2wjrHHzMFOresthhfZo2/mmfaGmKq7be9/OAKrevDPXKZ6XKjcH
	fpSE7/3JPVOoKYfpp77sU6KEwFIlgW5KcVhubseX0p5xZoizsNH/uXDzrGVRjqyYn4iGL83qvz7
	yV6GlXfKjbv2EO7NrmxI3Poaditrq4mjLCF5Jm/sDApsuHgS/cYHjtNA0H/C3LJPZOn1L3RpNFH
	2lg0XJ/n+XtlxY8qPreerBvvBs2fGTyhrwtyD16Zd1sAw9NmRC1mzLhLzzU3fwUq0lcf786mHAM
	bGLQFHOZMarSjAoxml1JzvdVXya60924iwppxHkbH7HW0WK6IpJoEpqe5EMxMrusYFSHTOPKgZO
	Qd+Ee8Z1GoNf7JJx5XjbwQBdn2e7XcKkRWrbhi4tuid7WzA8mUCRLKDtL8abJRotlFI+ilHu149
	EYXds2dswJBHkL9vYUSHJZR2eBK/lfNDUwJ65lIXQU7IRx/kAQ9ioEAWMmAUTBTNargVaxxAWoE
	A==
X-Received: by 2002:a05:600c:6388:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490c2d1412emr306094195e9.14.1781082907244;
        Wed, 10 Jun 2026 02:15:07 -0700 (PDT)
Received: from [172.16.16.15] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcaf4548sm28915245e9.2.2026.06.10.02.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:15:06 -0700 (PDT)
Message-ID: <f6a513e8-227f-4b22-bd4d-81d88536eff1@gmail.com>
Date: Wed, 10 Jun 2026 11:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: add procedural macro for declaring configfs
 attributes
To: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20260603-configfs-syn-v2-1-cb58489c2647@gmail.com>
 <DIZHKJSZXQ4Z.6SPXJVGDV9ZW@garyguo.net>
Content-Language: en-US, en-AU
From: Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <DIZHKJSZXQ4Z.6SPXJVGDV9ZW@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/26 4:32 PM, Gary Guo wrote:
> On Wed Jun 3, 2026 at 3:08 PM BST, Malte Wechter wrote:
>> Implement `configfs_attrs!` as a procedural macro using `syn`, this
>> improves readability and maintainability. Remove the old macro and
>> replace all uses with the new macro. Add the new macro implementation
>> file to MAINTAINERS.
>>
>> Signed-off-by: Malte Wechter <maltewechter@gmail.com>
>> ---
>> Changes in v2:
>> - Add a try_parse helper function to macros/helpers.rs
>> - Fix bug where 'child' configuration gets dropped if trailing comma is missing (sashiko)
>> - Link to v1: https://lore.kernel.org/r/20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com
>> ---
>>   MAINTAINERS                     |   1 +
>>   drivers/block/rnull/configfs.rs |   2 +-
>>   rust/kernel/configfs.rs         | 251 ----------------------------------------
>>   rust/macros/configfs_attrs.rs   | 182 +++++++++++++++++++++++++++++
>>   rust/macros/helpers.rs          |  15 +++
>>   rust/macros/lib.rs              |  85 ++++++++++++++
>>   samples/rust/rust_configfs.rs   |   2 +-
>>   7 files changed, 285 insertions(+), 253 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2fb1c75afd163..45f7a1ec93b45 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6464,6 +6464,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git config
>>   F:	fs/configfs/
>>   F:	include/linux/configfs.h
>>   F:	rust/kernel/configfs.rs
>> +F:	rust/macros/configfs_attrs.rs
>>   F:	samples/configfs/
>>   F:	samples/rust/rust_configfs.rs
>>   
>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>> index 7c2eb5c0b7228..f28ec69d79846 100644
>> --- a/drivers/block/rnull/configfs.rs
>> +++ b/drivers/block/rnull/configfs.rs
>> @@ -4,8 +4,8 @@
>>   use kernel::{
>>       block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>>       configfs::{self, AttributeOperations},
>> -    configfs_attrs,
>>       fmt::{self, Write as _},
>> +    macros::configfs_attrs,
>>       new_mutex,
>>       page::PAGE_SIZE,
>>       prelude::*,
>> diff --git a/rust/macros/configfs_attrs.rs b/rust/macros/configfs_attrs.rs
>> new file mode 100644
>> index 0000000000000..a7fc75cdebcc0
>> --- /dev/null
>> +++ b/rust/macros/configfs_attrs.rs
>> @@ -0,0 +1,182 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use quote::{
>> +    quote, //
>> +    ToTokens,
>> +};
>> +
>> +use proc_macro2::{
>> +    Span, //
>> +};
>> +
>> +use syn::{
>> +    bracketed,
>> +    parse::{
>> +        Parse,
>> +        ParseStream, //
>> +    },
>> +    punctuated::Punctuated,
>> +    spanned::Spanned,
>> +    Ident,
>> +    LitInt,
>> +    Token,
>> +    Type, //
>> +};
>> +
>> +use crate::helpers::try_parse;
>> +
>> +pub(crate) struct ConfigfsAttrs {
>> +    container: Type,
>> +    data: Type,
>> +    child: Option<Type>,
>> +    attributes: Vec<(Ident, LitInt)>,
>> +}
>> +
>> +fn parse_attribute_field(stream: ParseStream<'_>) -> syn::Result<(Ident, LitInt)> {
>> +    let id = stream.parse::<syn::Ident>()?;
>> +    let _colon = stream.parse::<Token![:]>()?;
>> +    let v = stream.parse::<LitInt>()?;
>> +    Ok((id, v))
>> +}
>> +
>> +fn parse_named_field(stream: ParseStream<'_>, name: &str) -> syn::Result<Type> {
>> +    let name_id = stream.parse::<Ident>()?;
>> +    if name_id != name {
>> +        return Err(parse_field_error(name_id.span(), &name_id, name));
>> +    }
>> +    let _colon = stream.parse::<Token![:]>()?;
>> +    let v = stream.parse::<Type>()?;
>> +    stream.parse::<Token![,]>()?;
>> +    Ok(v)
>> +}
>> +
>> +fn parse_attributes(stream: ParseStream<'_>) -> syn::Result<Vec<(Ident, LitInt)>> {
>> +    let attribute_id = stream.parse::<Ident>()?;
>> +    if attribute_id != "attributes" {
>> +        return Err(syn::Error::new(
>> +            attribute_id.span(),
>> +            format!(
>> +                "unexpected identifier: {}, expected: 'attributes'",
>> +                attribute_id
>> +            ),
>> +        ));
>> +    }
>> +    stream.parse::<Token![:]>()?;
>> +    let attr_stream;
>> +    let _bracket = bracketed!(attr_stream in stream);
>> +    let attributes = Punctuated::<(Ident, LitInt), Token![,]>::parse_terminated_with(
>> +        &attr_stream,
>> +        parse_attribute_field,
>> +    )?;
>> +    let attributes = attributes.into_iter().collect::<Vec<_>>();
>> +
>> +    stream.parse::<Option<Token![,]>>()?;
>> +    Ok(attributes)
>> +}
>> +
>> +fn parse_field_error(span: Span, name: &Ident, expected_name: &str) -> syn::Error {
>> +    syn::Error::new(
>> +        span,
>> +        format!("Unexpected field name, got: {name} expected: {expected_name}"),
>> +    )
>> +}
>> +
>> +impl Parse for ConfigfsAttrs {
>> +    fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
>> +        let container = try_parse(input, |s| parse_named_field(s, "container"))?;
>> +        let data = try_parse(input, |s| parse_named_field(s, "data"))?;
>> +        let child = try_parse(input, |s| parse_named_field(s, "child")).ok();
>> +        let attributes = parse_attributes(input)?;
> I have a `parse_ordered_fields!()` macro in module.rs, please extract it to
> helpers and use it instead of implementing the parsing in an ad-hoc manner.

That is a good idea.

>> +
>> +        Ok(ConfigfsAttrs {
>> +            container,
>> +            data,
>> +            child,
>> +            attributes,
>> +        })
>> +    }
>> +}
>> +
>> +fn make_static_ident<T: ToTokens>(ty: &T, suffix: &str) -> syn::Ident {
>> +    let raw_id = quote! { #ty }.to_string();
>> +
>> +    // Sanitizing syn::Type::Path, this is safe since it is
>> +    // only used as the identifier.
>> +    let normalized = raw_id
>> +        .split("::")
>> +        .map(|s| String::from(s.trim()))
>> +        .reduce(|a, b| format!("{a}_{b}"))
>> +        .expect("Cannot be empty")
>> +        .to_uppercase()
>> +        .replace(|c: char| !c.is_alphanumeric(), "_");
>> +
>> +    Ident::new(&format!("{}_{}", normalized, suffix), ty.span())
>> +}
>> +
>> +pub(crate) fn configfs_attrs(cfs_attrs: ConfigfsAttrs) -> proc_macro2::TokenStream {
>> +    let (container_ty, data_ty) = (&cfs_attrs.container, &cfs_attrs.data);
>> +
>> +    let data_tp_ident = make_static_ident(data_ty, "TPE");
>> +    let data_attr_ident = make_static_ident(data_ty, "ATTR_LIST");
> Instead of creating identifers like this, just scope them properly so that
> a fixed identifier is used without colliding.

I believe it is nice to keep the identifiers unique, especially if you
have many fields
you can easily differentiate them.

>> +
>> +    let n = cfs_attrs.attributes.len() + 1;
>> +
>> +    let attr_list = quote! {
>> +        static #data_attr_ident: kernel::configfs::AttributeList<#n, #data_ty> =
>> +            // SAFETY: We are expanding `configfs_attrs`.
>> +            unsafe { kernel::configfs::AttributeList::new() };
>> +    };
>> +
>> +    let mut attrs = Vec::new();
>> +    for (attr_idx, (name, id)) in cfs_attrs.attributes.iter().enumerate() {
>> +        let name_with_attr = make_static_ident(name, "ATTR");
>> +
>> +        let id: u64 = match id.base10_parse::<u64>() {
>> +            Ok(v) => v,
>> +            Err(_) => {
>> +                return syn::Error::new(id.span(), "Could not parse attribute ID as a u64")
>> +                    .to_compile_error();
>> +            }
>> +        };
> Why parsing? The ID looks like it's just substituted as is.

For correctness, if you pass a negative integer literal it will panic
without this parsing.
This is not likely, but it provides a nice error message if this were to happen.
I can maybe move it to the parsing logic instead.

>
> Best,
> Gary
>
>> +
>> +        attrs.push(quote! {
>> +        static #name_with_attr: kernel::configfs::Attribute<#id, #data_ty, #data_ty> =
>> +            // SAFETY: We are expanding `configfs_attrs`.
>> +            unsafe {
>> +              kernel::configfs::Attribute::new(kernel::c_str!(::core::stringify!(#name)))
>> +            };
>> +
>> +          // SAFETY: By design of this macro, the name of the variable we
>> +          // invoke the `add` method on below, is not visible outside of
>> +          // the macro expansion. The macro does not operate concurrently
>> +          // on this variable, and thus we have exclusive access to the
>> +          // variable.
>> +          unsafe { #data_attr_ident.add::<#attr_idx, #id, _>(&#name_with_attr) }
>> +        });
>> +    }
>> +
>> +    let has_child_code = if let Some(child) = cfs_attrs.child {
>> +        quote! { new_with_child_ctor::<#n, #child>}
>> +    } else {
>> +        quote! { new::<#n> }
>> +    };
>> +
>> +    let data_type = quote! {
>> +        {
>> +            static #data_tp_ident:
>> +            kernel::configfs::ItemType<#container_ty, #data_ty> =
>> +                kernel::configfs::ItemType::<#container_ty, #data_ty>::#has_child_code(
>> +                    &THIS_MODULE, &#data_attr_ident
>> +                );
>> +            &#data_tp_ident
>> +        }
>> +    };
>> +
>> +    quote! {
>> +        {
>> +            #attr_list
>> +            #(#attrs)*
>> +            #data_type
>> +        }
>> +    }
>> +}
>> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
>> index d18fbf4daa0a5..fdab8804e1ba9 100644
>> --- a/rust/macros/helpers.rs
>> +++ b/rust/macros/helpers.rs
>> @@ -4,6 +4,7 @@
>>   use quote::ToTokens;
>>   use syn::{
>>       parse::{
>> +        discouraged::Speculative,
>>           Parse,
>>           ParseStream, //
>>       },
>> @@ -54,6 +55,20 @@ pub(crate) fn file() -> String {
>>       }
>>   }
>>   
>> +pub(crate) fn try_parse<T>(
>> +    input: ParseStream<'_>,
>> +    parser: impl FnOnce(ParseStream<'_>) -> Result<T>,
>> +) -> Result<T> {
>> +    let fork = input.fork();
>> +    match parser(&fork) {
>> +        Ok(value) => {
>> +            input.advance_to(&fork);
>> +            Ok(value)
>> +        }
>> +        Err(e) => Err(e),
>> +    }
>> +}
>> +
>>   /// Obtain all `#[cfg]` attributes.
>>   pub(crate) fn gather_cfg_attrs(attr: &[Attribute]) -> impl Iterator<Item = &Attribute> + '_ {
>>       attr.iter().filter(|a| a.path().is_ident("cfg"))
>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>> index 2cfd59e0f9e7c..745ba83c828b9 100644
>> --- a/rust/macros/lib.rs
>> +++ b/rust/macros/lib.rs
>> @@ -15,6 +15,8 @@
>>   #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
>>   
>>   mod concat_idents;
>> +#[cfg(CONFIG_CONFIGFS_FS)]
>> +mod configfs_attrs;
>>   mod export;
>>   mod fmt;
>>   mod helpers;
>> @@ -489,3 +491,86 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
>>           .unwrap_or_else(|e| e.into_compile_error())
>>           .into()
>>   }
>> +
>> +/// Define a list of configfs attributes statically.
>> +///
>> +/// # Examples
>> +///
>> +/// ```ignore
>> +/// let item_type = configfs_attrs! {
>> +///     container: configfs::Subsystem<Configuration>,
>> +///     data: Configuration,
>> +///     child: Child,
>> +///     attributes: [
>> +///         message: 0,
>> +///         bar: 1,
>> +///     ],
>> +/// };
>> +///```
>> +///
>> +/// Expands the following output:
>> +///    let item_type = {
>> +///         static CONFIGURATION_ATTR_LIST: kernel::configfs::AttributeList<
>> +///             3usize,
>> +///             Configuration,
>> +///         > = unsafe { kernel::configfs::AttributeList::new() };
>> +///         static MESSAGE_ATTR: kernel::configfs::Attribute<
>> +///             0u64,
>> +///             Configuration,
>> +///             Configuration,
>> +///         > = unsafe {
>> +///             kernel::configfs::Attribute::new({
>> +///                 const S: &str = "message\u{0}";
>> +///                 const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
>> +///                     S.as_bytes(),
>> +///                 ) {
>> +///                     Ok(v) => v,
>> +///                     Err(_) => {
>> +///                         ::core::panicking::panic_fmt(
>> +///                             format_args!("string contains interior NUL"),
>> +///                         );
>> +///                     }
>> +///                 };
>> +///                 C
>> +///             })
>> +///         };
>> +///         unsafe { CONFIGURATION_ATTR_LIST.add::<0usize, 0u64, _>(&MESSAGE_ATTR) }
>> +///         static BAR_ATTR: kernel::configfs::Attribute<
>> +///             1u64,
>> +///             Configuration,
>> +///             Configuration,
>> +///         > = unsafe {
>> +///             kernel::configfs::Attribute::new({
>> +///                 const S: &str = "bar\u{0}";
>> +///                 const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
>> +///                     S.as_bytes(),
>> +///                 ) {
>> +///                     Ok(v) => v,
>> +///                     Err(_) => {
>> +///                         ::core::panicking::panic_fmt(
>> +///                             format_args!("string contains interior NUL"),
>> +///                         );
>> +///                     }
>> +///                 };
>> +///                 C
>> +///             })
>> +///         };
>> +///         unsafe { CONFIGURATION_ATTR_LIST.add::<1usize, 1u64, _>(&BAR_ATTR) }
>> +///         {
>> +///             static CONFIGURATION_TPE: kernel::configfs::ItemType<
>> +///                 Subsystem<Configuration>,
>> +///                 Configuration,
>> +///             > = kernel::configfs::ItemType::<
>> +///                 Subsystem<Configuration>,
>> +///                 Configuration,
>> +///             >::new_with_child_ctor::<3usize, Child>(&THIS_MODULE, &CONFIGURATION_ATTR_LIST);
>> +///             &CONFIGURATION_TPE
>> +///         }
>> +///     };
>> +///
>> +#[cfg(CONFIG_CONFIGFS_FS)]
>> +#[proc_macro]
>> +pub fn configfs_attrs(input: TokenStream) -> TokenStream {
>> +    configfs_attrs::configfs_attrs(parse_macro_input!(input as configfs_attrs::ConfigfsAttrs))
>> +        .into()
>> +}
>> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
>> index a1bd9db6010da..876462f7789d1 100644
>> --- a/samples/rust/rust_configfs.rs
>> +++ b/samples/rust/rust_configfs.rs
>> @@ -4,7 +4,7 @@
>>   
>>   use kernel::alloc::flags;
>>   use kernel::configfs;
>> -use kernel::configfs::configfs_attrs;
>> +use kernel::macros::configfs_attrs;
>>   use kernel::new_mutex;
>>   use kernel::page::PAGE_SIZE;
>>   use kernel::prelude::*;
>>
>> ---
>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>> change-id: 20260417-configfs-syn-191e07130027
>>
>> Best regards,
Best regards
>
