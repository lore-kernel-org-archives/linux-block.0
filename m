Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04340AD8B;
	Tue,  9 Jun 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032672; cv=none; b=mrqqV5oAJp3xaW7W/V5w1b8vN2+5CZHSN7YwxS6YnVwYMp6CfB8PpzAYBWa5KnfecPTZRtiaRwgXsBLK4hDH+Hz+gcCN/HNlMlhBKaiinMsMblhRuaNszYVFFXmrXM3QtUpGWbauX8bClMmZlxutMBplS9L/gx4T0eAxqcDKJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032672; c=relaxed/simple;
	bh=xd/altTiEmLts+ET/xrl2RTBlfY83eAmYmlDKop0Y4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4H5F+/GUyM+0P1piDFkq5y7hiWrKp4WMNgyXuuaKKj6y6Q5uYE+xLJAcZ1A0u58arLiP2JNzj+LoYZMw3f9bPyM/xDy0MtbLSGD9QHWCvDdY4ast0uenVm/rvF6WevQ2jWCrWkf6yDE0TtTKqhc2Oh9wBEpF0GDvHOqeTthf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOpkIGy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOpkIGy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A021F00893;
	Tue,  9 Jun 2026 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032671;
	bh=dAPErZub35CZRx6cRiD4tDxfNHqt4EuvLpyZZOzwYBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BOpkIGy0vWKfnVPuc32W+RgiwQEKWwVFlLjhaG3yLag7kuk3JZrioSTHUZazNEX9V
	 UYOWlrhQf01weTRZYF+AWKbbC8q2gM+G5u15fl51lLINl16hXrFlqkS7lgNRODpgE+
	 nOTTpXBhf+f30wu/FazulF8lUv3UGupacuXC1k9KlNDZH2AvDBjxupV1PZz/0LgBg5
	 UNxNy0Uaflf3dLD4ei4zWmAUPXm2HYky5KcP5wgkS0qfxeMAvZ4DuIdECWQL9Iic1z
	 cVDdL7uFG8iWEaAuzUCLfzeslTJtOUcRK8AvbyKyzUS8/RUKHTTAkfYS5iPQcz5zLa
	 IMb36Yp7Os6eA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:50 +0200
Subject: [PATCH v2 71/83] block: rust: remove the `is_poll` parameter from
 `queue_rq`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-71-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xd/altTiEmLts+ET/xrl2RTBlfY83eAmYmlDKop0Y4U=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT027BJxlk5QPCxItS21m2vrFHxGANnDAgd3
 IbcDwh3OPWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk9AAKCRD6UCkIqsW9
 0LF9D/923dP0veZGR2zfMjDu/gMAkrMiM1R4hyi+SVGsVcewgN1D1luGHrk+H6j9V9TNVrzS3m6
 gAu8+oplAnEp2FcSumoCdp/D73QHljzxq14myEC0wZOTOWbipS6Luej/4wgrDTMJO+UdnzdaRAG
 tKWS5Rw8c55Far19Gncm90UVqlxCq9AoO48teIcKl1MVaXKxWKoIwLh9ditcZ/Qg+S/JHr2SFGm
 POz0yCG2RJFhL/2heewf+s22ZeNWiUR6MaamuAMoylXhwM91kP9LpEm8uFYPqU7ouq9olV85igQ
 H8j8K2posTmlHNBupPFh5/oMBvs849KJZGeAIF+V6iIgP3qE9bCtJSPhshNO9c7YO1OAsOdMNKO
 EOLU0Jc+EgcjqVQQmvW8Ze+pokll8AGRSI5y+BQ8eDqnhsw+eh3Ptn6EzgDBCObgcaDPXbMJtDJ
 LKdbN8DtBmwp9llutBwp6TGpT1ceS4Ph8/TYLzq+oPZPK5skpRNp9tFVRGrARV3dSMR/TX4jJzI
 /odctllp+jTuef2Z3pKiFTukcgCXrHCbsOuSnrQvkM+4m9/SGaGaqX1/PVHEjBG0kkuXEB3v6fz
 juSBiv5FucmvVh4zkjKh6Hen50NFyv70eNX1r4Wb+JJKe6Gc3Z4uQt5bqylYSF/DCZLDcoQxLwN
 8UH8FXhYWmjQsOA==
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
index 32af69bbf8f0..8e17b2b17a66 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -960,7 +960,6 @@ fn queue_rq(
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         is_last: bool,
-        _is_poll: bool,
     ) -> BlkResult {
         Ok(Self::queue_rq_internal(hw_data, this, rq, is_last)?)
     }
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index e8f0d03f2ff7..47e1f860c6ba 100644
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
index 505e7d2b2253..d28af9a5e006 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -93,7 +93,6 @@ fn queue_rq(
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<IdleRequest<Self>>,
         is_last: bool,
-        is_poll: bool,
     ) -> BlkResult;
 
     /// Called by the kernel to queue a list of requests with the driver.
@@ -214,11 +213,6 @@ impl<T: Operations> OperationsVTable<T> {
         // `into_foreign` in `Self::init_hctx_callback`.
         let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
 
-        let is_poll = u32::from(
-            // SAFETY: `hctx` is valid as required by this function.
-            unsafe { (*hctx).type_ },
-        ) == bindings::hctx_type_HCTX_TYPE_POLL;
-
         // SAFETY: `hctx` is valid as required by this function.
         let queue_data = unsafe { (*(*hctx).queue).queuedata };
 
@@ -235,7 +229,6 @@ impl<T: Operations> OperationsVTable<T> {
             // SAFETY: `bd` is valid as required by the safety requirement for
             // this function.
             unsafe { (*bd).last },
-            is_poll,
         );
 
         if let Err(e) = ret {

-- 
2.51.2


