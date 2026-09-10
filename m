Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446863DCD83;
	Thu, 10 Sep 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030876; cv=none; b=Ta26opAnPqwjjG4TRDrP7zY1Jx362nFIglhTL3QDR6N74DE1OfzWD3ACJDbNUBpfgt3qNjq+G9GihnMbwcbEzDG0FMQb/ueXgAKEwjFF7GnN0PjLQhfF3giV2tvJ36yRGpXNgKWvyo1FWDuYFRI7QAfAnuUrv2CYO6lkN3X4KiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030876; c=relaxed/simple;
	bh=mGjHroTCuk5mK+JJ+qPXVN3JjYkyaG93c58j6hdhhAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lq0XcNe1CI/PDtNOsZWchhof12IFZVeExGp/sSZGmrFl8kpWMz4MM45KKQ8ZztXY+2j1Hm+YtCNMv33n22/02LhNXKoTMvFCgpAtvFBfRyIAZkMRHwKFccm0B77htenn68u2gSHciCXfHiNVfadYkM/YOJYLqkHSRzZKoEq6eKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3BerBbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3BerBbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B481F00893;
	Thu, 10 Sep 2026 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030860;
	bh=Wg/k9xgyZfA9ou1Djuuw6WTAhRSTMUQxS2X1MvSzmrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M3BerBbvMzXCbqj1EM09oZC1x/XqtdFtYXby2y7p5INcP1rT/onE38lD3s9fbAPt1
	 dTM3owMdOb51VKsqIS7ZY4Jwd+kmExADj4SdFBpqtRitNVsuPob0zCPz/YCbvq/NWg
	 bKEUVq61CO36E7mG2RaRdMSHyjZ7cCks9P0bE1iIUh50r0w6bwX3IzKb2uL/bCD0J0
	 XCJ+26ItEf7z37CManyUaT30zxZl0HKA6kD+wNWZ99EgI8FR8q7xtGE26//BdQyFY5
	 r/Vf5yfq3gWNKI5fBzX4eKcDmkrgIXN0SXzDQwGZVe6/iwbjS5wVgAkLQVgjI7Wj+N
	 34OcU8MdNduOw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:13 +0200
Subject: [PATCH v21 9/9] rust: page: add `ExclusivePage` for race-free page
 access
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-9-e83257373062@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=mGjHroTCuk5mK+JJ+qPXVN3JjYkyaG93c58j6hdhhAw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGpjFpIGLMETXkqUNOBWFFizecM/26XuOncT
 XS44dh5H5CJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxqQAKCRD6UCkIqsW9
 0LrMEACOm8qftJlk0GIO4ABiC6zoPZAx2wOPesrHLpI3yWQgcGB9ibsYkXK02yOfxuQMd5U1XEy
 kbzCsSAVhUUTuRLhFIUTEOpjgX/MXvSnmXJxnZogRyVBym3A6Je6rXWsgU4Je3qDsRWaz7kFXUk
 R1drGj+gxmakDZaVaxEoWBkzuRr7ZvwKHWUIJxhzkDb5psCDVvZOY6A1xcTwC5rate+r3NPo516
 +iVFq6MqVlAcHnwGGMGsCkBBUt9aWLt/Hiunh84LwSYOTzrIDtFEQoSr450gCDwK9FTjmcpoHXj
 94+1SOEu5P9+U2V3aRAQYVVOJAL5tAaLDeLcLNvP9OY9Z9iZmx9BOHShqepoaOf/E+sG3s5hDgB
 dwqZVd5fHyf0EuSdKGM/fNhQiRwPJ4aAL7pONHTSNWJTYRIT4dmS5Zspd9WlBHs0KP64c5Jbee5
 wmnyR4QPIDeyzzTkw9d7GDN+Dg4409ufq3emr5PX6XMRdxHiScv1MJ5x6fLF62b+xZZtP04ahI/
 UJPJHdQKHsuZoK1JYSiGqLBv01CXdiSuV3oDAlLBqcSBCdj3jmNlD3RyWwimRU3WsP3JyBSMSla
 2VTyzkCqWTXDpUa5HncvNKHmXLW4Hb/YlycVtlU1KkGP0vZIYslkDWvSezPQAc2SODRqlPkf8uz
 cvfoyXcSbtziopA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`ExclusivePage` wraps a regular page but adds an invariant that the
page data area does not incur data races. This means `ExclusivePage`
cannot be mapped to user space or shared with devices, and it
becomes simpler to directly reference the contents of the page.

Since `Page` implements `AlwaysRefCounted`, handing out a `&Page`
from an `ExclusivePage` would allow safe code to obtain an
`ARef<Page>` to the page and break the aliasing invariant of
`ExclusivePage`. Thus, do not implement `Deref<Target = Page>` for
`ExclusivePage`.

Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

---

This patch was previously submitted as part of a different series, see link
below. It is included in this series to provide an example user of `Owned`.

Link: https://lore.kernel.org/r/20260605-page-additions-v2-1-03f04c8fdbbf@kernel.org
---
 rust/kernel/page.rs | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index cd394b0656c0..4e5b1c2f4346 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -17,7 +17,11 @@
         AlwaysRefCounted,
         RefCounted, //
     },
-    types::Opaque,
+    types::{
+        Opaque,
+        Ownable,
+        Owned, //
+    },
     uaccess::UserSliceReader, //
 };
 use core::ptr::{
@@ -349,3 +353,52 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
 // SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Page>` from a
 // `&Page`.
 unsafe impl AlwaysRefCounted for Page {}
+
+/// A page whose data area follows standard Rust aliasing rules.
+///
+/// [`ExclusivePage`] has the same usage constraints as other Rust types. Thus, it cannot be mapped
+/// to user space or shared with devices. This makes it safe to reference the contents of the page
+/// while the page is mapped in kernel space.
+///
+/// Note: [`ExclusivePage`] does not provide access to the underlying [`Page`]. Handing out a
+/// `&Page` would allow safe code to obtain an [`ARef<Page>`] to the page, which would violate the
+/// invariants of `ExclusivePage`.
+///
+/// # Invariants
+///
+/// The data of this page is accessed only through references to [`ExclusivePage`]. While a shared
+/// reference to a [`ExclusivePage`] exists, there are no writes to its data. While an exclusive
+/// reference exists, there are no other reads or writes of its data.
+#[repr(transparent)]
+pub struct ExclusivePage(Page);
+
+impl ExclusivePage {
+    /// Allocates a new `ExclusivePage`.
+    pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
+        let page = NonNull::new(page).ok_or(AllocError)?;
+
+        // INVARIANT: The page was just allocated, so its data is only accessible through the
+        // returned `Owned<ExclusivePage>`.
+        // SAFETY:
+        //  - We just successfully allocated a page, so we hold the only reference to it, and we can
+        //    transfer that exclusive ownership to the new `Owned<ExclusivePage>`. Since
+        //    `ExclusivePage`
+        //    is transparent over `Page`, we can cast the pointer directly.
+        //  - The page is never moved out of its allocation, so we can treat it as pinned.
+        Ok(unsafe { Owned::from_raw(page.cast()) })
+    }
+}
+
+impl Ownable for ExclusivePage {
+    #[inline]
+    unsafe fn release(this: NonNull<Self>) {
+        // SAFETY: By the function safety requirements, we have exclusive ownership of the page, and
+        // by the type invariant no other references to it exist, so we relinquish the last
+        // reference count and the page is freed. Since `ExclusivePage` is transparent over `Page`,
+        // we can cast the pointer directly.
+        unsafe { bindings::put_page(this.cast().as_ptr()) };
+    }
+}

-- 
2.51.2


