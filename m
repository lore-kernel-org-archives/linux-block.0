Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2D3FF89D;
	Wed,  1 Apr 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044211; cv=none; b=f1NYmZJduQblp+OGYCcJCuMMRHEOWyM412A+22eYTt1Lku88r5OCEZbz246urVF2YAjNjTU0BPnhkmg1a5KV/CzE4GQu6J2nZYg6XdnLc9tZId/pqvlJ9Xw0FSz7+SmwXvbUWL7uGJTbIffx8lScth85bZG/18Wr7yxf6fWEORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044211; c=relaxed/simple;
	bh=iISLHJsJQiyE5V1a4iQF3ymUr2P6zTU39tNtCIX5lU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzS79giW6RPsn6vJTjQhNZxGmNfsmLMULaoWJpq1XY1gT07Il0IllBtwTeT5H+UposSeTJZeRv+TIHn4VaJU8Gw0ahHnF0iN8iJbsHWQZ3ccvW6cKkkbOZr53PcXqJ4u4ZCKd0W9r4FDXt8NMN6oehsx/Gti8jGlT3xJ1OyNAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwH43iMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwH43iMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1EFC4AF09;
	Wed,  1 Apr 2026 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044211;
	bh=iISLHJsJQiyE5V1a4iQF3ymUr2P6zTU39tNtCIX5lU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwH43iMXpXDQcRy4+AMfSoYea42pNLVjzuMUPXqV9lyKyZIS7rRAiS9cIgTsQsdyd
	 j6B+J+/pu75uzOpJdnOhGJFNMudRyhbVI5dSzB4BiQVbTcwkXAFXR8xUeur9CaaAtt
	 JILD8rNL8BETCD7dVZ00oT076Wj2GzJGGKGV6CXrVenq2zJx1Lq8ByMqTLw1UKAF4R
	 wf7/Ah1lAE4c15DAF/slU0ZwiQvEKjx+rSuvc5YXtnnEw53F1u8bcFjkR9SONe1CBC
	 +R4ZEzhNp4MYwVjW3Cv+ubljVX44Z9Rv2JtwQix1BCDgnfWCo1kCfKXLTfhQHkzxsH
	 iTdb7Dl5K7QVw==
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
Subject: [PATCH 21/33] gpu: nova-core: bindings: remove unneeded `cfg_attr`
Date: Wed,  1 Apr 2026 13:45:28 +0200
Message-ID: <20260401114540.30108-22-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These were likely copied from the `bindings` and `uapi` crates, but are
unneeded since there are no `cfg(test)`s in the bindings.

In addition, the issue that triggered the addition in those crates
originally is also fixed in `bindgen` (please see the previous commit).

Thus remove them.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/gpu/nova-core/gsp/fw/r570_144.rs | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144.rs b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
index e99d315ae74c..2e6f0d298756 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
@@ -7,9 +7,6 @@
 //! This module may not be directly used. Please abstract or re-export the needed symbols in the
 //! parent module instead.
 
-#![cfg_attr(test, allow(deref_nullptr))]
-#![cfg_attr(test, allow(unaligned_references))]
-#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
 #![allow(
     dead_code,
     clippy::all,
-- 
2.53.0

