Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA22F0C62;
	Tue,  2 Sep 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807002; cv=none; b=fRmq7Mucg3UCQnEiiXeHtheNZTcrYI0RtEvmzBX50fiABWfbspHMoLut5MohYAcK/NmIUyuxmNh2YjeScG/+DGgm27D0kriPlOLpXsxCba8OX/vo8xPOkYiQ4VHSIqCmRJxUBbqQoNb6eSLuVYx6sLXxJ+tCPe1dS0uGjW/Te6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807002; c=relaxed/simple;
	bh=ZIg/RXaSX38pfYsocsCL9XpLI7wCfaehuexl1zdhPPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MMTqsRXiJCifCbq6/kx4AsgFxyTzjVsC8ap+DzXs4tAuguPeo/B8UnR4/+KklFGu790dUjYOWxNpnKMejtsU3A+4yP/Bk4ayjw7o6mnw6mn2qocmgjk1QHTZLxfFG/oOdVYFGnl6egkU4ayqAUjZzzp+PzcpyOBvocySTEvk0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOSlGZiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOSlGZiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF6C4CEED;
	Tue,  2 Sep 2025 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807002;
	bh=ZIg/RXaSX38pfYsocsCL9XpLI7wCfaehuexl1zdhPPk=;
	h=From:Subject:Date:To:Cc:From;
	b=GOSlGZiE7o31BUuqFS7rkczKZoofLfhWRimO4sJl/kpaGUP+3T0vpT4CjTE1RPvWO
	 xLD6YTM7EfJcc5+my+LIjQ1ZpHgqlQJWCMM2+hym42sMbtRopeH4KMdOKs4yVNW6pd
	 dV4EuqZnzvsDo85lBw0ong3Eut06b8xRC/ymChSV8FnliWKmTx3vqNWpe67HNr3iXB
	 SxHQuUKb2FsYZ+KTKDxM1JJCdT88Yjk286++I0QZB1Ei0HfkatjAma0PBSRz3gIV24
	 yGyW8r7WnNy0FiEri3NLw0c4AxUnoeq/IVfu+FXjz98TYIi+eW4zjydcbWB4ckGALm
	 jj4yzzFqN7uTw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v7 00/17] rnull: add configfs, remote completion to rnull
Date: Tue, 02 Sep 2025 11:54:54 +0200
Message-Id: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6+tmgC/3XNTWrDMBCG4asErauiGf06q94jdGHJo0TU2EFuR
 Erw3StnExfR5TvwfPNgC+VECzseHixTSUuapxr27cDCpZ/OxNNQm6FALQwYnqfbOPLblRfDa3q
 lLRC6SESsomummO7PwdNn7Utavuf889wvsF3/nSrABe8VGOcdWePx44vyROP7nM9s2yr48la4x
 uPmfSeDiFFh5xsvdx6g8bJ62aNBrwg7hMarl3eAjVfV0+AEDIP0vQ6N13uvG6+r1w6UloAqgG6
 82Xls/5vtfzBaCEMYhf3j13X9BaJWa6DtAQAA
X-Change-ID: 20250616-rnull-up-v6-16-b4571e28feee
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5615; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ZIg/RXaSX38pfYsocsCL9XpLI7wCfaehuexl1zdhPPk=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr72mAEdsU5cWlpDhDaCO76VNOzhMmYjcVHNl
 bE5+4XH5pOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa+9gAKCRDhuBo+eShj
 d8RWEACfHD7M4V3R9NoQVa5IU/PHsZO7DdspH2wvZauK/FQPaQV87SORsNIx2V8VKCv5PDQdg4F
 3OXiILlBNNYrw0GgOF+Zc8SxFC4Z+PCmqVOshx8RM12/mDA69pzrUHtSHVtN71LTP7nS2sjV6RD
 AXBM3jf2T7HTHYS/AFCUvZQtUDvUeoVQhiSd77sWkuAyrKYYukbrA+DBhHmuYyGmIhyBfbIXRoR
 HRWCJYK4R9obeRg3ji9ziscOxu8rBgiCZ0F3jbLcGruMnm0DScXa+BxalwLOKUQEHtKzv7HcZtH
 7grMs+d1geIqNYtzOVkAiMzwoz/9ZjdRJV1KPwJoXnY49occcDil6tgtE6vgNhSDvJnO1+8qv9N
 drMw2fI480+BVnQVqDhNkaNhyItTVFTGS0qkJ60E5iMh2AVqXkoP7buGB2Mgwzcr2zZZe2tug9M
 Th3a6xXkQi7xRbcQv2Rcf0WdWZahJkR+35nUhSbIE9s5ie5MNomRg3PENSA9BtdtkDXauoQmGaJ
 qqb2qKmzVrcRf08u9hy0OKgu4/rSNtpsFmfJdPBhaoJ3WUWbAd20BRuOAnLmlgNALsdkI8JPKBw
 xn2JejBmflfn/ysfah3n0gixYDAYaoWV6n/eIEM0SCIDoLhJfOqUnsukysbHoLenNmBHumm8xA+
 P+b6T5MMjb7+Ogw==
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
Changes in v7:
- Fix name of `kstrtobool_bytes` in commit message of patch 06/18.
- Fix stale safety comments in patch 15/18.
- Refactor `kstrtobool_raw` for readability.
- Link to v6: https://lore.kernel.org/r/20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org

Changes in v6:
- Move re-export of `configfs_attrs` next to macro.
- Use implicit coersion to pointer in `kstrtobool`.
- Change the name of `bool_to_bytes` to `kstrtobool_bytes` and improve the implementation.
- Remove a useless pointer cast in "rust: block: add `GenDisk` private data support".
- Get `GFP_KERNEL` from the prelude in "rnull: enable configuration via `configfs`".
- Rebased on v6.17-rc2.
- Link to v5: https://lore.kernel.org/r/20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org

Changes in v5:
- Re-export `configfs_attrs` from the `configfs` module.
- Remove transient stray dead code `NullTerminatedFormatter::from_array`.
- Use `kstrtobool` when parsing boolean values through configfs.
- Remove a stray space in `pin_init!` macro invocation.
- Remove useless calls to `ptr::cast` when retrieving `queue_data`.
- Rearrange positioning of safety comments.
- Link to v4: https://lore.kernel.org/r/20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org

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
Andreas Hindborg (17):
      rust: str: normalize imports in `str.rs`
      rust: str: allow `str::Formatter` to format into `&mut [u8]`.
      rust: str: expose `str::{Formatter, RawFormatter}` publicly.
      rust: str: introduce `NullTerminatedFormatter`
      rust: str: introduce `kstrtobool` function
      rust: configfs: re-export `configfs_attrs` from `configfs` module
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
 drivers/block/rnull/configfs.rs    | 262 +++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs       | 104 +++++++++++++++
 rust/kernel/block.rs               |  13 ++
 rust/kernel/block/mq.rs            |  14 +-
 rust/kernel/block/mq/gen_disk.rs   |  54 ++++++--
 rust/kernel/block/mq/operations.rs |  65 +++++++--
 rust/kernel/block/mq/raw_writer.rs |  55 --------
 rust/kernel/block/mq/request.rs    |  21 ++-
 rust/kernel/configfs.rs            |   2 +
 rust/kernel/str.rs                 | 162 +++++++++++++++++++++--
 samples/rust/rust_configfs.rs      |   2 +-
 17 files changed, 674 insertions(+), 192 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


