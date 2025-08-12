Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36352E717B;
	Tue, 12 Aug 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988399; cv=none; b=j2OeL6E+rYoEP5gAoayG+u/XCE/0HaEVKsZHkOXXh56Grt/UcpPb9CRUikrPoqpO5gZrn1yxShbVR8H9XUbZSdeiXOSyUXw2Ew/daLClDp7ZaOAH3tnnpmh1b2h5QxTKSA6N8HZvSoZltUV88D59KILBSJWW21gvasWHyNLtcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988399; c=relaxed/simple;
	bh=5vdh1riAR0ZL9xaLLQRBtVtO//nClfhfAq/IqeV6FBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhvxgm1FO9fpiO7AKfG0X5TDKLe84/p/QiFYH6aI3p9uDHednN+dmoiA3tOPlP1yxnEVY++C7TPsZDEthQsDZsqlwA+Y4e5tUvmcvS8hurdB//zFuIynpApFYiFC4Xm90wOJpBdp34LEFqnc3pmPDbZDoUtwrQIilCynBq1xOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPD/D0Z4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPD/D0Z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E1BC4CEF0;
	Tue, 12 Aug 2025 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988398;
	bh=5vdh1riAR0ZL9xaLLQRBtVtO//nClfhfAq/IqeV6FBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZPD/D0Z4UaD4iVP8yjxS4+6iYcJ392xZhUk6BdaEv35g1us/JnEDazC5fTkbogXrl
	 tYKmB2FhB4fH1+n+zfwvHk9zB2WawE38DO9dCxbks3NfxMbEG+LB6+0kUJSxUNdOit
	 aeopHDVSUNLSTOR03IOUAHT6f/xcOEIll3iOJ56Qj5Mz9r6WG0G0Mp0vZ/ZQVQnt5x
	 EI6+kZmbkjg61xgf/onnEJyxRF22vTnzhMj7LuAfIFRbslv19xo9sty81J9sLVAmXx
	 heXvN76DKe/KP48hKTHgNuem+L1+KcS+890S6x83pwblFH9tuVJ9GzKnp0LtXEjcKe
	 Go3RvBr7k5sSg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:22 +0200
Subject: [PATCH v4 04/15] rust: str: introduce `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-4-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2720; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5vdh1riAR0ZL9xaLLQRBtVtO//nClfhfAq/IqeV6FBY=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8fKlpJ8jBjQG7Hiw5jhqLFg/iPJu/OAJjPr
 lI8UDjotlaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/HwAKCRDhuBo+eShj
 dxdgD/kBvs3r8XCENbIp6EI7LHK7yDcd18oPIe4WjKcM17srqNA1W23fdXxzM6Ry0kpdjfD1R4v
 3MPlNXPzD4ohFd2AM5ApFqhG8Ym28IH1UHRkJvdYYSnEN1jaV5yUzv+/AZC+BoV8GC9DyK9N+W2
 CfBE/M33G4Rr8ZOQVwIu9fS5V7Aqq8M4L4DP4uappH90wGIvqAgQvmbdLW+LgsvWE4yxKuqwyxc
 E3iK+KFCo6lRUHcCKw64fG8yV3DwPPFk2mVI8WDKdky8sSkglJ8Nezk9ruTIXxi157oCuTwLt1N
 ejTAgTZIZz1dGp9Nxclb4JI3JFUKex/1BS/SWNEvAfLa1PnlIB4n+ukE8rL3WfcDm5DOt+2K+gi
 MCdhiMGzctEnC9p/LcIuz/9JaZyib8nIF0rH857tyMa9NZRPHtkAHCEmexTg3AY2WhnEv46s24Z
 sQiJ8hteUPu9xINr1BTe4MTEoDtcMiutlkGkiBxvv/wAxBTpQyintIIoLVz2NIQAa7QQEKPcCTO
 VqUz/kJGMlaqAhFA/MPerlK90N2UkGRGhFWEAu2MGhvr0Gf6vswAKDoKsLDkjrFncVpixFgFp0c
 p4qS5xFck4keRtbgMqV+VdGHtsjbvW6RMVt/F+LEvrfWZvlN8vMdjtq6udljN21VrDqsHg9qPnQ
 tBJqlRnf49ysphg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `NullTerminatedFormatter`, a formatter that writes a null terminated
string to an array or slice buffer. Because this type needs to manage the
trailing null marker, the existing formatters cannot be used to implement
this type.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 46cdc85dad63..e84f62c01815 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -871,6 +871,61 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
+    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
+        *(buffer.first_mut()?) = 0;
+
+        // INVARIANT:
+        //  - We wrote zero to the first byte above.
+        //  - If buffer was not at least length 1, `buffer.first_mut()` would return None.
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


