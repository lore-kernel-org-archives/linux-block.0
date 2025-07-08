Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7123ED69;
	Tue,  8 Jul 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003976; cv=none; b=IWB2jFnPYFn2tOQlQK5p9fAs6aJGj6az7XEXhB6uOugjmIaVhhHbXbbBpjiM8LN9Ywwb570Mz7n7Io7ndD8TBqHuXuSKPOh2FwsQYSYTJ1ABZ3VILdrMeP1CTjr3Bhv5qA4zHHd8bIbuWlupjYJiYSEbcqqmlnsdWa9BXaJWcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003976; c=relaxed/simple;
	bh=L2wr4k193kbQ+EZ3WJsPLRyFUtGJsDx6XOUn90oep28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bJMAdQ/AM/MZnMsvksL720fiarsrdgrOZ9PHCdWM8jLOkuItR24kTzUHGmnZulNLvBEtd8tFpRayYSF6r7+xxsIkzBMg1DwWO7q0Zdp9BixGdVBdXgmT7CaRqPbNwF2eCt6Ra821EcsGzchg14s+8Ud/wZVlNRexQB5139qvBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IINgpaq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IINgpaq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A5C4CEF0;
	Tue,  8 Jul 2025 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003976;
	bh=L2wr4k193kbQ+EZ3WJsPLRyFUtGJsDx6XOUn90oep28=;
	h=From:Subject:Date:To:Cc:From;
	b=IINgpaq2NU0WgBcGKQh3AeTqaD2sgzbEkLKkHJhQliL5//fomYZ2fu1Tl5Crt1CRq
	 OBo/pRHVe3SSiYPUzEC9g2NOJ/ooFYs89NmcpE1vNTvaXM3zIAXoJsGPpk+35rf4+N
	 7jhM5dkr905KnY9ENKPVuFKlpX+cGebM4bK6c3aEs1nOfk8c7dQ9F8Tj5b02t4EW3d
	 0N7+PREs6kKUD1hmFoq11wuiy2zLTX8+gi9mm1lE+XfHu9JeB7RhU7cWhHEIf/xvFb
	 CyvLVhBo/1zehIRvFKHLzW31PLc/7hJHgKvXh4VAJUhjLl0AwRYWIYEqHagdYe+I66
	 Urqmah4x2Q9yQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v2 00/14] rnull: add configfs, remote completion to rnull
Date: Tue, 08 Jul 2025 21:44:55 +0200
Message-Id: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADd1bWgC/3XMQQ7CIBCF4as0s3YMkJYSV97DdFF02hIJNIMlm
 oa7i927/F7y/h0SsaMEl2YHpuySi6FCnRq4L2OYCd2jGpRQndBSI4fNe9xWzBorbdv1kpSZiAj
 qaWWa3PsI3obqxaVX5M/Rz/K3/k1liQLHVmpjDfXaquuTOJA/R55hKKV8AdKcQuutAAAA
X-Change-ID: 20250616-rnull-up-v6-16-b4571e28feee
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2701; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=L2wr4k193kbQ+EZ3WJsPLRyFUtGJsDx6XOUn90oep28=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXU86luDbFJMpkovjftupsWMSVtlFMMO0pq1j
 wl0F1ddBH6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11PAAKCRDhuBo+eShj
 d+KVD/4rrYsswPHTUb+mf+9/hZqJ9kGBFjLiyTUSmJwGh0VGDadEQiuX6LEk/I2WFLvKHGhpHDD
 PwAFRnL7knX+lM0exs5WC7gl3W1qTGbswzWyN76xO4Xgt+DkduDE7k/SpkvqBiH1h/ceR5mzXvo
 gOFMUQEGKpgRXtke9nMPpEkdoj+I1U9scuItlsPGyICXntH9Z0+bLSUgCyXEJvrMe+loCdd/maV
 lznt0p/HFCMk2bVkQQZsmk00yyq5BfuFi6dHXAUPMaMoRrowrPxNRNcBWYx5Ddjt31WTJ8Yknm8
 OtOcEOHPLWNxLcFymigc62Kr8ibyVs/e7vDsnz1cS5nj1eBZ+X19Nl5tRaeDO/38niw0A1xfToL
 wSeQngMDL54p+K/OlgPn4PBmWHHbiBYH2qFfVsOUUiBRZPnA1J4x8vEB3LUR+y2ogp8gxL9VsZj
 6chermwh1JmwV4RhfQcewP9W9X8gCZsLmR6H3PQztX52PGkivnNwTZAud078t5+x0T6eZSF3dYX
 /1u9CZz+hOTWfh6Y62SsDngtNFiQsiFTrBsoqFU6vYF72sQsdgjHqdZ4TxQ1xczbr7sg+CUKrqK
 O90OcQmpCvK16ne5o0v5aAwuj1ukLb7YKeQDOJ8mpaiCN0nPjvzu8No4B9yGOwBAkfTMhQLXoE7
 a4K09vkmmvgy1OA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series adds configuration via configfs and remote completion to
the rnull driver. The series also includes a set of changes to the
rust block device driver API: a few cleanup patches, and a few features
supporting the rnull changes.

The series moves the raw buffer formatting logic from `kernel::block`
to `kernel::string` and also improves that logic a bit.

This series is a smaller subset of the patches available in the
downstream rnull tree. I hope to minimize the delta between upstream
and downstream over the next few kernel releases.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v2:
- Rework formatter logic. Add two new formatters that write to slices,
  one of which adds a trailing null byte.
- Reorder and split patches so that changes are more clear.
- Fix a typo in soft-irq patch summary.
- Link to v1: https://lore.kernel.org/r/20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org

---
Andreas Hindborg (14):
      rust: str: normalize imports in `str.rs`
      rust: str: introduce `BorrowFormatter`
      rust: str: introduce `NullBorrowFormatter`
      rust: block: normalize imports for `gen_disk.rs`
      rust: block: use `NullBorrowFormatter`
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
 drivers/block/rnull/configfs.rs    | 277 +++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs       | 105 ++++++++++++++
 rust/kernel/block.rs               |  12 ++
 rust/kernel/block/mq.rs            |  14 +-
 rust/kernel/block/mq/gen_disk.rs   |  50 +++++--
 rust/kernel/block/mq/operations.rs |  65 +++++++--
 rust/kernel/block/mq/raw_writer.rs |  55 --------
 rust/kernel/block/mq/request.rs    |  21 ++-
 rust/kernel/str.rs                 |  95 ++++++++++++-
 15 files changed, 622 insertions(+), 184 deletions(-)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


