Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0C2D77E3;
	Sun, 15 Feb 2026 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198938; cv=none; b=uOoncBX13dyJNZNvzlN5lSlmT7pu8N71u74Ukw58XCPwjUc1RS6c5iyq8k/qr0488017DlJUs55h1hQ0keP6szoe0awCDB5LX/vCp2ZpoMU10/DSFkFNQVsKtSdD5Wepjumh6zBSSsD5wbxKotBFvfUD53KWtqBktNxr0m/jzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198938; c=relaxed/simple;
	bh=6LAOeUSwUtS+ZAfhWOk/dU6VGMrvdfMVJxYHu0ElVWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dv8jjiaRCkTa1bdupKS7x9jGS6bNf9Fb/U28l5uiaZ+K5i0kDUBf3cr9DMNfLe7VBTU8O9T7nhO8D6ZFb67dYFH5D4jLbHXj75q7Tm6ujq7bHY1npy7HDvkzDSOw8AWQtWJSeMNZdbbL9klYo6U6t8k9A9MqXMj87YofMKpK8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcb1swnd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcb1swnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350C8C4CEF7;
	Sun, 15 Feb 2026 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198938;
	bh=6LAOeUSwUtS+ZAfhWOk/dU6VGMrvdfMVJxYHu0ElVWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kcb1swndbwEz60aKfQ99++Rx9ZSn4aB6GXhSvIWTAtBLl+Gei2BTtnc0kzm3a7S0/
	 ZEFK3Z/FEEJBNBU/1853eTcF1/WaLL5LIzC5aL/DY5xSwYWNBVPmfhSlCsa7L1g0EA
	 s2M9buM51ruySlwcLy82Ty4vaqCXrRc2Xd165o0hXHjbsqBwLpRYRbo4NUcyAa+zTG
	 IOrz5tLX6DqRxU90SXXemi3PAyj1TiSpW2Bc1cdQUy13U9B+Iooibo5xtPJGa/hlyx
	 krgIJqFyXDL+10P2EqvACbuSXgjkgWocQEBfYfbfLy+N+Xny7G/B4I4dNE8+ax/k7t
	 ZIJOiPjGtEneg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:06 +0100
Subject: [PATCH 19/79] block: rust: mq: add max_hw_discard_sectors support
 to GenDiskBuilder
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-19-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6LAOeUSwUtS+ZAfhWOk/dU6VGMrvdfMVJxYHu0ElVWg=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgtNy3HVqeMKx/bZtfhBvhyhrqQKDLf+61b+
 q5GOgtGnQCJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYLQAKCRDhuBo+eShj
 d9IBEADCxuBV98p4EeEhXjdQG5XWMxSpvLsVbj3M0E2kKiIwcrxpa9AJxkVUursKhIi9rUDxdXd
 NGWZ8HSlmyqls7Y3hpUwFYndcQuW4nxAIZWt42FirgHrX0NCX16lx5I5/+eo+IiCe4ccRoHMgEq
 01JXhX/piAGvhuN76Mw1mnLR5cum7zQp7ycaIRJ4K4/UMpTsEF3OfLWykGYO5K0WPyk+KEbqEm9
 sgiwnrbXmxW/bSIdx/1FPpb3hBkpCM2zn63p7d5iA80VcNj7gIlcujiu0fHe1Y1ReypylwCgQzs
 P1D7ypmft0pyj6sUvKE3DpC5IP5Mw4drtUI1vuNg3gA4679X3QodH4030qzOSKOZc365A865dmg
 GfRFkfTBC+7EpHTNS5k5/Yxjv9Gm3kF86NLFSsIKsceTL94/dhP3rKEwbkzqG6HmyS7Bv/kF0RB
 5QkWfbIieVe+VA5YZz8BywbkcyjaDfWQG7QKSXjZywbVUM/iU6+1Mw/RCtFmSaB8sNcGTKLIQ+H
 9ECe9/cLh7S9dHdjxSGMNER1PxwGSyywJRieit8ZRWY1dplVI1K+zBzDgYH9mNOTOSODhSau8rs
 gpAckvS/+VSaabzfijTBrBxcN45a6FbRcjIFeDm1mzmlEjyk1hONveYVeINnK3BBzTQXtb3VABW
 l0QslnlC7NVHN2g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for configuring the maximum hardware discard sectors
through GenDiskBuilder. This allows block devices to specify their
discard/trim capabilities.

Setting this value to 0 (the default) indicates that discard is not
supported by the device. Non-zero values specify the maximum number
of sectors that can be discarded in a single operation.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 1ce815c8cdab0..75968d6a57639 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -25,6 +25,7 @@ pub struct GenDiskBuilder {
     logical_block_size: u32,
     physical_block_size: u32,
     capacity_sectors: u64,
+    max_hw_discard_sectors: u32,
 }
 
 impl Default for GenDiskBuilder {
@@ -34,6 +35,7 @@ fn default() -> Self {
             logical_block_size: bindings::PAGE_SIZE as u32,
             physical_block_size: bindings::PAGE_SIZE as u32,
             capacity_sectors: 0,
+            max_hw_discard_sectors: 0,
         }
     }
 }
@@ -94,6 +96,16 @@ pub fn capacity_sectors(mut self, capacity: u64) -> Self {
         self
     }
 
+    /// Set the maximum amount of sectors the underlying hardware device can
+    /// discard/trim in a single operation.
+    ///
+    /// Setting 0 (default) here will cause the disk to report discard not
+    /// supported.
+    pub fn max_hw_discard_sectors(mut self, max_hw_discard_sectors: u32) -> Self {
+        self.max_hw_discard_sectors = max_hw_discard_sectors;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build<T: Operations>(
         self,
@@ -112,6 +124,7 @@ pub fn build<T: Operations>(
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
+        lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         if self.rotational {
             lim.features = bindings::BLK_FEAT_ROTATIONAL;
         }

-- 
2.51.2


