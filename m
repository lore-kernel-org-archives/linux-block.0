Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383B4EBACE;
	Tue, 29 Sep 2026 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674529; cv=none; b=Z2f2lWn96+mTiht9bcwr0mdcQCO2C/MZ3Ztny7eAP9sRghpkLL5AToNcU+IctuMKoc+rXE2I9eMdBJKjIQceHjU/cqy8yAvKgKl78BIZzUfnwc3cnqwOKa7OtcGOsuiV2eFGCE/aaGrhBcgB1eGGJHNM+Y1D5fW8MTPsy1LhoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674529; c=relaxed/simple;
	bh=Z7OUl0i3sQjUAEjfw/wqD+5KyPrzC+Wsx0yvEh/ojj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwO58vncmjg1cHeAFN9h5yhcPomD3JPKd+f4n+kO0lXV1FXGYs7OBvyrQlTrJM0kuuocw6lstSafRGJH4o/dKiRR0WhTT7TRQN4hO0zHTSO/AWPPjs+K+1BAPi93e+B1TnsJPk9oYqxOr14niYiX9z9htoN1NjrwI1rG0tWpveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL0CbQWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL0CbQWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAEB1F000FF;
	Tue, 29 Sep 2026 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674528;
	bh=iXQX/3BOXog90H/JA/iMJeB0KGRyY6MIEgBbTemEc4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OL0CbQWC4RaPqvZBOgB6FmNxcd5H+StE/d4KLii7Ms1jn7WkorTDNsUmKxR81V7rS
	 6hlmwzSWzLhRznrwDd6rN7e6qNlzrr5ctc/wTeebYaU8Ptmur514gw8lQuJdsL/xIG
	 qHawCSR57oA1oS2Lje/upq2mjTBRjiblVvHK2s0Rz2KRglz3gfhpw5pf7YYK1BXwiM
	 2kLf77j1iU8lVkKZxK2aSyKUkQcTD2adkCQ/AfDxlSfqIYZMtz/zu5/Q65Hu+v6+zS
	 GTxFy//P24I93fWZAiiTo5UEIVX8nscMH24BcTiW4y59u2OGHB5RoGyCgC/t2ma4nC
	 gNFt2TqXZGR8A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:04 +0200
Subject: [PATCH GIT PULL 6/9] rust: block: Fix GenDiskBuilder block size
 documentation
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-6-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sophon Z <aiqubits@hotmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xaD5icldS7wuJjjC0NYH7OGfajVxqDa5UZX0hR7MjwM=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YYq6/CVvVznPzMv/eSPkUOg73YjcBJPkEIV
 T/p4yXw/42JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGGAAKCRD6UCkIqsW9
 0KkgD/9P3wNKSPUuYti/7N2O+WorLYOrHCQvTTVDRbtJ/EL7TvhQoXUN/f3wWacKqAlenVH0IHh
 8Ts2182e4S/lJxUAHuLMGmRgU+u4X4P5JFjsFWBUQBOYK8vtc+Chz6IirSWNI8kYhoawZdiRSFu
 QEuOoh2mDGh1ucN9I5c3Evkc9isQOUyrQWfK/Pk6l5FKt9VDITbf6iS0gP1ykY43IyWe1tkTNdR
 KobCgLX66U0wWRxWMbzvG9AvPZt7mcROLcRHcd+0XaNuSZHwEVzMJ9iFBtZHJBHYzMXeW4kOLbV
 kJxOqtBeWMBER0A5oACxV51KIG2BafIUeSM1t0kMbvQXOODrk38Lvc7Uci2djpjVvGgFbRnpxLR
 5iWWFdhUWuvGJGb/AfuX8dSURQjL3yRFU5IvsG489y6H5erBFg22/GAIA+B5sXeb5nbViRj7Rf7
 grsTAVsJVTJSd9yfK8IAUGUvbGt5iUya5xzWX1mL6UGdpGE2dficNFA+2utBONVt31kq6V8D181
 XdLLu3/Jeb4LGD1eomMxKveBz73w7/P/LpsEvpnycQbjhrUTFlwkY2F7QqWbAYE6Pv/txomkGSk
 g7C/Cpav5JNh/TYxj8WCenGHky2ZDMDcE3u1HPTXJ5AzWo8oBB+qOgWl1/AO23Wh8Ph3Rgc0pn1
 1+70EysjwuaM9lw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Sophon Z <aiqubits@hotmail.com>

GenDiskBuilder::validate_block_size() accepts powers of two from 512
through PAGE_SIZE, but the documentation for logical_block_size() and
physical_block_size() states that the maximum is 4096.

Use PAGE_SIZE for both documented upper bounds so that the documentation
matches validation on architectures with larger page sizes.

Signed-off-by: Sophon Z <aiqubits@hotmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://msgid.link/20260831-fix-gendisk-block-size-docs-v1-1-900546005799@hotmail.com
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 90d364ab3bf2..0fe640f3aec6 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -75,7 +75,7 @@ pub fn validate_block_size(size: u32) -> Result {
     /// Set the logical block size of the device to be built.
     ///
     /// This method will check that block size is a power of two and between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
+    /// and `PAGE_SIZE`. If not, an error is returned and the block size is not set.
     ///
     /// This is the smallest unit the storage device can address. It is
     /// typically 4096 bytes.
@@ -88,7 +88,7 @@ pub fn logical_block_size(mut self, block_size: u32) -> Result<Self> {
     /// Set the physical block size of the device to be built.
     ///
     /// This method will check that block size is a power of two and between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
+    /// and `PAGE_SIZE`. If not, an error is returned and the block size is not set.
     ///
     /// This is the smallest unit a physical storage device can write
     /// atomically. It is usually the same as the logical block size but may be

-- 
2.54.0


