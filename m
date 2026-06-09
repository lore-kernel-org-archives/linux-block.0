Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716B403B00;
	Tue,  9 Jun 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032560; cv=none; b=ctvcP3qVcJoZxjuzRa5nMLf3Ad/1/CAQrlliGeZe2+/6NLDpZL53u/IcnAThuLannVjEF96geRnXbPzSzlk+D2HRG5DDdVyqrD81StC+QOcn7QB87G9zgnSs81NvuMi6/pjchkSzF7QmeA6GjwPJ52WALVM8YF9aP5k8j7eFTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032560; c=relaxed/simple;
	bh=AEQaJe7SK7Z/x0RCHvYjLfe6Z+31poYBBz6CEFZucYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6CeLpq4HPreke2K6b0K166W73Nbjj/1f0pLEP4caX+28Vmnh+xhlVr0vJ6BD/Aih1kQMkZ/Xr33ZhAwRnV65tJnVu0VbXFshe7Ufctrq7XbLmDkLoLUNVBLYTKpHCn70pB+eBj86GSADSJ2tP0gvLWg3Q2ZDq6KuwqhRVnRbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORLbq2rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORLbq2rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8FE1F00898;
	Tue,  9 Jun 2026 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032559;
	bh=kylCIHTIqWZVVqg1E9SzeJnum0Ofj/qvsUr/FLAXqYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ORLbq2rd9IsQ0KM6VJkQSIi0/UUW9JcgQsqWlCtS4dFjSwrUkEpFwdwYMFe4wqwbs
	 j8XR9XS1sWdSqZc3q5QMLfS1VJ2GWM+8PHe61CAnVcaRdypxKxtu0bbTZAZDWMk7kL
	 RdLkzJvjZUir7vsU1jowtfq23armyfMPakzgnD9IEYceS+TvXUpHxTmj3RbmcGnewr
	 5OBNEN8zLRIBWq0IZl3v+Q3CuK9Wn7ka3SPM9EzJlLfNUJelFXnSb9USQY3Gu9A2be
	 RM80E96/gwdcWp+a0vekE8wnKQ3CpnoId2e6HEj5Yr4A8JGbmiu0nHM9flEL3oXBVR
	 6ALdqJmtFh44A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:45 +0200
Subject: [PATCH v2 06/83] block: rust: fix generation of bindings to
 `BLK_STS_.*`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-6-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4558; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=AEQaJe7SK7Z/x0RCHvYjLfe6Z+31poYBBz6CEFZucYI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS5MZAEtPyseKnhLu3ha3HCPw+XFEI2sVTNN
 RpPLZ/VhfaJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkuQAKCRD6UCkIqsW9
 0E9bD/9uFjqpyDnP6ArF+C4Ps9g7VX+5ehlZp5Wge0BITznbNerYO0QBEofxj5R+p+7QOSQHlcM
 lWX2y4KUeqwioR8dtZiFjPNq2s/EWY0ceeUALCorjFMAoW6JTl0eTX99wUJ92mS4nmTwtemI69L
 K2fc3Pis9rGscgDoFurnNvd4Szph5Kg4jWAmwX+TL7BBNhPvjM42oEEYQXHVbL4T/zarMe1AsDM
 27nefnw/tFHEd3nls3Yvx4eTAYjVwPzD6nPuL37oiXi7++NTGHGBnSe2I/9sjlx5nDRYeFf32Mi
 URUpGsp0xyV+TUmTyiR3eXTXvbgVBdFutTpQBCifsFsKu9R1KrUi7FXsocbqZuc48QPxQW3G7lc
 wQXOLbg7i/0AbwVWFFyvH+OzJMYADyt9dU3QbtKtPcCjv7QoyzrjSmpvT+urO7SKRHBBM63IRzb
 CDGf4gMv3qb5a+jGPzQ14la92avZLuIEj/XrtAcxlQYwyWlYWxiuDNCixROoUFqAqhnnv6FZssx
 4DMOjqAhpG09dp3qkjCU9pmGMzpJtNQpe4Hy6XT8omwBYv8faeCttn/JsIXIWHr/Di0Ji9e8+fM
 WqXl4V39o4hHqpXQy+nu3vVHsB3C3RwHOt7IUAWCzyBUy7K+1O2UTBQPdbsgjKrlGqlHkpItsZK
 8Par3G2IHTfF3CA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Bindgen generates constants for CPP integer literals as u32. The
`blk_status_t` type is defined as `u8` but the variants of the type are
defined as integer literals via CPP macros. Thus the defined variants of
the type are not of the same type as the type itself.

Prevent bindgen from emitting generated bindings for the `BLK_STS_.*`
defines and instead define constants manually in `bindings_helper.h`

Also remove casts that are no longer necessary.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindgen_parameters            |  6 ++++++
 rust/bindings/bindings_helper.h    | 19 +++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 17 +++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 6f02d9720ad2..128731e84775 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -5,6 +5,12 @@
 --blocklist-type __kernel_s?size_t
 --blocklist-type __kernel_ptrdiff_t
 
+# Bindgen cannot extract values from the `((__force blk_status_t)N)`
+# CPP-macro form used by most of these and emits the few it can extract
+# as `u32`. Block them entirely; the `RUST_CONST_HELPER_BLK_STS_*`
+# definitions in `bindings_helper.h` expose them as `blk_status_t`.
+--blocklist-item BLK_STS_.*
+
 --opaque-type xregs_state
 --opaque-type desc_struct
 --opaque-type arch_lbr_state
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 9da216faad51..b1fb3afee4ca 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -119,6 +119,25 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_OK = BLK_STS_OK;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_NOTSUPP = BLK_STS_NOTSUPP;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_TIMEOUT = BLK_STS_TIMEOUT;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_NOSPC = BLK_STS_NOSPC;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_TRANSPORT = BLK_STS_TRANSPORT;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_TARGET = BLK_STS_TARGET;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_RESV_CONFLICT = BLK_STS_RESV_CONFLICT;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_MEDIUM = BLK_STS_MEDIUM;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_PROTECTION = BLK_STS_PROTECTION;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_RESOURCE = BLK_STS_RESOURCE;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_IOERR = BLK_STS_IOERR;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_DM_REQUEUE = BLK_STS_DM_REQUEUE;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_AGAIN = BLK_STS_AGAIN;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_DEV_RESOURCE = BLK_STS_DEV_RESOURCE;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_ZONE_OPEN_RESOURCE = BLK_STS_ZONE_OPEN_RESOURCE;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_ZONE_ACTIVE_RESOURCE = BLK_STS_ZONE_ACTIVE_RESOURCE;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_OFFLINE = BLK_STS_OFFLINE;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_DURATION_LIMIT = BLK_STS_DURATION_LIMIT;
+const blk_status_t RUST_CONST_HELPER_BLK_STS_INVAL = BLK_STS_INVAL;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
 
 const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 89029f468f44..6b2fcd76372e 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -6,10 +6,19 @@
 
 use crate::{
     bindings,
-    block::mq::{request::RequestDataWrapper, Request},
-    error::{from_result, Result},
+    block::mq::{
+        request::RequestDataWrapper,
+        Request, //
+    },
+    error::{
+        from_result,
+        Result, //
+    },
     prelude::*,
-    sync::{aref::ARef, Refcount},
+    sync::{
+        aref::ARef,
+        Refcount, //
+    },
     types::ForeignOwnable,
 };
 use core::marker::PhantomData;
@@ -124,7 +133,7 @@ impl<T: Operations> OperationsVTable<T> {
         if let Err(e) = ret {
             e.to_blk_status()
         } else {
-            bindings::BLK_STS_OK as bindings::blk_status_t
+            bindings::BLK_STS_OK
         }
     }
 

-- 
2.51.2


