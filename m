Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6F423E8B;
	Thu, 10 Sep 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030933; cv=none; b=rLXLOinsFpXb33Kx1jIhRhkliKKvoNLF7jJGDA23cdB4G0yumUQv/YTRDE7fbLktjXLcqejXF6Q7RiDzNBGx3UKB5A6GFc+DX6QTLJsTXcfir8Iyog1cs8BjKCwX9Twj7JTsGK1f94mrEZGaaca+KTHDfKPWxUxnzpG8nMb6eOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030933; c=relaxed/simple;
	bh=O2wzGYJMYAkc/T2itapqXFBmX/u7K5ttf1JgBR/HfM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6bu7CD7NCMqy64DQMDu8xet3LBz0CFGVs857Ask7ZCmAVwgV/m1fcrTVg9t7h95W/md2lcK5dhqPuJ2p82cffqa8h7ZrjqzxO0JsJrKhXQv7wyh3TiZlovrBmF81oabzxPDydBcXaAY9633cCjigpLpBqljRpaOzZNki8Qw9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZe2GdwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZe2GdwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B707A1F00893;
	Thu, 10 Sep 2026 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030930;
	bh=nMuMfZ5oOT5xSQNE2UbnqHDsN16Vf+j3KeZtRcXbj5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jZe2GdwOlAtK2Y/DOgIkQVr++reMQhah0vlgv6xXz1IeuoFD6LxcNE0jRYaUZrkqr
	 Nh4Kfb6H0sjZ/vWlR09a9d/t7FmyuRr5lwq8BQQpuWgwcbSBs3gYCszxCc6opuexwl
	 rI12KdSLv4BUZH0JjgRbkTrNcz2peyBAc2gL6KF7JEyYm2WT32wELiGPU/hSO0w/Hi
	 YQ0/qtRVZxZCkxXNXHXP/2x8/msUwDKOJH+kwguKlwEyCxrLfIdng7SiuzDxmJYWQE
	 FHq/Vv64FeSeWdF1pQvfMfjuR90V4qVR8eWlUfgzF++JnUnK0avT4qUXVkZmXXpudm
	 5kRP7FdZovV8w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:07 +0200
Subject: [PATCH v21 3/9] rust: implement `ForeignOwnable` for `Owned`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-3-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=O2wzGYJMYAkc/T2itapqXFBmX/u7K5ttf1JgBR/HfM0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGjQYuzzLPzVcDFmo/+nPkuUnB8xRZWr6uP/
 wqulSxov86JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxowAKCRD6UCkIqsW9
 0AeWD/4xQAImVQJWGybdMjjzNA5J/mQ//XrWd8nl0WREOfKnkBJ5A44YG9C3TPFyt5i++gERKuU
 cfW3tb2jUIisOMF9GnvwnRpDoGb36Wfz0h2an+YSgiEzrFpsE3tK6u4RI4TF9GAx6YMnuqXjNiF
 0Vfl8fQjrSZxR2Ym5O3DIZjCrwYtOVdDxpygxWu6TKL0pdI6vq+LKduP9hqXBhOUPlRgaVgNiBL
 97Ggf0jMjmag0lqML/jN10MQFyLATAWhQnxJDAsRMLL5cctk0xrQQX4U1bV67D/NPS2gOtyb9ny
 RS6v6yaTlmmrF+xfuO5k4ZlKJ8/Q+XNI6HqEHYFCg8KUG0FPZoOfW5bbL40whtN9cqBHyu0uTvc
 GKWLJxaizTo0hqfGi196tFw0K76kzTRS5IVr/jrGkdsVO9Z7aFICi8t4DRqehZOiLqa8/Kgc1qS
 fz2gm5J/3wBIHTS5EtZSWUcuXYB6p9u1UcuiKVmt0hPcd2kVOonaHsn2oF2cgKeWG2LAtTlQE/j
 iOtBj660fPiupzl1yKm+ulg9UvkMrWGYJUwQJ0SdwOS/2wd4SgSrdOqyiDCCgu1VoVHxAPa4eBc
 gd/3hd5BB9l/mZO25TBpArMYuKfUECI2bGD/Rz1k6Cr/KkOdqTw2QInQHRguGnD2w6NXoeJTqQx
 Wg1ZeU9c+ANsrIw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
places such as the `XArray`.

Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
implement `ForeignOwnable`.

Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/owned.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index b76edd7c4151..e54a058d65cd 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -15,6 +15,8 @@
     ptr::NonNull, //
 };
 
+use kernel::types::ForeignOwnable;
+
 /// Types that specify their own way of performing allocation and destruction. Typically, this trait
 /// is implemented on types from the C side.
 ///
@@ -189,3 +191,51 @@ fn drop(&mut self) {
         unsafe { T::release(self.ptr) };
     }
 }
+
+// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
+// pointer satisfy alignment requirements of `T`.
+unsafe impl<T: Ownable> ForeignOwnable for Owned<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+
+    type Borrowed<'a>
+        = &'a T
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = Pin<&'a mut T>
+    where
+        Self: 'a;
+
+    #[inline]
+    fn into_foreign(self) -> *mut kernel::ffi::c_void {
+        Owned::into_raw(self).as_ptr().cast()
+    }
+
+    #[inline]
+    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
+        // SAFETY: By function safety contract, `ptr` came from `into_foreign` and cannot be null.
+        let ptr = unsafe { NonNull::new_unchecked(ptr.cast()) };
+
+        // SAFETY: By the function safety contract, `ptr` was returned by `into_foreign`, which gave
+        // up exclusive ownership of a valid, pinned `T`; we retake that ownership here.
+        unsafe { Owned::from_raw(ptr) }
+    }
+
+    #[inline]
+    unsafe fn borrow<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Borrowed<'a> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a
+        // reference for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    #[inline]
+    unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::BorrowedMut<'a> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a
+        // unique reference for `'a`.
+        let inner = unsafe { &mut *ptr.cast() };
+
+        // SAFETY: We never move out of inner, and we do not hand out mutable
+        // references when `T: !Unpin`.
+        unsafe { Pin::new_unchecked(inner) }
+    }
+}

-- 
2.51.2


