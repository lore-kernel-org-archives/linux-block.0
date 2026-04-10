Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B63D9DB0;
	Fri, 10 Apr 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839949; cv=none; b=pXamN6Aejmr+kTjDowidDqL/2micSUiPEmNIWbkPzdymaTECuMGHQN7m7WOAw0Uqa7A/XvaL4k2M6rK9F6HNYaj8853SbjgLRXLBpbQMXXItRr1lMuoKpVpv6cDZwC7HeLVDhMq4rwf6S637pG3uzC4AFr9nR7z/hcgCt5vRjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839949; c=relaxed/simple;
	bh=NEyq3xPTwDOEdfOw41rf/Eb8RJ5ht1gKHhKHHhFUVis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJACIsybAwzybv56FuTUQgU+iYL1XUwbzJR1aKBiYXyFsvT0NOheqseOZSfy/v6x7h6NzXvYpwlxzSJCYC+FVU2tUlAL7TGj0j6gXRjUmADds25Vs0XZunWDqzyKs2YD6MP6qm3lngkjVy1iN03B+wHSVwxoWFUIqSJNiWadfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=l1yAJ1eZ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="l1yAJ1eZ"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a484aad4;
	Sat, 11 Apr 2026 00:47:05 +0800 (GMT+08:00)
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
Subject: [RFC PATCH 0/2] rust: block: add a borrowed blk-mq timeout callback
Date: Fri, 10 Apr 2026 12:47:02 -0400
Message-Id: <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d784a3f0503a2kunmb238a8d6d3395
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBkdVh1MT0IeGU5LSkxLGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=l1yAJ1eZfijRQgnOmtpF98IxOdbTvrr32GvjaEQ9eyMPuGZkzPmolM+9Ls5XJ/TBqyGq2YZ5HYcTPHzc1V/A61E4rfWD9OiogwVAMIZLvS1b+p17ghnYrs9RLPpnBCOBEc7lhNoj7MdCZhOaySWFqrOaYTPGce4UzDRQCpZ8p7E=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=BqlLaKie+4HliX7GZqmmpNASww4MQDMT9UpjtIN6IQU=;
	h=date:mime-version:subject:message-id:from;

This small RFC series fills a missing blk-mq callback in the Rust block
layer. Today, Rust block drivers cannot participate in request timeout
handling because the Rust blk-mq vtable hardcodes `timeout: None`.

Patch 1 adds a typed `TimeoutReturn` wrapper for
`enum blk_eh_timer_return` and extends `mq::Operations` with an
optional `timeout(&Request<Self>) -> TimeoutReturn` callback.

The key design choice is to model timeout as a shared borrow of
`Request`, not as `ARef<Request<_>>`. In this tree, blk-mq invokes
`timeout(struct request *)` synchronously while the block layer retains
ownership of the request. The timeout path is therefore a notification
over a request whose lifetime is guaranteed for the duration of the
call, not an ownership handoff to the driver.

Representing the callback as `&Request` keeps that contract explicit in
the type system, avoids fabricating a fresh `ARef`, and avoids touching
the request wrapper refcount from the timeout path entirely. It also
prevents the Rust API from implying that drivers may persist or take
ownership of the request from this callback.

For compatibility, the vtable only installs the timeout callback when
`#[vtable]` generates `HAS_TIMEOUT`; drivers that do not implement the
method continue to expose `timeout: None`, preserving existing behavior.

Patch 2 wires the new abstraction into `rnull` as a minimal reference
user. `rnull` implements the callback and returns
`TimeoutReturn::ResetTimer`, which keeps behavior close to the current
default timeout handling while proving that the Rust abstraction wires
cleanly into a real driver.

This tree uses the `timeout(struct request *)` blk-mq ABI, so the RFC is
intentionally scoped to that signature and does not model the newer
`reserved` parameter variant.

Build-tested with:

  make -C /home/lwz/rfl-dev/worktrees/rnull-upstream-contribution \
      O=/tmp/c2saferust-rnull-upstream-build LLVM=-15 defconfig
  make -C /home/lwz/rfl-dev/worktrees/rnull-upstream-contribution \
      O=/tmp/c2saferust-rnull-upstream-build LLVM=-15 rustavailable
  make -C /home/lwz/rfl-dev/worktrees/rnull-upstream-contribution \
      O=/tmp/c2saferust-rnull-upstream-build LLVM=-15 vmlinux
  make -C /home/lwz/rfl-dev/worktrees/rnull-upstream-contribution \
      O=/tmp/c2saferust-rnull-upstream-build LLVM=-15 \
      drivers/block/rnull/rnull_mod.ko

with `CONFIG_RUST=y`, `CONFIG_CONFIGFS_FS=y`, and
`CONFIG_BLK_DEV_RUST_NULL=m` enabled in the out-of-tree build.

Comments are especially welcome on whether `&Request<Self>` is the right
long-term Rust surface for blk-mq timeout handling.

Wenzhao Liao (2):
  rust: block: mq: safely abstract the timeout callback
  block: rnull: implement dummy timeout callback

 drivers/block/rnull/rnull.rs       |  4 +++
 rust/kernel/block/mq.rs            |  2 +-
 rust/kernel/block/mq/operations.rs | 40 +++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.34.1
