Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FC22F11;
	Tue,  3 Sep 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386410; cv=none; b=pdYyDIheG24BBbBGBCcYSZEu1VBgqVqKTIXBprZOf8Y4YGxskIEDLm/GCxa2G7QP7gkDEA//D1dzO29L8wbZH+8YeSAEbJ1/VbzZ4jZC9Su8uMKF0dsW6PDJvE623CNasAZSle86H/U8zvbne8tu0Wxny8ul4ueHPr0vEANS/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386410; c=relaxed/simple;
	bh=3NZnnSTOt8QqC78m6RFomWxsmZgbDW7veu7LAxRn0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9QVMHtJc0+ufeLsXgnUNqBwWIsU6SDMPe54AYQ6qBiykRn3188CAUqqEVHWscbLY+JR/VhYuXE3H7mgjjz8MPke7Hul10n55GVSfP/9WCcDtINsIa+p2GJQLQm5lz7/i0iO7Blu2PBqsqsg2ohtvx6AG/j267+fukVVVJUCXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTgZ/TmO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTgZ/TmO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so38485395e9.3;
        Tue, 03 Sep 2024 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386406; x=1725991206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTTtSleF9QUDvuD2g/6jIrQ7gUIyErN2s34T3DUELQw=;
        b=gTgZ/TmOUXXRvRFZ8i6jlEK8SMAPDgRc2UGaL7dEhFlaZzg65LG7PW+k68GgHN+OWp
         WZh4pp1qqGxzZw64Vv1FyGLKUu6E4vFwy8YC0d7y3QI3mw4Y9h9s/SYBNAblHy9VvSaR
         tVNpExZh4TOS8tpkPRAXbQBWc7Gbi3tWRkPD1rHdta4ZGic3tmPiv5OgoNb+KucUy0Q0
         bPagjuBMDO6ttxEQgbkBIJQCxhF55htOSbzwzfVrZui19Vj8/NIMcjmpSKIPgR3ljN2M
         gbJynZ6cHrA50UNN6Uiu2HJiavXJSZ1oMZdg2PFBncbyey8Tx5m7y7ufTBNdk0QYySJZ
         Nawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386406; x=1725991206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTTtSleF9QUDvuD2g/6jIrQ7gUIyErN2s34T3DUELQw=;
        b=BLXpPy+2W72UcoJe2FvdIfodXTtM224hsWSTxGzUURqw1lfPSxrWAad2cmAECHw6v4
         ZPpTliBpxL3gprUXNNfqFSfgE9xvonCh7veVlDkl9oHchqirv1y4emI91YuhLsMQiTHx
         v0Fc1wvVAHdFrE4YO+8yJ7ZKASJj26LIshV71ho0B/fCoJupeR3PXMfCviVd8C8h8Lg1
         Lli3ix23Jb0eJL8URp4SbRwEpN+v9/m49sW0FezYaqCACqiFtso8CdLNp9mRfdr6Ed7K
         Hd5yGiHn1QatM3dIcI+z1IBPiy864HB5aIv3tQEtRuGRxK666FSJcqrkYWVyYXgoVG/h
         AjAg==
X-Forwarded-Encrypted: i=1; AJvYcCVKh/VnxnFNK9Zwncd18d5ZRSG87qh5McPm8ToYmtLcwfmK9n0EeDAIJsQoZ38T69JwM11V2Hgu5gVLig==@vger.kernel.org, AJvYcCW5FNG6Oq+1qFhKul93/33TV3I1CwVDcbK+AoNQSif3OyEV7iqiABLZOEdxvC9JouQK6tRZeDpwJ6rK4yZsNAU=@vger.kernel.org, AJvYcCXlMGxZjde/GuGp0vawZT0kLBcypZVnFyZgnKpnmMvRnQ79mCEJVv+o4iME9EHIvZj1YfmWtQ0zssC0f9gb@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5JXgPKWaN92EgGVf6n+KgHegH1zwhiaQLAf2YvVNXFIMbfGd
	h5yky4LH5STlTg9QUqKwm/36PAvZOf1jS7CS0ggoBVnqXz0FTF4j
X-Google-Smtp-Source: AGHT+IHiJ2vRCCdjjT4peWQjU9DiGLCH9AHM/lR2+Z4z4z5DgE6OHwyt9kXo77v9sju+w1AKOgl8jQ==
X-Received: by 2002:a05:600c:1d8f:b0:426:6158:962d with SMTP id 5b1f17b1804b1-42bb01e6e03mr130469495e9.23.1725386405146;
        Tue, 03 Sep 2024 11:00:05 -0700 (PDT)
Received: from localhost ([2001:9e8:baff:c800:ef0a:4bbb:2082:107f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf15b9b1sm137939785e9.10.2024.09.03.11.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:00:04 -0700 (PDT)
From: Francesco Zardi <frazar00@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Zardi <frazar00@gmail.com>
Subject: [PATCH v2] docs: rust: fix formatting for kernel::block::mq::Request
Date: Tue,  3 Sep 2024 19:30:29 +0200
Message-ID: <20240903173027.16732-3-frazar00@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several issues with rustdoc formatting for the
`kernel::block::mq::Request` module, in particular:

- An ordered list not rendering correctly, fixed by using numbers prefixes
  instead of letters

- Code snippets formatted as regular text, fixed by wrapping the code with
  `back-ticks`

- References to types missing intra-doc links, fixed by wrapping the
  types with [square brackets]

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1108
Signed-off-by: Francesco Zardi <frazar00@gmail.com>
---
V1->V2:
Fixed the order of the "Reported-by", "Closes", and "Signed-off-by" tags.
Removed empty line after "Closes: ". 
Many thanks to Miguel for the prompt feedback!

 rust/kernel/block/mq/request.rs | 61 +++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..a5c1edb4602e 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -16,50 +16,55 @@
     sync::atomic::{AtomicU64, Ordering},
 };
 
-/// A wrapper around a blk-mq `struct request`. This represents an IO request.
+/// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
 /// # Implementation details
 ///
 /// There are four states for a request that the Rust bindings care about:
 ///
-/// A) Request is owned by block layer (refcount 0)
-/// B) Request is owned by driver but with zero `ARef`s in existence
+/// 1. Request is owned by block layer (refcount 0)
+/// 2. Request is owned by driver but with zero [`ARef`]s in existence
 ///    (refcount 1)
-/// C) Request is owned by driver with exactly one `ARef` in existence
+/// 3. Request is owned by driver with exactly one [`ARef`] in existence
 ///    (refcount 2)
-/// D) Request is owned by driver with more than one `ARef` in existence
+/// 4. Request is owned by driver with more than one [`ARef`] in existence
 ///    (refcount > 2)
 ///
 ///
-/// We need to track A and B to ensure we fail tag to request conversions for
+/// We need to track 1 and 2 to ensure we fail tag to request conversions for
 /// requests that are not owned by the driver.
 ///
-/// We need to track C and D to ensure that it is safe to end the request and hand
+/// We need to track 3 and 4 to ensure that it is safe to end the request and hand
 /// back ownership to the block layer.
 ///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of the C
-/// `struct request`.
+/// [`struct request`].
 ///
 /// # Invariants
 ///
-/// * `self.0` is a valid `struct request` created by the C portion of the kernel.
+/// * `self.0` is a valid [`struct request`] created by the C portion of the
+///   kernel.
 /// * The private data area associated with this request must be an initialized
 ///   and valid `RequestDataWrapper<T>`.
 /// * `self` is reference counted by atomic modification of
-///   self.wrapper_ref().refcount().
+///   `self.wrapper_ref().refcount()`.
+///
+/// [`struct request`]: srctree/include/linux/blk-mq.h
 ///
 #[repr(transparent)]
 pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
 
 impl<T: Operations> Request<T> {
-    /// Create an `ARef<Request>` from a `struct request` pointer.
+    /// Create an [`ARef<Request>`] from a [`struct request`] pointer.
     ///
     /// # Safety
     ///
     /// * The caller must own a refcount on `ptr` that is transferred to the
-    ///   returned `ARef`.
-    /// * The type invariants for `Request` must hold for the pointee of `ptr`.
+    ///   returned [`ARef`].
+    /// * The type invariants for [`Request`] must hold for the pointee of `ptr`.
+    ///
+    /// [`struct request`]: srctree/include/linux/blk-mq.h
     pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         // INVARIANT: By the safety requirements of this function, invariants are upheld.
         // SAFETY: By the safety requirement of this function, we own a
@@ -84,12 +89,14 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
     }
 
     /// Try to take exclusive ownership of `this` by dropping the refcount to 0.
-    /// This fails if `this` is not the only `ARef` pointing to the underlying
-    /// `Request`.
+    /// This fails if `this` is not the only [`ARef`] pointing to the underlying
+    /// [`Request`].
     ///
-    /// If the operation is successful, `Ok` is returned with a pointer to the
-    /// C `struct request`. If the operation fails, `this` is returned in the
-    /// `Err` variant.
+    /// If the operation is successful, [`Ok`] is returned with a pointer to the
+    /// C [`struct request`]. If the operation fails, `this` is returned in the
+    /// [`Err`] variant.
+    ///
+    /// [`struct request`]: srctree/include/linux/blk-mq.h
     fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
         // We can race with `TagSet::tag_to_rq`
         if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
@@ -109,7 +116,7 @@ fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
 
     /// Notify the block layer that the request has been completed without errors.
     ///
-    /// This function will return `Err` if `this` is not the only `ARef`
+    /// This function will return [`Err`] if `this` is not the only [`ARef`]
     /// referencing the request.
     pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         let request_ptr = Self::try_set_end(this)?;
@@ -123,13 +130,13 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         Ok(())
     }
 
-    /// Return a pointer to the `RequestDataWrapper` stored in the private area
+    /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///
     /// # Safety
     ///
     /// - `this` must point to a valid allocation of size at least size of
-    ///   `Self` plus size of `RequestDataWrapper`.
+    ///   [`Self`] plus size of [`RequestDataWrapper`].
     pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper> {
         let request_ptr = this.cast::<bindings::request>();
         // SAFETY: By safety requirements for this function, `this` is a
@@ -141,7 +148,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
         unsafe { NonNull::new_unchecked(wrapper_ptr) }
     }
 
-    /// Return a reference to the `RequestDataWrapper` stored in the private
+    /// Return a reference to the [`RequestDataWrapper`] stored in the private
     /// area of the request structure.
     pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
         // SAFETY: By type invariant, `self.0` is a valid allocation. Further,
@@ -152,13 +159,15 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
     }
 }
 
-/// A wrapper around data stored in the private area of the C `struct request`.
+/// A wrapper around data stored in the private area of the C [`struct request`].
+///
+/// [`struct request`]: srctree/include/linux/blk-mq.h
 pub(crate) struct RequestDataWrapper {
     /// The Rust request refcount has the following states:
     ///
     /// - 0: The request is owned by C block layer.
-    /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
-    /// - 2+: There are `ARef` references to the request.
+    /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
+    /// - 2+: There are [`ARef`] references to the request.
     refcount: AtomicU64,
 }
 
@@ -204,7 +213,7 @@ fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64
 }
 
 /// Store the result of `op(target.load)` in `target` if `target.load() !=
-/// pred`, returning true if the target was updated.
+/// pred`, returning `true` if the target was updated.
 fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
     target
         .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {

base-commit: a335e95914046c6bed45c0d17cabcd483682cf5e
-- 
2.46.0

