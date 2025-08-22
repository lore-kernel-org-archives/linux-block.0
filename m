Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C62FDC3D;
	Fri, 22 Aug 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864947; cv=none; b=h5B8/6TsfVsLOuGTIbJlgCckHD+ukviTNqjULAqvPQjVbCxJ5FgdpzRK/Y0oqZZXNGB2ErdeNy8i+ZI4aCCadclUFWChW7xfIRP0B5oRm1BykB5DZTp/0Xv1u8RTYq10rM9b/zPfgSRORVRMBnyDnrexoSDPztD7rEHHzHZ7xB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864947; c=relaxed/simple;
	bh=Hl2oRNYbBHso61BXXHLO+jiCInVPd7Fo+1gfwzFywQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJWP5zE0ve8pRgjdi9KIf75WqqY2PxbweU+p3/ead4/8JQcDggv+HXw++MmhENEdo7v0RNOUGCEj9VXj+lhIcnJu+7l57vO9wRC4WymY/si9yl/s3M7cXp83wo0ThU9uJTIm6hNstLjXQCP4hOCBsAkt58NJbuITyz9AEOIUMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbJZv7wI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbJZv7wI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010BFC113D0;
	Fri, 22 Aug 2025 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864946;
	bh=Hl2oRNYbBHso61BXXHLO+jiCInVPd7Fo+1gfwzFywQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rbJZv7wIu9O3kILewVIi76qiZPtowYk4zdxAP/7L1VO240NlxgeRuUSkLr0CWmHJR
	 V+JklussjI9UlyR6a7Zj5eWCQ/rxuZpAbfBbg+wS9UO/0nYamGBM39kHdS5rRBLLve
	 DZlKKKNj+WgVcQOFzuMeMZE5gLcdvyRTakutosYFM3txt/K4gEcmXso+O2iNCOEkki
	 WoFJZ5Iybq131jBu667TqdwvMQBVc+pLOPdUu9ohNuCd04euuZmyqHskSYPBCmTTej
	 gACGAC+XtyB/UxsklpAPMLrTZZTz1lNVzwBE9zzq7nlbNNwWBcvPJn+82G7gldzTnD
	 xV6moeKfPZCIQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:40 +0200
Subject: [PATCH v6 04/18] rust: str: introduce `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-4-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Hl2oRNYbBHso61BXXHLO+jiCInVPd7Fo+1gfwzFywQ0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF81D6SbPuy2OHW/7vXXiRBHmhys31IydQyJA
 8XCju6/YxOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfNQAKCRDhuBo+eShj
 dxxSD/wIE9APfwQmyjVRYGzUfekfLRx6TbbRm+Vq7rflfHMcgXlME1VaBXSSPajHOmHkyC9GdJ4
 onz2jGzVO7NWiuXgNrJ10A5+1HKPTgpcKVMYQQsuc99mfrI7CHvDtEDd407kAku/RgeMEsc01E1
 Bq7VAehUj2HOFrSbrfCCR05gDYjRIWQb8XigXAp0J+BtDAsKuUU1yIXTN/SEwwblue4uIgisDsS
 VX7lwWe+rt9VEHrVfnNcKJc/kDimBQNQ/kvR/fWDRF1amAi4l9eCmP2rAmZDaVIybmyFG2d5prS
 BtlIn4G8mgBuVOmi81btNl9uloCKLtqSAGcD5zwAHGQz0c8VUf0rPMQ6fFJ4ZkY3+6fIBNK70j5
 0GGB1UAiasWvxQiAABvCS/3ZrmJeOzwDlNyUZ7IwnpNaI2XPSlY1WCwrRqlYwCB3jtRK3K9IRR4
 /5FoQCOwz6eZchfmGgpikWBS2vQnuxWXvM3mxSgYkTwFjJWiKNgLe31fwYbwztAJdk8ki3Z4inK
 uCRkPGR3IjfO6jLPQcGIEsF5X22aO+ercCfV5/efu39Dvc93bYLiZ1SUdo0kqOfXQdIzOuLGVNh
 xQBf93dAoKPwVNV7HeOntCL3Eu2gdoTXg6tzBuIHbBocS5o5mjm4401jKYacu2wH7PoGkeqbJTP
 mZglkuwkDKAG5iQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `NullTerminatedFormatter`, a formatter that writes a null terminated
string to an array or slice buffer. Because this type needs to manage the
trailing null marker, the existing formatters cannot be used to implement
this type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 46cdc85dad63..d8326f7bc9c1 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -871,6 +871,55 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
     }
 }
 
+/// A mutable reference to a byte buffer where a string can be written into.
+///
+/// The buffer will be automatically null terminated after the last written character.
+///
+/// # Invariants
+///
+/// * The first byte of `buffer` is always zero.
+/// * The length of `buffer` is at least 1.
+pub(crate) struct NullTerminatedFormatter<'a> {
+    buffer: &'a mut [u8],
+}
+
+impl<'a> NullTerminatedFormatter<'a> {
+    /// Create a new [`Self`] instance.
+    #[expect(dead_code)]
+    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
+        *(buffer.first_mut()?) = 0;
+
+        // INVARIANT:
+        //  - We wrote zero to the first byte above.
+        //  - If buffer was not at least length 1, `buffer.first_mut()` would return None.
+        Some(Self { buffer })
+    }
+}
+
+impl Write for NullTerminatedFormatter<'_> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+
+        // We want space for a zero. By type invariant, buffer length is always at least 1, so no
+        // underflow.
+        if len > self.buffer.len() - 1 {
+            return Err(fmt::Error);
+        }
+
+        let buffer = core::mem::take(&mut self.buffer);
+        // We break the zero start invariant for a short while.
+        buffer[..len].copy_from_slice(bytes);
+        // INVARIANT: We checked above that buffer will have size at least 1 after this assignment.
+        self.buffer = &mut buffer[len..];
+
+        // INVARIANT: We write zero to the first byte of the buffer.
+        self.buffer[0] = 0;
+
+        Ok(())
+    }
+}
+
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
 ///
 /// Used for interoperability with kernel APIs that take C strings.

-- 
2.47.2


