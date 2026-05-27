Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCF369203;
	Wed, 27 May 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873505; cv=none; b=FXoMTE3WCAxWNPDPXo5xEYN/ybgjaEwLNyBFyiFkfkVyys+i0JzfRv80iUAY2vAMthMPF50/tomLDzJdDg069CNvDYknB21AbsB1uTIrvQ3+WCIaOKvFH/hj/kzL3LOazzSDDvWPCFd8L9q+O13ZR+SpAH4+pNVqfCLG49I3x+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873505; c=relaxed/simple;
	bh=rgZhbhhR+RAOEnRJz24xSBUx9U5HxC9Cz5fDc6PBqJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HyJTx9uUayCMMobQYRimtX11/aaCHDZkXVJwILH5uzbAlq/mSbACaKOOL6FtRMPcXhkSyE95BTZZaiVQU8GZUFkERuGNVi71VkDxKsxa1IPWCrEYBQoQi9kKMF1nkvlfcobLoZs6oTm3op7UitHI5WO+1WRq0ZvwEj0c490+9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MigwV1a7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MigwV1a7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0B61F000E9;
	Wed, 27 May 2026 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873502;
	bh=/YPac6bIzmLQ32+MFukhB9SPsMGBvUW7Fb/NoEiv/oA=;
	h=From:Date:Subject:To:Cc;
	b=MigwV1a7wwknAQ3vZv8A1xEOc7mujvKZJfVyVBMa1aO6RG/gwtmbEX77Z2I2wwNXk
	 H6P2IYZg9HRyOFbXBvsotmPe17SGeAblBExcP8cinhAx3ryqZRNxHZ5CVmrSyKbBRD
	 6DMF8isz+IXsTK0jiJIVVXPhhHcmLum71l9bVo+YssL8NGpngVeq7llQeUfeiB+MjR
	 HE/RCtXCoM2Qh24SzDbEPWXH6LbDzFsWkPY/rWngGAFHryBnPv/wyRmwbZrwYTP0pm
	 kwNgdCAKMdcF6evXfdqrkwfY/2VtNetRbfnIpgp5AeReuNM8Iu+H5+MZetp/yGLHP7
	 GlYIMPQz+uyvQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 27 May 2026 11:18:09 +0200
Subject: [PATCH] rust: block: mq: align init_request numa_node arg with C
 signature
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
X-B4-Tracking: v=1; b=H4sIANC2FmoC/x2NSwrDMAwFrxK0rkAVcT69SukideRGNNhFbkIg5
 O51uhmYWby3QxZTyXCrdjBZNWuKRa6XCvw0xJegjsWBiRty3OJzTv6NIRlG2b54diSHhcxEGAa
 dFxNs6p5a6lzwdQ9l7GMSdPsf3R/H8QN7MAn4eAAAAA==
X-Change-ID: 20260527-block-for-next-2026-05-26-2200-failure-64907085fc49
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

Commit b040a1a4523d ("block: switch numa_node to int in
blk_mq_hw_ctx and init_request") changed the type of the
`numa_node` argument of `blk_mq_ops::init_request` from
`unsigned int` to `int`. Update the Rust callback signature to
match, so that the function item can be coerced to the C fn
pointer type stored in `blk_mq_ops`.

Without this change the Rust block layer fails to build:

  error[E0308]: mismatched types
     --> rust/kernel/block/mq/operations.rs:274:28
      |
  274 |         init_request: Some(Self::init_request_callback),
      |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^
      |                       expected fn pointer, found fn item
      |
      = note: expected fn pointer
                `unsafe extern "C" fn(_, _, _, i32) -> _`
                    found fn item
                `unsafe extern "C" fn(_, _, _, u32) -> _ {...}`

The argument is unused on the Rust side, so this is a pure
type-signature change with no functional impact.

Fixes: b040a1a4523d ("block: switch numa_node to int in blk_mq_hw_ctx and init_request")
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/operations.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c..861903e18fbf 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -218,7 +218,7 @@ impl<T: Operations> OperationsVTable<T> {
         _set: *mut bindings::blk_mq_tag_set,
         rq: *mut bindings::request,
         _hctx_idx: crate::ffi::c_uint,
-        _numa_node: crate::ffi::c_uint,
+        _numa_node: crate::ffi::c_int,
     ) -> crate::ffi::c_int {
         from_result(|| {
             // SAFETY: By the safety requirements of this function, `rq` points

---
base-commit: 27236c051c01c1c1025e0e0d12a107082557e8f1
change-id: 20260527-block-for-next-2026-05-26-2200-failure-64907085fc49

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


