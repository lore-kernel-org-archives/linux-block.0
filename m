Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385892F99A4;
	Fri, 22 Aug 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864915; cv=none; b=mwE+jvLrDetZTxzQruaecm9KrrQcVD2YL3Wzu0VPapdXykL27A7BI81gQxsA8Pm1Mu8uRvEQCvxSBvOxvIQJJsph6L+3rf1cPzSPUHI61SUXb17VczU4mVlzEdq7svCGcFEH4sc9X4LTzjK2pJxBFhatmOcb9+WmTi6OW2sFnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864915; c=relaxed/simple;
	bh=1skKBQN9bkuB1K4Hq6zHIcgUjRNl091GUakh3Rk7h6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tRsrKwwMXl7kpSSWUndHJV9CRifQIezPsjx785X1pMGh4VhiuW+0Qmgnk/5DXlx1shW5xh+lou2oi5fWSFJPeA25Z+Tlr/a0s6f9VnS3BCAvPleEm+y38SBe+hnNlKNVoco9IRIW07wfUiji0GreGugvw7XwvJ8tiXVko5t6CIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhWmqziw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhWmqziw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6372C116C6;
	Fri, 22 Aug 2025 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864914;
	bh=1skKBQN9bkuB1K4Hq6zHIcgUjRNl091GUakh3Rk7h6Q=;
	h=From:Subject:Date:To:Cc:From;
	b=RhWmqziwcemXkubBDoF3bXvQZbw7G5qaw4QPcqzsBgkzJ49KAsvZPKj9uLYjIK7i/
	 hY6LgvRxxOibiAtcMq26fmULbNYuWIfwcsQV8Unt2s+Erc8QSGWsERF/aam95VjvNC
	 q5O2qAf16+QCy2iSjYukka9tcl3N6D6DslT8qhFaaZkxUWNMnV/fq7WP6arYV15KIp
	 LJdZUfz6buPkiEj7huPNyt2ARpxAWv9J1njcVRIcRMLeNj/3qeNykxr2bw3hkjPQBo
	 KfGO3Je7UY16CGC8iSdqVHk1antE33VbNoRE3Wlu8LAlcEXElN2dGuzZHAJ1202Pv2
	 AXLbhN0i3UcOg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v6 00/18] rnull: add configfs, remote completion to rnull
Date: Fri, 22 Aug 2025 14:14:36 +0200
Message-Id: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxfqGgC/3XMwYrCMBSF4VeRrM2Qe5Obpq58j8FF095qsLSSa
 hiRvvukblSCy//Adx5i5hh4FrvNQ0ROYQ7TmMNuN6I9NeORZehyC1RIyoKVcbwNg7xdZLIypzd
 UAaPrmVlkdInch7/n4e8h9ynM1ynen/8J1vXrVQKpZGPAOu+4sh73Z44jDz9TPIr1K+HLV8oVH
 lfva92qvjdY+8LrNw9QeJ29btCiN4w1QuHNyzvAwpvsuXMKuk77htrC07unwlP25MCQBjQt0Id
 fluUf/4oUr60BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5398; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=1skKBQN9bkuB1K4Hq6zHIcgUjRNl091GUakh3Rk7h6Q=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF8v0tbDwWXBOxZ8mFeZdsTIZI4twbwH3oeRs
 N6s/nkPqw6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfLwAKCRDhuBo+eShj
 d6cMEAC071sRIFG3BrPTzyKoy+BxUSbIVwJ5FEm6uUWwWa2ueA03hHpR/kcjEj8tx8k0bfHQTaA
 jePoiHd7KikdAi/ROcZCEb2aztkFj3M60bKOsY6zH4tXNcH2AzGJAOvLAZUgXcyKA6qBE/6wIuX
 BxdVOmKKAAia9hPMh1bYgvTAR66gTOg5brbB6woRT/bDJocTg5IEme1aSdhnufRGx/pEcKDkF+f
 e9Wq6Wc0bI0tDBJWyqeaIp4wABOoIFITakE09HQTfBWGpJuGgjUsuS7b+48jtE8EMoz/awzDrFb
 t8kLFu93JD+SY9A7mCo3kZwcjLLBRnZRjAJasaxDr7iClqzt070lvz9+YiewSM/k9X5Q43xLBCW
 ThB3IUnifR6ITRjzEX3MIlBHwgnlSuyxw4zzhavw85MXSAIyI1irwtxPtlvo1L0cN3fwxYk5I7y
 40GWrC36dcjfaHHSlQegDxl7/cLF4M5uONOvW1p/TUi3NPmwh8dMrbdEfIUhJ3G5A4MR406ib/B
 SVbKRKVUSthvXN25qsKnOHN5XLXBXuQYbYVxsJItq7ydp+E7PCtRau3SpF6ChuFwMZDSB6lrqCH
 4cbuOVhEkGA8lAk8beANwkb4AfWQ3IaeoJz/VVdakC+n6HaZNDePJwqHB52pf5VASehxnU8YAm9
 4x7tupfRPgu2T2Q==
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
 drivers/block/rnull/rnull.rs       | 104 +++++++++++++++
 rust/kernel/block.rs               |  13 ++
 rust/kernel/block/mq.rs            |  14 +-
 rust/kernel/block/mq/gen_disk.rs   |  54 ++++++--
 rust/kernel/block/mq/operations.rs |  65 +++++++--
 rust/kernel/block/mq/raw_writer.rs |  55 --------
 rust/kernel/block/mq/request.rs    |  21 ++-
 rust/kernel/configfs.rs            |   2 +
 rust/kernel/str.rs                 | 163 +++++++++++++++++++++--
 samples/rust/rust_configfs.rs      |   2 +-
 17 files changed, 675 insertions(+), 192 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


