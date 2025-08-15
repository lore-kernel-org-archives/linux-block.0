Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C931986D;
	Fri, 15 Aug 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243118; cv=none; b=kjVDcB4J/m8BqUkzN7CbDozqLb0F9FsJ5Pf34+4zN+M1HPnZTwFFCdOC8DLAyk24hyWqqyGPI8rXroqfRzH9iGqAKjZsIqApZoINU0oG8tw+ZhI3yYb8LX4lI6Y7D7Z8OJ1a/9JSeC4y527oiAX0qZGOiJeEq4o2wL8FeTlVsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243118; c=relaxed/simple;
	bh=Hl2oRNYbBHso61BXXHLO+jiCInVPd7Fo+1gfwzFywQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHY/dqoZZd9XiQv3RszrX5hqz74hOqcCKJRe8F98imJ0RnQ1Hm2ZMl/FmGz49LkSYg18kAukdt5wK+Zn4iz1KG0l/2F7qziY+a6ogenLFnbUjjQH/jeW8Rt4DwgahEywZX6ThulPtjMekUB+gZQrTYQcuDhQG8NN1rOk1pw05cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXA83exv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXA83exv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E50C4CEF4;
	Fri, 15 Aug 2025 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243117;
	bh=Hl2oRNYbBHso61BXXHLO+jiCInVPd7Fo+1gfwzFywQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LXA83exvk1yHaow9Vt5CPd16rsQ8vDDL5E1QZzqlLwsiIFhEd6w/Vs3Zl7r9e+mMd
	 oCAWRjtqrND6Zqn7mAcrZErnThJM+JC1RIKMIj321PI+fpJd8X4lPGeUx7G6GZ9OpL
	 ZmOlgjwNznKG72rRvUP8SgR3MVJKwbvK96Li+fvkb+8NiYrqtRz/u9198Q1/vHAJvd
	 H/1OQsbjQSM3UKgSR/r/hSR4Haa7RvcSJQNE7qRpZrsgKVfjozAPXZRPKz9nj73WU0
	 r4sApKyQdByVsNIf375r7ByI+fJmWbpHX9Y2L1AnrXviEKirOAzHdl3QA+m5xkAZY3
	 rWURcAqvuM2Pw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:39 +0200
Subject: [PATCH v5 04/18] rust: str: introduce `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-4-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI3vUbKhBBQMW+RBgwIt+sBsnWaEjse0FiMQ
 l9nTK7DsBCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iNwAKCRDhuBo+eShj
 dwrdD/wMWCOy6wPKZTmKVly7PWtSFZORMHM0qVPzJbU3zNNZuQLeWtlQ8wlvPoALTjihHBRIwWA
 oAJKgRVIJhXs3vDAATE1L40XwQpM451uHO9KOqhk5EL24nNVze5N8u5vqZtkN6tIg7ubqvooNKw
 MnXvkIrfPIgXb5GHAoiB2vnknCMvN0y9GeeJZDmW8+3QhpK6fnA/now4SjnXwf90c/vedjQtOfB
 ItTMp1H7x+3pwVQ6yB5F/g9IyETzv/SWuc2HrwmsJ4LesDVOSvWq/UC92QT67hcU7AX0yGUN+/g
 GZkg2yLmiZKcnJyNU1ZtiiYHd0sgEc17ojf1ng173Db9LavcvJedLDZdF6zW2H6R0ZfgDJSVQbn
 MezYgnjtXTZg1PZP9CuwueiXPa9H+Mqr8Ebwa2EpVLToZektMb/lcYN4wKNzELVMsUxj1+7syN9
 INZ85qlsb3OfsHyMTWn45BiWYl1f5Tu37/N1HEcvtIJRVMfFfsUUzbEmLnqE+/GsEIFpiYIR1gl
 LjuVCLtIDYzWInBmV+XsXwsN7GdDoLT5eXUxhQrc2n46FiJviGdS0KkGNdCNwSulbgvarNHLLG0
 IFTEeIZUgIQGK6Rtb6gtG/D8GYdTaZG9fTqHzttD04juwQ+OOrTkrCtCRoz5qvPddtPbzC1GrkP
 aiuMHSW3bnD4+3A==
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


