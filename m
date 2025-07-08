Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E7248871;
	Tue,  8 Jul 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003958; cv=none; b=QxUXx0hMdUkMZV5eP9ZfX1OJcF1o3R/o6oX50A089w4GrOXCcqW0/j8VFENAgvg8DafgkJOESTH6quuvyOGVN0JbfvtpdiehvvaChUXg0wI9dos5vdUvn9rv523r7GS1IpL2jX6jJlfcefQZvhHQRkbw6ot3iZRdKPHQlinl7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003958; c=relaxed/simple;
	bh=Tc69NpZsnd7U7OJBUvDg6vLnyx/YuYb6KbZ5n87FHyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDwaeq/Ac/hKJOLy72JTv0N/RNUdwHKRU6y1x6G38YkJ70XONwI6wCVFQhJ9jwmZ5yiMLp3nZd4WoT1kyT80S4ga7V2cL40M6RvyC47O5X0V1rE64/luYOBP61QyiHBLQaZ+YSx7Y+k61LAN1jgwsbr9ROAHyJSVgi5ZsrxiVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdntC6Uk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdntC6Uk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0203C4CEED;
	Tue,  8 Jul 2025 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003958;
	bh=Tc69NpZsnd7U7OJBUvDg6vLnyx/YuYb6KbZ5n87FHyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tdntC6UkSZ7F7DdjJkJWDuW15dnotGqWbLgVC1VAFsr6YuklEq09j9XdBYCVWMsci
	 RGKlu5KezaXkXriRM7kY0i+MhBN8aEoZ3ImcKRy4IGwJH9D63or6Hel2MxAplsGP+f
	 mG8aXZSaQa0oXEOF5iTA4Gp7U6sm3iKq7giTkVjbHnna2mbVbRTD4sLGaW5Bz5pHdN
	 tzDA9ywNbNcp8v6QDjB5DNHq8jgbwzgFNXi1GjCWTSwjVWgTUJZgqhCDgjh+oI8/8K
	 OjVcFdOdFOr2ZJLJZm/N5r3gUUMTpvaXk24rE6jQmQOHIb1LeaNQzQ5BpePiXQt/kS
	 FR2uBXeEkM4Rg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:44:58 +0200
Subject: [PATCH v2 03/14] rust: str: introduce `NullBorrowFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org>
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
In-Reply-To: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Tc69NpZsnd7U7OJBUvDg6vLnyx/YuYb6KbZ5n87FHyw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVDxefYaaw1FyQfRThv9Lp6u74GZ80xXa9hq
 cLhVemmuAKJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11QwAKCRDhuBo+eShj
 d7yBEACOHt07/pNgojf/PNidcBKq3qj6UG5iv6qDOtFuv8W9FNsqcAHX80ECtElLNo228irDdRr
 yze/AkN6NmpOorqMAvQArEXc3BEJktLlcz311J2/5Uhy/QeDdj4TVEmKd0LgmMWAOTQjNXvn7CM
 /8gIwtBT4YEti/wodwpcPXvlH0Hv5se0tKrI6iWlbsiKSVpsGKjeZ8DBOld8hLr1R70spQIzjHr
 nlHrk2AJQIbyAkSB5lPwZvOUinecnYVF7H5Eqp0rNRyWyEne8f30Pwr6jAab7EtT4Djsw8FT4+K
 7/GcIkiThHIL2oMO4E6ePHv0vIT8zuZLpUogsjs27rm8Q/R3GLTPwn6wyfQ4Bv9inpVhnyVxuyO
 W5uBis0EoGwCB2Rmzo4ez5pwwPUOlnddK0dAfqwKw436NfTbow7uKybgcSTAmvzrPg6sikI0m2v
 qcRePKupl0cKhYhn//VF7wrC6F2HP1UIaXgXRbYEBpHPb0fuQFx3qR+UgxKC1UQlgDQXFwwhIw1
 w2gP3uF7vpIJ4itxVkNNIkWTP8lq3OT5xQdS1SOmehBVJQXv2taq+7yHrgvemW73C5+QJ+BImgY
 R9iGBu253bPoRQRVUFTXWER5h8SmtADRwj/u1AEwLhi4wIHZLwhFTBVtjcPfND+k/IUY9wXOfiq
 kpIW6gLj5CEAC4Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `NullBorrowFormatter`, a formatter that writes a null terminated string
to an array or slice buffer. Because this type needs to manage the trailing
null marker, the existing formatters cannot be used to implement this type.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 78b2f95eb3171..05d79cf40c201 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -860,6 +860,65 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     }
 }
 
+/// A mutable reference to a byte buffer where a string can be written into.
+///
+/// The buffer will be automatically null terminated after the last written character.
+///
+/// # Invariants
+///
+/// `buffer` is always null terminated.
+pub(crate) struct NullBorrowFormatter<'a> {
+    buffer: &'a mut [u8],
+    pos: usize,
+}
+
+impl<'a> NullBorrowFormatter<'a> {
+    /// Create a new [`Self`] instance.
+    pub(crate) fn new(buffer: &'a mut [u8]) -> Result<NullBorrowFormatter<'a>> {
+        *(buffer.first_mut().ok_or(EINVAL)?) = 0;
+
+        // INVARIANT: We null terminated the buffer above.
+        Ok(Self { buffer, pos: 0 })
+    }
+
+    #[expect(dead_code)]
+    pub(crate) fn from_array<const N: usize>(
+        a: &'a mut [crate::ffi::c_char; N],
+    ) -> Result<NullBorrowFormatter<'a>> {
+        Self::new(
+            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
+            // at least `N` bytes.
+            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
+        )
+    }
+
+    /// Return the position of the write pointer in the underlying buffer.
+    #[expect(dead_code)]
+    pub(crate) fn pos(&self) -> usize {
+        self.pos
+    }
+}
+
+impl Write for NullBorrowFormatter<'_> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+
+        // We want space for a null terminator
+        if self.pos + len > self.buffer.len() - 1 {
+            return Err(fmt::Error);
+        }
+
+        self.buffer[self.pos..self.pos + len].copy_from_slice(bytes);
+        self.pos += len;
+
+        // INVARIANT: The buffer is null terminated.
+        self.buffer[self.pos] = 0;
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


