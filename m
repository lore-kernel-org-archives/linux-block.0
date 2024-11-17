Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7C8831;
	Sun, 17 Nov 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731856310; cv=none; b=iwgwxOh69tWBA4Sc/ZMcAD/q24b7PT5bH8h0M1aoy0PnvVCqk/nkn11k/GjkmXZdsYXIsyme9Te7nL/VcpjNAYhIymiuvyrLiOflto2PUJMX2v+K8HH/uyEGTpWjL7m0pHKmueX+yS4OPbWNTGV0jx/3xDlAsvjzWYiLqUweV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731856310; c=relaxed/simple;
	bh=YoWEgbjfpT0pRKmM5sLM3OnhUgtNHURpAF5a1fG7oDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J/nGchVtusGuiLxHruCY2CcWGqWFNhN/EvvZSHjgmsbsDYc3RtP8nyN4ULmtaoRAR89OICicrayUvU4cwRCXI9Ftp/gJXpM/8IAMcFzCt4g7a5DDPEsRXuq7hPoJ/oYyhkpB3j2miT4bQCjH/oYBfkPtMQuP6fwFvTZe/JWjEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3N+T/Vs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3N+T/Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69DB0C4CECD;
	Sun, 17 Nov 2024 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731856309;
	bh=YoWEgbjfpT0pRKmM5sLM3OnhUgtNHURpAF5a1fG7oDs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=E3N+T/Vs1LKBInl2ZXVI2j7Y1XIEiy3wAHvkLbMOkWst2Jsv0VjBfHu7BnIH2XFuH
	 s09dnZ5QzmNf7OH+zXAGztFzgpUAXASstIgtIlEPHl58miSuq2iu4IJPGoOgKouPoY
	 R37/pCb4ugofjQTdfZFwBtCNA6m0ne9QoZMsnbbkI41vR+L7FTIjq5as1rj5ek0nIC
	 aTY88Hwwx7ZmdDt9+Pj2FIyT8CiXlqTykOZaPnT2nulvqSksN0aiFaxvaEVXfp6TAr
	 C45hcOUXdd/bH9yYgNlO0d3tGHxob5S5ldyMOYobN7a1ez9uh6R6OMxqWv9KdqeOFC
	 ge1TSPp2eY93g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14BD68BEF;
	Sun, 17 Nov 2024 15:11:49 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Sun, 17 Nov 2024 20:41:47 +0530
Subject: [PATCH] rust: simplify Result<()> uses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIALIHOmcC/x3MQQqAIBBA0avIrBM0grKrRAuxsQbKwqkoxLsnL
 d/i/wSMkZChFwki3sS0hwJdCXCLDTNKmoqhVnWjtW4l03as5F8Zka/1lM5OprNeGeUMlOqI6On
 5j8OY8weuNWvsYQAAAA==
X-Change-ID: 20241117-simplify-result-cad98af090c9
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731856307; l=3582;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=9wh8APnbE+xtYBBHViec799odh7ToNYbNtboBILuiv4=;
 b=KwKDJLX1CAhKLCiNJsRH41q4RnVX6JT2IaF2iIN5gA1wqesEONanU83urTsIDlPG8AdssXWZ4
 jXKYUpk51h+ByiaQUvylhQUgWs6/9BfIElhdayxeAi1xSAwLjz9xKIc
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

This patch replaces `Result<()>` with `Result`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1128
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
 drivers/net/phy/qt2025.rs        | 2 +-
 rust/kernel/block/mq/gen_disk.rs | 2 +-
 rust/kernel/uaccess.rs           | 2 +-
 rust/macros/lib.rs               | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..25c12a02baa255d3d5952e729a890b3ccfe78606 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -39,7 +39,7 @@ impl Driver for PhyQT2025 {
     const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
-    fn probe(dev: &mut phy::Device) -> Result<()> {
+    fn probe(dev: &mut phy::Device) -> Result {
         // Check the hardware revision code.
         // Only 0x3b works with this driver and firmware.
         let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 708125dce96a934f32caab44d5e6cff14c4321a9..798c4ae0bdedd58221b5851a630c0e1052e0face 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -45,7 +45,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {
 
     /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
     /// and that it is a power of two.
-    fn validate_block_size(size: u32) -> Result<()> {
+    fn validate_block_size(size: u32) -> Result {
         if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
             Err(error::code::EINVAL)
         } else {
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 05b0b8d13b10da731af62be03e1c2c13ced3f706..7c21304344ccd943816e38119a5be2ccf8d8e154 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -49,7 +49,7 @@
 /// use kernel::error::Result;
 /// use kernel::uaccess::{UserPtr, UserSlice};
 ///
-/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
+/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result {
 ///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
 ///
 ///     let mut buf = KVec::new();
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 4ab94e44adfe3206faad159e81417ea41a35815b..463920353ca9c408f5d69e2626c13a173bae98d7 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -144,11 +144,11 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// // Declares a `#[vtable]` trait
 /// #[vtable]
 /// pub trait Operations: Send + Sync + Sized {
-///     fn foo(&self) -> Result<()> {
+///     fn foo(&self) -> Result {
 ///         kernel::build_error(VTABLE_DEFAULT_ERROR)
 ///     }
 ///
-///     fn bar(&self) -> Result<()> {
+///     fn bar(&self) -> Result {
 ///         kernel::build_error(VTABLE_DEFAULT_ERROR)
 ///     }
 /// }
@@ -158,7 +158,7 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// // Implements the `#[vtable]` trait
 /// #[vtable]
 /// impl Operations for Foo {
-///     fn foo(&self) -> Result<()> {
+///     fn foo(&self) -> Result {
 /// #        Err(EINVAL)
 ///         // ...
 ///     }

---
base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
change-id: 20241117-simplify-result-cad98af090c9

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>


