Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E52E54AF;
	Tue, 12 Aug 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988347; cv=none; b=ONitJeh1i24pSVfYbDkPXuChColfcCY4I0XF70q6gqxzhb1KIZMM92EUwaIR3Gdqf7x6sYIdAw13JgRXJ8esYOBc59opcAshUv+Lks6RelkbWcTwfpWlUwGQEP/ALIUvcA56XTvqf97dCHFZTosHuX50Awr9KlNSwgp8UzGlzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988347; c=relaxed/simple;
	bh=pJ1LHzCrM9voAmxPDL5JxPQ1z+/fyVrsqn66BjvdsR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fNjO47boRaIwc7hO3xYLBIzg7My9KzwDJThsbjs102lufYrSDnKaCfgYS/XxTp7c7/NgsJ+JJTPDQ7DrClQLuMjYUG9b2kAM86olOyim4EmyfG5VoCE5McPiVqlmxdd56rw7BnRqzV3xNiDSYW0NYte6BejAFR7C9gQlEl7jnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEekgIVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEekgIVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780B0C4CEF4;
	Tue, 12 Aug 2025 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988346;
	bh=pJ1LHzCrM9voAmxPDL5JxPQ1z+/fyVrsqn66BjvdsR4=;
	h=From:Subject:Date:To:Cc:From;
	b=FEekgIVa2QeSwMv6SxtjD3vYGT8lfVasnlrceQk7Xi45ahjwraThNCZCCPgK5ab7V
	 fu0b05TZr67SZ/EVI2kXpfrwVlfRhWgxavr+ikY9F/pS5m/C5VK5FeYS+vw3smdLkx
	 eJM2C/k5VWNzCpXxIHGmuGAwb9geA0x3qdIIlg9SboMhJGvGZX+FLaS8SAVpMPXT+c
	 ZMMNHTR0br7oEb7OJK+v1OpJF00Cxv5WhqnSjfH3681kojMRSC3EOadiFPEE9+KT+7
	 A/3HIg3kol4dUYcLbLR5nbDhMY14hTRoiu2H4CW0uW/6Kn31ObT9P9/nDh7VGKo9m4
	 VFNFGY+a2L2pQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v4 00/15] rnull: add configfs, remote completion to rnull
Date: Tue, 12 Aug 2025 10:44:18 +0200
Message-Id: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOL+mmgC/3XM0Q6CIBiG4VtxHEeDH0TsqPtoHYj9KMupg2Q15
 72HnlRzHb7f9nwzCegdBnLKZuIxuuCGPoU8ZKRuq75B6m6pCTDImeKK+n7qOjqNNCqa0si84Aj
 aIiJJaPRo3XM7vFxTty48Bv/a/iNf179XkVNGK8mVNhoLZeB8R99jdxx8Q9avCB9fML3zsHpTi
 ppZK6E0Oy++POc7L5IXFSgwEqEE/uOXZXkDZG/+oS0BAAA=
X-Change-ID: 20250616-rnull-up-v6-16-b4571e28feee
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=pJ1LHzCrM9voAmxPDL5JxPQ1z+/fyVrsqn66BjvdsR4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8ZE0PzaCH+5cGdHO4FtLj9KhsLl+FwAET10
 qPYaO1Oh5WJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/GQAKCRDhuBo+eShj
 dz54D/9yMRFi9WW9Bo8dVOH/I95S4LZpWallEmaBEg34plW7GUXvsbTT9X0loZA5qfshL/erA8x
 3ejL91lCgwUPoPM6xQg3FwUTOawQNdp5LhLHModoIBoGrr3oJhEEyVhaa0uDcYR47sHwQaj1L1n
 w1POU+4nluhoKEe5GzrnCh2ub0bThamK0F+5pwmvyPXKGI0UcPdazriGdD8D8Gx7qve8wNjftX1
 cOLnMzmzCgLmhsSHGMeEDKgqtd4/PbZEd3664y3umks9hUq+wsrtoKdcw624vs08ylIOND9k2VZ
 FzarlKuVBUSVbzd3jhNSpKfw/FIL0mgafnmUanwxbxRHW7roKM5hhSKGhD5JGTqeXWd6k5SG/bv
 Y2jgfGo6kyKHZJcbJQoR+Nkf3l30XHLp6da4aQ1YzSij8rNyT+aJvVycEF+ZkOE/yfnENH1dskm
 n8dh9+PQzNQE+mRD/O8YjA7IiS38+4YMj2c8mPOt2DPk57CQYzfPA+km0s/YrBaPFULV/sM52V0
 6c3s5x+YapgjTKEk2LPwMVDQJMwIgEw5Dy7LEd+J+t9iU1Riu1HHKgjQkK4/M9sMN/a3+QjJM9e
 CzGbepvfVByp3EFklB1E1UzfzGo8AL820oK4a9NBbp6drQzkAhswrjG+HYP1IDIcbfXnpXKnhxk
 JuWPvi5RdKT0+vA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series adds configuration via configfs and remote completion to
the rnull driver. The series also includes a set of changes to the
rust block device driver API: a few cleanup patches, and a few features
supporting the rnull changes.

The series removes the raw buffer formatting logic from `kernel::block`
and improves the logic available in `kernel::string` to support the same
use as the removed logic.

This series is a smaller subset of the patches available in the
downstream rnull tree. I hope to minimize the delta between upstream
and downstream over the next few kernel releases.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v4:
- Rebase on v6.17-rc1
- Merge patches that expose `str::{Formatter, RawFormatter}` publicly.
- Remove `NullTerminatedFormatter::from_array`.
- Change signature of `Formatter::new`.
- Change invariant wording for `NullTerminatedFormatter`.
- Add missing period in comment for `SECTOR_MASK`.
- Rephrase docstring for PAGE_SECTORS_SHIFT.
- Use `write_str` rather than `write_fmt` where applicable.
- Improve boolean parsing in rnull configfs interface.
- Be explicit when intentionally dropping data (GenDisk::drop).
- Add minimum size invariant to `NullTerminatedFormatter`.
- Import `EINVAL` from the prelude.
- Link to v3: https://lore.kernel.org/r/20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org

Changes in v3:
- Rename `NullBorrowFormatter` as `NullTerminatedFormatter`.
- Remove `pos` from `NullBorrowFormatter`.
- Call into `Self::new` in `NullBorrowFormatter::from_array`.
- Use `Option` return type in `NullBorrowFormatter::from_array`
- Use `Option` return type in `NullBorrowFormatter::new`.
- Remove `BorrowFormatter` and update `Formatter` with a generic lifetime.
- Split visibility change of `str::Formatter` into separate patch.
- Link to v2: https://lore.kernel.org/r/20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org

Changes in v2:
- Rework formatter logic. Add two new formatters that write to slices,
  one of which adds a trailing null byte.
- Reorder and split patches so that changes are more clear.
- Fix a typo in soft-irq patch summary.
- Link to v1: https://lore.kernel.org/r/20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org

---
Andreas Hindborg (15):
      rust: str: normalize imports in `str.rs`
      rust: str: allow `str::Formatter` to format into `&mut [u8]`.
      rust: str: expose `str::{Formatter, RawFormatter}` publicly.
      rust: str: introduce `NullTerminatedFormatter`
      rust: block: normalize imports for `gen_disk.rs`
      rust: block: use `NullTerminatedFormatter`
      rust: block: remove `RawWriter`
      rust: block: remove trait bound from `mq::Request` definition
      rust: block: add block related constants
      rnull: move driver to separate directory
      rnull: enable configuration via `configfs`
      rust: block: add `GenDisk` private data support
      rust: block: mq: fix spelling in a safety comment
      rust: block: add remote completion to `Request`
      rnull: add soft-irq completion support

 MAINTAINERS                        |   2 +-
 drivers/block/Kconfig              |  10 +-
 drivers/block/Makefile             |   4 +-
 drivers/block/rnull.rs             |  80 -----------
 drivers/block/rnull/Kconfig        |  13 ++
 drivers/block/rnull/Makefile       |   3 +
 drivers/block/rnull/configfs.rs    | 273 +++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs       | 105 ++++++++++++++
 rust/kernel/block.rs               |  13 ++
 rust/kernel/block/mq.rs            |  14 +-
 rust/kernel/block/mq/gen_disk.rs   |  58 ++++++--
 rust/kernel/block/mq/operations.rs |  65 +++++++--
 rust/kernel/block/mq/raw_writer.rs |  55 --------
 rust/kernel/block/mq/request.rs    |  21 ++-
 rust/kernel/str.rs                 |  83 +++++++++--
 15 files changed, 608 insertions(+), 191 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


