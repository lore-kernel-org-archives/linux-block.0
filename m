Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D752D3726;
	Fri, 15 Aug 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243163; cv=none; b=iPmfMBjG0WHC1EtbTt0knec1LjhJkWHzp+818Unl3DWNCzG/a67zpiiVmWTIyI0yFsOa5yO+BxdV3JQRrt8FcdwkGh7M2pzx92Gbyk1Qvk0uohc7DEwB+58awx2cQRHSRwSvT0c1O6djKKx9pE1Z6E6BTiIu2lho4LnT4zWNBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243163; c=relaxed/simple;
	bh=F1xlZDFgVWjBQKgbNEQcWRpep8ZD9QDUOW3xY4uARq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YQ/w941RmbsqWQyanvGl8R7LqaQRddYWrWrzClGRvPaaJa76RTjEV+RZ11yqWN91k3Z36huQLbCD+IIVFnc2ByanFphzlo4IrHTgHqDbvLDlRE3qw59T2EqvX66V534FjwSc5i7CnETtz6ZJCVA1cMTOYrOXCH4pNc729yqDA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asSbFfth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asSbFfth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34309C4CEEB;
	Fri, 15 Aug 2025 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243162;
	bh=F1xlZDFgVWjBQKgbNEQcWRpep8ZD9QDUOW3xY4uARq4=;
	h=From:Subject:Date:To:Cc:From;
	b=asSbFfthS68TeIWoRC0zNP1sVY3bwdNz+Mh0oejHmLogVfQeN6UrKcz3Ov67/S/co
	 GR8jwtrgaAYQzL7MC+QgTnY8+JNFkKZ55MHs1yMlMnqRJUjXx1Qe4YqMF8ogRvgkQk
	 7Swm+INomA3MSGMNkBjpkJHO42f5+APZHlxxZHnA0joAgzFoVMnhKyFSWnwkDGCxN1
	 7ZcDXRSgb3oC5wkNBPU0W7rHKrCe/6eRBKa3EN1NHJE+nYd8njwSZWlvn/qkkJu64w
	 oEEz/CAstE0moozShF+Qfoj+kVgYjOGGPpc1vdbzXub5Mjf/P0HcBoSRHpC2+FzE9o
	 LsA5DwbGmhTMw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v5 00/18] rnull: add configfs, remote completion to rnull
Date: Fri, 15 Aug 2025 09:30:35 +0200
Message-Id: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvinmgC/3XMQQ6CMBCF4auQrq3pTEsprryHcUFhkEYCpEijM
 dzd4kZN4/J/yfeebCbvaGaH7Mk8BTe7cYiR7zJWd9VwIe6a2AwF5kKD5n5Y+p4vEw+ax7QqL4D
 QtETEIpo8te7+PjydY3duvo3+8f4PsK1/rwJwwSsF2lhDhbZ4vJIfqN+P/sK2r4AfXwiTeNy8L
 WUt2lZhaRMvvzxA4mX0skKNVhGWCIlXH28AE6+ip8YIaBppq7z+8eu6vgBxOURVbQEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4888; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=F1xlZDFgVWjBQKgbNEQcWRpep8ZD9QDUOW3xY4uARq4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuIlCyzecOGtD2M8Yybbw+/inEXyHu0ulWyGI
 oUUjV6IbM6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iJQAKCRDhuBo+eShj
 d6BPD/9VW9Hx8fFdux/ml4XL9BUi8AzeBtjlJXEM8XOudopqNqZAYp6WqM8CkJzGcS4tm+wx51x
 K3VUHKjnPNd8b3ydAzRKpcAY46BgDwQ8ulmBM1OmCvgGAKLCM9vqoFUp6KwsmwR+Og9auCY0690
 K7vbzCI0Tx8bG+UoU0qjr3o1BbzxJ+p6hZ39wLfZyPKDW/Vf5kogsibx+2Z9cSk4fTDYJpEJLwG
 T0LHR1rNs2V/VFbF1IGXCV+N8LSHpTHSwWN7tKQyhwD7i8QH5jR1SIXIBcuh1oblFl02NZtmXwE
 TWMlLAWcnnWkh8tFnQUADuFSoIPCnFzkHla51LMjBb+hl7bIiXbrC6bute4m98ChntPdh2eHuhe
 xZ7fpHtmJ9vES8qOBBx6wONXJWmlnjlV276nqfM4ZguFDKyAit4SYKThwcZEIwq5CIHMB9ZAA4V
 kYXUT3Ijde3ndBrz3+MqKYxzWyYA/onjaENyeVv92s1+mRFdd/aTfr/TJ+X2xAxpqPVDRWmoh3o
 j7Z41hyGxcfSGpKloV9OqKcXPJmn83DUxnzRXhV29XUW2EXgrrGYTn2yB6E/oZmkka41KU6Pjv7
 ywunFFqLAjAwyJb69rJynjRFOEt4ohK9TB0a0UC3EkrMGIBTMgbXvbIzNDY9YGRlYxYiZku/9IR
 J2NUS33zB9k26Xg==
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
Andreas Hindborg (18):
      rust: str: normalize imports in `str.rs`
      rust: str: allow `str::Formatter` to format into `&mut [u8]`.
      rust: str: expose `str::{Formatter, RawFormatter}` publicly.
      rust: str: introduce `NullTerminatedFormatter`
      rust: str: introduce `kstrtobool` function
      rust: str: add `bytes_to_bool` helper function
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
 drivers/block/rnull/rnull.rs       | 105 +++++++++++++++
 rust/kernel/block.rs               |  13 ++
 rust/kernel/block/mq.rs            |  14 +-
 rust/kernel/block/mq/gen_disk.rs   |  54 ++++++--
 rust/kernel/block/mq/operations.rs |  65 +++++++--
 rust/kernel/block/mq/raw_writer.rs |  55 --------
 rust/kernel/block/mq/request.rs    |  21 ++-
 rust/kernel/configfs.rs            |   2 +
 rust/kernel/str.rs                 | 151 +++++++++++++++++++--
 samples/rust/rust_configfs.rs      |   2 +-
 17 files changed, 664 insertions(+), 192 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


