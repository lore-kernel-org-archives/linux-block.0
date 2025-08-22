Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D92FD1CE;
	Fri, 22 Aug 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864922; cv=none; b=thAHMqCunaXNE2b2KkuCMg7h4ibZfVNZzJg5gzhNPXqqSDX06hpDZRUNl25kW5GTdDu4gqAiLxIdEH6oGUPbVW77TxIzzrq8AUabCgoRN8d06N4FN4WQn+IKIioS7J3MJRzzKSSlGLfmb8OeFkJsXX6HD829nFzGOAKpMbnCn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864922; c=relaxed/simple;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYj3SzF/XCmk1G4YvT6Q1vbzEhVGfJGsS88BrmVZJr3JIQVyFb1f5sAMuNrzSrZtLeLmEEVauEphz+s7ufp0mzXuJCl7Tys2DYB29XVpcKhV9xqzD6zldV7ugFoOkYNMKo8B8jJzESfxZtj6CVwBhGdZktFM2j3GLQhDQMq7EnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTkOEpWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTkOEpWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB522C113D0;
	Fri, 22 Aug 2025 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864922;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UTkOEpWrLXJcs42jUIvOnetUEv2udipxzsscUOceES+Qauxe1dY7I2xZcD2w8m4hP
	 TwBQM7MuWlYlad0UGtrWDrraur54OSJO2OSC0Niqe/wuOD/6aqeshyR7KR1cTykOMu
	 9ONCK3v8qoIUF+gcAC7PLFUWAGWjLpI61NaBpb4sdMv4gkDD3qK39yTowe/qwfXDAg
	 SfbZXPWBtr92VQS29sFuUDlHQ5buy2U5skIixnZ1G9rKn4JdAPDlTtrxUmNqhobCy5
	 dSVyKPABePoQN2GF+DEahsAycGaZa5xh2fNiTgZlIocyREnYvgPJhlkOSpxLCbO+/e
	 5K4VPJ1uX38zw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:44 +0200
Subject: [PATCH v6 08/18] rust: block: normalize imports for `gen_disk.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-8-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF84IZsT/PnZCkY0C5tGvDURlEdBW+zo4aeAe
 sbUkXcKYB6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfOAAKCRDhuBo+eShj
 dzQTEACH3/BznknYgy92P4Z7MDtqAQS7KjEC+y+w2I35vtnXwaCX+/puZnoBQamnsS3sOJQGaib
 nOjyFL+LYLA1yad9+Ugpn21KRaGbKzM7GaJYdzuUkUJ+d592isdYxbYRHiWVD+OaYCUjTemIDBF
 HZ5kgHoX3JPWqJuUlV/5SPOZLF8vyMPLe17D/e/EpFPJSNdEe8e2dnZXtFULb9SRexpVATzPMJp
 yMViMtWhr7EkoTbZnv615gveVGIanp6/gp4JvzC+SuBZoVw/hFtqvESr2pqjEs6rutM2+PxhJ5Y
 vSgLrwAMDRv5WmvTE7Ref66UbvQccJa9d6Xb6/eqbQATdyWi8GXSaP2iIs4q4FUCW0i7tcatDBk
 bu7dFx4GklCl1akhxDPmsuuPjPNovMtNDpMYuRWOV01NnJVIaU2zV4KkFIHNCUqH53Heh6JWfZf
 6Y8nArdvUV3K2J51HCkADhXkroKXAavfoMzv4ic2uQ+gQRSjstB9s/NQPxyLw9vNRZPQL89pNdr
 uh9qHt6EH+rSdsWGGKXRnO/8aLVGg2rmZNYrCCXKQd50TyO5KQ+5EuUbaS7F9GKLk4mSxwT5Ao5
 X2gQxcCrjVxYaBvY4Z/EFFE9kbYzYtv+GOAIQ5xENjeehuC5b5sngMgjWek/PPGSTfThy7eJTL3
 Fo+R41q372PA2kw==
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


