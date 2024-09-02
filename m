Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002F1A4E7A;
	Mon,  2 Sep 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725311768; cv=none; b=CcL3P6Ih4XFmoF72vKjQrrakGzgG1FrBWxo8F8DpQVWGAloEn/Ym4dn45Kc0jjk/iAEgcvfJREzLCRb4Cx9hngqu2UmNQu4+kvOEADJMOjDPAbqyaYelEHEUTIcJzHx6nWiRbJFVINBuk7B88h4wElNyjUT/kR4J+fA+IvTYjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725311768; c=relaxed/simple;
	bh=xHIradCTOWxs111sVGsTWXNDob8KaHxOSBLFE3nj+qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6ox90d1/0eVZBJy993HZDJbSq9B1xBPDQiyFfNNllA8pAY/OFM6kt9Zzf05uVCLPIquEfwzYqzKtiQgsVUMLnZRqLHhWYHcTtOWbqx155FFfDk6IlvGDuqOXylWX6L7V2kd/97kf+2dTiOIqCjAy27YLLrO3sVtqJNJqLzmEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpT094S2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpT094S2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so38430775e9.3;
        Mon, 02 Sep 2024 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725311764; x=1725916564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPtPsF6UAM9E686vehQDB5d6aPxb9xK3nFtvVgTfqY4=;
        b=BpT094S2ElIE1+Yhk27R7fuK4ofoL8+00C6ji7QkYvZ+3vFFgZv3R3zKySzoI606Ek
         ig/Yv+7Szs9uDjXlgnQgprHU0IB8ojFKVKOpxNP/8v936FBVmZItQ6oRZRGUr0D4S7Yl
         o9n4H8ChIq45HJU0Zbo7aQesH6fT9OcePJPe8yG/apvovX5J2yc+5oq9WghFc268WzQ7
         tOk42tTOhH54X07kP+i+/cVnoe8GAHZybXp9HCIH5nKqRg1WOe6BSRsydqSkhAtZTLdQ
         tTbstfhLmtcyaVUIwOJNuw+94n7hBOZ6qsne//y6wS9/eASFgcMm0MVnuhrKEu3wQch2
         VY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725311764; x=1725916564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPtPsF6UAM9E686vehQDB5d6aPxb9xK3nFtvVgTfqY4=;
        b=Iz1njgNOewFwFgtxDf4eBzCV3jOzjXt+jngVzjy4O1P3vfR0hn9jul6SkcAfg+/wTy
         lnGhK6EgpleMwjwW2lnoBaNlRsKHMcENePCCex6LiO0cKeyfVg/rdzei0EbGpjXlO1mw
         OAGkmUTAM6eFmnJaTunFE6v8eE3mrdGcANhbltPCwVinHP2401j2nUi4g/rFrpYInyGw
         bJrga7OrLXzXPOa+v3CvXBP59UlW8diNsD0bIjMXfwxddYCLxz059p219a/acO0L5nfz
         lz4dS4IAmwUl+W+5K4ShBZP5Z9UaX19TZvY/U+XZnNiquRq7HaItaD+GDrFVlLz2+rSS
         4rnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+5sy77OM3R8DkBBp4mQVRw0x8mbwNj10G9awBvxRWCTqkgzlcnUeLmpuIOUDprDENtiIsg0s7N2jbfg==@vger.kernel.org, AJvYcCXjOT5eUCNmbCkv9vCTAIRh3DdPS14/Qpcsemt112SHyfUgiGq9ocCsHUE+5xVr6eKyZtIbbr3wuxKySUnn@vger.kernel.org, AJvYcCXpVbtLzSlToObN00+OsyTlinOBSGz/z7VqLOI4EeZ95XBmCtvuuxWEkjpqF+pLfH++FkfpUul0DgyWYGaU+Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrhmQXXl7XYrdbBfoG5VzDASAhSYcEZUgQJFSfuPuFvC+61bX
	Z/trcX0lySLhNsGUmw4xtmkzOimOxZ5JQwloaGD8uzcm6sJuXah7
X-Google-Smtp-Source: AGHT+IE6UBN+imp8de3hPh0orb3455J/7ReQ7aN3NqyMW39i8in3Loh8Ndyo9/Tph97GgffcPulGhQ==
X-Received: by 2002:a05:600c:3ca9:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-42c82f67431mr34638755e9.25.1725311763513;
        Mon, 02 Sep 2024 14:16:03 -0700 (PDT)
Received: from localhost ([2001:9e8:baf9:8300:afb3:538c:3255:5bc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc87773fsm113061675e9.0.2024.09.02.14.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 14:16:03 -0700 (PDT)
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
Subject: [PATCH] docs: rust: fix formatting for kernel::block::mq::Request
Date: Mon,  2 Sep 2024 23:15:53 +0200
Message-ID: <20240902211553.103807-1-frazar00@gmail.com>
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

Closes: https://github.com/Rust-for-Linux/linux/issues/1108

Signed-off-by: Francesco Zardi <frazar00@gmail.com>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
---
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

