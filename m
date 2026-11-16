Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838896;
	b=1T1JqLXIiaTlgMoAolrGF6kQy1JF0qMbo0wXihpDwNhDJMFzETfPE6cSqI18RDh/yQSn
	 7loKAqr8llufmAxIPZl09xhqAJcSo7hN+a0zIEOFW+f6RB4Lsnj+W338U2R8n0xTgqYXm
	 DYD/bCZmBGKTbJ6+KEudQNddJjM1wJKASzsiuEVm+ITiWDXPeqQEDFTWiW/Mgoudie0/O
	 6jZC9ccopP1tfzwhiQmg537VO0/3sYZRpgAcb50nbzkTEwrHYeoVqSb3ouIYg0z/WD4OM
	 u/A8q27nXVIozRu2+uYndY1JdJZ8EuFaQFYUe51nxkVfq25YT1u3R+SuPI7sfRC4oIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838896;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=avroJVXI7FYPP9BX1mpXsZCBZ9F8Uq429Emp0GZBvxk=;
	b=ameqZ8NH880NrTIpqBG5WzWhx7kfBLWv5F16oK+qprArPu4bw9ctv7l4O+UUg2u/GJei
	 NmxsVaWOXVSW0JApTYlAqHk9ZftjbB52x3HQ1lCiwbwn7uLEwJA+dEfBqwkR67EBxbr4S
	 n4b6Pnm4fsq7QCc33+KCiwGkrT9sabfoHV+24kyW1hccUE/1QRds9vxnooCkIz7XxAonN
	 dhW5C3xxRJoh/vFMZ34W00O7a5tBTR2EYEwhaC06Za7Clf9dQdhUGdKhUEk+E/ObuBiTU
	 Cuisrwmmq5/KMyyAFVPHxm+eJUhJGWg82ZgiSoKvg3b3iSdpq3+YzeEUMe+OslivN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YU0t6OjF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C950606A31C;
	Mon, 16 Nov 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YU0t6OjF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7252A1F000C4;
	Mon, 16 Nov 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838895;
	bh=avroJVXI7FYPP9BX1mpXsZCBZ9F8Uq429Emp0GZBvxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YU0t6OjFrvjgkDDvOuuKnQWnjekr+xxSg16q9vPrkImGDCbn83dqyPNqFv3qxxNR5
	 PqGdB4hyPeN8vKZM9TMClVa9zrVFeVMdStgn/w6FsWiFsYEtwvas/FpLblwu6NjmJV
	 deO7Kzzs4mspJZo+TFxUHMy9EmBcQYPpTBv3ixAq15LH2YKdp3KlQMOSf9t7QofZtK
	 a8c1VfGYV5BYm03eznfItWSdAbeampwj6gSVV6gDC9C4eQ+Z2je8dhxtp/q9VE9F9a
	 UNxy4wOW4nK4zjryOzmqYBDmc99ysNZI4gRC90BtHx9DP8Fo/Fblf4P7wX3xv3c1PA
	 05TY6YhW2AAUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Nov 2026 15:21:00 +0100
Subject: [PATCH v22 3/5] rust: implement `ForeignOwnable` for `Owned`
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-unique-ref-v22-3-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
In-Reply-To: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
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
 Christian Brauner <brauner@kernel.org>, 
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
 Johan Hovold <johan@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Markus Probst <markus.probst@posteo.de>, Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=yxSwAMf1WCPKfeJBxmCTAk/DQrKQubqT1B9hug50/gI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq+xFS+9cTttA9+oADXGC7GEWmmDosjg6s4Ao7a
 qKVHkrzi2yJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavsRUgAKCRD6UCkIqsW9
 0O3jD/49Splh6UzX1b0EokN7/Bp9lpjcX/DWmN5abF8blBytH3yV6+s4lAYrTuN4IbwrH6lGWP+
 G0TE5WjwSJMFPIGikWQ+VuqTHmrYBgy34ckfY3sgSCgpLZe1Ulq4aeRUqc6LPTBcW/PcxZzctJc
 SMWpuB9vMTCEX7wCDBCFIGA0I7XZKRZ+sT2eSleHRevwnmQ5qG/k7uG6qot2gWi5xWFi67AH29M
 39V8/VIFeNaKaGWj5FcEUAYL0i/c3GHNiDONnKhPkzRsBspNENw1A1ljRP1a/aP6vCE1yaIOxWF
 u/eWmPlBAvD1DN3JxG2QHn89Lb3tvpETyGuXRfp/vExtaQhPcK6hhjI8glNSy+taBQUhUciaZ7o
 HbMhLvYLOZ+DI187LcoitByoRm7L5ZpQZxwB6mmIvcrL2kBLNVD3WueR9xrMAGTmBItRXInawml
 lVoE/5RXApo+8R3y903FvVcx1P79l9P/KRf+DEmo/S1yyd84RPEvWjD6rBnZDZ2atX8zB/AhAw4
 Lv4hSHlmrR//tO9SiqOnLgWhiw0S8YrY502KaW0j7zpyoGvQzn6cJq1dsO7xsw1KockvDh597lr
 xBMInACeni6dtSLhueSr4IqgRIC9vD9lUhfcvQNA0/JX3iA2+U0UpmEc3526Y2BUhOsLgth0g+Y
 FZT/S29GIWWp2GQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
places such as the `XArray`.

Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
implement `ForeignOwnable`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/owned.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 51da9bc7e1f4..c255420f8383 100644
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
@@ -272,3 +274,58 @@ fn drop(&mut self) {
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
+        // SAFETY: By the function safety contract, `ptr` was returned by `into_foreign`, which
+        // consumed an `Owned<T>` without calling `T::release`. The requirements that were upheld
+        // for that `Owned<T>` are still upheld, as the ownership it represented was only held by
+        // the foreign pointer in the meantime. We retake that ownership here.
+        unsafe { Owned::from_raw(ptr) }
+    }
+
+    #[inline]
+    unsafe fn borrow<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Borrowed<'a> {
+        // SAFETY: By function safety requirements, `ptr` came from `into_foreign` and the
+        // `Owned<T>` it was created from is not reconstructed or mutably borrowed during `'a`. By
+        // the type invariants of that `Owned<T>`, `ptr` points to a valid `T` and it is sound to
+        // create a shared reference to the `T` for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    #[inline]
+    unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::BorrowedMut<'a> {
+        // SAFETY: By function safety requirements, `ptr` came from `into_foreign` and the
+        // `Owned<T>` it was created from is not reconstructed or otherwise borrowed during `'a`. By
+        // the type invariants of that `Owned<T>`, `ptr` points to a valid `T` and it is sound to
+        // create a mutable reference to the `T` for `'a`, given that we only hand it out as a
+        // `Pin<&mut T>` below.
+        let inner = unsafe { &mut *ptr.cast() };
+
+        // SAFETY: We never move out of inner, and we do not hand out mutable
+        // references when `T: !Unpin`.
+        unsafe { Pin::new_unchecked(inner) }
+    }
+}

-- 
2.54.0


