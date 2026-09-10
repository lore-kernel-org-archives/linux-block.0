Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E23DB30F;
	Thu, 10 Sep 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030945; cv=none; b=WEol9VorOXCqGMYqyouXS42VphaCxv6+2xdluAFewIovX+2rlcJFARLQffB8I4LMDRK7KINaf5685B5VhX3YDaomQHiJIe/MQ5eD9aVtVgE5o81i48qy/ZyssE1p7SS4zNjd/uZaRWiOmDSBWjRxvzEDe/2U/NmZR2o0/pH/bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030945; c=relaxed/simple;
	bh=Sp6YRCoJj3CawkjK6Gl7pVgDMf8rxdwoCR/Q4hQH9ds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k5oNNhP7Tkq5U4hVReyZGHdBGldAV5MGaqDJjLuQclKHYRm0C/ESkfKcu+uAhBpMT+VMRnocISFckh6H0xGKS9pDRCxHoOmus0YnoRDFwOzOndHEb90LM8WElPZMNH6CJarqWNArgDgDlw2gYUX4sWE/vR0GkElLg3V66/mbSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNWSOyjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNWSOyjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418FF1F000FF;
	Thu, 10 Sep 2026 09:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030943;
	bh=GYaQ9Qw7yqy+pa99UaWhxp0mlpiBoF24PQM3D3leZU0=;
	h=From:Subject:Date:To:Cc;
	b=oNWSOyjz86/Hxwzvn2CxrT8mfQlE4o6iYiRf6PzgZD9XgpHzTxMjDLCstDnkTwNDb
	 GFBRKUIn3BxU1qI8BWisZ/fGUJIvuoZh8G0XMuH2I0IiGiZON1IcOxayfK8+ZYvavE
	 Z5M1lbHhudEP3bfJz2AWzq8sARR7TGnp8eiNVPf2WcD9bT4uSANOFnwA8qBAgc+mdH
	 oq+C9V9Svv4yNVFd0Sx0L0I6bX0IJSNhAPuP5Y7wEQ7fC/3IyK6Uw1EU3SRlpQX5gc
	 23NCdaBmjY5eBsgwd3aN7p7Qoqk6tq0Lbin++EdhZ/RMvPZsfvpGMR6bEK8peXXixG
	 szY/f915bLmLQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v21 0/9] rust: add `Ownable` trait and `Owned` type
Date: Thu, 10 Sep 2026 11:00:04 +0200
Message-Id: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJRxomoC/2XQy07DMBAF0F+pvMZoPIlfrPgPxCK2x60FSsChE
 ajKvzPppnks51rnju2bGKkWGsXL6SYqTWUsQ88DqqeTiJeuP5MsiQOBgBoa0PLal+8ryUpZos8
 xGauzJy8YfHFYfu9tb+88X8r4M9S/e/mk2iVeegwgtOsePpMglY0BPYUuhvD6QbWnz+ehnsXSN
 Cm90ghbrVk731ByJoCJ8ajNWu92G9YRVZdjUMql5qjtQ5v9zS1rG9rYJPQNBH/UbqVRb7Vj3RK
 YoJ03qbVH7dfabLVnzbmNnXMpp3zQCA/tdu/mT+TdHmyjjUXltrvnef4Hc5kSqRwCAAA=
X-Change-ID: 20250305-unique-ref-29fcd675f9e9
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
 linux-usb@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14336;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=Sp6YRCoJj3CawkjK6Gl7pVgDMf8rxdwoCR/Q4hQH9ds=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGe+dQbbI/rQgWWQoNjTomIq+LnebWzXRSK+
 as0rQy2UeSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxngAKCRD6UCkIqsW9
 0BJAEACax/RfVnt3GLXTrNW86+7gqP7CYAFomJCpfdEfnr6ZWoiM12dA6tiwZCX17WjLAJ1Tf9+
 T5wEFgHHrxK9eTzBdNLKCQB5fiRmeoGe53BS6DZFgB6CYhFRz+dnzH1VosCki21ZcyGNH//COIE
 dRrPCqeH1vbpsJ0jTFE2WZE0QeVjkLY9qphFt9Gx3wv2cXqqR4y/Z4ZJ/RvyYS2l/RNSD44RSQa
 c1juKGGJOlns5/sYw1vSFIv8L0bIinXm1ECDokggI3s2YoNyhKH/SP4WRlL8u5WCD2k7cbnSYTW
 SM2yQD3vFDsvP0WCFTs9We7VHO+9QcAPDDOV/iGhibrE+oekPjn7Z6+JBokXgIc07OukKihjCbR
 gbSxMGi735TdVE+n7UtFilZDSGc+Tv4mHJ+Ys2LEzqjmS+sIez6pGU/Zh7vka+8tETgimTRR9Vw
 6eNXVVI8Keizbd9sPN0yJtscprIGVaWjMBz5oiKOp+ReTE1ZBNGSX14+TNRxpqTcNuB9o8HFXQu
 X1MmM1qhigi6QOh65TFHzjISJh5FMGLnFxvTPVKW/FGmXSU7xmaz1yaHjKLdCwpsdUJp658QWe1
 VLEkil311tVppR0XB+13RjNZhBC6qVOxWC/CiNptkyMSa+5gavLIJBOY4LN9Zgauz6tfeC2K88o
 3nsvuyfEUmbW9Ug==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a new trait `Ownable` and type `Owned` for types that specify their
own way of performing allocation and destruction. This is useful for
types from the C side.

Implement `ForeignOwnable` for `Owned`.

Convert `Page` to `AlwaysRefCounted` and add a `from_raw()` method.
`struct page` is managed by a native reference count, so pages are
modelled as shared, reference counted objects rather than exclusively
owned ones.

Add `ExclusivePage`, an `Ownable` wrapper around `Page` with the added
invariant that the page data is free from data races.

Add the trait `OwnableRefCounted` that allows conversion between
`ARef` and `Owned`. This is analogous to conversion between `Arc` and
`UniqueArc`.

Patches 1-3 implement `Ownable` and can be merged on their own.

Patches 4-5 split the `RefCounted` trait out of `AlwaysRefCounted`
and complete the SAFETY documentation for the `ARef` example.

Patch 6 adds `Ownable` -> `ARef` interop via `OwnableRefCounted` and
can be merged later if consensus on its shape cannot be reached.

Patches 7-9 convert `Page` to `AlwaysRefCounted`, add
`Page::from_raw()`, and add `ExclusivePage` as the first in-tree
`Ownable` user.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v21:
- Require callers of `Owned::from_raw()` to treat the pointee as
  pinned (Sashiko).
- Import `Page` directly in `allocator.rs` instead of using the
  `page::Page` path (Danilo).
- Update DRM GPUVM for the `RefCounted`/`AlwaysRefCounted` split
  (Sashiko).
- Rework the SAFETY comments in the `ARef::into_raw` doctest to
  justify the correct obligations (Sashiko).
- Use `sync::Refcount` in the `OwnableRefCounted` example (Gary,
  Danilo).
- Add a link to the SAFETY TODO tracking issue to the `ARef` example
  patch (Miguel).
- Convert `Page` to `AlwaysRefCounted` backed by `get_page()` and
  `put_page()` instead of `Ownable`, and return `ARef<Page>` from
  `Page::alloc_page()` (Alice).
- Update Rust Binder to store `ARef<Page>` instead of `Owned<Page>`
  (Alice).
- Add `ExclusivePage` as the in-tree `Owned` user, without
  `Deref<Target = Page>` as that would break its aliasing invariant.
  The type was previously posted as `SafePage` and is renamed here
  (Alice).
- Reorder the series to keep the `Page` patches together at the end.
- Link to v20: https://msgid.link/20260824-unique-ref-v20-0-490735672187@kernel.org

Changes in v20:
- Fix a few copy/paste errors in safety comments (Sashiko).
- Use `self.page.get()` rather than `Opaque::cast_into` (Alice).
- Add a space between generics in a comment (Sashiko).
- Change a safety comment to reference Box rather than KBox (Sashiko).
- Link to v19: https://msgid.link/20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org

Changes in v19:
- Update `workqueue.rs` and the `aref` module docs to use `RefCounted` instead of `AlwaysRefCounted` (Sashiko).
- Remove the default `OwnableRefCounted::into_shared` implementation to keep the trait safe (Sashiko).
- Fix the `ARef<Self>` rustdoc link (Sashiko).
- Reuse `Owned::into_raw`/`from_raw` in the `ForeignOwnable` implementation (Gary).
- Link to v18: https://msgid.link/20260625-unique-ref-v18-0-4e06b5896d47@kernel.org

Changes in v18:
- Rebase on `rust-next` (2026-06-24).
- Drop the `'static` bound on `ForeignOwnable for Owned` (Gary).
- Make `Ownable::release` take a raw pointer instead of `&mut self` (Alice, Sashiko).
- Drop `types::ARef` re-export (Alice).
- Drop unneeded `#[repr(transparent)]` on `Owned` (Gary).
- Fix `FOREIGN_ALIGN` for `Owned` to report the pointee alignment (Sashiko).
- Remove `BorrowedPage`; use `&Page` directly (Alice).
- Update Rust Binder for the `Owned<Page>` conversion (Alice).
- Update `pwm.rs` for the `RefCounted`/`AlwaysRefCounted` split (Sashiko).
- Fix documentation nits: missing `// INVARIANT:` comments, stale `Page` docs, and a stray `mut` (Sashiko).
- Expand the `use` statements touched by the rename patch to the multi-line style (Onur).
- Link to v17: https://msgid.link/20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org

Changes in v17:
- Rebase on v7.1-rc2.
- Reorder patches so that `Ownable` can merge without `OwnableRefCounted` (Alice).
- Add `#[inline]` directives to short functions added by the series (Gary).
- Link to v16: https://msgid.link/20260224-unique-ref-v16-0-c21afcb118d3@kernel.org

Changes in v16:
- Simplify pointer to reference cast in `Page::from_raw`.
- Use `NonNull<Page>` rather than `Owned<Page>` for `BorrowedPage` internals.
- Use "convertible to reference" wording when converting pointers to references.
- Fix formatting for `Page::from_raw` docs.
- Leave imports alone when adding safety comment to aref example.
- Use `KBox::into_nonnull` for examples.
- Add patch for `KBox::into_nonnull`.
- Change invariants and safety comments of `Ownable` and make the trait safe.
- Make `Ownable::release` take a mutable reference.
- Fix error handling in example for `Ownable`
- Link to v15: https://msgid.link/20260220-unique-ref-v15-0-893ed86b06cc@kernel.org

Changes in v15:
- Update series with original SoB's.
- Rename `AlwaysRefCounted` in `kernel::usb`.
- Rename `Owned::get_pin_mut` to `Owned::as_pin_mut`.
- Link to v14: https://msgid.link/20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org

Changes in v14:
- Rebase on v6.19-rc7.
- Rewrite cover letter.
- Update documentation and safety comments based on v13 feedback.
- Update commit messages.
- Reorder implementation blocks in owned.rs.
- Update example in owned.rs to use try operator rather than `expect`.
- Reformat use statements.
- Add patch: rust: page: convert to `Ownable`.
- Add patch: rust: implement `ForeignOwnable` for `Owned`.
- Add patch: rust: page: add `from_raw()`.
- Link to v13: https://lore.kernel.org/r/20251117-unique-ref-v13-0-b5b243df1250@pm.me

Changes in v13:
- Rebase onto v6.18-rc1 (Andreas's work).
- Documentation and style fixes contributed by Andreas
- Link to v12: https://lore.kernel.org/r/20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me

Changes in v12:
-
- Rebase onto v6.17-rc1 (Andreas's work).
- moved kernel/types/ownable.rs to kernel/owned.rs
- Drop OwnableMut, make DerefMut depend on Unpin instead. I understood
  ML discussion as that being okay, but probably needs further scrunity.
- Lots of more documentation changes suggested by reviewers.
- Usage example for Ownable/Owned.
- Link to v11: https://lore.kernel.org/r/20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me

Changes in v11:
- Rework of documentation. I tried to honor all requests for changes "in
  spirit" plus some clearifications and corrections of my own.
- Dropping `SimpleOwnedRefCounted` by request from Alice, as it creates a
  potentially problematic blanket implementation (which a derive macro that
  could be created later would not have).
- Dropping Miguel's "kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol"
  patch, as it is not needed anymore after dropping `SimpleOwnedRefCounted`.
  (I can add it again, if it is considered useful anyway).
- Link to v10: https://lore.kernel.org/r/20250502-unique-ref-v10-0-25de64c0307f@pm.me

Changes in v10:
- Moved kernel/ownable.rs to kernel/types/ownable.rs
- Fixes in documentation / comments as suggested by Andreas Hindborg
- Added Reviewed-by comment for Andreas Hindborg
- Fix rustfmt of pid_namespace.rs
- Link to v9: https://lore.kernel.org/r/20250325-unique-ref-v9-0-e91618c1de26@pm.me

Changes in v9:
- Rebase onto v6.14-rc7
- Move Ownable/OwnedRefCounted/Ownable, etc., into separate module
- Documentation fixes to Ownable/OwnableMut/OwnableRefCounted
- Add missing SAFETY documentation to ARef example
- Link to v8: https://lore.kernel.org/r/20250313-unique-ref-v8-0-3082ffc67a31@pm.me

Changes in v8:
- Fix Co-developed-by and Suggested-by tags as suggested by Miguel and Boqun
- Some small documentation fixes in Owned/Ownable patch
- removing redundant trait constraint on DerefMut for Owned as suggested by Boqun Feng
- make SimpleOwnedRefCounted no longer implement RefCounted as suggested by Boqun Feng
- documentation for RefCounted as suggested by Boqun Feng
- Link to v7: https://lore.kernel.org/r/20250310-unique-ref-v7-0-4caddb78aa05@pm.me

Changes in v7:
- Squash patch to make Owned::from_raw/into_raw public into parent
- Added Signed-off-by to other people's commits
- Link to v6: https://lore.kernel.org/r/20250310-unique-ref-v6-0-1ff53558617e@pm.me

Changes in v6:
- Changed comments/formatting as suggested by Miguel Ojeda
- Included and used new config flag RUSTC_HAS_DO_NOT_RECOMMEND,
  thus no changes to types.rs will be needed when the attribute
  becomes available.
- Fixed commit message for Owned patch.
- Link to v5: https://lore.kernel.org/r/20250307-unique-ref-v5-0-bffeb633277e@pm.me

Changes in v5:
- Rebase the whole thing on top of the Ownable/Owned traits by Asahi Lina.
- Rename AlwaysRefCounted to RefCounted and make AlwaysRefCounted a
  marker trait instead to allow to obtain an ARef<T> from an &T,
  which (as Alice pointed out) is unsound when combined with UniqueRef/Owned.
- Change the Trait design and naming to implement this feature,
  UniqueRef/UniqueRefCounted is dropped in favor of Ownable/Owned and
  OwnableRefCounted is used to provide the functions to convert
  between Owned and ARef.
- Link to v4: https://lore.kernel.org/r/20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me

Changes in v4:
- Just a minor change in naming by request from Andreas Hindborg,
  try_shared_to_unique() -> try_from_shared(),
  unique_to_shared() -> into_shared(),
  which is more in line with standard Rust naming conventions.
- Link to v3: https://lore.kernel.org/r/Z8Wuud2UQX6Yukyr@mango

To: Danilo Krummrich <dakr@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Tamir Duberstein <tamird@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
To: Onur Özkan <work@onurozkan.dev>
To: Lyude Paul <lyude@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arve Hjønnevåg <arve@android.com>
To: Todd Kjos <tkjos@android.com>
To: Christian Brauner <brauner@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
To: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
To: Serge Hallyn <sergeh@kernel.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
To: Igor Korotin <igor.korotin@linux.dev>
To: Viresh Kumar <vireshk@kernel.org>
To: Nishanth Menon <nm@ti.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
To: Ira Weiny <iweiny@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
To: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: driver-core@lists.linux.dev
Cc: linux-block@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-usb@vger.kernel.org

---
Andreas Hindborg (5):
      rust: alloc: add `KBox::into_non_null`
      rust: implement `ForeignOwnable` for `Owned`
      rust: page: convert to `AlwaysRefCounted`
      rust: page: add `from_raw()`
      rust: page: add `ExclusivePage` for race-free page access

Asahi Lina (1):
      rust: types: Add Ownable/Owned types

Oliver Mangold (3):
      rust: rename `AlwaysRefCounted` to `RefCounted`.
      rust: Add missing SAFETY documentation for `ARef` example
      rust: Add `OwnableRefCounted`

 drivers/android/binder/page_range.rs |   8 +-
 rust/helpers/page.c                  |  10 +
 rust/kernel/alloc/allocator.rs       |  21 +-
 rust/kernel/alloc/allocator/iter.rs  |   6 +-
 rust/kernel/alloc/kbox.rs            |   9 +
 rust/kernel/auxiliary.rs             |  10 +-
 rust/kernel/block/mq/request.rs      |  19 +-
 rust/kernel/cred.rs                  |  16 +-
 rust/kernel/device.rs                |  12 +-
 rust/kernel/device/property.rs       |  11 +-
 rust/kernel/drm/device.rs            |   9 +-
 rust/kernel/drm/gem/mod.rs           |  16 +-
 rust/kernel/drm/gpuvm/mod.rs         |   9 +-
 rust/kernel/drm/gpuvm/vm_bo.rs       |   6 +-
 rust/kernel/fs/file.rs               |  23 ++-
 rust/kernel/i2c.rs                   |  13 +-
 rust/kernel/lib.rs                   |   1 +
 rust/kernel/mm.rs                    |  22 +-
 rust/kernel/mm/mmput_async.rs        |  12 +-
 rust/kernel/opp.rs                   |  16 +-
 rust/kernel/owned.rs                 | 378 +++++++++++++++++++++++++++++++++++
 rust/kernel/page.rs                  | 206 ++++++++++---------
 rust/kernel/pci.rs                   |  10 +-
 rust/kernel/pid_namespace.rs         |  15 +-
 rust/kernel/platform.rs              |  10 +-
 rust/kernel/pwm.rs                   |  12 +-
 rust/kernel/sync/aref.rs             |  87 +++++---
 rust/kernel/task.rs                  |  13 +-
 rust/kernel/types.rs                 |  12 ++
 rust/kernel/usb.rs                   |  17 +-
 rust/kernel/workqueue.rs             |   8 +-
 31 files changed, 828 insertions(+), 189 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


