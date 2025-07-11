Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD02D46A6;
	Fri, 11 Jul 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234218; cv=none; b=ciD0VoW1pxXjAGPp+4k9hB5VLLSAFcJwDRUhN1ulkSw25fBYAqWnMQvgCYxckAe2zcv6akjFfQI/FLjPYXfsIc2OdDIdEVH7B0pycqfkROxd3Rq677UEyp6hKR4i682GqP+92Lbhx1VBQW05noZN8fje/pwSl12XsRdXko23Xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234218; c=relaxed/simple;
	bh=AYWYuPxO7KkBuuMRitEmKq+GxfKULamC7whXKRkZjjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UENt1FXvqN2aaTw8S9AdBmDlZxGAaZlVrjTAM58BtLhn/HU+w9aixSucJl7BREzEq2qSRSGDko+Nz6ns23avK2a10wR0POKYYrQK7FN5vBlcCowRxWKnjvByurUbV9FriqX+AK6N3WiYdNd1jmrEpTR0MBszMYhVCVUWLIRKvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz/lqMRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz/lqMRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF33C4CEF4;
	Fri, 11 Jul 2025 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234217;
	bh=AYWYuPxO7KkBuuMRitEmKq+GxfKULamC7whXKRkZjjs=;
	h=From:Subject:Date:To:Cc:From;
	b=Uz/lqMRr0tE2mwFqBzOkD9mc0jQEu0rxpvKyiONs0QyE2s0lBLvgno0d/lVTezMD3
	 1v8W5VRdSudX7qW58yn/L/iG36/Zo/HaSAbz1Z0FH1jChR1A92lHp/6F28AnyLgt7e
	 PCDWlcMSf06mKkIiMDBszdUUcOtdHeiPyIYTJ1cFv1RaxjVO9Ygv3S98ez4gK05uEG
	 52QBYz8f2AmJT2T+NDENE/dUHQ/e39ti2DzuW1e77YVDwsIO6uqJkVSahEEbEldLwZ
	 oMNSU9V4ylqrp0sGrq1TZ0EYyZnduUeH0HTTKS+63gATIhElE+077sZqJZLDYdxOko
	 pcf3cvxunVrBg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v3 00/16] rnull: add configfs, remote completion to rnull
Date: Fri, 11 Jul 2025 13:43:01 +0200
Message-Id: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMX4cGgC/3WMQQ6CMBAAv0J6dk1boBRP/sN4oLiFRlLIVhoN4
 e8WLsYYjzPJzMICksPATtnCCKMLbvQJ8kPG2r7xHYK7JWaSy5IroYD8PAwwTxAVJDRFWQmU2iI
 iS9FEaN1zH16uiXsXHiO99n8Um/27igI4NIVQ2mislJHnO5LH4ThSx7ZXlJ++4vqnl1tv6rzl1
 hayNl/9uq5voQLIYe0AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3443; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=AYWYuPxO7KkBuuMRitEmKq+GxfKULamC7whXKRkZjjs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjHP5ZnY61f3XZXqAPVIRxWptdUKlYpsvJoi
 SWyQtqAhbCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4xwAKCRDhuBo+eShj
 d1CWD/4j4glz2Sc6XkUenGPfXgQjlHIrjFLYiRzcTHRYvmrZcx1CP7FA77GlJTW/dIsaZY0OVCg
 JQ4MA6ODg39orRN+W2NZ1cuAn1nbmfyxKTFcyRKnz4JD5ZL+z2xmxaLGkao/4TXRLLFHl1HnR/A
 PZdSZEJ0BTLuHSaLXmaSGw5ImjHzFWGNcuYIKrq+Ty8HAO1DJkHHy8ZO0455ofM1ZIF0jzoY2Yq
 Ruyb6O7YVN0hlhQMOg92I48oBDJHgsCwLEbuMPdCnVp0YZurjbUr4FJOLFs5EXPHU/oYPlPd0mP
 DhhqfVH49N8aZ0nL3fIem1H1naImXPgWXPlspVAQ5SrLvJjqfCvHR9WVZCb4rT44zfssOg62J0j
 yINp7inr6Vzh7fzAFof650DLiYR7I8chacMwWJDsi4zJZk3l1gcfJq9WwqqiAbSLf3qCt4v9Ldr
 Uab/IxZqv/SsPW6365cEbYUwsA/qcbR9Rx6+yQsrYwp8TJrhE1VA0yokoDNo9PEQMw1KiSYqNzO
 N+8cz7E9bEs0xbC9Wy8R5GA5tKfSAMEG10xjoky0ux1Dipr4HwxmJ4eZB07F7/zg/KMnLn3dS3O
 C2MLoJm7X4BiT2RtIjavKR0oTmtHla5GB9CRtMS5tnERCtoJMJX6t45QgyHP9AEYbsfSMTyEfx5
 4sG0TG6Az07nO4w==
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
Andreas Hindborg (16):
      rust: str: normalize imports in `str.rs`
      rust: str: allow `str::Formatter` to format into `&mut [u8]`.
      rust: str: expose `str::Formatter::new` publicly.
      rust: str: make `RawFormatter::bytes_written` public.
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
 drivers/block/rnull/configfs.rs    | 277 +++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs       | 105 ++++++++++++++
 rust/kernel/block.rs               |  12 ++
 rust/kernel/block/mq.rs            |  14 +-
 rust/kernel/block/mq/gen_disk.rs   |  53 +++++--
 rust/kernel/block/mq/operations.rs |  65 +++++++--
 rust/kernel/block/mq/raw_writer.rs |  55 --------
 rust/kernel/block/mq/request.rs    |  21 ++-
 rust/kernel/str.rs                 |  78 +++++++++--
 15 files changed, 603 insertions(+), 189 deletions(-)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250616-rnull-up-v6-16-b4571e28feee

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


