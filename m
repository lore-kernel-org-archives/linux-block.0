Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF63F4100;
	Fri, 26 Jun 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474935; cv=none; b=fetyyDOeTMe11SbeiTDIiEJZdpFhMCwjpmW5UKJ3TjYOk6Qvz22af4fUSZcs93X/KNphlZkxj0EHlzpR4PGYuTxC61mmQJnNG41nxlCax0PdkJTLvMUT+EWJKl5U0/BJITdC4yKpaHkxxYkxyjJpe5cy4uPc/CuUkllyz5jfp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474935; c=relaxed/simple;
	bh=rxFg/OxNn7Iq2MJWs1wke7ArbvlV7NG8RuAFMsQ/1ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXqrf63HNDhvgbv18ZmxN+vw2h5pKB/K/eL4mBVL8+lsIUzXAbFmxw+O4L2Jhkh4a/pBrdjiPnh4I2TkF3WngziHAXHM1q+67HRVV8kXhhCPAXbfGHJ/0PEU8OYWvWEU1quMCOdunjMZMc9I3QfmIvg1CHaPSJOXpXDB0LareMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKqjad42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKqjad42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE671F00A3A;
	Fri, 26 Jun 2026 11:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782474929;
	bh=HqYVmoPun9uThSi6e4i4mienBqI4nWoqt5vN59RnpsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mKqjad42xYAZRLbtP8kQKjVT+kMZDvm4fSe5dDNcFTDtHA+DeVzUwint2IRD+Q5Mg
	 bTyykVvfOMCyyi0fFgjAwDaQLjgJE+6HqZgjidFgpU+gClN253nuwYH7gg98QEYUcI
	 SMASWXZe/TDARjw5RxOar6hvszN+EYdFT3adc/bZo6KF0fVuYV2wvwrx0SEb87SnQY
	 O8/A0bgzp2tdZOvxAu6BpaPIRMCc6w18v+7RK+/AjIDavqzGu+oywzABLKtczpJane
	 6wlUHbr+HK+oVBoxw8a+CDhScUZmo/wqVWDn4dhDkvi6+VHgW4oFv3I/4ETXAtRYUr
	 1AG76K043EKcw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 26 Jun 2026 13:54:00 +0200
Subject: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2726; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=rxFg/OxNn7Iq2MJWs1wke7ArbvlV7NG8RuAFMsQ/1ok=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPmh2mexRRMoFN1jy1lxkXcXvUPvmvPHbqJnCj
 QAUGGC7f7qJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaj5odgAKCRD6UCkIqsW9
 0LrCD/93GVgfFyjgmqz4PMTBC6DC/QsQMpzEyq47kxne8s0C3CmAbCGQvd4mAcI8HSxqbwOjcFL
 OBDHo542xnGwDB/Bfgk8ZJ36Yp3PK+stZX0/+AFnICkNrNSqcJmhhHjdo9Tu7mV5bwpTyv3nC+C
 uj74AWk015g/E8FCrteSPOFOBGMSpal/pjGzSMsfpToOrxzxqQ8ThXzd6U7NE01vCWjJ5Nq/PD+
 QP/IpqC+sXlkzjL2Dh3xl5vES+tBXeVFF97zq/7jfWtVddoEEJPYcwbsTFDhB+hFwVHQ5ti1+EQ
 5PpYGdSk0GoVfIdBz251SFJuvtwmKa1xBMr/TU6UlazoxdbwHohI3mhrlz78g5SyUqyjgiahy90
 +jB6ontwnaZZmTwallmY+6mowMat/7VB0RpL+RTMQqpvRWoNFF65ILwaLa7w7QYHY3fzDJvYuJn
 kWADzpzeZAO9GkNC5RRmCCobtIQBcbekBQj8O7eO8RBKHSuFvmBeUmoiG3SUSeNj3eYg7pKmvEa
 rwHJf8DWKqz4lWTKGDNqFeWEWHnRxPHqZBMITllCI6hpe2UxiuVRBUrao7AzseLD6qXGFth8/pE
 cDQm/5nPJMMkgAPTn7hMpZ0wfDTE2Rsq0bT03XgHYN8T/equKYrQVk8vTBgLp14kaEmAAS1kebW
 SBN8VIqJ/Bt9/gg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
places such as the `XArray`.

Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
implement `ForeignOwnable`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/owned.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 7fe9ec3e55126..93a5dfcc1e6f5 100644
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
@@ -186,3 +188,51 @@ fn drop(&mut self) {
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


