Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360337D100
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262856; cv=none; b=mVtE6cAYdGqO1SZJWicpC0B6VswlicE5ZOYx1NaqS+6wL4w+BoTtC1JEd20w67y0PlIrL73QOi6r+lmWKYzf0T/+EBGgPIGXNc/yfj1cz9WKrBdI3ObCsUtsDaErVWaXTmBKlfv2joHZ8EwaKweJv41/gJR14J05+0v5cfLCxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262856; c=relaxed/simple;
	bh=eqMsKmMrVPR5kTGUkImNiDqvCNPz4fpwi1svfEwYHCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fsMBtav0G9urk1edgJxbN4wjJeEzue/VO1+JFK+CTLEPkktU9AZjrzwxfEpdLwORUF0+W8Ow8s2deRgXSGpPTsKHzAlwgpQuwIAyUxEp5JI4E0M3WWXGl3VILF2vUy152ZX/YCkdd6TTVCzGg64n/R3VnvY3SgNoUuBH7ua/CD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQYOLMUj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQYOLMUj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso25157755e9.3
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779262853; x=1779867653; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RO+tCCCSue2id/N4emUlo+MAydiQkdwgenz3gSYRrYw=;
        b=mQYOLMUjQWJQsgd+bzspwyHzGraF5uX3F7uI8pwVpph5VAZM2tIbHtVMfMPG1GQrqD
         igapuP3072IiJnWpcHUaSZGHlrqHIvBTKsLS3CV6x2NVsIIR8AFoDvDgEUseXmkEtG7E
         HLAcAHuXQmexzecHWXps+fsfkCZHh14r/pglsmBB2oM52yIgtRYlD2Oi8x9HpgTlP/tG
         eF/RHuSfwNCWpz2jfjzTZerlkpNnrBslld244EyFK6l6KpOMowVrRmUxHS1UmLPwesYo
         N3MfyllEGRzd2Pk4kfL5ov5ZfEwBRZZ6KPy7gxO42CilQvDWOZIzPq213jnidDejwnLu
         Ohjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262853; x=1779867653;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO+tCCCSue2id/N4emUlo+MAydiQkdwgenz3gSYRrYw=;
        b=hUOvPmIbsRmG8E2gxkEHTLZgK2EJbW8/WHeqOmXwDRTmnvEXIObPf4aZ1KfjpUFRwI
         yJO56wsPH1u0c3mjr1rC0EgmBRjcJK8kn8wmu5WwmA3m49pzRp2C5T95x/4q8IXa+OLy
         R+S1jzM6e7XXz3xdjH3c1p20jq3kF/wwPb+wyWJfQ4aWGoxGGMxCRsKp1cu9qJ8MpTy4
         XdQvEuGEZIaKxnWXIRtkAt18XfBCdggrZvdYnMCPXUyShbMCP8BG/WI/J+oR9nuRrEHX
         w+uR8IjqdtZyjv0tLQYlX7ClpeeI3tkajd7d85+9Esb3+7jeC0sSmPY5Cz4g57f2JvQm
         oo5g==
X-Forwarded-Encrypted: i=1; AFNElJ/pwa/oacqtfKjgE4pVlSNWiVzt3Kq3De5zbu3y6syQQceF76VKrMPQTwIMAQumbgLUB+ykZkoVrdPJzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7RVVyHTeJI2KDOW8OXRbDUxxrpxBGv1f6a2aT9MvXsKAcS7Z
	xxpPqA4ceI3D5N0MM8zj2DaL6Ad9OxrH+6psGrS4lzeq3Q2Z1IrGiRKM
X-Gm-Gg: Acq92OEN7IDkX500sYcf+tXI6DHgVDUsu5dbqTL02v8CgYS8zYN69hopB/UZ3TICGyp
	Ew51vtudkdNcpL3TEvk4w53hWLSaPHCKmZ1fDLeLRc/vZoy7MsPuaXbraTO5sdAyeLkgkEX3jRq
	FeIp+o2nfyDxRV+H7s28r56XcgO09CBtjUcbhdExg6kh+aymexeqhZhI1GhKf7m6NQgQesbPc3F
	uzw5/cvW8tCLqr5Z4lOH38dkwjTd0l4qr3QQASv72pqlI0FB2QozeYWbjCFt/2J7uv+TnAiX1sN
	cGPodRN6++7KnsI3Z5q4x+7Y9Ij8u8zGQzEVVPCux2yRY2VnuLhE4I/WUNAr7xeKjDVOU+/XHyl
	iO+7SGiBhZaO5q08P7Rjx7qbIZiF5UbKvMT92I45T051lHMax9Rd4vOD96G/77iImHWH+PAfN97
	TLkLtbH8pRu6HXYHaI9ot2e7KPHd2VulE=
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr331867205e9.10.1779262852614;
        Wed, 20 May 2026 00:40:52 -0700 (PDT)
Received: from [172.16.16.15] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm48745498f8f.24.2026.05.20.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:40:51 -0700 (PDT)
From: Malte Wechter <maltewechter@gmail.com>
Date: Wed, 20 May 2026 09:40:43 +0200
Subject: [PATCH] rust: add procedural macro for declaring configfs
 attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgtJFYteRRxE05qllQZEKd7d4
 viG/wsoZ2GFqSmQ+RKVFCuobWA71hjYyF4NFu2APTmzpegleDX6REMjMTrqEK2DmpyZvdz/bl7
 e9wOxG6tRXgAAAA==
X-Change-ID: 20260417-configfs-syn-191e07130027
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, Malte Wechter <maltewechter@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779262850; l=20458;
 i=maltewechter@gmail.com; s=20260417; h=from:subject:message-id;
 bh=eqMsKmMrVPR5kTGUkImNiDqvCNPz4fpwi1svfEwYHCs=;
 b=amZHOz9q1YH339fxUURIj3C4BOXBz/q1/NQ/nA0ZfHzZwuGT8bybEr0H/VH+yzy2a+9nQGVs8
 2ncX54J0epuAb7k6rvVeqJpWV3/fDMAbuB/7wa5H4yAFS0oRSDB9CpJ
X-Developer-Key: i=maltewechter@gmail.com; a=ed25519;
 pk=07WplWXZnwyLTMZOHNCIGcpoEutcMXU/JDY6f9VtxSY=

Implement `configfs_attrs!` as a procedural macro using `syn`, this
improves readability and maintainability. Remove the old macro and
replace all uses with the new macro. Add the new macro implementation
file to MAINTAINERS.

Signed-off-by: Malte Wechter <maltewechter@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/block/rnull/configfs.rs |   2 +-
 rust/kernel/configfs.rs         | 251 ----------------------------------------
 rust/macros/configfs_attrs.rs   | 182 +++++++++++++++++++++++++++++
 rust/macros/lib.rs              |  85 ++++++++++++++
 samples/rust/rust_configfs.rs   |   2 +-
 6 files changed, 270 insertions(+), 253 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd163..45f7a1ec93b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6464,6 +6464,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git config
 F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	rust/kernel/configfs.rs
+F:	rust/macros/configfs_attrs.rs
 F:	samples/configfs/
 F:	samples/rust/rust_configfs.rs
 
diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b7228..f28ec69d79846 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -4,8 +4,8 @@
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     configfs::{self, AttributeOperations},
-    configfs_attrs,
     fmt::{self, Write as _},
+    macros::configfs_attrs,
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325d..7a91e36677f52 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -791,254 +791,3 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
         self.item_type.get()
     }
 }
-
-/// Define a list of configfs attributes statically.
-///
-/// Invoking the macro in the following manner:
-///
-/// ```ignore
-/// let item_type = configfs_attrs! {
-///     container: configfs::Subsystem<Configuration>,
-///     data: Configuration,
-///     child: Child,
-///     attributes: [
-///         message: 0,
-///         bar: 1,
-///     ],
-/// };
-/// ```
-///
-/// Expands the following output:
-///
-/// ```ignore
-/// let item_type = {
-///     static CONFIGURATION_MESSAGE_ATTR: kernel::configfs::Attribute<
-///         0,
-///         Configuration,
-///         Configuration,
-///     > = unsafe {
-///         kernel::configfs::Attribute::new({
-///             const S: &str = "message\u{0}";
-///             const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
-///                 S.as_bytes()
-///             ) {
-///                 Ok(v) => v,
-///                 Err(_) => {
-///                     core::panicking::panic_fmt(core::const_format_args!(
-///                         "string contains interior NUL"
-///                     ));
-///                 }
-///             };
-///             C
-///         })
-///     };
-///
-///     static CONFIGURATION_BAR_ATTR: kernel::configfs::Attribute<
-///             1,
-///             Configuration,
-///             Configuration
-///     > = unsafe {
-///         kernel::configfs::Attribute::new({
-///             const S: &str = "bar\u{0}";
-///             const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
-///                 S.as_bytes()
-///             ) {
-///                 Ok(v) => v,
-///                 Err(_) => {
-///                     core::panicking::panic_fmt(core::const_format_args!(
-///                         "string contains interior NUL"
-///                     ));
-///                 }
-///             };
-///             C
-///         })
-///     };
-///
-///     const N: usize = (1usize + (1usize + 0usize)) + 1usize;
-///
-///     static CONFIGURATION_ATTRS: kernel::configfs::AttributeList<N, Configuration> =
-///         unsafe { kernel::configfs::AttributeList::new() };
-///
-///     {
-///         const N: usize = 0usize;
-///         unsafe { CONFIGURATION_ATTRS.add::<N, 0, _>(&CONFIGURATION_MESSAGE_ATTR) };
-///     }
-///
-///     {
-///         const N: usize = (1usize + 0usize);
-///         unsafe { CONFIGURATION_ATTRS.add::<N, 1, _>(&CONFIGURATION_BAR_ATTR) };
-///     }
-///
-///     static CONFIGURATION_TPE:
-///       kernel::configfs::ItemType<configfs::Subsystem<Configuration> ,Configuration>
-///         = kernel::configfs::ItemType::<
-///                 configfs::Subsystem<Configuration>,
-///                 Configuration
-///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
-///             &CONFIGURATION_ATTRS
-///         );
-///
-///     &CONFIGURATION_TPE
-/// }
-/// ```
-#[macro_export]
-macro_rules! configfs_attrs {
-    (
-        container: $container:ty,
-        data: $data:ty,
-        attributes: [
-            $($name:ident: $attr:literal),* $(,)?
-        ] $(,)?
-    ) => {
-        $crate::configfs_attrs!(
-            count:
-            @container($container),
-            @data($data),
-            @child(),
-            @no_child(x),
-            @attrs($($name $attr)*),
-            @eat($($name $attr,)*),
-            @assign(),
-            @cnt(0usize),
-        )
-    };
-    (
-        container: $container:ty,
-        data: $data:ty,
-        child: $child:ty,
-        attributes: [
-            $($name:ident: $attr:literal),* $(,)?
-        ] $(,)?
-    ) => {
-        $crate::configfs_attrs!(
-            count:
-            @container($container),
-            @data($data),
-            @child($child),
-            @no_child(),
-            @attrs($($name $attr)*),
-            @eat($($name $attr,)*),
-            @assign(),
-            @cnt(0usize),
-        )
-    };
-    (count:
-     @container($container:ty),
-     @data($data:ty),
-     @child($($child:ty)?),
-     @no_child($($no_child:ident)?),
-     @attrs($($aname:ident $aattr:literal)*),
-     @eat($name:ident $attr:literal, $($rname:ident $rattr:literal,)*),
-     @assign($($assign:block)*),
-     @cnt($cnt:expr),
-    ) => {
-        $crate::configfs_attrs!(
-            count:
-            @container($container),
-            @data($data),
-            @child($($child)?),
-            @no_child($($no_child)?),
-            @attrs($($aname $aattr)*),
-            @eat($($rname $rattr,)*),
-            @assign($($assign)* {
-                const N: usize = $cnt;
-                // The following macro text expands to a call to `Attribute::add`.
-
-                // SAFETY: By design of this macro, the name of the variable we
-                // invoke the `add` method on below, is not visible outside of
-                // the macro expansion. The macro does not operate concurrently
-                // on this variable, and thus we have exclusive access to the
-                // variable.
-                unsafe {
-                    $crate::macros::paste!(
-                        [< $data:upper _ATTRS >]
-                            .add::<N, $attr, _>(&[< $data:upper _ $name:upper _ATTR >])
-                    )
-                };
-            }),
-            @cnt(1usize + $cnt),
-        )
-    };
-    (count:
-     @container($container:ty),
-     @data($data:ty),
-     @child($($child:ty)?),
-     @no_child($($no_child:ident)?),
-     @attrs($($aname:ident $aattr:literal)*),
-     @eat(),
-     @assign($($assign:block)*),
-     @cnt($cnt:expr),
-    ) =>
-    {
-        $crate::configfs_attrs!(
-            final:
-            @container($container),
-            @data($data),
-            @child($($child)?),
-            @no_child($($no_child)?),
-            @attrs($($aname $aattr)*),
-            @assign($($assign)*),
-            @cnt($cnt),
-        )
-    };
-    (final:
-     @container($container:ty),
-     @data($data:ty),
-     @child($($child:ty)?),
-     @no_child($($no_child:ident)?),
-     @attrs($($name:ident $attr:literal)*),
-     @assign($($assign:block)*),
-     @cnt($cnt:expr),
-    ) =>
-    {
-        $crate::macros::paste!{
-            {
-                $(
-                    // SAFETY: We are expanding `configfs_attrs`.
-                    static [< $data:upper _ $name:upper _ATTR >]:
-                        $crate::configfs::Attribute<$attr, $data, $data> =
-                            unsafe {
-                                $crate::configfs::Attribute::new(
-                                    $crate::c_str!(::core::stringify!($name)),
-                                )
-                            };
-                )*
-
-
-                // We need space for a null terminator.
-                const N: usize = $cnt + 1usize;
-
-                // SAFETY: We are expanding `configfs_attrs`.
-                static [< $data:upper _ATTRS >]:
-                $crate::configfs::AttributeList<N, $data> =
-                    unsafe { $crate::configfs::AttributeList::new() };
-
-                $($assign)*
-
-                $(
-                    const [<$no_child:upper>]: bool = true;
-
-                    static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
-                        $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
-                        );
-                )?
-
-                $(
-                    static [< $data:upper _TPE >]:
-                        $crate::configfs::ItemType<$container, $data>  =
-                            $crate::configfs::ItemType::<$container, $data>::
-                            new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
-                            );
-                )?
-
-                & [< $data:upper _TPE >]
-            }
-        }
-    };
-
-}
-
-pub use crate::configfs_attrs;
diff --git a/rust/macros/configfs_attrs.rs b/rust/macros/configfs_attrs.rs
new file mode 100644
index 0000000000000..f5c3a8d9bffbd
--- /dev/null
+++ b/rust/macros/configfs_attrs.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use quote::{
+    quote, //
+    ToTokens,
+};
+
+use proc_macro2::{
+    Span, //
+};
+
+use syn::{
+    bracketed,
+    parse::{
+        Parse,
+        ParseStream, //
+    },
+    punctuated::Punctuated,
+    spanned::Spanned,
+    Ident,
+    LitInt,
+    Token,
+    Type, //
+};
+
+pub(crate) struct ConfigfsAttrs {
+    container: Type,
+    data: Type,
+    child: Option<Type>,
+    attributes: Vec<(Ident, LitInt)>,
+}
+
+fn parse_attribute_field(stream: ParseStream<'_>) -> syn::Result<(Ident, LitInt)> {
+    let id = stream.parse::<syn::Ident>()?;
+    let _colon = stream.parse::<Token![:]>()?;
+    let v = stream.parse::<LitInt>()?;
+    Ok((id, v))
+}
+
+fn parse_named_field(stream: ParseStream<'_>, name: &str) -> syn::Result<Type> {
+    let try_stream = stream.fork();
+    let name_id = try_stream.parse::<Ident>()?;
+    if name_id != name {
+        return Err(parse_field_error(name_id.span(), &name_id, name));
+    }
+    let _name_id = stream.parse::<Ident>()?;
+    let _colon = stream.parse::<Token![:]>()?;
+    let v = stream.parse::<Type>()?;
+    stream.parse::<Token![,]>()?;
+    Ok(v)
+}
+
+fn parse_attributes(stream: ParseStream<'_>) -> syn::Result<Vec<(Ident, LitInt)>> {
+    let attribute_id = stream.parse::<Ident>()?;
+    if attribute_id != "attributes" {
+        return Err(syn::Error::new(
+            attribute_id.span(),
+            format!(
+                "unexpected identifier: {}, expected: 'attributes'",
+                attribute_id
+            ),
+        ));
+    }
+    stream.parse::<Token![:]>()?;
+    let attr_stream;
+    let _bracket = bracketed!(attr_stream in stream);
+    let attributes = Punctuated::<(Ident, LitInt), Token![,]>::parse_terminated_with(
+        &attr_stream,
+        parse_attribute_field,
+    )?;
+    let attributes = attributes.into_iter().collect::<Vec<_>>();
+
+    stream.parse::<Option<Token![,]>>()?;
+    Ok(attributes)
+}
+
+fn parse_field_error(span: Span, name: &Ident, expected_name: &str) -> syn::Error {
+    syn::Error::new(
+        span,
+        format!("Unexpected field name, got: {name} expected: {expected_name}"),
+    )
+}
+
+impl Parse for ConfigfsAttrs {
+    fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
+        let container = parse_named_field(input, "container")?;
+        let data = parse_named_field(input, "data")?;
+        let child = parse_named_field(input, "child").ok();
+        let attributes = parse_attributes(input)?;
+
+        Ok(ConfigfsAttrs {
+            container,
+            data,
+            child,
+            attributes,
+        })
+    }
+}
+
+fn make_static_ident<T: ToTokens>(ty: &T, suffix: &str) -> syn::Ident {
+    let raw_id = quote! { #ty }.to_string();
+
+    // Sanitizing syn::Type::Path, this is safe since it is
+    // only used as the identifier.
+    let normalized = raw_id
+        .split("::")
+        .map(|s| String::from(s.trim()))
+        .reduce(|a, b| format!("{a}_{b}"))
+        .expect("Cannot be empty")
+        .to_uppercase()
+        .replace(|c: char| !c.is_alphanumeric(), "_");
+
+    Ident::new(&format!("{}_{}", normalized, suffix), ty.span())
+}
+
+pub(crate) fn configfs_attrs(cfs_attrs: ConfigfsAttrs) -> proc_macro2::TokenStream {
+    let (container_ty, data_ty) = (&cfs_attrs.container, &cfs_attrs.data);
+
+    let data_tp_ident = make_static_ident(data_ty, "TPE");
+    let data_attr_ident = make_static_ident(data_ty, "ATTR_LIST");
+
+    let n = cfs_attrs.attributes.len() + 1;
+
+    let attr_list = quote! {
+        static #data_attr_ident: kernel::configfs::AttributeList<#n, #data_ty> =
+            // SAFETY: We are expanding `configfs_attrs`.
+            unsafe { kernel::configfs::AttributeList::new() };
+    };
+
+    let mut attrs = Vec::new();
+    for (attr_idx, (name, id)) in cfs_attrs.attributes.iter().enumerate() {
+        let name_with_attr = make_static_ident(name, "ATTR");
+
+        let id: u64 = match id.base10_parse::<u64>() {
+            Ok(v) => v,
+            Err(_) => {
+                return syn::Error::new(id.span(), "Could not parse attribute ID as a u64")
+                    .to_compile_error();
+            }
+        };
+
+        attrs.push(quote! {
+        static #name_with_attr: kernel::configfs::Attribute<#id, #data_ty, #data_ty> =
+            // SAFETY: We are expanding `configfs_attrs`.
+            unsafe {
+              kernel::configfs::Attribute::new(kernel::c_str!(::core::stringify!(#name)))
+            };
+
+          // SAFETY: By design of this macro, the name of the variable we
+          // invoke the `add` method on below, is not visible outside of
+          // the macro expansion. The macro does not operate concurrently
+          // on this variable, and thus we have exclusive access to the
+          // variable.
+          unsafe { #data_attr_ident.add::<#attr_idx, #id, _>(&#name_with_attr) }
+        });
+    }
+
+    let has_child_code = if let Some(child) = cfs_attrs.child {
+        quote! { new_with_child_ctor::<#n, #child>}
+    } else {
+        quote! { new::<#n> }
+    };
+
+    let data_type = quote! {
+        {
+            static #data_tp_ident:
+            kernel::configfs::ItemType<#container_ty, #data_ty> =
+                kernel::configfs::ItemType::<#container_ty, #data_ty>::#has_child_code(
+                    &THIS_MODULE, &#data_attr_ident
+                );
+            &#data_tp_ident
+        }
+    };
+
+    quote! {
+        {
+            #attr_list
+            #(#attrs)*
+            #data_type
+        }
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2cfd59e0f9e7c..745ba83c828b9 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -15,6 +15,8 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
 
 mod concat_idents;
+#[cfg(CONFIG_CONFIGFS_FS)]
+mod configfs_attrs;
 mod export;
 mod fmt;
 mod helpers;
@@ -489,3 +491,86 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .unwrap_or_else(|e| e.into_compile_error())
         .into()
 }
+
+/// Define a list of configfs attributes statically.
+///
+/// # Examples
+///
+/// ```ignore
+/// let item_type = configfs_attrs! {
+///     container: configfs::Subsystem<Configuration>,
+///     data: Configuration,
+///     child: Child,
+///     attributes: [
+///         message: 0,
+///         bar: 1,
+///     ],
+/// };
+///```
+///
+/// Expands the following output:
+///    let item_type = {
+///         static CONFIGURATION_ATTR_LIST: kernel::configfs::AttributeList<
+///             3usize,
+///             Configuration,
+///         > = unsafe { kernel::configfs::AttributeList::new() };
+///         static MESSAGE_ATTR: kernel::configfs::Attribute<
+///             0u64,
+///             Configuration,
+///             Configuration,
+///         > = unsafe {
+///             kernel::configfs::Attribute::new({
+///                 const S: &str = "message\u{0}";
+///                 const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
+///                     S.as_bytes(),
+///                 ) {
+///                     Ok(v) => v,
+///                     Err(_) => {
+///                         ::core::panicking::panic_fmt(
+///                             format_args!("string contains interior NUL"),
+///                         );
+///                     }
+///                 };
+///                 C
+///             })
+///         };
+///         unsafe { CONFIGURATION_ATTR_LIST.add::<0usize, 0u64, _>(&MESSAGE_ATTR) }
+///         static BAR_ATTR: kernel::configfs::Attribute<
+///             1u64,
+///             Configuration,
+///             Configuration,
+///         > = unsafe {
+///             kernel::configfs::Attribute::new({
+///                 const S: &str = "bar\u{0}";
+///                 const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
+///                     S.as_bytes(),
+///                 ) {
+///                     Ok(v) => v,
+///                     Err(_) => {
+///                         ::core::panicking::panic_fmt(
+///                             format_args!("string contains interior NUL"),
+///                         );
+///                     }
+///                 };
+///                 C
+///             })
+///         };
+///         unsafe { CONFIGURATION_ATTR_LIST.add::<1usize, 1u64, _>(&BAR_ATTR) }
+///         {
+///             static CONFIGURATION_TPE: kernel::configfs::ItemType<
+///                 Subsystem<Configuration>,
+///                 Configuration,
+///             > = kernel::configfs::ItemType::<
+///                 Subsystem<Configuration>,
+///                 Configuration,
+///             >::new_with_child_ctor::<3usize, Child>(&THIS_MODULE, &CONFIGURATION_ATTR_LIST);
+///             &CONFIGURATION_TPE
+///         }
+///     };
+///
+#[cfg(CONFIG_CONFIGFS_FS)]
+#[proc_macro]
+pub fn configfs_attrs(input: TokenStream) -> TokenStream {
+    configfs_attrs::configfs_attrs(parse_macro_input!(input as configfs_attrs::ConfigfsAttrs))
+        .into()
+}
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index a1bd9db6010da..876462f7789d1 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -4,7 +4,7 @@
 
 use kernel::alloc::flags;
 use kernel::configfs;
-use kernel::configfs::configfs_attrs;
+use kernel::macros::configfs_attrs;
 use kernel::new_mutex;
 use kernel::page::PAGE_SIZE;
 use kernel::prelude::*;

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260417-configfs-syn-191e07130027

Best regards,
-- 
Malte Wechter <maltewechter@gmail.com>

