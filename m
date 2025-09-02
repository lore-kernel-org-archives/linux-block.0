Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88F2E5412;
	Tue,  2 Sep 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806933; cv=none; b=ChYwRN2KQItbs0gh0pk60HN+zW82gXhB2wKuTsxjAf6JmPfVRuXkDhMboGuy8i7S/EYDEtNJUOud46rsf2D9HcbHIvJaR8sYBT/dsXJSCsCtwmGOMpDA6Z/7oMobQ2ju/fXJuFXlu5Gu+xrkDYYx52fwgcuSxBd+oQU9d5uLeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806933; c=relaxed/simple;
	bh=vipqlYY6O+HI8HCAO+GyfEa49mZe/gTyx2DU5+fC7G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8lgJyZrK1WPWLVwNQ8g8q84kL25hHbVjdZcvd6TIsleOuF3KKmu7tL6KARrvqwpzgxZ3FyZE6l1mephVIkeiCNmBYQEHV77q5ux7t+wd3oAcP25qwX9x5B266VRGmEDvXonevIxdBcQ6CQrsKaEGhsgIkdU9NvYfjkNLye4kuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXGOcorj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXGOcorj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908D0C4CEED;
	Tue,  2 Sep 2025 09:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806932;
	bh=vipqlYY6O+HI8HCAO+GyfEa49mZe/gTyx2DU5+fC7G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mXGOcorjYYunTLKayMB8otxsrtPF++SLHAEYKdc56DJxlBQC+VeaJdPizub/IpUEJ
	 l1vot1Pazn8M8qpRJDhYD5NrDWhmVELGJQcSTROJvBEvXJ8p+82BR7EVDEWts+TUpT
	 M9XF5aq+7dxa9VyVRrNX6aNLaNXefdvsFqI+us4ewxar8a28HyIKsG7RKZz2yh6PFA
	 vfjf9eoMRByxzG7kfXBJxTa6bc/DBvnqkvKcciRSkOVkpS2WLgtv5V/LVifV0e5yV0
	 1O/HgKqamPWHtb2KaVgAZQvykWLbyiz3BVKQLbpYZIF89T3hd5fzj6G4+11fRC/dJu
	 BdyO/hvolLmbQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:54:58 +0200
Subject: [PATCH v7 04/17] rust: str: introduce `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-4-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=vipqlYY6O+HI8HCAO+GyfEa49mZe/gTyx2DU5+fC7G8=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr78P7RWlhh3LZjfg/zSaOl3/ULIeC8XSBg6R
 WriczEieiuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa+/AAKCRDhuBo+eShj
 d85FD/9lgcr6JFiftAbDoyBrJLly3m8r4Gxt2Y1rZLpBFPLCG+r5kQwX9fbK39HxI53I7Zm4sAh
 0aWVuRc3r4S+uXqjhU2rYhrg16aYPnmkjW1HN65R7+o7pyq6QckbaAgViGdsU4ruy+P0OVxZQI9
 WWT9G+vNJ4Ezy5l7LQuyEPJlpchoIp99X8gydSvdMSodwdsZVGr6M5ojo0aldqD8GTv1azBdIRK
 TI6vYztEzfyFEa4FD5Cqy0iAISb3NcPnN2ckaTsVZVtAYrHMo1vTFympTe9QzxA9WOfSspZ4PD6
 isyy1CjhdQ4hh3fiIu0SmBGFOvv8XpM+MPOgg1oxkeNmb5VdwaRrZDraHfvyYxXL4xUobkkbVor
 vJp5MtOfqxydVSSnWpXXD8uDNw49XLbuCrbG/TCh1BbQ5uK6fTxw7CI1MuICFWAmTxlGz6F62FK
 rgfYuncAxdVa9FZQEphPTmMnX/PkezVopJQT7Rrs2Goziv1vgthnSf9gfKKwTgSrD5kdj1YBAjr
 bTbh0bi7juPC8zF5QFIWbqsSKiHLqmDGlFtj0cvjEgwLLgK74rdJ1kVjKptQit3Qp2F76IYcHzR
 W4Ofth99Dl7b2acH6yFnVwKIejGi0m/jdYBAt303ceh4drC7SKdVxUwIWtavQxoiCMe/nFoWt5g
 8+3lvBQVNI6tYnQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `NullTerminatedFormatter`, a formatter that writes a null terminated
string to an array or slice buffer. Because this type needs to manage the
trailing null marker, the existing formatters cannot be used to implement
this type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


