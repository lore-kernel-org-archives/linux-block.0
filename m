Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A5299A9A;
	Fri, 11 Jul 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234215; cv=none; b=mKjAdGAlFN67iAHbixlvxzsIVlxYxXwG+yWpgUpiOdJ/qwVS1WHEqcSksSSyBYevLUokLoEnp3OYW1ivzBio4Ezm6k6iMqZGBabc8H/lau3178EVNKOLaSQ2ffTnSEfQuQskYq1rnsreFrrdJW+ROVD14NyZHe5xBrXHhoHYiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234215; c=relaxed/simple;
	bh=EhHdiid3UqGuUgMiYwFJtu8dUDXo0aTr/QDEzmI5oUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6vxbmK9Y0vfxEi+kxeRyV/K/YRorXEOTeOQhE5zQ/xOd+qjQBnPPWXDuQA8endjL1Au/bi2CnmtsZBsJBASHSRg8HqYXTWHIt1Ebge3GVgd0oFPQnUgPbv6FXx54bNS6VoYUPH4MkXEjJ5aL+0BaGr+0M9dhc34l8id22VIGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuz9EZwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuz9EZwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06C7C4CEED;
	Fri, 11 Jul 2025 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234214;
	bh=EhHdiid3UqGuUgMiYwFJtu8dUDXo0aTr/QDEzmI5oUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fuz9EZwKBmjSvH5fGej6no7QVdsInQo2sKOPB0s+58nAswK4J0l+dopviO78U9ObG
	 vY0STPEUPVQmM6CONsK5w01wY6XAndqad+ztNC1r3KNIBfwY4Jwek0aBjvog5aZRYB
	 +uLLiQ++mbkZgjB0Lj/ZOWBRLiyNUZK+lNbb+/sMNuXRMqQ4t7LeqVinAG3c6XqDuU
	 347IwJ0BhqakI3tOruBFE4djUrALeMbXtTSYvbx57BbuX/MI5plX9d/4eMPdLipP/g
	 wyUhV4TL4ROq3RLliNItIy9VjRDKLRjB7b0Sc3TXT9claCqVVhuUSeofxClFta+Vyw
	 59u4GgzKSaQrw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:06 +0200
Subject: [PATCH v3 05/16] rust: str: introduce `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=EhHdiid3UqGuUgMiYwFJtu8dUDXo0aTr/QDEzmI5oUc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjO0ay/x8XurYLiBY9uUrinQhxpWdlIN08tx
 O/PlQFgf7WJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4zgAKCRDhuBo+eShj
 dy7DD/90N/KMj2ZMuzp6xbysj2qmyIXagWj9lcuKrdAK6j653C7Y5lwSkKGoBWO/psiT0k8w2tF
 p5zcOd3NhTsmdriIfZJN29y4/UWpawpVeiB/5ilz1o0jP7b84JruSQjKqB+BKqHt4Sg8s8MeZLt
 guedU0rjY3vos4Vlj+XVVdhuf3BLztLpEyNfQ1nmjeeo/MkqhHFmJBfw7bPcpYK5pLRu8PBPpMw
 py7P7JQPRIOcK8WgKbyStSDzS5/onth15SON6rHyMXQ7tl+Tz8UkOO2+Nqqvfm+fPDXN1UcgzLn
 a2p3e8/xUaYDOwelkAWxmgtA6HbiUHV0Z0EbCBZ/2SJkiiC9khe9iUq2Mj2qv/hpyOOhU3pfaKg
 FwnsRp0G7FWSQGbQRsr3KCqf5A89eUkCXcS8g6/Y9GRwavmnkk1zamGewaQMZlo+3hmf+bhmAa3
 BK6FD0CB+wGKaOCeClBg8uqUlaln7SJic0TfjE3nB38eVIKNHSBXJbOkDwaP/I+D2d5F7H0ZrXf
 v3BG3WCSowYbkv/M+vnhQArlDuU6NVmR75rxa3bNXu4lVY78Whqfbyi8dm1eoCs+ejeOz8SxWv4
 6ENi7wlC36jVdOF4uU4TXL5UMX1GMSmziLBtvWzyXZqe6oLsMw9yCXLopB+3TO/XrW2UEkyXlwX
 u4CmFp48PstXWxA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `NullTerminatedFormatter`, a formatter that writes a null terminated
string to an array or slice buffer. Because this type needs to manage the
trailing null marker, the existing formatters cannot be used to implement
this type.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index b1bc584803b0..c58925438c6e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -838,6 +838,56 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
     }
 }
 
+/// A mutable reference to a byte buffer where a string can be written into.
+///
+/// The buffer will be automatically null terminated after the last written character.
+///
+/// # Invariants
+///
+/// `buffer` is always null terminated.
+pub(crate) struct NullTerminatedFormatter<'a> {
+    buffer: &'a mut [u8],
+}
+
+impl<'a> NullTerminatedFormatter<'a> {
+    /// Create a new [`Self`] instance.
+    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
+        *(buffer.first_mut()?) = 0;
+
+        // INVARIANT: We null terminated the buffer above.
+        Some(Self { buffer })
+    }
+
+    #[expect(dead_code)]
+    pub(crate) fn from_array<const N: usize>(
+        buffer: &'a mut [crate::ffi::c_char; N],
+    ) -> Option<NullTerminatedFormatter<'a>> {
+        Self::new(buffer)
+    }
+}
+
+impl Write for NullTerminatedFormatter<'_> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+
+        // We want space for a null terminator. Buffer length is always at least 1, so no overflow.
+        if len > self.buffer.len() - 1 {
+            return Err(fmt::Error);
+        }
+
+        let buffer = core::mem::take(&mut self.buffer);
+        // We break the null termination invariant for a short while.
+        buffer[..len].copy_from_slice(bytes);
+        self.buffer = &mut buffer[len..];
+
+        // INVARIANT: We null terminate the buffer.
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


