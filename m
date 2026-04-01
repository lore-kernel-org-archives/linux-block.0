Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD54070F9;
	Wed,  1 Apr 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044259; cv=none; b=ZHns8hhisxnkBkCk1H5EXBkUY8YKhjWe19TaO8v2OOMKfC9cliWCq+xuG3zQnLmdhbv7Vo6wsLxPrzzhkxIIebqBE3PwtlYgG+thybU/UzxpA9UhWXUSZqIP1rubRTO+F+7BecXB65NuINu0Jow6tKO3/abSVh7pV7vNc/7gcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044259; c=relaxed/simple;
	bh=ZrS7YCyshnbs/lG/9j9L7W/ZUrAuF338JPwI0nwq6Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxOe1TDL6hOW8pqozZANUPCg86D68IJ0kfDHClQ8z3J4kgK++6tuWQhqvwE/fRGgqNg+uP8bMdNKL+fJedhAKWep65ovOcuPShq0ZJIic/BhHe2rTS/ettGgnVf4RGDEzAstumXL45Vs7CPPeHeqX05M0CNTgkVZjUznrkKacIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYUKktNt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYUKktNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A793C4CEF7;
	Wed,  1 Apr 2026 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044258;
	bh=ZrS7YCyshnbs/lG/9j9L7W/ZUrAuF338JPwI0nwq6Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYUKktNtjBtnO2jEekVdFzAXCPxvMmq8cOZ/wimER2kJOuz26TYi2q5bk91NF6CFY
	 V3uRQuToa4yd5/BlRrJuDUAvl/Ng8LmL71ojncQB2XFtcInSO8RsXWX1UcDolbNEKf
	 Vr7CCsu4JLP8hJ8Kq7urO0JEocaF0r6VbZa+42Sdln5aiR3/s6R5CaAOkIYDTOBYFN
	 jQ19XQq/9YUv1eHqK24bolOhTgYGxRPfjpfeAX42W17zK+3HMCGkzXRWdt2m3/51bF
	 jzN98RjCjBcK57ESqOPlvU09ERPYNtXiyClFAHc+QnLlv5x2uSLTqHwOePbncyE2kZ
	 tpwl4A5SNvXTg==
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
Subject: [PATCH 25/33] docs: rust: quick-start: add Ubuntu 26.04 LTS and remove subsection title
Date: Wed,  1 Apr 2026 13:45:32 +0200
Message-ID: <20260401114540.30108-26-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ubuntu 26.04 LTS (Resolute Raccoon) is scheduled to be released in a few
weeks [1], and it has a recent enough Rust toolchain, just like Ubuntu
25.10 has [2][3].

We could update the title and the paragraph, but to simplify and to
make it more consistent with the other distributions' sections, let's
instead just remove that title. It will also reduce the differences
later on to keep it updated. Eventually, when we remove the remaining
subsection for older LTSs, Ubuntu should be a small section like the
other distributions.

Thus remove the title and add the mention of Ubuntu 26.04 LTS.

Link: https://documentation.ubuntu.com/release-notes/26.04/schedule/#resolute-raccoon-schedule [1]
Link: https://packages.ubuntu.com/search?keywords=rustc&searchon=names&exact=1&suite=all&section=all [2]
Link: https://packages.ubuntu.com/search?keywords=bindgen&searchon=names&exact=1&suite=all&section=all [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 34c39f208333..db08c3a03a4f 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -90,10 +90,7 @@ they should generally work out of the box, e.g.::
 Ubuntu
 ******
 
-25.10
-~~~~~
-
-The latest Ubuntu releases provide recent Rust releases and thus they should
+Ubuntu 25.10 and 26.04 LTS provide recent Rust releases and thus they should
 generally work out of the box, e.g.::
 
 	apt install rustc rust-src bindgen rustfmt rust-clippy
-- 
2.53.0

