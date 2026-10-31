Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793460530;
	b=CdnxIJbSKLzLBryIV417zh0KScqRckopBZ/2UxgvLV4RfYM1NlPsEv+08zA/pIyf/H0l
	 czqp2BhlBNJPX6Mqr2BjINpADQW6SgJZR/61SoSRlDYMZ+Pw/TM7SWIUXXAnvqr0R9KKA
	 OcIqvJfxvFlWRmrv2IxAdofSL8bYC06eTp55axfVN53DycWWunULf5JpSxmfjio0DhXbO
	 zUV2hDkfWtWj3bYRAtenZmlyks3zV3KBHIX4QEkCnjo2Vhp7PmWBQY7tSxCHCCF+uJu4G
	 lNaPvoUA34LY3PyRW7k240hblN8z76Ks8E83nXoliywKzwIlyH+wieBREud0K6Iacdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CJa7C6Xl/9w/tDEkPIM/dGCbIN1/e0W6lA5X5usmim4=;
	b=rnOp8EO4qhAvtYWznDoh+r59wGD+w3ZBramnuj7B9l4FEvnRjf6rpLTP7NhnQqxzG970
	 TgwjrorwNHvrgCH/8qo27oy3GJrjkXS4iddmgQo2nzDdjTzKZQPsALkY3IZdRTA33IkL9
	 Ha2QJret1PXBfVDlHhXh8hcwRTS7K/i007nD/UuIsKFP4302yZdgG4BtbkXEIRr8gyqyq
	 TVH6xvoCHCFBDH8Kj/Gv//6w9PCjA8+KEY8BWOnY5f+yMCvAV5iHd/a9UJ+s1bf3x97fU
	 Cjnn1nuErlvQqZyawkRUS48ExK56PPSB1YGoCsGlfvpqBkQqeeqV7wODaC6mMqRAwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fCYOCQ/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E105606A31C;
	Sat, 31 Oct 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCYOCQ/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F901F000C1;
	Sat, 31 Oct 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793460529;
	bh=CJa7C6Xl/9w/tDEkPIM/dGCbIN1/e0W6lA5X5usmim4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCYOCQ/fMhG4p6DVy7RZYH3I3dBTuKy5rkQMzVY8yLWGsWZn0gOvyxPL3jZP8uLhv
	 +k/VSPxmiTAgjPKM4VTACZvm3CDQL//H6eoRyk/Z9d7BbBcxGoxESmcv+eIYigm13g
	 L0vt/hpJqCn2/Op2/Dfbqzx82sQgZ0uhquuV7jOfnXtLzAvWQdXts9diqcHTYCqAzo
	 inGVXNLvI5fd0X3CWtlJyyHWiyBmG/6rD9fcQBfz0MkWyfCkSxAPCc9Iw05jSpNfst
	 jv7HlvWk3w33gx3KqEWjnV7iXUsh67yO4CXsazLVxCwNaaj4/4K5Bbb7KhyQJP8jQz
	 EteChu//bphHQ==
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque array wrappers
Date: Sat, 31 Oct 2026 11:28:46 -0400
Message-ID: <20261031152846.746656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bindgen 0.73 emits the blob of some opaque types, such as ones aligned
to more than 4 bytes, as a `__BindgenOpaqueArray` or
`__BindgenOpaqueArray<align>` newtype instead of a plain array. The
newtype only derives `PartialEq`, `Eq`, `Copy`, `Clone`, `Debug` and
`Hash`, and the `MaybeZeroable` custom derive does not reach it, so a
struct that embeds such an opaque type is no longer `Zeroable`.

`spinlock` is opaque (see rust/bindgen_parameters), and with lockdep its
blob becomes a `__BindgenOpaqueArray8<[u8; 72]>`. Commit 71ec3c7d6db8
("blk-mq: quiesce a queue that joins a quiesced tag set") added a
`spinlock_t` to `struct blk_mq_tag_set`, so an allmodconfig build with
bindgen 0.73 now fails:

  error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]>: pin_init::Zeroable` is not satisfied
    --> rust/kernel/block/mq/tag_set.rs:41:49

Which wrappers exist depends on the bindgen version and on the opaque
types of the configuration, so they cannot be covered by unconditional
impls in rust/bindings/lib.rs like `__BindgenBitfieldUnit` is. Derive
`Zeroable` for each wrapper in the generated bindings instead. The
pattern allows for the spacing of bindgen's output when rustfmt is not
available.

Fixes: 71ec3c7d6db8 ("blk-mq: quiesce a queue that joins a quiesced tag set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Jens, Linus: the block pull brought this in. 71ec3c7d6db8 puts the first
spinlock_t into a struct that the Rust code zero-initializes, and since
then a Rust allmodconfig build of mainline fails with bindgen 0.73.
Sadly the commit wasn't in linux-next before the pull request went out,
so the build breakage wasn't caught there.

Build tested x86_64 and arm64 allmodconfig with bindgen 0.73.2, and the
Rust code with bindgen 0.72.1 (no change to the generated bindings) and
0.73.0, with and without formatted bindgen output.

 rust/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 0ac9ab28cc2b5..0165626decbe7 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -514,13 +514,20 @@ endif
 bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 
 # `--rust-target` points to our minimum supported Rust version.
+#
+# `bindgen` 0.73 emits the blob of some opaque types as a
+# `__BindgenOpaqueArray[<align>]` newtype, which the custom derives do not
+# reach. Derive `Zeroable` for those wrappers, so that a struct embedding such
+# an opaque type (e.g. `spinlock_t` with lockdep) is still `Zeroable`. The
+# pattern also matches the unformatted output used when `rustfmt` is missing.
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.85 \
 		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
 		--no-debug '.*' --enable-function-attribute-detection \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
-		$(bindgen_target_cflags) $(bindgen_target_extra)
+		$(bindgen_target_cflags) $(bindgen_target_extra); \
+	sed -Ei 's/pub struct __BindgenOpaqueArray[0-9]* *< *T *> *\( *pub T *\) *;/$(pound)[derive(pin_init::Zeroable)] &/g' $@
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.53.0

