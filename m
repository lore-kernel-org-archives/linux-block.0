Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4B3F9F3E;
	Wed,  1 Apr 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044105; cv=none; b=dZxTOiEb55/zwAun2oqZUe0UBH3vLDshCazDn+pDhiBYnPMWkzk6/ZHv7sECidNQR30RX6cRK7N72vWiNHNNT6VGuJlr4Thg6SgBEJOhJ0GqwZThbFEy3Zeep6xY26NCKoT40KwG9xV1O40beJdauFT32Pg3SL4p1lW/7rd98f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044105; c=relaxed/simple;
	bh=oCOOGcyyszcaXC31455V0be0QqdPMZoxWheuEK3ZCSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GchUD7l6Wy2cMsWhAGfSUiw8wsHXN3/eae8quDR822vjnlUVaAodPcV2p45K3VSL9fvd8grpQb6iSl5InRqYlD5dOYhZBjsWMAPR2jlIAhDZfgbzC8T7x+pP6zCzJxEWct2plw4gscXKiZSBH+rFb0I9XGIpe0TMj+5L8KlQNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoxIk+02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoxIk+02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04AFC4CEF7;
	Wed,  1 Apr 2026 11:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044105;
	bh=oCOOGcyyszcaXC31455V0be0QqdPMZoxWheuEK3ZCSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoxIk+02vJe18xjAgrD81txVK4wtRlTfUWrhHLGDRSQiV+me/fjnLC+7phHDlesuL
	 J7Hq1xhTdOPfCfF8DlMkdOt8rrbVHMirjmXItItYHfBPD25cX4fMo/GBYwdrbRu7fZ
	 0AkU4tct54K8WMu16YFOTGOQcGE3qx2fKQnsmkDzl/vyf61S0QPF9vcb0C1gkRPnMR
	 e+5uOE14VQelGq2Cq0xHw4LUMkQ9WlkXANUH0HKCMdNXt3l1xPhuNuUmuYpg9lJb/A
	 TRD5Link8UuZH9tLBuJ6KDPuIvaQ52PV5omvSLGJvk5BLHki1ajJnBJ5vuJsGi1ltQ
	 c73r0TDlYXWnA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH 12/33] rust: macros: update `extract_if` MSRV TODO comment
Date: Wed,  1 Apr 2026 13:45:19 +0200
Message-ID: <20260401114540.30108-13-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`feature(extract_if)` was stabilized in Rust 1.87.0 [1].

Thus update the comment to reflect that.

Alternatively, we could use it unstably already.

Link: https://github.com/rust-lang/rust/pull/137109 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/macros/kunit.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 6be880d634e2..6f6d746b8dbb 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -87,7 +87,7 @@ pub(crate) fn kunit_tests(test_suite: Ident, mut module: ItemMod) -> Result<Toke
             continue;
         };
 
-        // TODO: Replace below with `extract_if` when MSRV is bumped above 1.85.
+        // TODO: Replace with `extract_if` when MSRV is >= 1.87.0.
         let before_len = f.attrs.len();
         f.attrs.retain(|attr| !attr.path().is_ident("test"));
         if f.attrs.len() == before_len {
-- 
2.53.0

