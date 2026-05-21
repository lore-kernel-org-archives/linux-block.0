Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7F385D93;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346633; cv=none; b=K2XsW1yvECvWBgXkshuR0WbNxohUk9hXad7Kpsdt1GpUnVl60CoAR8wmTiSE8uFyPwoHszCiXEfggmmyiLYKoMtbfFDkShptm4ZhbE8NvbYz5Wy2P2CC110SiiWqtb5cyEiIfBK2Wuf5RYMn03IZv71jHhBWyf4QF5SQToGuRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346633; c=relaxed/simple;
	bh=GpYuZvdDKSuZ1FkselZsxzc4wSkWmWm7XFBxDLF6Dfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dUJ4i/6xegBZpP6pzV32CU5DK3IoMql++8YZI9Xkn+GGWDvadZBvMgabXf93LBCetQVTn8O9PxK1umT5JpV+oTcwucfx91NtGg+R+BU+rEbBc8pNjLEyltMDfhZAzRCpqC9jWSpXvUX1VcxmH8+0Az/8FbTx4SbDC90m/K5RVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hLMjqvYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hLMjqvYn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ADABC2BCB4;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=GpYuZvdDKSuZ1FkselZsxzc4wSkWmWm7XFBxDLF6Dfo=;
	h=From:Subject:Date:To:Cc:From;
	b=hLMjqvYnQWOz8cctvuijoJ4Mx4x8ZG9jdUaupVfEVNEJMxTIIkhSfgivIE71jIwSG
	 BhqwJlxem1laR+31rwhGzmrltCz44aecosZdZNlWYUvKKFBnNBdsCs9r80RI3jwhxu
	 CMB8TUBuTK6jJRuVaijhjhJD4PDHJfKBRHKNX4/4=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF4CD4F3C;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Subject: [PATCH v3 0/7] rust: use vertical import style and remove
 redundant imports
Date: Thu, 21 May 2026 14:57:06 +0800
Message-Id: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKsDmoC/33NzQ6CMAzA8VchO1uzjg/Bk+9hPIytSBMBs8GCI
 by7gxMH4/HftL8uwpNj8uKaLMJRYM9DHyM9JcK0un8SsI0tlFSFzLGCjr2xFGDyBM3gOj1Cpes
 LlWmNBlHEw7ejhucdvT9it+zHwX32HwG36V8uIEhAtLkqai3JmtuL+2k+xzWxcUEdCCV/EioSR
 WZNVjYG0yw/Euu6fgGytJ6W9wAAAA==
X-Change-ID: 20260519-miscdev-use-format-9ab7e83b1c11
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Alvin Sun <alvin.sun@linux.dev>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=2046;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=GpYuZvdDKSuZ1FkselZsxzc4wSkWmWm7XFBxDLF6Dfo=;
 b=9TEu8Yc9XNqL9wX0FvAYfA0lvscmTHZs2twn+GcDzJhNe5UnPm8lthdGPe11tTpP2XTfpTgo3
 JcXbyTOrc1gDOUZSajW+eZGDIefXk0kBSHzEZIvvVqnOjic1rkaxH4B
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Adopt the vertical import style and drop redundant imports already
re-exported via `kernel::prelude`.

Changes include:
- Convert use statements to vertical import style in miscdevice,
  samples, doctest, and block/mq
- Remove imports covered by prelude and apply minor formatting

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
Changes in v3:
- Add trailing // to last items and closing braces in block/mq imports
- Add rnull vertical import style
- Add doctest vertical import style
- Link to v2: https://lore.kernel.org/r/20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev

Changes in v2:
- Reformat use statements and drop redundant imports in
  rust/kernel/block/mq
- Drop redundant imports in rust/kernel/miscdevice
- Link to v1: https://lore.kernel.org/r/20260519-miscdev-use-format-v1-0-11d526ba0edc@linux.dev

---
Alvin Sun (7):
      rust: miscdevice: use vertical import style
      samples: rust_misc_device: use vertical import style
      rust: miscdevice: remove redundant imports
      rust: block: mq: use vertical import style
      rust: block: mq: remove redundant imports and format
      rust: block: rnull: use vertical import style
      rust: doctest: use vertical import style

 drivers/block/rnull/configfs.rs    | 27 +++++++++++++++++++++------
 drivers/block/rnull/rnull.rs       | 15 +++++++++++----
 rust/kernel/block/mq/gen_disk.rs   | 24 ++++++++++++++++++------
 rust/kernel/block/mq/operations.rs | 14 ++++++++++----
 rust/kernel/block/mq/request.rs    | 16 +++++++++++-----
 rust/kernel/block/mq/tag_set.rs    | 28 ++++++++++++++--------------
 rust/kernel/miscdevice.rs          | 23 +++++++++++++++++------
 samples/rust/rust_misc_device.rs   | 34 ++++++++++++++++++++++++++++------
 scripts/rustdoc_test_gen.rs        | 11 +++++++++--
 9 files changed, 139 insertions(+), 53 deletions(-)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260519-miscdev-use-format-9ab7e83b1c11

Best regards,
-- 
Alvin Sun <alvin.sun@linux.dev>


