Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78638E5FC;
	Wed,  4 Feb 2026 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206240; cv=none; b=N0c9spC4elXDVwW4HTisesX3sCAI91BoGd1a350+qwxePMnAZt8yN73vTtAWngwyk6b4lDA+iX+duKBje8TP3efneQVt87y6eStYsue5cjCMP9uw9dTJMtF5S1+qb/oF3KmvKXBdrQH/iP7QfFB6pWqme1dZgl+oT34H6vgJ18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206240; c=relaxed/simple;
	bh=3669cUuITKf9u7tNBrqzpeq3tWTkH+jHDiuw+zCYrkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayeJLiolpDt/89BxtmuMJWePbM+I4hAZ289d9jguthndI6NzPor75mCkn7XPrEs6CiW66tx/i3ZMao3v45gjbpHyvoj0ptKx9ifOpDpPA0BV5TTa3vFKEh7ubwQJCLnbvP9NfwucWmohkajJ0szcU66tkaOfbuuVfgl2/UhQhnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pac4HwXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pac4HwXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92374C4CEF7;
	Wed,  4 Feb 2026 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206239;
	bh=3669cUuITKf9u7tNBrqzpeq3tWTkH+jHDiuw+zCYrkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pac4HwXDEvkjtpqH3duQWkwwKzmPV6AGkrzzuHZe0O5AELAb9TK6GCTXHIbhsOZ8Z
	 q8tneEGcvwedeY277RW6MH/iRB75j9wIsomGma3B/1dNp6pdbowEdwUf/XLaePwge6
	 1a/kNPutWgagecr03ZdMjHBr1mwWyGLAS1dP+0OrrtdDLzMoBbYiy5JJrFfLi5bYkY
	 Qk/78O6ReZYYANDU2/O7DOup7Nd6dBU8JzT2UF/PL7x2m/RL8kHvJGJ/aHtW9IO8i6
	 C6boOy8YxHr7RQvGBbsTVJrgM1MK3OP3WbAQRBzeYhbp6fSkazlcrPQSn6jn4fG2XM
	 taOND3Q8Nn4yA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 04 Feb 2026 12:56:47 +0100
Subject: [PATCH v14 3/9] rust: Add missing SAFETY documentation for `ARef`
 example
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-unique-ref-v14-3-17cb29ebacbb@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 Igor Korotin <igor.korotin.linux@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OkPeSjQsIxKohCmbfrAmRiZJb8MRdSOGkBDNdfIpHoA=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzQBBW2YqZGe4r2rWgHunfjy7egLqvEkgf7uz
 37O8ZRA0baJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYM0AQAKCRDhuBo+eShj
 d8ySD/4oYFBz5VsAwkAc/58oE1gXZfwyx+fXfX6bgRFe4iQKQGVEtyYJSzETywutuMaGAmARdAi
 4UDKl4ygsICYVqLTt539ppsrWo2lF/YHT01wrCKlG2Dj7yIB/TagCsgMMn8n65juI9wGfW1dGrV
 1ClAkZ2fSD3EuBAP/SB9koV3O3TQB50NTF3q1rm0twBv/iWQuKmpJgdVzfIMGu99ZiHTN0EHd+I
 aTSOdg0c2U6QRfvXa4qxLoF2nSseFVbXsFRlFt/hma2dzLbj4+uZSVeyh64pc/1DMu4FjigBTeZ
 TYpF39r5j72xpLegzF1hOSbCSFWb93osfqan6YO38C++oWm81Jne2RQO8vlCSDipEYwwLKn+/RI
 WqFAwZDSecHK2y6sTxytNBFK2HKp36t2br3edIiMZ93JtPAOeeYJxw+EvmlbeVYSMYmSI0MBAiy
 aCF9eSlo4E/n6UGTZ7BX/R5+Gz0nhkjUnTv0/WM78JvEdHFXzg8eJEPmbl20x74aGx4AsZteFq2
 FIIDipB4dmtWFMEVPHavrNIAzTGz0e846BMYnBe70K35ixMEigNxsF3QYjrLcXtSXQXoXeQKsM3
 hlOlLb+hoGE5ZACH8lEcrepeFUuRy4HGujzE4WIH+nr1EMmTQtYMc63npItj/L5iX55R1rv1Tq6
 FXC4PDR6u4FX/Mw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Oliver Mangold <oliver.mangold@pm.me>

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Original patch by Oliver Mangold <oliver.mangold@pm.me> [1].

Link: https://lore.kernel.org/r/20251117-unique-ref-v13-3-b5b243df1250@pm.me [1]
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 61caddfd89619..efe16a7fdfa5d 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     /// # Examples
     ///
     /// ```
-    /// use core::ptr::NonNull;
-    /// use kernel::sync::aref::{ARef, RefCounted};
+    /// # use core::ptr::NonNull;
+    /// # use kernel::sync::aref::{ARef, RefCounted};
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: The `RefCounted` implementation for `Empty` does not count references and never
+    /// // frees the underlying object. Thus we can act as owning an increment on the refcount for
+    /// // the object that we pass to the newly created `ARef`.
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: We keep `data` around longer than the `ARef`.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///

-- 
2.51.2


