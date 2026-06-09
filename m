Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53144D2EDE;
	Tue,  9 Jun 2026 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032325; cv=none; b=XAzp3Jfk5YwYIza+gIxhxi9aqNUt8B4MZXhcD7Qwpvm/jvBY7FOIVsQ1/SMcUp4E+UFaB2XqYM0ELdt7ByvAPFJAeN/PeUjqwM3fKWbFtHCFYwk6eHOleIvDsPcyOCZAbyidX26Do506ytiCpcGdpu8Khnw/EDvKLpAULj8kiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032325; c=relaxed/simple;
	bh=W0O2CczxZDQEXRc15dJETKMQ+dkKiMZR7U8tm411g7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZfOPN/gL5RJhemES6nb87deyXPZPmiBLYG4teDjSOAplr+5pw2IgU/Lsn4kPBZrwCPoeiY0pfkuzddB6RhmVgm9oi3VDqc+5kiqzuy6FOE3r+xnu3h+gOJQBIvsUniKv2DdURHD8N+/gics+e7rw8XdXnKsm5+UlIXD7A9/zWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWh84ZQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWh84ZQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC0C1F00893;
	Tue,  9 Jun 2026 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032324;
	bh=+YoDlaRXxHkBdL9A3Iy3eyhP/tykMNVFwls11O+PbGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KWh84ZQZbd6+abJoZIFIxRUn4c5TrwdxMM/86SAfgZTUh6LojigcMZcS5+SAofC+j
	 43O9jA6Q0PVLSoLmT5cekTXpstMmziu34IY4oicvKtd4/I28lKCaBG4zG1eWiBasq8
	 ZmXp24Rb7GmggbZSBZPaT217AwW0dz5zs8OnOgZ+OV6xFD11SFStdpDWVzIkolj5Op
	 y557TTH3PeayehmmC7aY6efh5NWG00BEEznzp3sEYMtY2EK27SPUMGD97Z8DfGPlO5
	 V1XXt3jl+BFVTR/wq5KnKladB0fOdbR9OpNv51kuH3rMDxygWm+MUVtecbA37wwcJj
	 4KGuinCXguuQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:44 +0200
Subject: [PATCH v2 65/83] block: rust: add `GenDisk::tag_set`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-65-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=W0O2CczxZDQEXRc15dJETKMQ+dkKiMZR7U8tm411g7s=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTvQ1j9ShlTi9k2Sxb2Wf0dabZIrqUisKav9
 O2siS1ba22JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk7wAKCRD6UCkIqsW9
 0FeWD/9yDXxLKGaEABjjYFcFzRClbH4obCRuAURGM/QGNN9G68bjR5xvZgZBY2ro33xcNTNJAJL
 40PULazu/7YNQvvPEommrLYYtyhDfbp/IgLzBIOTzp6jwSAfSHAIivLG98wyH/amIbR1vH8yCql
 SBDdg/alHTtXGCU0q2i+pbsClfWDluhNWB7x4H4UG8+LC5nW6Jud2OXoy3VYZcluv7qanvjUJUg
 itVhIUBCc0CsZakZ3bAicLz9qx324CAigGnYNBC0XecSxh0jmsIopTMS5Vn3bSQjY8ffpVWI+zz
 +3K99Hgnhv6uX1VODIAC7V7dp13ZPw9pq1/w8tFFhXa83i42bKeqH4EMDwtArYia/r5UN+8Hxru
 W/jUOiqtMyP+/6yvN2WWEGIDkCP90nS/ITnMdwqplALX6quStpjIrtpEWHDcJvqGupxXlRnmxoS
 vxlRuEN9Hci+7AlgG121BQDKaTq/6gR9fZfOpOSa3pO37+JcWv3qNI9wGHa6QY8xtYDF3RWWaAs
 jOM6ahj8m58s1GqtrBlSzSyFs1JhsSdZoWOgQ1VHhOxANpkNHBqTIuyuEzo9Krvs74mm5LO5KEG
 jM8F3FHT/n5ck6W8SkIAJahMQV/vvVUYxBdGI6n1+VJuZqib6n1gmfGQWb74cml/ePNiQby0wb8
 g+x3smGKALfVxkw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `GenDisk` to obtain a reference to the associated `TagSet`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 5367ca92b7aa..a50ba7b605d7 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -257,7 +257,7 @@ pub fn build(
         // `__blk_mq_alloc_disk` above.
         let mut disk = UniqueArc::new(
             GenDisk {
-                _tagset: tagset,
+                tag_set: tagset,
                 gendisk,
                 backref: Arc::pin_init(
                     // INVARIANT: We break `GenDiskRef` invariant here, but we restore it below.
@@ -341,7 +341,7 @@ pub(crate) const fn build_vtable() -> &'static bindings::block_device_operations
 ///    `bindings::device_add_disk`.
 ///  - `self.gendisk.queue.queuedata` is initialized by a call to `ForeignOwnable::into_foreign`.
 pub struct GenDisk<T: Operations> {
-    _tagset: Arc<TagSet<T>>,
+    tag_set: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
     backref: Arc<Revocable<GenDiskRef<T>>>,
 }
@@ -363,6 +363,11 @@ pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
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


