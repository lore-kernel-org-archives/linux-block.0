Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98700264A65;
	Sun,  5 Apr 2026 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433253; cv=none; b=uvltLkT5JqZi7oVrg4vnTTKYaABbsZyCY9KJeKaOtAw61l1GItzPeq7y1XEziEaACRcGCFCFbPTdS863sHW6ZhNdqQwLQ2h9HebirRkjCSueTo2IAa+24uYsRz+us8OVPczobFWkX/cms9+Txa8lsi8se3atmj6D7kdqDM773EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433253; c=relaxed/simple;
	bh=oJiEjRp/opaguJ4HhOa7BUALrmAHlwil3WnDUUwEFyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQe0b1Twgq2pjCtsf9FGFLw4ZVT6aBseZB1bXd05JeHi6Pr7i9m3yx1/1PxaHfhEXfd4/hrU/XyXX35DdBf+q/b3dCZoc25E50u5g9X+ZsPCGIF/qphmZfBiqqTlISs1NNU9mHWFwhlDuFurZgeRiUfAQsySv832qeeEVYrb6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c10lWAwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c10lWAwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5734C19425;
	Sun,  5 Apr 2026 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433253;
	bh=oJiEjRp/opaguJ4HhOa7BUALrmAHlwil3WnDUUwEFyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c10lWAwN7MLREejYSBh3vQLAgy//epBWc0tngWnnNsGINz8/8BlSPWfgahadGOvdg
	 GJR/QGcckyY1VKHxNGRQhD/YyTL42GRWjDnY9CRlUt+Bx7rCq+inC36ss3LMkllx5C
	 jCzn/1H+H3U2Udf/nYq4VGqSHLFJs5uBG1jN2j7ksPIuZQIwZS8T1ZqvFfTkCjXinf
	 HwuRwkXS9MYDk6Pqlgm7p9mbcEhyyEKZ4di60v8j1CCV16s5WfaVl6n4/rqtJFA5Ag
	 9rs7/6aurHA4leXQgoMVliGbwR86JVtRyVkjWqwpFzYYP2uH4d8JIwQ8pbaJ3B9UHq
	 QUN1C/k9eWL2g==
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
	linux-doc@vger.kernel.org,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 04/33] gpu: nova-core: bindings: remove unneeded `cfg_attr`
Date: Mon,  6 Apr 2026 01:52:40 +0200
Message-ID: <20260405235309.418950-5-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
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

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
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

