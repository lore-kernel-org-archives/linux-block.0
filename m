Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABEE406073;
	Tue,  9 Jun 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032630; cv=none; b=lfincPUne0ya4NEv1JiSLYSYgqVSvnASOFtN3DmQZUsUUGhe0ZBno2cNElviR+oYC1hzAZPJzH91F6zVqySK+toO3ZqxO3X2jmP/kW32QkfhYviEs9sBLUJ/BcsYqpXDI6SJNef6mjY9YX7reRch6vMlN/8yj6Uy5zPlxG2O+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032630; c=relaxed/simple;
	bh=NIOSFhSPNxZhzeKeGIxP5rwZxvn86AQcjaih/HmSERI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frzpjzAx4UOJ8wSzYt/Tix6Jr0cUK31rk3TJH5QcbzBo3k+2aVrK667EP85TWWA4O5Nen5bZEJQeKH8ZHBk6GKpm7BE5DgbCuzXtu3rv15Xs4sRPwTiarnDKLa2hvk4HMOrKHF3aYpnhnGsZwNNAYeEV2JLG97YNlYMyxfnBp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMBuXHKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMBuXHKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D36D1F00893;
	Tue,  9 Jun 2026 19:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032629;
	bh=WOpj7e1Nhzq+smZTE7xHDrYEYXBQOG4Wg4O9/mQv0/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dMBuXHKj7RBMnrn8vqr8h9A0cqlKkwuGkdYwYlk5HTqvGLjz5KyjqENj1lJ0wBl6c
	 67Koi+t68S/qgWgzIaTGps9fGoTf+rEnGeetWs2XB4tLee1Q29kYYzFkRNke9lZ7TG
	 F2LfbPPnohHoYTJmZxkiXkyIFiUVquvh/atI+hSocOxWAgUREe7//Ydi6jmh+0ZBz9
	 aaSV208dDkez7DyZrzCT1tqrZCdkDFqlfLSQ/puHn434pX159mMhJdG98G5JAAkhEf
	 U/kbPDSxMX7Vz8z/PRNLH2V+XO/7a6gbfCKFZQr2d4k7tQiqyQklJ43UbLiFX3VyS2
	 k+Z8/7PoKuN9Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:20 +0200
Subject: [PATCH v2 41/83] block: rust: introduce `kernel::block::error`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-41-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=NIOSFhSPNxZhzeKeGIxP5rwZxvn86AQcjaih/HmSERI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTZOFzdFIMSshGFudWmfHLuQiMwx6tHAFLj3
 aRHUI8FQHSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk2QAKCRD6UCkIqsW9
 0MT5D/49nDByyphJs16CpsUBJQfuY/Jfg9V9KHly+Mo6HIhh2UrcaH1n80P875Kyz0m+sNCeXu1
 B/QAaoAb35Y/RULsjofHll4JlMDxuYjoE4lppDLn0F2aa5Kz1P9ujoe0arE+dGAh8dxKYicCUSC
 /Q/Iem7dwXnhJSx0gscIiB8w24DN8yA1YqRDuwAMxLKos2HweBg4PqdPbe9IrSdQXlSAATUsDFl
 DtmKEDrI1hfdNsZU+GPNc7c42c+RLfo8kQRrwMZOlg4c/eXjL9wlaWN1ZnD/nsmlYXO5x7cXqzg
 5wET2xLrgxkTFlgvYWJRW/TN6kvOyZhCgEAyIIQ2WFthIPzYwJbrVkKldHIfxyxZdlAaL4HaVcp
 DHnO57hsHbvg0aacNhmxK2VkUhax27Rc2Jl1NNpCGUJNcmmFw9XukCn6G2tP8eZZ6ZTOW68OiPF
 wPW/eB21y1mFa8CP4kXQPHuPPy77RLx3UswOMpYdPhvzZD4dYsCBVnTBFYr3ZdD6+kFJMRE5fII
 8G1eQ2BbBZyhxr/TleLh8MGjjYH9mC9g27dZ7Wfms2y5thH0c0bhyYAW390TAQq7DGsNQmSuiCh
 suf9YEpWUTCcDoJZrvOngWRV6dCPk4KLyjNHSaWoVeVcTzs7mf6u9V3caF9/5j9yB4GMGxrnAO/
 rVeZt73bEmgtG0A==
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
index 96e48a2e6116..b3578f28871a 100644
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
index 05cf869ac090..6dd14a72526f 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -163,8 +163,9 @@ pub fn to_errno(self) -> crate::ffi::c_int {
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


