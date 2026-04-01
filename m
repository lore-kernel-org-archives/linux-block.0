Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7B3FCB2B;
	Wed,  1 Apr 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044271; cv=none; b=G6E1XU9Y6DoPhfks68ictSUa5hXQsugMiGvnqITWaJUZiiEo92vz+nMHKs1HQN93fWT9+h0KtwCmJgN0biALMl8ATmZTSlHO89qXHf9ecrPbTJeV4LEcZCUuBdlcAv380OhL6Aj4gzOOAhGBnB+yJ/oCpIayiuIi5VVYMdnnFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044271; c=relaxed/simple;
	bh=iESh/PsAjDcxQq1FPvUHHfd+weV5KPEgRwQZ+Kj82r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5WHrMAMlTNnfr6L3yVP+1vKshge/CbKTeXX1bTsXZuxT7N8j7rJrrAKSBozGHu7vVALrnaHXe0wCoU/82nZ11YtA4fr80QNyfB5gB/2doTRaVTCzzz9h3JxeJ7EIqC8+dSPYzw1KDD0DD/2TVBSWSL6dizG2KIgr5c9fOV7QTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMSjHj3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMSjHj3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F5DC4CEF7;
	Wed,  1 Apr 2026 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044270;
	bh=iESh/PsAjDcxQq1FPvUHHfd+weV5KPEgRwQZ+Kj82r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMSjHj3hxQyMr3QOLPc9anPPOGIWvLjjfUs5B9icQA6qsTjz7U5bSiiQLz5Hoz/OZ
	 3YloS9ZOhT+qiN9KqpcVdJ/fLcbsTEZsVpLlIJR/p8UWfxVDZt/sNTHzb3Tb1udZ9E
	 jYKb+IF68+AxkebN//+Bv/5FcswBwbEnYjMPl5q4E8tRf1uFO6MDGiu0giHqkZrPMZ
	 B/JU0qy6HQc8IL0tBX9Pvko/kdINTPzrBMF75o1WUkXp4U9BqKKQmSf0bTLleTLfsz
	 9SSYwlPv8GbLy88Jt1O+HwrOoOXCjTR4QWXF2VgqHQ3s27vGf1rd5NqLc88kF63w+j
	 heSTJSaAyigww==
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
Subject: [PATCH 26/33] docs: rust: quick-start: remove Gentoo "testing" note
Date: Wed,  1 Apr 2026 13:45:33 +0200
Message-ID: <20260401114540.30108-27-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentoo does not need the "testing" note, since its packages are recent
enough even in the stable branch [1][2].

Thus remove it to simplify the documentation.

Link: https://packages.gentoo.org/packages/dev-lang/rust [1]
Link: https://packages.gentoo.org/packages/dev-util/bindgen [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index db08c3a03a4f..1518367324fe 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -57,8 +57,8 @@ of the box, e.g.::
 Gentoo Linux
 ************
 
-Gentoo Linux (and especially the testing branch) provides recent Rust releases
-and thus it should generally work out of the box, e.g.::
+Gentoo Linux provides recent Rust releases and thus it should generally work out
+of the box, e.g.::
 
 	USE='rust-src rustfmt clippy' emerge dev-lang/rust dev-util/bindgen
 
-- 
2.53.0

