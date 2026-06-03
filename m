Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676F3A782A
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495720; cv=none; b=Zpt4oXgF3nXOJ9RaVk1V+ZYWRQfP46EieyoJYNnVwI/AoVaCdguJ9bi6aESR2LGVtYRmqxr6ygcjGvF0Z8GVq5a1WZZRudURcw9EUyrwo02T1shuqQoIwteY3GBAAIokE1cNx6bJPuGiVE22k0kHsiwp5tbnIZmuczloA2pR5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495720; c=relaxed/simple;
	bh=UZBzC4mkOBLTvp3u5L/CRvBTZs/ZqdIzznnBi48JzTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i7/OoREQaWYh5pBE+SEcusgg3+b17DmznlygqjkyL1U1UNqlDC1A9v0v6gCPyw4PCv/6Py6bAnk/CzzUja7lsVTYaSVhLxTFzflem+S++lYwDNhI8tkKgPWlzSjphKqFD0lyudJbs1fn+nB/634UFGjmSdUFz0qVh+DBBLrgq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib9wYdgP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib9wYdgP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49041e84237so7243205e9.1
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2026 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495716; x=1781100516; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQjixubEe0JOxXIG6jNUIWub0O0mCeLRwASvqRJwK1Q=;
        b=ib9wYdgPc7YtpE9TChknf1Ls0wokFBXp18RGN/w5/3aVGBJqnqOv3MHj2I3Vx3y5Fc
         66um7bdNkf0fwsYpQ7VzErtPmGi1083Jx/rreycP21BfrFhZKhSc5kAB97ZwFVnXznku
         dzKjckI3efZV++72oGMsu+opvGknQXBj1TMCyb8q1OqEsFApdrV1Ca9Bx2yWYDrU7v2s
         vVglLPFAC5jWFMI1JpQ6sZ0i9kmV/D5Wt+GMm4ky2nSUOmZ8g/LzcIcoBDNBBi1hiThM
         eHlKlBTQh1mTzjjbz3h76nxq9dgK+I12KSfjEbkn3iKoycqp+xbpcVguOIjAr3YYC/pg
         6Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495716; x=1781100516;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQjixubEe0JOxXIG6jNUIWub0O0mCeLRwASvqRJwK1Q=;
        b=sIqrvwYZQfBDFqF8YamfW2IX34Ul1WjNMkN75/LD7n5t2Rmt4VM0wT3TOOJsnIQoNb
         5aWi0p5SJWVhdG8VV9/H3CNpJ0ilkTQ6jbxxiJSHvQHTseNnqS44TYQk4dA9c3TGbvde
         /jQR6YZaxbSbpZBceYnimgBdf+vDZ4Vcm2jZPdenBXJIoh/ynZWB2Dkgm5MV92K3SBKW
         8Q1x/OWIrOwJ+LLsZLx5okfNDb6Umuw22d9/hF/6gaO4OEiwss8vm9rFPJz0Yk6+7jT/
         nqhbkrM12qu+YZJqvNsL4jmB8OR+LaAGlJW2+cSKc96Z4MK7UDScCU9zha/3MNd6UU2y
         6jlg==
X-Forwarded-Encrypted: i=1; AFNElJ8MGAHwHXkkCFZFPgFH0oTMUPXWyB4OKuPgP5TfK+QlFVBP+HAV1yWmx8QLO2vfcnEWfhEou5HKzw1Odw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPhU09XcYNeb+B49vEWv2FcxeOPXtjb628T/8fHXPHeooX/s2
	EDbq8eoi3wZFhl9bhNoaJENU4DAKMeXxHiwCYUqdyXLVUJFYgIAHAI0j
X-Gm-Gg: Acq92OEjbLBzoXbePjf8ZDNDCNr8I1AwtesnujeLC3P3sfMFcJdXock9LNFA1gRjaqL
	NULPxou4788mn+Q1q1uaD+zpYpv7MphZ74QePAHrAoYPjgsfEaWLR2DS5n4iemgqGqyCScOnvim
	p+JrmWKurBqg/C6+vzgxu+PfhBrWFeDN8KhzMfisfDQ2nCQaSWht9wmp1xPgaPcmrrsha11++rA
	qd5S+HUIZT0R6LseQqkaTy/BpIuWjtY365SLFMN//hUpguwAT1wPVunx0JVOdyZ5tcfRW+a7Eqa
	nMPej4QHOxedpiml7N/Iqxx/rUwNu/gYIzgQeuFSmCWIaRhUVT7w0LAAf1bivkGH9ATIfnb11wt
	fzKtU0n+k5mT7YKaT37+41oxkhqE9emf9IsjmxJuM9nBEGwkpm8kkSq9Z3rTa8kip9WQWmFUgLA
	spmH8ApjHxFXjFcjU6GEhc/wwOHmFgrJeSI892KxxNvA==
X-Received: by 2002:a05:600c:4f05:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490b610dc80mr41468315e9.2.1780495715232;
        Wed, 03 Jun 2026 07:08:35 -0700 (PDT)
Received: from [172.16.16.15] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm241404105e9.0.2026.06.03.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:08:34 -0700 (PDT)
From: Malte Wechter <maltewechter@gmail.com>
Date: Wed, 03 Jun 2026 16:08:29 +0200
Subject: [PATCH v2] rust: add procedural macro for declaring configfs
 attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-configfs-syn-v2-1-cb58489c2647@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XMQQ6CMBCF4auQWVszUwXElfcwLGqdwiTSmtY0E
 sLdrbhy+b/kfQskjsIJztUCkbMkCb6E3lVgR+MHVnIvDRp1g0dqlQ3eyeCSSrNX1BFjSwdE3UK
 5PCM7eW/ctS89SnqFOG96pu/6g2qN/1AmRaqx9e2EprPs9GWYjDz2NkzQr+v6AQnWhlyoAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780495713; l=21678;
 i=maltewechter@gmail.com; s=20260417; h=from:subject:message-id;
 bh=UZBzC4mkOBLTvp3u5L/CRvBTZs/ZqdIzznnBi48JzTw=;
 b=819Gqg6BDuM4DeUdBrWNLHy/EN8+U2IUQ98JFrQICMoF/kYW/zj39bnN283uiElCNDXnpC2Lz
 DoA+DDd+hP0CtIpO/yJl2fWRoYr1PKMXZlDtg+SGkXNN6dLrtsAkKXj
X-Developer-Key: i=maltewechter@gmail.com; a=ed25519;
 pk=07WplWXZnwyLTMZOHNCIGcpoEutcMXU/JDY6f9VtxSY=

Implement `configfs_attrs!` as a procedural macro using `syn`, this
improves readability and maintainability. Remove the old macro and
replace all uses with the new macro. Add the new macro implementation
file to MAINTAINERS.

Signed-off-by: Malte Wechter <maltewechter@gmail.com>
---
Changes in v2:
- Add a try_parse helper function to macros/helpers.rs
- Fix bug where 'child' configuration gets dropped if trailing comma is missing (sashiko)
- Link to v1: https://lore.kernel.org/r/20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com
---
 MAINTAINERS                     |   1 +
 drivers/block/rnull/configfs.rs |   2 +-
 rust/kernel/configfs.rs         | 251 ----------------------------------------
 rust/macros/configfs_attrs.rs   | 182 +++++++++++++++++++++++++++++
 rust/macros/helpers.rs          |  15 +++
 rust/macros/lib.rs              |  85 ++++++++++++++
 samples/rust/rust_configfs.rs   |   2 +-
 7 files changed, 285 insertions(+), 253 deletions(-)

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
index 0000000000000..a7fc75cdebcc0
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
+use crate::helpers::try_parse;
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
+    let name_id = stream.parse::<Ident>()?;
+    if name_id != name {
+        return Err(parse_field_error(name_id.span(), &name_id, name));
+    }
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
+        let container = try_parse(input, |s| parse_named_field(s, "container"))?;
+        let data = try_parse(input, |s| parse_named_field(s, "data"))?;
+        let child = try_parse(input, |s| parse_named_field(s, "child")).ok();
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
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index d18fbf4daa0a5..fdab8804e1ba9 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -4,6 +4,7 @@
 use quote::ToTokens;
 use syn::{
     parse::{
+        discouraged::Speculative,
         Parse,
         ParseStream, //
     },
@@ -54,6 +55,20 @@ pub(crate) fn file() -> String {
     }
 }
 
+pub(crate) fn try_parse<T>(
+    input: ParseStream<'_>,
+    parser: impl FnOnce(ParseStream<'_>) -> Result<T>,
+) -> Result<T> {
+    let fork = input.fork();
+    match parser(&fork) {
+        Ok(value) => {
+            input.advance_to(&fork);
+            Ok(value)
+        }
+        Err(e) => Err(e),
+    }
+}
+
 /// Obtain all `#[cfg]` attributes.
 pub(crate) fn gather_cfg_attrs(attr: &[Attribute]) -> impl Iterator<Item = &Attribute> + '_ {
     attr.iter().filter(|a| a.path().is_ident("cfg"))
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

