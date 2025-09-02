Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307712EFDB7;
	Tue,  2 Sep 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806983; cv=none; b=dQzeiTDrPr0y89V6csxNxo4esgXekMmtZrhOEiDw400evFQx5OyR38s07hPep7O+8su2PjkDUpyh170mNIgF6cq3hl9Uw1Z6Jx3XpFjRfvCQQrLzyUenJQ70gkpqIYoADwpro7q+ZlSzLjyjK1EbK6IiD20lREeid81yxDXjtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806983; c=relaxed/simple;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwEjFhpi0YUwcR4aT9Usb0hyKFTEV1UfPVlf7K+Amm/2JxteifmvBN5SYCHvJ0C+5kortv7sUfqTgmqKlF8CDGWbHdlAnVMihJ1XAnkJf3j/go0b7mUfc2Rnq6BHI3oBPTkHYjdUXxRM1xd5FfJrm933YhezzdLXC1BsOz9Jwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL1cnGHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL1cnGHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F368C4CEED;
	Tue,  2 Sep 2025 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806983;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WL1cnGHEhqQZrPwsVedZEVINUE+NaF37SCoy6A6HhUZq0YRxlUI0+rmM/UuZOtiZf
	 2i4T7I8RyE+yHhLEBPVO4YntWEWhxyago9wcbk6iOrt0pUx6bc32ANs38oyKw1GQpL
	 U8id0MxX1ljr86B3DDpXEznEJMIsy9S/lsZ79I3fkRpmBqIPaqiAK5UETckuk1+TdL
	 IZDpBnyIFcOrCwuXUCOEBc4eqNg/o+zdFg0u2yK7OZDQlg8inxaz3CnNOvFbqmigOt
	 1MjQZOIdYPRzqKm7LVTEiIoTfJVssBoDxJiaKv1JgfiI//D2tSXqBk6kZedY6A2vJw
	 P+d0fNaE3n81A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:01 +0200
Subject: [PATCH v7 07/17] rust: block: normalize imports for `gen_disk.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-7-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr7/T9AybLo0yTdjc2xqJFr0ZCmIyrcy7GdeA
 x9Y+8kuTHSJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa+/wAKCRDhuBo+eShj
 d+YWEACX4L3b5NzVQXiqKxshBZEsO7AjbHqycBhW+Pr/wtbrN+1WnwseqKD3bdq9vUt+jQq3b+j
 JSDlS8uJvyMApTh4txv0S0WRdGna2xObbNxYjlT+Q9gskFAlmdbnzpyVzoOVHyZkt90J7Yns2/U
 lCM1BcqOHylBvZl1eh92+2wJnU+DyMxpmyXIxChqFBzzB5k+4rFBmTatB6exvxuY8zu8F066iQX
 sflZhkKNRBwNbCg1XGBYVLPTiDmchSHGFWIcDdMVh6snTf6vS+CI2AERzDqn0R5oesi+HWbp/Fm
 rfywLeLysoAJn6HkxcFZgjgAbVrTtE60hSAsV5hcJJUK2AlYrQizwAYSckzt57HGkOXYzUp2Uil
 43dfG3cu9gjqx9Upnzur1cK8PwWcMc1LrEmJ8gENsWuidAyzYB7zXG6T6ew5xXmIindHn7TgEBJ
 gsdIXhOAmeZACsiOJTJ0A7CrgheN0dRg9DXHHJeJt6Y9qWCvUCeIOlkuSHw0m33PYAxyaGzkx7P
 UGfiDxyxipplsBuJkqNxIpCBjDWObg594tF47Ge5JRWIMw+OYsKOBr2wkrjp6u0p7a553x5M473
 xc+0WuWpgYj0WWwyTVbHT/lVIXN83kqdYlAfEPKf6X6KwtL7z8OtIZ5K9P+K/w/IzEmwugYO2so
 Dlr65RvJzauK6lw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up the import statements in `gen_disk.rs` to make the code easier to
maintain.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..679ee1bb2195 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -5,9 +5,13 @@
 //! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
-use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
-use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
-use crate::{error, static_lock_class};
+use crate::{
+    bindings,
+    block::mq::{raw_writer::RawWriter, Operations, TagSet},
+    error::{self, from_err_ptr, Result},
+    static_lock_class,
+    sync::Arc,
+};
 use core::fmt::{self, Write};
 
 /// A builder for [`GenDisk`].

-- 
2.47.2


