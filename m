Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34803B3C18;
	Fri, 10 Apr 2026 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812128; cv=none; b=i+KjqXw+8rEDYZio/DowNGXTVZkvTH/4sFrWDcT5eqkcuaVZlGe7tgWtXPr7bk+wSMpkwLF8M3Yl4QwcayBFKq2OD5tb6YdZViZ30cm9ge1rI8l7XXGboMqqPQASIf4AR8gz2M849WiVIiZuNXGxBK1R/Pon7AHVX/gVN91zbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812128; c=relaxed/simple;
	bh=cpxAhEEbwjLpVaJs29k60Q5aP6r7PJtLymDOQVTDBoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H1OVVf15x/le/rOZ5G0cLkq7OaV1u1V2liRb1bUvMU9FRzXnQ1qOmdNjTiJw1bc2nWkILpD7CqWKKwH6s9io1NPwFjpEwOOGi5wGKx7SH8ZbQ/+5P0liveuEUkqOo6tvVByuyqDojwSdHr3RjPovsdwwu8zFVTGbjYWZ1QykCHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=ByJtFEKH; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="ByJtFEKH"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a3dd6901;
	Fri, 10 Apr 2026 17:08:30 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: axboe@kernel.dk,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	aliceryhl@google.com,
	lossin@kernel.org,
	boqun@kernel.org,
	dakr@kernel.org,
	gary@garyguo.net,
	sunke@kylinos.cn,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] rust block-mq TagSet flags plumbing and rnull blocking wiring
Date: Fri, 10 Apr 2026 05:08:27 -0400
Message-Id: <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d76a6688203a2kunme6cebcccb9cc0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZShlMVhoYSk4aGk9ITh8eGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=ByJtFEKHm2+QbuLn84HpbSM24OFpXl0MgnkCQ5LWzlN48V7POwxyR3QDrzigHPtyy0PCftbTDQl3MhewASfPcfG+/fMtB74ngzZaRBOv5EvKoUnVIb0NfKQhvJTB2l1OPdI6+bQWSDXMdHB/oaLwnikei+lQWFowj0jKkXUlqgM=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=kZe++j08EY3Ck8EUAI/l3+qbfWy1H1jYaZM+39RwVd4=;
	h=date:mime-version:subject:message-id:from;

This RFC series fills a practical gap in the Rust block-mq abstraction by
exposing blk_mq_tag_set.flags safely, then wires one in-tree consumer
(`rnull`) via configfs as a reference.

Patch 1 introduces `TagSetFlags` and `TagSet::new_with_flags(...)` while
keeping `TagSet::new(...)` for compatibility.

Patch 2 adds a `blocking` configfs attribute to `rnull` and maps it to
`TagSetFlags::BLOCKING` when powering on a device.

Validation summary:
- Out-of-tree build on rust-next (LLVM=-15): defconfig, rustavailable.
- Enabled CONFIG_RUST=y, CONFIG_CONFIGFS_FS=y, CONFIG_BLK_DEV_RUST_NULL=m.
- Built vmlinux and drivers/block/rnull/rnull_mod.ko successfully.
- QEMU runtime test (initramfs automation) verifies:
  - `/sys/kernel/config/rnull/features` contains `blocking`;
  - writing `blocking` while powered on fails with busy semantics;
  - writing `blocking` after power off succeeds again.

Comments on API naming and any preferred follow-up scope are welcome.

Wenzhao Liao (2):
  rust: block: mq: safely expose TagSet flags
  block: rnull: support BLK_MQ_F_BLOCKING via configfs

 drivers/block/rnull/configfs.rs | 32 +++++++++++-
 drivers/block/rnull/rnull.rs    | 11 ++++-
 rust/kernel/block/mq.rs         |  2 +-
 rust/kernel/block/mq/tag_set.rs | 86 ++++++++++++++++++++++++++++++++-
 4 files changed, 126 insertions(+), 5 deletions(-)


base-commit: 3418d862679ac6da0b6bd681b18b3189c4fad20d
-- 
2.34.1
