Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEC3ADB94;
	Mon,  8 Jun 2026 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907140; cv=none; b=gPSf2TSFitpMF9Q0XzIBvHhfFGq17sGLUnvpG6frn6QASA+Duj2sI47FDvctkN644jBixhYryUl3zrAkLbmIHmxC9akb652Nw2Q52ZktB/vgaqc8wcy3eMJeFUEc9PWSlrPg6niAEJF3wyvx+aMTBhOdxFrdDO2Ospo5rdrKe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907140; c=relaxed/simple;
	bh=81tZ6uqr6vxiXYEcG14j37NbBeu1YXEHO1iGp3knNjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KpW0T/ZXlGrC+iwpfn/7e5l7u2XP8o2e5KjYYQ0w7QBKEzFXLVABy+pZnriM9vF+kmRMPPOA6cqitdWfjZFOpd6gZ3fAyMD6M+ApX4aI5SKdVhoGMnKRAxjJ5kBlFtHDqzCS1ntEsmwEEskSITfPWiLavdjohMYeqBVKNKdpomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2yWKUSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2yWKUSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782FA1F00899;
	Mon,  8 Jun 2026 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907138;
	bh=UkXpD2yPDo3XPKG6ddQID2Op1OA1vFwtRr7+pDnM+FY=;
	h=From:Date:Subject:To:Cc;
	b=e2yWKUSjFyTfFH0G/TgVNH5bVnQSY0lHNiddneb0NKaWEaY6dwlXZzHm4mCk4AoSr
	 rJbxPH+8SnALJdmln9S2ItLFkB5xF01OJZWaqsvhzHIJtb9FW4TXy8ZybwRig73NM+
	 SFVLfFS+vgqZEYsdCvhoZE6GNfjsjESuTYkop5WI0noTHIBTR6uoERHZHFdrl0NAau
	 j/UdDg/DNuamHsVNyZ3bMfUSIDWdITssJlV2Nc+sHp9TkpSEX/QtWFZMckOMQEMP1q
	 cPjKzs9w2emRqOI5O42jY/8jzm2mbhewMXhojgK5PyGwdON9bbx25Wfk6PxavpBFO+
	 wtw6YhsyI5m7A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 08 Jun 2026 10:24:34 +0200
Subject: [PATCH] rust: block: require `Sync` for `Operations::QueueData`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEF8JmoC/yXMMQ6DMAxA0asgz7UUghQhroI6OMEFM4Q2JgiEu
 DtpO77h/xOUk7BCV52QeBOVJRbUjwrCRHFklKEYrLHOONPiJ3NmHGgl1CMGbI13jnxTWwpQqnf
 il+y/Y//8W7OfOazfDVzXDTeAM/tzAAAA
X-Change-ID: 20260608-queue-data-sync-80b66ab312ac
To: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=81tZ6uqr6vxiXYEcG14j37NbBeu1YXEHO1iGp3knNjQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqJnxEcvTUOxGfHAHKjSzJ5dLQqQJJ5urIlG2FA
 f1KxE4fUDKJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiZ8RAAKCRD6UCkIqsW9
 0FlPEACZZLNBWeKuWRs78Umrg5q2Wzmc/vTBJfDz6as9boc49kPDP83g7cJwTh96FZy1oY4hdaf
 1R81MxGMUZs04JJEIyKUSdT1QOOM+C2okXgvQUakpij1R6Gvnfc1QuXpq2XuuzWoKqGvtrpwGrl
 3Zpt3d96Pl1BreZ3fWROZKPXGaZFDwmPMqxN+gJ2eZX4+/AEoLpTHbUHzkWS+rsAOY07Dygbdww
 UgOe8Kd7zIznT68MvTGaKz8Spgd1CaLZPD0S00AN40MZjjJgH/W8VTeiIm4WvW92CmqyxzWcDa3
 nWVUoJFjFE57rZ/T0Grqsw4YPqUJQvlw+kJM4P5eC4/ZbGzHOOlM0TtdE0zFBE/V4cpg64c3Y1i
 ytOWcnj9+fNoXdeAGkWWR6VUV2XhK8cG7RdrG8npo8QqznCr8QuPXeY/QBezZZkBnXYcFIiB7LN
 8u8iW66QEADr0zeB1PJ67Nps6Vxb3yJXQ/0MeK1Q1gqnoeErojBKAFc1D5tOS5mFBxGqF5r7iE+
 jJG/YMuO6E2whHhRNSZvm9CbA/fR4pRK9Pt0Vf/JAzyE4lw59NypQ+dNSbcKzjY8VzVkkru13n/
 /25ysalabSp+nrtZ4QEORmXGOskPa1zTsZqq4T+/4wEapmnsWcSH1BOGZLdGgnEVhzodHUOc1qk
 /9LBnv/uzaAkm2w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The queue data installed in a `GenDisk` is stored in the request queue and
handed back to the driver as a shared borrow through the `queue_rq` and
`commit_rqs` callbacks. Both callbacks obtain that borrow via
`ForeignOwnable::borrow` and may execute concurrently on several CPUs,
since the block layer runs one hardware queue per CPU. That means a shared
reference to the same queue data can be live on multiple threads at once,
which is only sound when the referent is `Sync`.

The initial `GenDisk` private data support omitted this bound, so a
driver could install a non-`Sync` type as queue data and then access
it concurrently from multiple CPUs without synchronization. Add a
`Sync` bound to the `QueueData` associated type to rule that out.

Fixes: 90d952fac8ac ("rust: block: add `GenDisk` private data support")
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/operations.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c..89029f468f44 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -30,7 +30,7 @@
 pub trait Operations: Sized {
     /// Data associated with the `struct request_queue` that is allocated for
     /// the `GenDisk` associated with this `Operations` implementation.
-    type QueueData: ForeignOwnable;
+    type QueueData: ForeignOwnable + Sync;
 
     /// Called by the kernel to queue a request with the driver. If `is_last` is
     /// `false`, the driver is allowed to defer committing the request.

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260608-queue-data-sync-80b66ab312ac

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


