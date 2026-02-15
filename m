Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC762DF137;
	Sun, 15 Feb 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199121; cv=none; b=AG5BXMyaEPFiWERRawHslsPjcNrELDTbFq35pobsuKY57FlmMA2dOQx7Zer4fQ+tatGA81YEfZ9mgRC2J1MInvvXKwZiHQMwJG0goPYyPWiyAwaFqKpdI0wqdfSwULSlPO4gMYAIw9ln9vE6szsZjgsYENDELtNUvRaF3VQcHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199121; c=relaxed/simple;
	bh=eIKMKUHsinnjm6IdiHwgx8Cbg+4YOZ96zj8DP30QUB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXc510TgKr+0RzE33lhMl3N5x0OlU8RGr+U/AQPSH4udhgjUc0a1a+pDj0yCwvPGLJeCQ7wSouYEmDhuAcD1Jd3aoO+OhJAzXWSqDMjbq4Z980BTWCF06fCXY0rdI1CgHd34bH+jc/Qh8en1oK8SeXnvT+iv7xy0+upEwJfxahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbc0r5Qr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbc0r5Qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA85AC4CEF7;
	Sun, 15 Feb 2026 23:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199121;
	bh=eIKMKUHsinnjm6IdiHwgx8Cbg+4YOZ96zj8DP30QUB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rbc0r5Qrb7qkrPQNiJhEBZ/acLMM0TcAMN3AMncJp2J+dllypKZuVEnbEuLEdtPqe
	 kAkj28y8tQoORj03TgbhgyHxbtBUgTIg7TnDKh9LvzRQRpPa/kOlStL2AJJJcFlh2G
	 OBYUszJXkIqmN6LV7neooRwL0Oia03CB8TCbPZoSyqIrLVnAL/eY7EHgVrRiIj4jFj
	 cDXes+AKBsTL5FZJTBzNzPntyDprzHoOdcJ9oJcx3u1h7FwlVcfCk5dNe6CKebmC9Y
	 2IW7RK0jWDli2Qgl6MzZM65u3Uq9OI4AhCNXhfBwPOJ88Y7umYxeJot8XzSHbXVSXN
	 re0k1O/fG1qBQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:48 +0100
Subject: [PATCH 61/79] block: rust: add `GenDisk::tag_set`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-61-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=eIKMKUHsinnjm6IdiHwgx8Cbg+4YOZ96zj8DP30QUB0=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhSUpM//34bJGuIqeD4kIISe6J2+Xnz/36Oz
 i3Tue+aVvaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYUgAKCRDhuBo+eShj
 d2ACD/9agCA2MGNXTbdM1QI2Fqe0Uv4YftmLwHQmg3ttOb56ej/wO1bKYAhe0GN0qziAWopJau4
 o0v2t8yrPv+7WU6DIDSmuRZpgPzPnTRuoGFYQZ6Lh411eX8QrJxB2O7q8ifRdC4mFnbjtwDg2C3
 4fPmL3+dZ1q+993ilNfCnY0Z4UlN7HY+SQwoykInhH+N4AE05eaLRn46TUygY45VrAB64SUbfn1
 IajI0wymMUHYBZ+HzBY7g3eGoN0VYsdF+3DrIROzEEKGT1H8civF+vq5l5vOERuM/dNgFUfoL2c
 5CmmyxBVVkScEaqYEKacICSZyO1E3RYo8K6dway2M/RkKEqDTg1Fx66SAJtm40J6Ey9Aw6ItnVe
 EEmVReAdxwoOBGi/lmHD/PFLujWLvXcynBCLOzH2RSh7jhwhFUi3GHsYsExziyRzVJUhwG22D8m
 ld6ezc0wQ4S9YIKtIwU4AGc/KbXTL3kQRQnDff43cWlMCXT7msoIBuOAxCDS4x0QXOUR4/XHONr
 qbxDBnvXoe84HzyMkXKj7Rl7scESnbv0+LU67zAnYhfYYl4i4QRoTDxUuW17OqbwhbFFEyEkH9c
 IcqmDeQr/0HbO7kmpejntQgs1BLHmNyIbwFKOYg/soSqoUP/7EWEhaXufcHs+aRrSCpsmseuSe/
 Z4FtD6NOI8sKr1w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `GenDisk` to obtain a reference to the associated `TagSet`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index c6b9839864012..b5291bc3e051d 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -236,7 +236,7 @@ pub fn build(
         // `__blk_mq_alloc_disk` above.
         let mut disk = UniqueArc::new(
             GenDisk {
-                _tagset: tagset,
+                tag_set: tagset,
                 gendisk,
                 backref: Arc::pin_init(
                     // INVARIANT: We break `GenDiskRef` invariant here, but we restore it below.
@@ -320,7 +320,7 @@ pub(crate) const fn build_vtable() -> &'static bindings::block_device_operations
 ///    `bindings::device_add_disk`.
 ///  - `self.gendisk.queue.queuedata` is initialized by a call to `ForeignOwnable::into_foreign`.
 pub struct GenDisk<T: Operations> {
-    _tagset: Arc<TagSet<T>>,
+    tag_set: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
     backref: Arc<Revocable<GenDiskRef<T>>>,
 }
@@ -342,6 +342,11 @@ pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
         // SAFETY: By type invariant, self is a valid gendisk.
         unsafe { T::QueueData::borrow((*(*self.gendisk).queue).queuedata) }
     }
+
+    /// Get a reference to the `TagSet` used by this `GenDisk`.
+    pub fn tag_set(&self) -> &Arc<TagSet<T>> {
+        &self.tag_set
+    }
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a

-- 
2.51.2


