Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA8217659;
	Sun, 15 Feb 2026 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198889; cv=none; b=aJo1lJSphomtDID0qsaRpFtWecfDSUsqtY3ewp2JeQWGf/YyIRWPvG881TyXyIPagPfdC4kcAaXNC0B/J2t4zXEfhzwYMWLhDwohFdLRzv9NK19TcmCJh+Jl9AKppouOGSpgqRs50MyHGdrTxDPcPXp9Xikw424gKtHK2Mlq4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198889; c=relaxed/simple;
	bh=vHPgpZo5uXgA8zL+qju/AiVs11m7b10tJPDeLW3U++M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gm6cuXLFa+LDeFGiJvsaoowQhsNFVkOK9e3R6THQT5Ui8Z+ORP0ImDnk//Dehl/sH4gdvXC1BzKcNRZBwl/QELZ16zFUM0Hhdx2tFMEAHqqaqs2ZVQr/4HBVo81+X2PrCyz4gU5O6+gk83S+11LwY4kWwZVqEKImr0R4jE08RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6gN1JoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6gN1JoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F001DC4CEF7;
	Sun, 15 Feb 2026 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198889;
	bh=vHPgpZo5uXgA8zL+qju/AiVs11m7b10tJPDeLW3U++M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P6gN1JoYAil+b2m0a49hptXFxRbU6gEBpaZDLQpGcmkMNRl+ts2wQ9IGltjdaNsE2
	 iHtDP2IDj3SmgZ54TEEtWor4vbjebwuI/6hFw19GH6mKDkyZ5/MgUHV6fb4GGfNk0a
	 xj/p1b2YXIqEcyrLvelc5oC9oRgPZ0LqRgbsXEi4sBF0DJGBovK/t4K8s573ejI5Yl
	 BcQmzROO/AjjnmLo/yornM1A4/oLXUgDFODgqyKCOCTkPW6JlVFoWEiiKGUapcH0oY
	 rpAnGQKoWtCLZMIMHJTEW7jK9xXoDyS/WNUfFbAo1Qy+oAlVBeNulHMiJKsExOCnIS
	 uL0Uz256tvb6Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:54 +0100
Subject: [PATCH 67/79] block: rust: remove the `is_poll` parameter from
 `queue_rq`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-67-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=vHPgpZo5uXgA8zL+qju/AiVs11m7b10tJPDeLW3U++M=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhY2K0RYlJtYPGe5XGp2aD/s5dSMAoJeH2Oq
 zb/CAzQM5GJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYWAAKCRDhuBo+eShj
 d04tD/97m54PJ4Emn0i+4TXowMxdpppLVqZy2LiOwftpAsi23l98iD5eWe6aKOpyCgEHEXyfl5g
 Wq1XPUnTt8oQHgE4tpBPLAz8pzNke4DqN/w9WpvKODlITv3lJETQ3zHs4n91c3xL+ROO3F0W5OR
 w4v1vVMgv8hBmLr/8I4xlPGkyDWtkgEDjOGfqpRRvZBz27n4zfgkdT5ZPhHpjr8R2BteEGWu7v9
 R9iax5z1Wt+Sayzq7xXtL0uvd9Rs9Z5HW1nJpNllcV3yh36PdFibMYsi43OhC/kS8geCMoUY6m5
 lYDSHBw06dwiSzX2ZqIluikI9wtwZficu8hOzUeX8BIgidJNVZCFIfsDsDpyJSEnIFJJR49FX9H
 bBdURz9wVMzYy1AillTxxBKXbevqVQNEI1x+TzT9bEte0o1sLcriZZJVafiNVPGUoFXxAxcWQbJ
 kwTJdtofcJM26rXiDwYwOio1SO/9gpryZjduJrumk4x5OiVIvO/NS1pFuGBRDyEf71kkpz0yo18
 TUS3kp81o1NS4kZOad6+f83YVFW2gh5mZNfhbjWDin8MUToyhBJI483FD1Id4cNXA9pwr+HW0X7
 Vs/2kVPNqx5hQkKx8DpD/90WbWKLxxAMtD0qnsB4mF7+s3zzBTrn+N7v5HNwGUCHpstS68xrxTN
 cm8xLRqjLYfocmw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The information can now be obtained from `Request::is_poll`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       | 1 -
 rust/kernel/block/mq.rs            | 1 -
 rust/kernel/block/mq/operations.rs | 7 -------
 3 files changed, 9 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 592fbf5790fd2..db856f03b78cb 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -907,7 +907,6 @@ fn queue_rq(
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         is_last: bool,
-        _is_poll: bool,
     ) -> BlkResult {
         Ok(Self::queue_rq_internal(hw_data, this, rq, is_last)?)
     }
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 786c32f2cb56c..02d75acfddb3b 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -90,7 +90,6 @@
 //!         _queue_data: (),
 //!         rq: Owned<IdleRequest<Self>>,
 //!         _is_last: bool,
-//!         is_poll: bool
 //!     ) -> BlkResult {
 //!         rq.start().end_ok();
 //!         Ok(())
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index e4de6db807e18..efead98767196 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -67,7 +67,6 @@ fn queue_rq(
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<IdleRequest<Self>>,
         is_last: bool,
-        is_poll: bool,
     ) -> BlkResult;
 
     /// Called by the kernel to queue a list of requests with the driver.
@@ -188,11 +187,6 @@ impl<T: Operations> OperationsVTable<T> {
         // `into_foreign` in `Self::init_hctx_callback`.
         let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
 
-        let is_poll = u32::from(
-            // SAFETY: `hctx` is valid as required by this function.
-            unsafe { (*hctx).type_ },
-        ) == bindings::hctx_type_HCTX_TYPE_POLL;
-
         // SAFETY: `hctx` is valid as required by this function.
         let queue_data = unsafe { (*(*hctx).queue).queuedata };
 
@@ -209,7 +203,6 @@ impl<T: Operations> OperationsVTable<T> {
             // SAFETY: `bd` is valid as required by the safety requirement for
             // this function.
             unsafe { (*bd).last },
-            is_poll,
         );
 
         if let Err(e) = ret {

-- 
2.51.2


