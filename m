Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E95146A93;
	Fri,  4 Oct 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079320; cv=none; b=bb15wYpCWw2o0gzLb2QD4S3Ib79PuYKf4wJ/mp7X8U0j4IK6zqDMHdOh0q4+Yasnzo4ou0thQSPHviu7EO6Hf8JewvAqqNUd/gSDfmshQsUDzkezKDfxpfkGiTWBCFZWXON8nS6GISKuV3QxwQGoqVIT6kWbyBx+2M6ZbMS9ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079320; c=relaxed/simple;
	bh=iPLMZgolL2OjvuOB8W1t69ecArE1UplQady/bEDmFSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZBjuOP/Y3GNPrxb3rrwc/7MEfjmgmqVAVfXyppshGoxY76uX7RZVAUxS8QEhGYVt/O8F39aOtMUF0KZaVl/A8oLKLcXLwo+/xfdGR+mjfIaPIpzuXxtdi9639u4/xIjjWAk9Dh9HxRnf1fUwEedBATnf5BomJ1jB8C0lh87Z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfgtGdHK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfgtGdHK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 477ABC4CECD;
	Fri,  4 Oct 2024 22:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079320;
	bh=iPLMZgolL2OjvuOB8W1t69ecArE1UplQady/bEDmFSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WfgtGdHKZu3QJZakEqIkOEurfeFBj3A5ggDvHDB02bUtxNONskfbEy/7ws0x71iw0
	 9gLULbWDHHKWSF6iMaIQ3kR/SLmY/ePhKY6+yvTxzAAtjW0RLZm/QGTbrR/ECx11LU
	 7C0ard6w15iKVOoFnAoaIK4U2HCNq3c9ovduDlx4Wu/Pq73WhiVJki8aOLPwvKpAPs
	 6fvCOpUiYjXL7SQPTL9IxtIwLxk/iwbNLs+nYCIEgmFdxkV8WZKV3ariQAjI93oiAX
	 VPtSO3VEQOVZXz7PO2402y1dzDOAjQPh00sk/v4J9cUmG7f/4gt9WVbGScJLDX50BA
	 xfgiQXYP6yeCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A9BCF8860;
	Fri,  4 Oct 2024 22:02:00 +0000 (UTC)
From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>
Date: Fri, 04 Oct 2024 15:01:37 -0700
Subject: [PATCH 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-rust-lockdep-v1-1-e9a5c45721fc@gmail.com>
References: <20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com>
In-Reply-To: <20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728079319; l=1817;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=sPd80p5ID1e1fg5bg8nSOM9q7MeynA1KNnT/FYVqLZ0=;
 b=+P16WMaS1TptJcNjuLo6USG7helplG+QSPK9e9AOKqDmUSTTXHLfIItjWKVGXWBqjWeXUpkTl
 I/CNBV2TN7GC6h3bsOa85emNKu/4Fj9zFkR7uoxnP92z2fa+aWkvwhA
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20240719 with
 auth_id=188
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: levymitchell0@gmail.com

From: Mitchell Levy <levymitchell0@gmail.com>

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
Cc: stable@vger.kernel.org
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/lib.rs  |  2 +-
 rust/kernel/sync.rs | 14 ++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..b5f4b3ce6b48 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,8 +44,8 @@
 pub mod page;
 pub mod prelude;
 pub mod print;
-pub mod sizes;
 pub mod rbtree;
+pub mod sizes;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..d270db9b9894 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -27,28 +27,18 @@
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        static CLASS: $crate::sync::LockClassKey =
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }

-- 
2.34.1


