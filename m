Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616F1E3DDE;
	Thu,  4 Jun 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604086; cv=none; b=Ofkkn5sHIw6H+3W8XKoAENoV/nTS7O2DexL8jlYyWL0lbkFGDO7MaTqI1L7Nk+Dpq/2dRrnyhH0lNgG552DXBm/FFbMCoxlWOWpsm/7Y+GUyTxMOgWzB5ZATsM+whB8uFLDy7UG9QXSwPLHaSN1Ja3JhMD96qa7/dz/vfalHNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604086; c=relaxed/simple;
	bh=wiR/tjsjZUc/szwoZmoCjaXgIOvvjFpABHNna2O4ox0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSHGMwYyUUdGKlI71vZvP4VYpTeN1CwR6FdmJ55m8osWGWeL+0TG9glBhpiPL49gLj7eIg61oWrTA0CFRh2VqbeS76Zz7MmCQ6k0I+EoWHwLOe8WgtFcqurXGtB0YfNRZymi/X0r29+HECbJcQKHdVv28NVSfkjYKd801TSJ+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1KhBYKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1KhBYKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAAD1F00893;
	Thu,  4 Jun 2026 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604085;
	bh=hN3l3BdGf/2AYaP03yQUTPwUIONO7SBS5tD05SJ/lgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L1KhBYKardL4WLZ1hxlsOwhksTaRQTGI+GRdaf7u+5MQLYeqW4lEoJFDK5PY8udEi
	 OgD8pgWy26+xr++oM7Eas5xkaFfFQVWQF0gfnE/F5TPP3XfvNea3Mz2VTe3tTpDBeP
	 1bxU43ejnz6I/o5682xm0l7UOqZ79U5PkaIjHZv+CUzCOAngWwGH0ZvEcQGeYsQjKK
	 0F4rK27NUH9tegKW2KFdA132RgpjWZg1P1S53KoP6Z/MZy+yzc98gRrwDxVmDTiYFe
	 kDSJcR75jkiLmb+QjuR21BLBIU9xRGCNr3KPvMstFAKl8aKJzXXN6D8QTD5Zg2oVcn
	 fIEFQRiqEI/Pg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:15 +0200
Subject: [PATCH v17 03/10] rust: implement `ForeignOwnable` for `Owned`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2733; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=wiR/tjsjZUc/szwoZmoCjaXgIOvvjFpABHNna2O4ox0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvojMJS3KEQLaRggiy/IympJ139LRe+De2u3
 A92SMSRv/eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb6AAKCRD6UCkIqsW9
 0EKxD/40KjICAkhQszkmSwLgDHYHvBdMURq9hW/tlw+Ez08KtTHqNDPCkZkXsfpdsApuKNQ52UY
 heVYe2Yx5rTJP9GY1T2tzh/4qCJcYe5U8yfWfpDPvYLgePHgSOnQbWO1MSJV4IDC2qfkuecSU6i
 ClrnIWqCB5Yd9DMGk36B2kktJPrDCXH+brMTD93I6IMz/2J87PsQRvQ4qubjvCa84SEGjlPd578
 KvK0wji01jfUpXS0QX8ccaXUELffUfenAKI38ilen48Wvfx28oqWGJoEDbtq/65D5iYOo+9DHMp
 GIgDlOzszni4/tUFObbPb6jT6bBa4E8O9wKm8UjQflIOdHbF8QetJbsVaDkoPOq1qcIO8LKJ003
 nl+kT+DMCM7PUpWagcDVIcAqrL4U/t7j5koXNEGeIa8UEQa2Z8aYquOZuof61j4uCgyGCzy1jZE
 7XDIK/8L+icsgpd8LLw7wUA5Amh0VcC28HvhGDK2yNUqIiMCXJuknR487j5nUawXyETew8AdwWn
 GfykSQUfGIUCawqJiakE4IQbS/kIXDbCQAdcBUxxEG/nv/4Zj2NUTuEk5Ld4CXZ1i2kkBir5Rbn
 EatZvAMk+OKzHVMWpEI4lfthHa377Jq6ytw19hLZoMHp/i2Ja1l19oLBy5I/y9Ko0JM50AxQWaj
 Gkz2Qjxyvb6xu+g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
places such as the `XArray`.

Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
implement `ForeignOwnable`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/owned.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 456e239e906e..5eacdf327d12 100644
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
@@ -108,6 +110,7 @@ pub trait Ownable {
 ///
 /// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
 /// - The `T` value is pinned.
+#[repr(transparent)]
 pub struct Owned<T: Ownable> {
     ptr: NonNull<T>,
 }
@@ -185,3 +188,46 @@ fn drop(&mut self) {
         unsafe { T::release(self.ptr.as_mut()) };
     }
 }
+
+// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
+// pointer satisfy alignment requirements of `T`.
+unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<Owned<T>>();
+
+    type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = Pin<&'a mut T>;
+
+    #[inline]
+    fn into_foreign(self) -> *mut kernel::ffi::c_void {
+        let ptr = self.ptr.as_ptr().cast();
+        core::mem::forget(self);
+        ptr
+    }
+
+    #[inline]
+    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
+        Self {
+            // SAFETY: By function safety contract, `ptr` came from
+            // `into_foreign` and cannot be null.
+            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
+        }
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


