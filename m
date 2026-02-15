Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67973101D2;
	Sun, 15 Feb 2026 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199136; cv=none; b=gYJl9zqeaiXo0cWEjXl9b1eCNHERdYVPWv9+RpFNYlr8hclDF9eEmwzEA+4QDpR/9HeSRAuFaWmzQ4SXokDPcWqDt4i5yMByWFPMuhNYRXXo7ZnFHHeCHsgx0DmlJIyRGCtuA/Xne3dixOOx1zLaBCaZE4vEPRlsQsRVFnYlYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199136; c=relaxed/simple;
	bh=eqqiqphigEUutWAOj4Ax0TLofmOBmjKS7MiYG2xrZGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhRIhH4yXbI5FjiPQxaxisqcTLPuzzPe7rAKI7ATrZKplVKRRCkNCtcARXJD3I9MuCwRlrcBc+lscWNvEJJZCq8U7WiCKPJGqj089nPJY/oU0U/442Elrz64cj2DoZEdUw3RT1ZbrfuusUV+MNtFliPk6kS2c9jNclUnYSBtuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXkyxUVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXkyxUVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F62C4CEF7;
	Sun, 15 Feb 2026 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199135;
	bh=eqqiqphigEUutWAOj4Ax0TLofmOBmjKS7MiYG2xrZGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PXkyxUVaJ59UKvQfextkryIKOLnj0O7g6KlrZmEkei4tuELxuOVRJCDq31Hg5833h
	 BQZjppCaKVSsRTdhzVgrz1pOTRkTpNb77Mp5u7MeVo582ftkRUXFAY4QCCjbMPMis1
	 kcrLlapeozPYfWMfHq72Y1NB7LYak5RLftIk0l21qISB5etNhRrh70D92+KyzXadlf
	 tulp0rVMhXnKWttVpro5dbBXp2dRY1R/zp63D7thp81nm1NZJ8xQbr9lMb83zl+hnJ
	 gWx0R0QpQeKOQkI2VsiU8X9LPRc20qQ/NjBE1/+T/f9lMsLNe2qQgK4bpEgCJgZ9FU
	 1/uEUke51zOFA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:24 +0100
Subject: [PATCH 37/79] block: rust: introduce `kernel::block::error`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-37-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4556; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=eqqiqphigEUutWAOj4Ax0TLofmOBmjKS7MiYG2xrZGY=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg9tsnSUeN3yuufEKi8gZGkENrakAQdsa/jp
 G2Ne5eHOG2JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYPQAKCRDhuBo+eShj
 d7ukEADC7oEHfidFv4Xqhl5gUwo5O6pu+bHLU0Tu2FJlcKY5YpbZ5TMIvBIacDygyfwKE/Nxod1
 ARcqIZt+gw+56hZchaZ/GBevkPBlChGWVFJ7TJdQA10U4hO4QoAExHS4Uf5Ko3A0b1AmaAPVMyT
 tJPE66g4mwJqH1y1N2v7liZoXYPNHc4P28xlKJUqZ8n4qfsWTMU2Rb9gEaOwabJaG0CNUR4Q2TN
 eoy6OxN3spvtReYPPzv25J8YqzD5Sz41ecJU27n825TPm9OfSeNbUOk/nZbUS0mvb3NxVCahHd+
 +mEq7rMoIaZ2W7/TkSPCS2zX8dd1yxHBHkXq/bbKARJy290YKNld8UgerTLX5SO8jtuebAdYbWd
 tyf8pXVkLWqI9JKAWvKBjV1bPWLbZ1crOE2j4AMFd4ad/WZofR73hdC/Dh8ZNP1Xv1MOj9FVGXN
 16oVuTZAAN/bekoR+h8JK7BCH077LuvnGPwe/zorwq9YdRnaTDG/GAR0iNrHnV1gCT1H5GpJcFZ
 gcDiujYahpCQoBSBE16JRIcFLghvHmmg3dM5jDOkvKEu2vwr16G0asEFF/E9C6cLmtGG6ucWWR8
 Apy7OwXG9VmOmEoRnLGaAmZiEvupDEJ+sUbOm94GpvmfBSJvVOJ6tWUpNiKVE+8WHa9zKJAiedX
 aT8eYCeB0te7iaw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Block layer status codes, represented by `blk_status_t`, are only one
byte. This is different from the general kernel error codes.

Add `BlkError` and `BlkResult` to handle these status codes.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/error.rs |  3 +-
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 19236ab95227b..6cd83dc75a5eb 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -18,3 +18,97 @@
 /// The difference between the size of a page and the size of a sector,
 /// expressed as a power of two.
 pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;
+
+pub mod error {
+    //! Block layer errors.
+
+    use core::num::NonZeroU8;
+
+    pub mod code {
+        //! C compatible error codes for the block subsystem.
+        macro_rules! declare_err {
+            ($err:tt $(,)? $($doc:expr),+) => {
+                $(
+                    #[doc = $doc]
+                )*
+                    pub const $err: super::BlkError =
+                    match super::BlkError::try_from_blk_status(crate::bindings::$err as u8) {
+                        Some(err) => err,
+                        None => panic!("Invalid errno in `declare_err!`"),
+                    };
+            };
+        }
+
+        declare_err!(BLK_STS_NOTSUPP, "Operation not supported.");
+        declare_err!(BLK_STS_IOERR, "Generic IO error.");
+        declare_err!(BLK_STS_DEV_RESOURCE, "Device resource busy. Retry later.");
+    }
+
+    /// A wrapper around a 1 byte block layer error code.
+    #[derive(Clone, Copy, PartialEq, Eq)]
+    pub struct BlkError(NonZeroU8);
+
+    impl BlkError {
+        /// Create a [`BlkError`] from a `blk_status_t`.
+        ///
+        /// If the code is not know, this function will warn and return [`code::BLK_STS_IOERR`].
+        pub fn from_blk_status(status: bindings::blk_status_t) -> Self {
+            if let Some(error) = Self::try_from_blk_status(status) {
+                error
+            } else {
+                kernel::pr_warn!("Attempted to create `BlkError` from invalid value");
+                code::BLK_STS_IOERR
+            }
+        }
+
+        /// Convert `Self` to the underlying type.
+        pub fn to_blk_status(self) -> bindings::blk_status_t {
+            self.0.into()
+        }
+
+        /// Try to create a `Self` form a `blk_status_t`.
+        ///
+        /// Returns `None` if the conversion fails.
+        const fn try_from_blk_status(errno: bindings::blk_status_t) -> Option<Self> {
+            if errno == 0 {
+                None
+            } else {
+                Some(BlkError(
+                    // SAFETY: We just checked that `errno`is nonzero.
+                    unsafe { NonZeroU8::new_unchecked(errno) },
+                ))
+            }
+        }
+    }
+
+    impl From<BlkError> for u8 {
+        fn from(value: BlkError) -> Self {
+            value.0.into()
+        }
+    }
+
+    impl From<BlkError> for u32 {
+        fn from(value: BlkError) -> Self {
+            let value: u8 = value.0.into();
+            value.into()
+        }
+    }
+
+    impl From<kernel::error::Error> for BlkError {
+        fn from(_value: kernel::error::Error) -> Self {
+            code::BLK_STS_IOERR
+        }
+    }
+
+    /// A result with a [`BlkError`] error type.
+    pub type BlkResult<T = ()> = Result<T, BlkError>;
+
+    /// Convert a `blk_status_t` to a `BlkResult`.
+    pub fn to_result(status: bindings::blk_status_t) -> BlkResult {
+        if status == bindings::BLK_STS_OK {
+            Ok(())
+        } else {
+            Err(BlkError::from_blk_status(status))
+        }
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 258b12afdcba3..e656465010d6c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -162,8 +162,9 @@ pub fn to_errno(self) -> crate::ffi::c_int {
         self.0.get()
     }
 
+    /// Convert a generic kernel error to a block layer error.
     #[cfg(CONFIG_BLOCK)]
-    pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
+    pub fn to_blk_status(self) -> bindings::blk_status_t {
         // SAFETY: `self.0` is a valid error due to its invariant.
         unsafe { bindings::errno_to_blk_status(self.0.get()) }
     }

-- 
2.51.2


