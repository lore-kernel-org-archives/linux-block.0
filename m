Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E6400DF9;
	Thu, 10 Sep 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030922; cv=none; b=td8nxKd/iLwTvsxdhvURWYpq9TCP6yoiZ8wF3pWgxt82Hww0Tjzft9BAq4cnBINfV2YSV+/bnFuKGvuaybuQskJRM/odeORKbVRU7D4hgy6AvvvgjQ9Is46JP1oCJ5GhoWVeYHjZRpiAui1aCJwAKe3DSPJeMsgkz4G+brqr5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030922; c=relaxed/simple;
	bh=/zjO9zdfV440sS+2/8AsObuBj/yeJcE7efHr9UaL+8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5oZKMzOCFGAzLjG3Z0tZ8DXc2dqn8t1qGfzUT/w0KUg5TVB4uZjHbaCeVLyXUkEJznD6qzYy53MkyxHlTOhn/kAD2y6+ZfkLahzfA6GfNq6LinAX+xfn0i4adM6GShZjiAn8IyEsbuDNr9moQfVH/rtBdCSr7cnTOZHBylLQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLZ5B3fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLZ5B3fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B21F000FF;
	Thu, 10 Sep 2026 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030919;
	bh=yt5UAGueNm32iTeFR6jcKBb+FhJxYmboaOihvjd/LlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OLZ5B3fuSqJeJziVml2J7+SuEmvWItkOgOQyjncwSG2DimnGwv4KyDQJlXLXW5sxM
	 nvCLV+4THEj2dC4voriGeaOEl5QiGheN3Z2q+ABMVBOmnvBJ8FuiomSDYgcAkjYXpC
	 WmtKW9WFO9JI1P3g0nUTzXvMxX7Fg2E2spCP2GDThib+uN4W2ZmGUi3s7tMBahhhib
	 nssJ+bxC5fSWQ5nIEawiqdv8AluaXKDpA29tlDrzi1jNgnhNaksN5SQ2CgBz20IqKC
	 z8oV75B01Z2KKl9IwRK3SOYnF1oqFwMJIWTDbyu/FS6hpLcCRVklw5rhUr6Y6iWJ7g
	 7BtR/7T+ldmkw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:09 +0200
Subject: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef`
 example
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
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
 linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=BNWtmHgpjNUhrCkbsOHEBA7MTI0LVX3SSpIhyT98+Ow=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGlMsJOOFdosQ0jUhYoghNsqo0y4sSrnWOtC
 1TQjvbumFuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxpQAKCRD6UCkIqsW9
 0Cd+D/9nAUfqKWaGoqKv7nfm0hhF9sliL+paN7BmyiCqXpgYuTMfax03XP7wuBLX+p1hrdviAhE
 H1PrBfVWfd3V3zHdCH/GokxiWtF4Uwki/PnMnl8bXFvJby5yN9P2wz1Bzr+ZoeZXdPlcAVwaUYf
 lAZgSE0szcxSq5yZYh5NZ5e1derfpNSOMIS6F/k3KTRFoPA6OpW6thdkVIXZOTacMnm6Gc0ZZW3
 cEKyHvTgntPVD4mYH2VewLR6LRt/3un9vJT2T5oj7/dHNQAaLmguQFggWup1xYA6a65I2dHc7Ol
 9mPIKE0Rc+s8IJMPX7bLzDvoNu/uBR4+qJTEQbtS5fzpYL/VubrnZpOqDkG+WdgWDbHYS29hpv1
 hOaNVXWUzxLlqPWyXJb0Kxq7nMnROnusibYCYRrnu6y588044SLI8D4h+WprDXV5ikecb+C3oVT
 uZbiWr2DcD406Wq9a1ctobdItGN7JO8tuPmepticFVhV3cd9xwr10q29wJ3DNgWY7Z00GxtadFk
 CxEV8zx8CkgTamGEaSpsZns8tdzXSdPz3lC5bnjzKC33CPk8iUrRGERISKT/xET9BJxqZjEAuHU
 tjAeZT75VZmxlGKiT22VwccqR12Y9eQ580MdcvGQVWbtb5BDrxCo6ka0p9YA+acEkL89XEl3Ljw
 4AK7zgNZG4eUFqg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Oliver Mangold <oliver.mangold@pm.me>

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Link: https://github.com/Rust-for-Linux/linux/issues/351
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Assisted-by: LLM
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 215e7eb139fa..ae76bd9b6c1c 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -147,7 +147,10 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: The `RefCounted` implementation for `Empty` does not count references, and
+    /// // `dec_ref` never frees the underlying object, so a decrement cannot invalidate it. The
+    /// // object instead lives as long as the `Empty` value itself, so creators of `ARef<Empty>`
+    /// // must guarantee that the value outlives every `ARef` derived from it (as done below).
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -155,7 +158,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: As the refcount operations of `Empty` are no-ops, we can treat `ptr` as owning
+    /// // an increment on the refcount. `data` outlives the created `ARef`, upholding the
+    /// // liveness guarantee required by the `RefCounted` implementation above.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///

-- 
2.51.2


