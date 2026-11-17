Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.30.211.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958350;
	b=ZSXPeYXvN8yWfSOdUsP+wIy+tjYmCnT/mnHSeS0iIiT1dft+uHmumsyxSMKxKKUkdPDz
	 Z8sclfQC6jpvT1tvW4QXKMTf0DIZEU3HbNQtIKsOqpU1AhxCE4oW6JT0HuyZomtGmDvRK
	 GVicJ1BBMvCGdzCvr/EZe73CIPpP+b6BaNLsIGTKrloCV0EpFAXe1ggp0VJykYYkCzvtm
	 y4SnVr2EhYuF52BhkUyn88/jd7j10W4mI2gskeHihQgpNsE9olLeAnEyvL/6RxaBDFo9f
	 /gCr6v8ikBnBGOOUzhDVz/kFrB9yejkJ0BWIyM1TKotNbVg/EdKeX7X+kP9do3kK51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958350;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bFKN+snfKCKIRA92xdfrL/fXj8QHSvi1QUir+8b99eo=;
	b=bCF9zqbB1X+0Gzc2eIyDqzsWpsrOlthT4PhHPIs9rjNxcBDlUnZfy8sJT80HdR9WLpCW
	 Hn24E7B7A1uvYheDBHNSQzuqz6sxbdYlhlww4VbVBiL5V9dhXhWoInuw3LnvudBADHIpc
	 bqf1NrIrFD9R4J1gjAv7KGMvBMaBjhEPnLQ2loa7pECwU2k/SvPEj0YSArO8A/V0MRJHQ
	 LkvxdvrNpqxU0/TBWBheBOwXX/QWb8imXVVXbNyFlfJWgc7yFaB3uo+GBZj2Qyk3BYaOS
	 44bLZDkF7ni6Kffwfy3wH+lgLx0PrOTmf5GIXrX1D2BPw+yLf+NFCGfMA7R2Ko8ugiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=konsulko.se;
	spf=none smtp.mailfrom=konsulko.se;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=rsa-sha256 header.s=rsa2 header.b=GAK1P0nC;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=ed25519-sha256 header.s=ed2 header.b=dRATJSc2;
	arc=none smtp.remote-ip=46.30.211.244
Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10F606A339
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB10F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=konsulko.se header.i=@konsulko.se header.a=rsa-sha256 header.s=rsa2 header.b=GAK1P0nC;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=ed25519-sha256 header.s=ed2 header.b=dRATJSc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794958347; x=1795563147;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=bFKN+snfKCKIRA92xdfrL/fXj8QHSvi1QUir+8b99eo=;
	b=GAK1P0nC5usdvu+dVAv04dijiDbfDVj0X4BtzX3igl5KuZqY8XKfgm2OEy4k0E64wc3pkxh+L5ft5
	 mCs62QiNQeqjgvno1Ew0RcvPFfc33ptDjvPxVXMrw5uUMK9BWi+3JlM0CZ2NWigM7qrmdPybo4R8xG
	 gFbyuYpCe6aOIfyoulZKtCtQtO3cDD7WQHV1x4IU9h0Z8QFhoUyMxzybbARHTV8J9v9nuH/zzMpGnN
	 5r3sgwBCDajeKUsu07oWtrnkHLrGmjozH00/TFMrzfO/Ao9H+rya70TXM3jtrNckcPAiHYZAE4TEDG
	 f7owC4qUEUam3bzHeLG0Jmf7GCVN6zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794958347; x=1795563147;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=bFKN+snfKCKIRA92xdfrL/fXj8QHSvi1QUir+8b99eo=;
	b=dRATJSc2iuwoJgMXn3zonAqFyQTwr0q2amA49/AAg5EVxkXk/qAW91ioXzn+4IG+NtkuPzCpfEimx
	 4Jf1eGgCQ==
X-HalOne-ID: 2484e663-e2df-11f1-92b6-49de817b90c1
Received: from slottsdator.home (unknown [2a02:1406:27d:15:2438:a644:c11e:a5ef])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 2484e663-e2df-11f1-92b6-49de817b90c1;
	Tue, 17 Nov 2026 23:32:25 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Igor B <igor.b@beldev.am>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH 2/3] rust: page: add reference counting, raw pointers and a private bit lock
Date: Wed, 18 Nov 2026 00:32:10 +0100
Message-Id: <20261117233211.3137168-3-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
References: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Igor B <igor.b@beldev.am>

A `Page` always owns its page exclusively, with no way to take another
reference or keep it as a raw pointer. Add:

- `Page::get()`, which takes another reference with `get_page()`;
- `Page::into_raw()` and `Page::from_raw()`, to convert a `Page` to and
  from the `struct page` pointer it holds a reference to;
- `Page::try_get_raw()`, which takes a reference from a possibly stale
  pointer with `get_page_unless_zero()`, for lock-free lookups like
  brd_lookup_page(). This is sound because a `struct page` is never
  freed, even once its memory is;
- `Page::lock_private_bit()`, which takes a bit spinlock in the page's
  `private` field and returns a guard that releases it. This gives a
  page used as plain memory a lock of its own at no memory cost.

Add Rust helpers for `get_page()`, `get_page_unless_zero()`,
`bit_spin_lock()` and `bit_spin_unlock()`.

This patch was tested with the help of  Claude Code AI coding assistant.

Signed-off-by: Igor Belousov <igor.b@beldev.am>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 rust/helpers/bit_spinlock.c |  13 +++
 rust/helpers/helpers.c      |   1 +
 rust/helpers/page.c         |  10 +++
 rust/kernel/page.rs         | 160 ++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 rust/helpers/bit_spinlock.c

diff --git a/rust/helpers/bit_spinlock.c b/rust/helpers/bit_spinlock.c
new file mode 100644
index 000000000000..5c59632bd171
--- /dev/null
+++ b/rust/helpers/bit_spinlock.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bit_spinlock.h>
+
+__rust_helper void rust_helper_bit_spin_lock(int bitnum, unsigned long *addr)
+{
+	bit_spin_lock(bitnum, addr);
+}
+
+__rust_helper void rust_helper_bit_spin_unlock(int bitnum, unsigned long *addr)
+{
+	bit_spin_unlock(bitnum, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7b..e955a33e3535 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -44,6 +44,7 @@
 #include "barrier.c"
 #include "binder.c"
 #include "bitmap.c"
+#include "bit_spinlock.c"
 #include "bitops.c"
 #include "blk.c"
 #include "bug.c"
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index f8463fbed2a2..9c287bfcc371 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -26,3 +26,13 @@ __rust_helper int rust_helper_page_to_nid(const struct page *page)
 	return page_to_nid(page);
 }
 #endif
+
+__rust_helper void rust_helper_get_page(struct page *page)
+{
+	get_page(page);
+}
+
+__rust_helper bool rust_helper_get_page_unless_zero(struct page *page)
+{
+	return get_page_unless_zero(page);
+}
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 1c0796ea229f..e75d9efbcce6 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -12,6 +12,11 @@
         code::*,
         Result, //
     },
+    ffi::{
+        c_int,
+        c_ulong, //
+    },
+    types::NotThreadSafe,
     uaccess::UserSliceReader, //
 };
 use core::{
@@ -200,6 +205,139 @@ pub fn as_ptr(&self) -> *mut bindings::page {
         self.page.as_ptr()
     }
 
+    /// Takes an additional reference on this page.
+    ///
+    /// The returned [`Page`] independently owns one reference to the same page as `self`. The
+    /// page is only actually freed once every such [`Page`], including `self`, has been dropped.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::page::Page;
+    ///
+    /// let page = Page::alloc_page(GFP_KERNEL)?;
+    /// let page2 = page.get();
+    ///
+    /// drop(page);
+    /// // `page2` still keeps the page alive.
+    /// drop(page2);
+    /// # Ok::<(), kernel::alloc::AllocError>(())
+    /// ```
+    #[inline]
+    pub fn get(&self) -> Self {
+        // SAFETY: `self.page` is valid by the type invariant, and calling `get_page` on a page
+        // that is kept alive by `self` is always safe.
+        unsafe { bindings::get_page(self.page.as_ptr()) };
+        // INVARIANT: We just took a new reference to the page pointed to by `self.page`, so the
+        // new `Page` has ownership over that reference.
+        Self { page: self.page }
+    }
+
+    /// Consumes the [`Page`], returning the raw pointer to its `struct page`.
+    ///
+    /// The reference owned by `self` is not dropped: the caller becomes responsible for it, and
+    /// releases it by turning the pointer back into a [`Page`] with [`from_raw`](Self::from_raw).
+    #[inline]
+    pub fn into_raw(self) -> NonNull<bindings::page> {
+        ManuallyDrop::new(self).page
+    }
+
+    /// Takes back ownership of a page from a pointer returned by [`into_raw`](Self::into_raw).
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by [`Page::into_raw`], and the reference it stands for must
+    /// not have been taken back already, by an earlier call to this function.
+    #[inline]
+    pub unsafe fn from_raw(ptr: NonNull<bindings::page>) -> Self {
+        // INVARIANT: By the safety requirements of this function, `ptr` stands for a reference to a
+        // valid page that nobody else owns.
+        Self { page: ptr }
+    }
+
+    /// Attempts to take ownership of a page from a raw, possibly stale pointer.
+    ///
+    /// On success, returns a new [`Page`] that owns one reference to the page. On failure
+    /// (meaning the page's reference count had already reached zero, i.e. its last owner had
+    /// already released it), returns `None` without otherwise touching the page.
+    ///
+    /// This is the kernel's usual way of giving a lock-free, concurrent lookup (such as one
+    /// protected by the RCU read lock; see [`kernel::sync::rcu`](crate::sync::rcu)) a safe way to
+    /// turn a pointer it found into an owned reference, without taking any lock: unlike
+    /// [`get`](Self::get), this does not assume `ptr` is already known to be alive.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point at a valid `struct page`. Note that, unlike most kernel objects, a
+    /// `struct page` is never freed or reused for a different purpose for as long as the system
+    /// is running: only the memory it describes is freed and may be reused once its reference
+    /// count drops to zero. It is therefore always safe to inspect and modify the reference count
+    /// through a `struct page` pointer that was, at some point, validly obtained, even if the
+    /// page has since been fully released by its last owner, as long as the pointer has not since
+    /// been reused to mean something other than a `struct page` pointer (which can only happen if
+    /// the caller itself reinterprets it as something else).
+    #[inline]
+    pub unsafe fn try_get_raw(ptr: NonNull<bindings::page>) -> Option<Self> {
+        // SAFETY: By the safety requirements of this function, `ptr` points at a valid
+        // `struct page`.
+        //
+        // INVARIANT: If this call returns `true`, then it has just incremented the reference
+        // count of the page pointed to by `ptr`, and we have ownership over that new reference.
+        if unsafe { bindings::get_page_unless_zero(ptr.as_ptr()) } {
+            Some(Self { page: ptr })
+        } else {
+            None
+        }
+    }
+
+    /// Returns a pointer to the `private` field of this page.
+    #[inline]
+    fn private_ptr(&self) -> *mut c_ulong {
+        // SAFETY: `self.page` points to a valid `struct page` by the type invariant. Taking the
+        // address of a field neither reads nor writes it.
+        unsafe { &raw mut (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.private }
+    }
+
+    /// Acquires bit `BIT` of the page's `private` field as a bit spinlock.
+    ///
+    /// Spins until the bit is clear, then sets it. The lock is released when the returned guard
+    /// is dropped. As with any spinlock, preemption is disabled while it is held. Bit spinlocks
+    /// are not tracked by lockdep.
+    ///
+    /// This gives a page that is used as plain memory, such as a page holding the contents of a
+    /// RAM disk, a lock of its own without growing any other structure.
+    ///
+    /// # Safety
+    ///
+    /// The caller must own the page's `private` field, and must only access it through this
+    /// function while the page is shared. This is the case for a page allocated with
+    /// [`Page::alloc_page`], which has `private` zeroed, as long as the page is never handed to
+    /// another user of `private`, such as the page cache.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::page::Page;
+    ///
+    /// let page = Page::alloc_page(GFP_KERNEL)?;
+    /// // SAFETY: `page` was just allocated, and its `private` field is only used here.
+    /// let guard = unsafe { page.lock_private_bit::<0>() };
+    /// drop(guard);
+    /// # Ok::<(), kernel::alloc::AllocError>(())
+    /// ```
+    #[inline]
+    pub unsafe fn lock_private_bit<const BIT: u32>(&self) -> PagePrivateBitGuard<'_, BIT> {
+        const { assert!(BIT < c_ulong::BITS) };
+        // SAFETY: `private_ptr()` returns a valid pointer, and the caller guarantees that the
+        // field is only accessed by bit spinlock operations.
+        unsafe { bindings::bit_spin_lock(BIT as c_int, self.private_ptr()) };
+        // INVARIANT: The lock was just acquired.
+        PagePrivateBitGuard {
+            page: self,
+            _not_send: NotThreadSafe,
+        }
+    }
+
     /// Get the node id containing this page.
     #[inline]
     pub fn nid(&self) -> i32 {
@@ -373,6 +511,28 @@ pub unsafe fn copy_from_user_slice_raw(
     }
 }
 
+/// A bit spinlock held in the `private` field of a [`Page`].
+///
+/// Created by [`Page::lock_private_bit`]. The lock is released when the guard is dropped.
+///
+/// # Invariants
+///
+/// The guard holds bit `BIT` of the `private` field of `page` locked.
+#[must_use = "the lock is released immediately when the guard is unused"]
+pub struct PagePrivateBitGuard<'a, const BIT: u32> {
+    page: &'a Page,
+    _not_send: NotThreadSafe,
+}
+
+impl<const BIT: u32> Drop for PagePrivateBitGuard<'_, BIT> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `private_ptr()` returns a valid pointer, and the lock is held by the type
+        // invariant.
+        unsafe { bindings::bit_spin_unlock(BIT as c_int, self.page.private_ptr()) };
+    }
+}
+
 impl Drop for Page {
     #[inline]
     fn drop(&mut self) {
-- 
2.39.5

