Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94512288AD;
	Fri, 10 Apr 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848868; cv=none; b=ff5ZAyKcTcf5LmOvaDM23gPILI7YHx86ZuD7nb63UisI0N+JWzhKRnR03haCHocufOUU0OvFUqGjvGGzG7RuEkLVG8PGJ9hudMWYi7JvgW3MWWgzXMFp46DQke4t+eoYy9DaeGdFnPJNaGWoyPRocEOwaY8raUVvJu99vaACpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848868; c=relaxed/simple;
	bh=bcCBoPf7IlpJw+Qqx4EcNvYn8Gn/UvxMP62Q6WIDRvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AmrnzBwlwGihFCBksQv4PvElD7wn0V9diYEgzQ3OjathUVoieymDA5x7HOELVhI7joIv2KJ8tY2KL7FhZQ5EmglkntmZ2blgqzmblgXbhB2i11lLyRagOq6eeMGiAm72Xl9AaMCW3DXGFwSCrLy6p4IqMPp/v8i+/OfomaFs7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=bBhWUZHe; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="bBhWUZHe"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a4a05110;
	Sat, 11 Apr 2026 03:15:45 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] rust: block: safely abstract the blk-mq poll callback
Date: Fri, 10 Apr 2026 15:15:42 -0400
Message-Id: <20260410191544.2203201-1-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d78d25af503a2kunmcbf66d2fda417
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkMfVkxLH0MZTB1MS01OT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=bBhWUZHe6FF+uDhL8tWpmDk/2TYEK18Y+bdJkhK3E0ywxqcc8IAy66Fxk59ysilrycPKFFtgygvVB5bzW9l8jjZ7UOly2GH6dR0xsTZRtEM6bZudiWOelhuMFJhPpk8avhiWdIQglJgIdQi0jb+xE+sQjSk2eWmFk2O5U6fXK/0=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=ehlmR9YTU6MhPkg+UIwEeoP/t821iHLhv8hTj8MSl7E=;
	h=date:mime-version:subject:message-id:from;

Rust blk-mq drivers currently cannot implement the `blk_mq_ops->poll`
callback: the Rust vtable hardcodes `poll: None`, and there is no safe
way for a driver to receive the borrowed hardware queue context or the
optional completion batch pointer that blk-mq passes to C drivers.

This small RFC series fills that abstraction gap and wires the new API
into `rnull` as a minimal in-tree user.

The core design choice is to keep the callback on borrowed blk-mq-owned
state instead of exposing raw pointers or synthesizing ownership in
Rust:

  fn poll(
      queue_data: ForeignBorrowed<'_, Self::QueueData>,
      hctx: &HwCtx,
      iob: Option<&IoCompBatch>,
  ) -> PollResult

`HwCtx` is a transparent borrowed wrapper over `struct blk_mq_hw_ctx`,
and `Option<&IoCompBatch>` models the nullable `struct io_comp_batch *`
argument directly. This keeps the Rust side aligned with the C lifetime
model of the callback, while still avoiding raw pointer handling in
drivers.

The return value is represented as a typed `PollResult` instead of a
bare `int`. The enum preserves blk-mq's semantics while making the Rust
side more self-descriptive:

- `PollResult::Completed(u32)` maps to a non-negative completion count.
- `PollResult::Stop` maps to the negative "stop polling" return.

The vtable wiring remains backward compatible: the callback is only
installed when `#[vtable]` reports `HAS_POLL`, so existing Rust blk-mq
drivers still get `poll: None` by default.

Patch 1 introduces the abstraction and hooks it into the blk-mq vtable.
Patch 2 implements a dummy `poll()` method in `rnull` returning
`PollResult::none()` as the minimal reference user.

Runtime validation summary
--------------------------

In addition to compiling the series in an out-of-tree build, the wiring
was validated at runtime in QEMU.

To exercise the Rust poll callback, I used a small out-of-tree helper
module as a test harness. The helper temporarily enabled a poll-capable
queue shape for an `rnull` device, submitted a `REQ_POLLED` bio, and
attached a kprobe directly to the queue's `mq_ops->poll` function
pointer. In the guest, the helper observed the Rust dummy poll callback
being invoked (`hits = 1`) and the polled bio completed successfully,
without deadlocks, crashes, or memory safety issues.

That helper is only test infrastructure and is not part of this RFC
series; it was used solely to provide a minimal "the VTABLE wiring
works" runtime proof for the new abstraction.

Any feedback on the design of the PollResult enum and the borrowing
strategy from hctx would be much appreciated.

Wenzhao Liao (2):
  rust: block: mq: safely abstract the poll callback
  block: rnull: wire up poll queues dummy callback

 drivers/block/rnull/rnull.rs       |   8 ++
 rust/kernel/block/mq.rs            |   2 +-
 rust/kernel/block/mq/operations.rs | 143 +++++++++++++++++++++++++++--
 3 files changed, 146 insertions(+), 7 deletions(-)

-- 
2.34.1
