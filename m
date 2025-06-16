Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECD2DF3FC;
	Mon, 16 Jun 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080362; cv=none; b=Fx5XlAY3x/VWdPWFtWgJ+izpxcEX0Qy8Q3WpaKOXgWhdCrmw/e0ifMD5OQ5JB5YAEJiOxg5W0Hhn32G5wWEDnhKnY6IaRFOXyQkICSax9o8CT7+BMfBy/OuI2V0rxBNLhb8BngYf9QjFq0NvZTYg2z34EdUVEIpwi4HhJxZo0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080362; c=relaxed/simple;
	bh=q5z+RDrW5wBaTgv+OiUSZnpnP7HF8lF6V6SPtIsftTk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aaXLbs+Pm8yRDtCSQehesuNifWGNwmMG/573fhl08W2wfUh2iV75Vt/Xq3h3K9YQIe92dSE63hR3FMiQxwe8AYIv9PnHTi4BDDQoQ8Wx1GNvFok/lZemBnrc/7jD776Z8mRjmBk9M0OlhGMuqM61VJ2M9WgcaapBGyC7bx43nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIHiaGqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIHiaGqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4609EC4CEED;
	Mon, 16 Jun 2025 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080361;
	bh=q5z+RDrW5wBaTgv+OiUSZnpnP7HF8lF6V6SPtIsftTk=;
	h=From:Subject:Date:To:Cc:From;
	b=gIHiaGqrdTgwpUqSc5hhwhxpuLHku0pm+lZWqpTPn0JpC9UaxqmnQo1FyGCDxF9q/
	 fgmVHdHCzYa33x0s1gNll3el9PI77nDgPkSaK5xLbcajuejer03iPAUsQWxAin3Laz
	 kAZuzjuEAx0zCFi9ydrhXEeMiG4hG+gGJyCrJB1kDl6cp1dEoH2toA2i8DMsjBhPWV
	 XqA5hdZFtsN51og48y7j/6y0NJvAmN/2MB/V4v1c5nBuIla5fbC1MwpCBrl56/v7Pn
	 +ZsfS/WJzoAFbBHt42gAsxA9nL+lMbBJgTXiemqvT+3qyDAlZtxYs9JzPIQQ39D3sr
	 xERdsdNaAaOUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 0/9] rnull: add configfs, remote completion to rnull
Date: Mon, 16 Jun 2025 15:23:50 +0200
Message-Id: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOYaUGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Mz3aK80pwc3dIC3TIzXSA3ycTU3DDVyCItNTVVCaipoCg1LbMCbGB
 0bG0tANeNDgRgAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=q5z+RDrW5wBaTgv+OiUSZnpnP7HF8lF6V6SPtIsftTk=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBr7WTgCTS8TfgSuYJoTWqQodyyJWmJkAZd/V
 W1Mpo4Lu8+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAa+wAKCRDhuBo+eShj
 d8SAEACjJoRClB2tKTL0F8DZAUk/J63U3T2T7+0Ct2AWDGqyBO/Elbi0ZU+L3HgUhWJNzBlIiZn
 MHt4uPu11aNgxGaD1Rok0TFlBA90SiXmlx5KktVSsTO7wm+thiphpoo94vyarKnVMHMSfDOxE43
 IWWgRyvEA6EP17+C5fdFPo4agRuHxoLt/JK1/4RjVOHTSrdlXoWyVQPlOUVJkcmktbgFhNEUdA+
 auq19fLyhWF6cW1EAVwTSjxlUEUhFE7TjmZvHhqMNeJQDxnNW38U8BIp+HXIH8BpHjsjzY4P3YV
 eKaN+m71blCJHXQjvVnWd4qZQQERPYO1/cg5+Czv9RVV7yB12DRsY1WAtVaIPMeH8OnNKPJb4+N
 pEnjih+dJzxy9gbbcyvXcik/2KsuUHlnkTlVZhYEQcY07i9FSpMamdSKnaY9LP8T0ehtKdfx0cP
 Ibf2W9hRhr5l6NPm042o2+s2kFdNugvsEfP4dhEaVF0dUxtkMJZjQzFCGqIfc1m/NQDPIwxEUyJ
 Xlsom6Ulu22sQ1LGg+Vk3KwmDU3kTqP1Tv7Rl60k/PPWWbVFcvFQQDrdg/Ef9boJmJuZAVe0YiY
 Z00/ievLStF/F/0upcfVdMr/pCeJMi2wPyCG0tO4Kp2vd8uUTRSMpN/B+bmBnl1GDpcx6vuQzjN
 TLWZDH+BEGWlMUw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series adds configuration via configfs and remote completion to
the rnull driver. The series also includes a set of changes to the
rust block device driver API: a few cleanup patches, and a few features
supporting the rnull changes.

This series is a smaller subset of the patches available in the
downstream rnull tree. I hope to minimize the delta between upstream
and downstream over the next few kernel releases.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Andreas Hindborg (9):
      rust: block: remove trait bound from `mq::Request` definition
      rust: block: add block related constants
      rust: block,core: rename `RawWriter` to `BufferWriter`
      rnull: move driver to separate directory
      rnull: enable configuration via `configfs`
      rust: block: add `GenDisk` private data support
      rust: block: mq: fix spelling in a safety comment
      rust: block: add remote completion to `Request`
      rnull: add soft-irq completion support

 MAINTAINERS                                        |   2 +-
 drivers/block/Kconfig                              |  10 +-
 drivers/block/Makefile                             |   4 +-
 drivers/block/rnull.rs                             |  80 ------
 drivers/block/rnull/Kconfig                        |  13 +
 drivers/block/rnull/Makefile                       |   3 +
 drivers/block/rnull/configfs.rs                    | 277 +++++++++++++++++++++
 drivers/block/rnull/rnull.rs                       | 105 ++++++++
 rust/kernel/block.rs                               |  12 +
 rust/kernel/block/mq.rs                            |  14 +-
 rust/kernel/block/mq/gen_disk.rs                   |  53 +++-
 rust/kernel/block/mq/operations.rs                 |  65 ++++-
 rust/kernel/block/mq/request.rs                    |  21 +-
 rust/kernel/str.rs                                 |   3 +
 .../mq/raw_writer.rs => str/buffer_writer.rs}      |  17 +-
 15 files changed, 550 insertions(+), 129 deletions(-)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


