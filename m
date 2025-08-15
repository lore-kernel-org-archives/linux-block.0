Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4A2E5B22;
	Fri, 15 Aug 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243145; cv=none; b=LOd0HW7GRz6wH/5bY1+5H+rJ9Ynjk6eBiO9NW68pDn+LZu8sRK9+xMsvcE6xuMph0hPOQNVvZoxKDJTnWmeUu/HIU6OUyV0suhqyAo1yjOqgsQC9uI4Ws0EVUKagl3QBr+/jXPqWpOUkjkx556bxjyIcP3yBgqYChhH5HYujK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243145; c=relaxed/simple;
	bh=9tB3J7dQh1l4F9h682AUS4KgJYolTIIS1I+Be6X1aiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r16uji2k5j4dAyOTxt6qqv1VCQxw2KqpxFTtS+eFF6jZEofJLHSLWP0sTUVkIthPSTO0Jv9Vqg+/0rtXAUXYpk0pjOhvOEUZpnrL8dgbYGb7nMZtukB0YHisXGRIlQGOvN9njzn7QThxoS/01N+5RQqn1flkiK1YgvdfUVhFPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgsr+D0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgsr+D0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE96C4CEEB;
	Fri, 15 Aug 2025 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243145;
	bh=9tB3J7dQh1l4F9h682AUS4KgJYolTIIS1I+Be6X1aiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qgsr+D0MaqWugibKHWjkFj+jyGiYjwv/oPDwolUsyfl8N+IKngNZwLbArXpg+UTwU
	 X3K0VFjGwHmOsSD6rxjr2klvoo8FjsqZApCJKKcih2MrGepGXAuqlh2xWCvHAXGwnp
	 tOk2T582RanDt/IFXF62mzlp+LN+w63HqpnEZYtTdTTsNjKwpepIePczizA9ZThSAu
	 ahp5JQQEMW303T7YslMkoUEMPtACf0mOlqeTfWgJ2N6Img4fRsVXAWtpl1Or4Nk9wI
	 jKXjjEWCm08uff9DVPS4KDPIXTYre7Yu+5TwADlBOu3GVHMJDBFHBQJjZIf2DLmF89
	 k1pIhtpz68Gsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:44 +0200
Subject: [PATCH v5 09/18] rust: block: use `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-9-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=9tB3J7dQh1l4F9h682AUS4KgJYolTIIS1I+Be6X1aiI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI8C7IcaT3KXeuk4OwrC7yn2hhwBakMYVjnx
 QoIQB7uJEaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iPAAKCRDhuBo+eShj
 d/VjD/wMq9kMtBAqFA2AgP+zUOtNrIHoueX9M68IaQ23GkiBAUsf9CUMyVukOx25/fmMzL8/4lO
 VzjBom+MaWDDs1fU2CKU/5nu0Ol4t7qhkJlB5zNOh5gz+N9KrRpGnByEtm6Ulm91LuacSTE74V4
 AcBm78bgOqLd18Yln1+7VMQUanBPfpzl3ppQa+yhHhts6M5FzUnlfHO+RDd5TcfK/NW6Yp422Hm
 MmqEDON4wshS3nWrwr9Xof0bpg4i5Zg7dnD6la0zYoU+qt7XlomGHSweWvNBrC6jRT6iItxSS6f
 62f9mTcBx0/WJvIli7UhqY3n0uCSNuo5v5Y1D9nd5Zo01p+TFxCbjfGwaACT/malUnGQieNKf6Z
 2h1opvHsVo4cigPu0e2uJbWe78yntPTc0llngTM9nzOIpNNWREkcI5RClfZfWa4hFLxlCp5RxCP
 2yiNnBhq0yGqJF9vRWpk3OoKqyN19u3oyHwjory4sltjuDnvm44Sbg0N6P2/Tdc9k04FGV89xMQ
 L5kKTotZDKyiXvnfIen1WIMCWvh8XSJYuGj729bi0VeI7YHOkatzMjKsxyEmrLmiSUvfrwXFZRg
 R9U3jhMX5/bKzMiYhacdcf16HzH1TuE2SO8uZYKA5bAkLOQEvFjhVgxbqf7gZcSZmmSzz62EYkC
 T7T/KIKQbwKNDpg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
the name buffer. This new formatter automatically adds a trailing null
marker after the written characters, so we don't need to append that at the
call site any longer.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   | 12 +++++++-----
 rust/kernel/block/mq/raw_writer.rs |  1 +
 rust/kernel/str.rs                 |  1 -
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 679ee1bb2195..20f1d46c774d 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,9 +7,11 @@
 
 use crate::{
     bindings,
-    block::mq::{raw_writer::RawWriter, Operations, TagSet},
+    block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
+    prelude::*,
     static_lock_class,
+    str::NullTerminatedFormatter,
     sync::Arc,
 };
 use core::fmt::{self, Write};
@@ -143,14 +145,14 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let mut raw_writer = RawWriter::from_array(
+        let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
             // yet.
             unsafe { &mut (*gendisk).disk_name },
-        )?;
-        raw_writer.write_fmt(name)?;
-        raw_writer.write_char('\0')?;
+        )
+        .ok_or(EINVAL)?;
+        writer.write_fmt(name)?;
 
         // SAFETY: `gendisk` points to a valid and initialized instance of
         // `struct gendisk`. `set_capacity` takes a lock to synchronize this
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 7e2159e4f6a6..0aef55703e71 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -24,6 +24,7 @@ fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
         Ok(Self { buffer, pos: 0 })
     }
 
+    #[expect(dead_code)]
     pub(crate) fn from_array<const N: usize>(
         a: &'a mut [crate::ffi::c_char; N],
     ) -> Result<RawWriter<'a>> {
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index ced1cb639efc..2ea3ea1bdb4b 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -886,7 +886,6 @@ pub(crate) struct NullTerminatedFormatter<'a> {
 
 impl<'a> NullTerminatedFormatter<'a> {
     /// Create a new [`Self`] instance.
-    #[expect(dead_code)]
     pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
         *(buffer.first_mut()?) = 0;
 

-- 
2.47.2


