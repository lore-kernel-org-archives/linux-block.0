Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838955;
	b=sQkFeWLRGCzTbhwe5uKIyNvtmQIukEoeXYX39D0qMsv5XNoHWmOBL2Z7fvo7dG2+7Nuz
	 2mZ/d4jxSUOSzIolw9CWQfMcvHRwbzzcMzDLJSw7/sObGCOxNFtCW4E/sl+scrREX0x9I
	 wCfiCVCjv0HuSAnXIt3qH2+IGS4+xVNHnN8jowebOi5U1yP9TeMSH7xTTZxuUvFKez0+y
	 54QcTk+IbmRGnf+6AUzYUR0IFdFg28TJVtUPwBiFwim8yQJQXrOuJkhBTPrqWgs8BacUw
	 hOwsug8aKhxaDDvYLYV05z0MsETEDCHGpkIZ9QsGHs44XK9jiUMd9yyStbjj+JSbLAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838955;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DD0O4UHQjOwX2z912jOf6aGqZALPy7YFtPLBcCMM8hM=;
	b=IQW8kWmwBngDhFa19pIOY1nDP1Vc8G4j6tkoq97g2jlArBT4afTpIISxafE9+i+l5TtA
	 TGbUnjaixWo26OQfjrSOKA+TN/5tXRW7+e15nDgRCgg0GVsoZMD3n5OEScO1vagUptuf8
	 lwEHYXgJznHha7ubrMzwBDOoh6Ngp7M6Aup82+wqTkVa/PE6PUiD/cT+OpDCf/BPHFG9M
	 splxbtfU1bW55NCI3NOuhvfwAaovwjZdKq6nYVIrldXBdRauyhJuUjdoz3Q79AysQyI9C
	 yLKYnMu9unmdQJblwLM12sl9G65omzQBo0e4dHzAj3Jz4o6xLqRm4mi1axkRpOCCBow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE3vt9xN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BF606A31C;
	Mon, 16 Nov 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE3vt9xN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC721F000C5;
	Mon, 16 Nov 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838954;
	bh=DD0O4UHQjOwX2z912jOf6aGqZALPy7YFtPLBcCMM8hM=;
	h=From:Subject:Date:To:Cc;
	b=cE3vt9xNqZP62Iuvpf+v4+ejdVWttN8ugRuIAEwId1qfYhXfbsIHn2wyF0FEmooz1
	 LihoWYw7Gq2P2zltzVexnxGGsmiNjqE+k4vMy6yCmYHlwecnwGUz+kepFIokUf+FfQ
	 wOFZNnSGwYjoLJPZObZ4NhMQKMTTYCJriuQKlRGaEa1vxghy3V0pIY2xZOFbnQw9WT
	 m5TG6+okP4ItZ7xw98XGO0go1P2dcbJkgoGBgACeNMyUsP0i2zRoSWo2svjlMQC3b+
	 /SQk3gEaMuHlEgv/jikawe5QQB34MulF8KQpCv7PtNAZp80qZ9t0zKUgjj8RrMVZiT
	 9suuukL520XlQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v22 0/5] rust: add `Ownable` trait and `Owned` type
Date: Mon, 16 Nov 2026 15:20:57 +0100
Message-Id: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEkR+2oC/2XQzW7DIAwH8FepOI8JTPjaae8x7RDAtGhTspE12
 lTl3ef0kqQcbfT72/jGJqwFJ/ZyurGKc5nKOFAB8HRi8dIPZ+QlUYOBAC2U0Pw6lO8r8oqZg88
 xGauzR88IfFGz/N7T3t6pvpTpZ6x/9/BZdmt7zTECRLfPoTcuuLQxgMfQxxBeP7AO+Pk81jNbk
 2apdxrEUWvSzitMzgRhYmy12euH2YZ0BNnnGKR0SbXabto8bm5J29BFlcArEXyr3U6DPmpHukN
 hgnbepM622u+1OWpPmvo29s6lnHKjQWzaPfybjkizvbBKGwvStbNBbtrL481BkkanQFtlFa120
 Muy/AP6nvxjWgIAAA==
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
 linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16151;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=PG5AlT95jWkG8BTEWfIkOjr5R7v+ukCPa/BO2Em/bPQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq+xFNGXJkaj9Ibo2DJoXtN+3zcvAK0uoIxM1+Q
 Tw7SHpk5lyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavsRTQAKCRD6UCkIqsW9
 0Ci8D/4+XLcgVkFKOjr1uQw+yD1c62vVzscWCdNLubUA3sjPglwhPXMXKr8bqHGrkMMLeUC6WXm
 ivNLdU9vaCgD42tt4Ea9kR/DoLf/aV5CyVRZjNwa8Aqopyodj2Pt2Rh9nahmfYVKGo55zjls3GT
 gLwqtuYz9chrrW7ftZsYiCtM+h7mGUiS8VLu75v/B2hjTqdn1WXMUpLqWDB+cDCDQ/oM7AtmGeD
 rH7+gaXdiLNNZ5Px4WOTRcLL6wRN3U+JWhiQ+vgJHZ4KBuICTfflSAZGCREMSmqpQ/WW+m0boZQ
 k4buOC+LltkpRmn+ykcEFflBQ9boXfxipEvfNxeuizeMQVZfGP+p3NckK15zFCB626hgRbqFfE1
 88XcnyEHX+21GMckElTBpTDzhMAPo2/MgOGdubgPoHYWp+yoq0HbkVzVFkhcAvzF5xf8PQWUibe
 3sy75yFlLFf0+x8tY5rUsMZH1oEjGCzdbnjhU8ATMQ7gZo0QkJo+9Re+Ipl8F9OsKLeCs7iN6+6
 tewFQE7ixrbOS8xP81nnUHynJpiAu4mg3A6LdZ+1dmTDjqX4EudLxSYtBLzvBUnLRhxgfmBYwTT
 8d8vFQmQ03pP8AZ3HXv9sOONMfIDhFlaT+5i9LsTQR1j21L0lHMCpcw0RH00uRsfOMmckSTlyp1
 aWuNxuxpms79rUQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a new trait `Ownable` and type `Owned` for types that specify their
own way of performing allocation and destruction. This is useful for
types from the C side.

At most one `Owned<T>` exists for an object at any time. The type `T`
decides whether other references to the object, such as an `ARef<T>`,
may exist together with the `Owned<T>`.

Implement `ForeignOwnable` for `Owned`.

Split the `RefCounted` trait out of `AlwaysRefCounted`, so that a type
can be used with `ARef` without allowing the `&T` -> `ARef<T>`
conversion.

Add the traits `OwnableIntoShared` and `OwnableTryFromShared` that allow
conversion between `Owned` and `ARef`. This is analogous to conversion
between `UniqueArc` and `Arc`. The two conversions are provided by
separate traits, as some types cannot become unique again after having
been shared.

Patches 1-3 implement `Ownable` and can be merged on their own.

Patch 4 splits the `RefCounted` trait out of `AlwaysRefCounted`.

Patch 5 adds `Owned` <-> `ARef` interop via `OwnableIntoShared` and
`OwnableTryFromShared`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v22:
- Rebase on v7.4-rc2.
- Split `OwnableRefCounted` into `OwnableIntoShared` and
  `OwnableTryFromShared`, so that a type can provide one conversion
  without the other (Alice).
- Rework the safety requirements of `Ownable` and `Owned`. An `Owned<T>`
  is now unique among `Owned<T>` handles, and `T` decides whether other
  references may exist together with it. Document this in a new "Access
  model" section on `Ownable` (Alice).
- Allow `AlwaysRefCounted` to be implemented together with `Ownable` for
  types that allow an `ARef<T>` to exist together with an `Owned<T>`
  (Alice).
- Justify `AlwaysRefCounted` implementations by all instances of the type
  being reference counted, rather than by the type not implementing
  `Ownable` (Alice, Gary).
- Update the safety comments of the `ForeignOwnable` implementation for
  `Owned` and the conversion trait documentation for the reworked
  invariants.
- Split `RefCounted` out of `AlwaysRefCounted` for the fwctl and serdev
  `Device` types (Sashiko).
- Split `RefCounted` out of `AlwaysRefCounted` for `Fence`, which is new
  in v7.4-rc1.
- Relax the `ForeignOwnable` implementation for `ARef<T>` to require
  `T: RefCounted` rather than `T: AlwaysRefCounted` (Sashiko).
- Move the documentation updates for `Ownable` and `Owned` from the
  `OwnableRefCounted` patch to the patch that adds the types (Alice).
- Remove the empty line after the hidden imports in the examples (Alice).
- Document the type invariant of `Foo` in the `Ownable` example.
- Drop Reviewed-by tags from the patches adding `Ownable`/`Owned` and
  `ForeignOwnable` for `Owned`, and from the `RefCounted` rename patch,
  as their safety requirements changed.
- Move `Page` changes to their own series to be submitted separately.
- Drop the patch adding SAFETY documentation for the `ARef` example, it
  will be submitted separately.
- Link to v21: https://msgid.link/20260910-unique-ref-v21-0-e83257373062@kernel.org

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
To: Christian Brauner <brauner@kernel.org>
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
To: Johan Hovold <johan@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Christian König <christian.koenig@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Saeed Mahameed <saeedm@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
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
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-serial@vger.kernel.org

---
Andreas Hindborg (2):
      rust: alloc: add `KBox::into_non_null`
      rust: implement `ForeignOwnable` for `Owned`

Asahi Lina (1):
      rust: types: Add Ownable/Owned types

Oliver Mangold (2):
      rust: rename `AlwaysRefCounted` to `RefCounted`
      rust: Add `OwnableIntoShared` and `OwnableTryFromShared`

 rust/kernel/alloc/kbox.rs        |   9 +
 rust/kernel/auxiliary.rs         |  10 +-
 rust/kernel/block/mq/request.rs  |  17 +-
 rust/kernel/cred.rs              |  16 +-
 rust/kernel/device.rs            |  12 +-
 rust/kernel/device/property.rs   |  11 +-
 rust/kernel/dma_buf/dma_fence.rs |   9 +-
 rust/kernel/drm/device.rs        |   9 +-
 rust/kernel/drm/gem/mod.rs       |  16 +-
 rust/kernel/drm/gpuvm/mod.rs     |   9 +-
 rust/kernel/drm/gpuvm/vm_bo.rs   |   6 +-
 rust/kernel/fs/file.rs           |  23 +-
 rust/kernel/fwctl.rs             |   9 +-
 rust/kernel/i2c.rs               |  13 +-
 rust/kernel/lib.rs               |   1 +
 rust/kernel/mm.rs                |  23 +-
 rust/kernel/mm/mmput_async.rs    |  12 +-
 rust/kernel/opp.rs               |  16 +-
 rust/kernel/owned.rs             | 494 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci.rs               |  10 +-
 rust/kernel/pid_namespace.rs     |  15 +-
 rust/kernel/platform.rs          |  10 +-
 rust/kernel/pwm.rs               |  12 +-
 rust/kernel/serdev.rs            |  11 +-
 rust/kernel/sync/aref.rs         |  82 +++++--
 rust/kernel/task.rs              |  13 +-
 rust/kernel/types.rs             |  13 ++
 rust/kernel/usb.rs               |  17 +-
 rust/kernel/workqueue.rs         |   8 +-
 29 files changed, 823 insertions(+), 83 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


