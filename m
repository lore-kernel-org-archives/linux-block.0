Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EA3043B2;
	Wed, 20 May 2026 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244813; cv=none; b=eJ5674K9SqZxJ8gtvO+BumZMnw4r25ZCdvPdmZACbKvbt8un24DV1PZAYaakEAksMGszAuKiC1Ozi1lPQd78vSliqn9KuEf/VFsWAqfw4OBL0F8j75St3zwRu5PcyxMOLnjsZdI7rJtvKC27LNFQuaxZPuYLQVFmO9qJBqhzAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244813; c=relaxed/simple;
	bh=Hv8oiDoc72/q0+gxKh9/jmGPhQAnR4AAfVS+LzRRfOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uZB+WgHB90j8EuF9NS9NuRtayGUlbnTw4mkwJKzQAjmtcac41jJ8UWeWeFowsCwSqJNvNqk3N11gmNEZwrbJxmes1A6pgNTO1okOljHwfuAdJEBju1FDKpwEu8/UrIY7dJMWfJIAJdmkMMdMLw7NruWtVe5NAXGjbYrzcH1D5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nix81bvu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nix81bvu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC690C2BCB3;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779244812; bh=Hv8oiDoc72/q0+gxKh9/jmGPhQAnR4AAfVS+LzRRfOM=;
	h=From:Subject:Date:To:Cc:From;
	b=Nix81bvui69EuOIcH+v7ph2G3/TcHCRgu8u5FIl5bzVDSJyyt0IpKrcv0xroMT7+2
	 SpQEQV+MqIVOcOhuzIIioNMXx0GCT9ZqS7dMCeoPbp861lGjAvNys4r9uFt4upqlRY
	 O3x+VsAcFdAbTMIl5ds1mb6wga7rZwCoJ0kWYlDc=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDECD5BAA;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Subject: [PATCH v2 0/5] rust: use vertical import style and remove
 redundant imports
Date: Wed, 20 May 2026 10:40:07 +0800
Message-Id: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcfDWoC/32NTQ6CMBCFr0Jm7ZhODSiuvIdhUdpBJpGftNBgS
 O9u5QAuv5f3vrdDYC8c4F7s4DlKkGnMoE8F2N6ML0ZxmUErXamSahwkWMcR18DYTX4wC9amvfL
 t0pIlgjycPXeyHdJnk7mXsEz+c3xE+qV/dZFQIZErddUaxc4+3jKu2znXoEkpfQG5JvLHtAAAA
 A==
X-Change-ID: 20260519-miscdev-use-format-9ab7e83b1c11
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779244810; l=1492;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=Hv8oiDoc72/q0+gxKh9/jmGPhQAnR4AAfVS+LzRRfOM=;
 b=CFWnBYhTjTZYwAzmq9aXO+nXCwy/oiLk4U6U/3oTJPXTu/ExR2jY/C4j8sUHGhHeD1vwW5vNE
 OI9/eGHNVO7BOY2Dm5tM7O33smR0G8Sr+6Ab+3NveJl3An92aJ0pBgf
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Adopt the vertical import style and drop redundant imports already
re-exported via `kernel::prelude`.

Changes include:
- Convert use statements to vertical import style in miscdevice,
  samples, and block/mq
- Remove imports covered by prelude and apply minor formatting

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
Changes in v2:
- Reformat use statements and drop redundant imports in
  rust/kernel/block/mq
- Drop redundant imports in rust/kernel/miscdevice
- Link to v1: https://lore.kernel.org/r/20260519-miscdev-use-format-v1-0-11d526ba0edc@linux.dev

---
Alvin Sun (5):
      rust: miscdevice: use vertical import style
      samples: rust_misc_device: use vertical import style
      rust: miscdevice: remove redundant imports
      rust: block: mq: use vertical import style
      rust: block: mq: remove redundant imports and format

 rust/kernel/block/mq/gen_disk.rs   | 24 ++++++++++++++++++------
 rust/kernel/block/mq/operations.rs | 14 ++++++++++----
 rust/kernel/block/mq/request.rs    | 14 ++++++++++----
 rust/kernel/block/mq/tag_set.rs    | 28 ++++++++++++++--------------
 rust/kernel/miscdevice.rs          | 23 +++++++++++++++++------
 samples/rust/rust_misc_device.rs   | 34 ++++++++++++++++++++++++++++------
 6 files changed, 97 insertions(+), 40 deletions(-)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260519-miscdev-use-format-9ab7e83b1c11

Best regards,
-- 
Alvin Sun <alvin.sun@linux.dev>


