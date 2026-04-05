Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E94264A65;
	Sun,  5 Apr 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433387; cv=none; b=OdLaFsntKJ+oAvxqWUPlgPOdoxjpns4Or2uUc0FnFKQ72nmZdI3h7AtjcdZDPpve46Ybg5Mzy7hE5Ab69HO33/Oy4GZs+iCvkUltF2RVce72kyU7kl7ymsRZcMCyu3Q+n48ZwL/JL6KHynXqc37v8h3aSqKeB42uISMm0OY0T8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433387; c=relaxed/simple;
	bh=epQs3AsyxZ8hhy5ISUPTkOTvgvbeYkZEdG041MVzF80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VScC9PULCUJ/wtkwKdPpjcZwo2j20IG7FTcXhDiT7KV0tkrEciIZc8UOr1M55jxcQ+NC4gQwgSsq7W0Qf4MOzbVspHj/wn4d249hkw97RsDZlrIO1UUnikBb91NE3R74PL2M5sI93xW5KxPfeWH+top5EI8SZSLKGbVTXdqMSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Jq/KNe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Jq/KNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4322DC2BC9E;
	Sun,  5 Apr 2026 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433386;
	bh=epQs3AsyxZ8hhy5ISUPTkOTvgvbeYkZEdG041MVzF80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5Jq/KNe79Oh6OGcaoN5PmN2FFcrPk6GXdZcnPkCCDQp2UqHYQ9SjPNHV1332T+nF
	 T+EMIfEl65JCvssoBOyMtZZKNAxU8TmRe5HaKPPwK+gBHmI/vYuqdH1BJv358cKnCs
	 j84VKway/sOwJ1457dvilIKK/J+Q/OQaHKwpmKO95nCh4B7yrwTBxi9e0NrjaZTtt9
	 crDuyneI/9sBvcynswhVdLKgIKdEhefPzcWdNZgBm/jAYpMGU+0smar730LDYpqwvX
	 AJij9W0+y1c22mbCnukDGTJao+rlNiw93Km7Z7OnP8ZZkoqeUHZ03Xxf7FbRHImwOl
	 bXVw24EbqtJYQ==
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
Subject: [PATCH v2 16/33] rust: block: update `const_refs_to_static` MSRV TODO comment
Date: Mon,  6 Apr 2026 01:52:52 +0200
Message-ID: <20260405235309.418950-17-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`feature(const_refs_to_static)` was stabilized in Rust 1.83.0 [1].

Thus update the comment to reflect that.

Link: https://github.com/rust-lang/rust/pull/129759 [1]
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index c8b0ecb17082..912cb805caf5 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -140,9 +140,7 @@ pub fn build<T: Operations>(
             devnode: None,
             alternative_gpt_sector: None,
             get_unique_id: None,
-            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
-            // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
-            // <https://github.com/rust-lang/rust/issues/119618>
+            // TODO: Set to `THIS_MODULE`.
             owner: core::ptr::null_mut(),
             pr_ops: core::ptr::null_mut(),
             free_disk: None,
-- 
2.53.0

