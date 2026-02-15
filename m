Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F31FE45A;
	Sun, 15 Feb 2026 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198850; cv=none; b=Vi8zfFo5HamtqymMcQn3D4glFfbVAZgREa8jJ1MzpUQhsBbdace6DCnbitOa8p7EiFBriM2aaCx+yXRMcD4oLM4DOUrKDY3XPG+U/eLoCg1tZe52Mx6HpeGtGQUIIlQoLbkIE1M7vS4qXOHJmijzEcEwLVwmdUqREEiWlG0QCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198850; c=relaxed/simple;
	bh=jDbHu1Zje3UqoEo8ZzyBlnA9FXargy0KlZo0vzXHkD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAyqjxFUuZa1cGqA1po2Mrexus5c3ReLBW43U5zlNn4pNZ5DHeRYmQ1NbYqD/k2KS1n6HRseyikXpBcqTP1MUMTIIeLosEDxG1DpMDqN+Vv12Sk/zGVzKZLIx7p8S9oKNWyLtuUDXioraUdWUxVG8+yfhp//NnMkkRSysE1Oc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOJUz8jH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOJUz8jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D25C4CEF7;
	Sun, 15 Feb 2026 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198849;
	bh=jDbHu1Zje3UqoEo8ZzyBlnA9FXargy0KlZo0vzXHkD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OOJUz8jHaC7LP3EtCPD65pnV+OuuUHg0BfVaV60OFiuMPeM7rly6GhALuF7lje2WE
	 iVrI4rr2Vz940v56ePbsz1FEK5OVUdh3FF9wwxV1wTkWj2NAygLoyr4CWMomQIjnMh
	 Rj82CkavoBwm/WoQPLybya11197FGj4lR8QIRRtdma1KUCqceLm0vZ9dil4TWYorw1
	 /yTkq7IdNoMo69hqDeiunR+YRM5gNd1MkqAfztRamRz/4iJcK3jF21ZmfTxqlmNckg
	 H7tpk+5FJbpAKhphMWEOebbbGY5Hs0H6S/bhrHYtVfhHhyCnINeGvDral+4gSo49oY
	 7uVPpXwDvEtaQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:01 +0100
Subject: [PATCH 74/79] block: rust: add max_sectors option to
 `GenDiskBuilder`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-74-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=jDbHu1Zje3UqoEo8ZzyBlnA9FXargy0KlZo0vzXHkD8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklheeOWsZ5urW4C1UgIxuTPpIyyfBrdvCKsur
 KSUpEKcmhiJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYXgAKCRDhuBo+eShj
 dydFEAC1bjAjzG0WwgcS1zrXw0+2c39sfZ4Y4rB+xPXYebButMnzTSTL4dU+tGbyFFq5x4d0g90
 j3OCa2gMD8rbHleMZ9yo5J1XCRE/GWd5vhplDWCPHVOcLQaCFzwL4tw90z/FgQ5J0nswbXtg0Su
 NgHGvdb2an2pEy+z+tYNqQoP3cYGmGUyFXzXHI6iAERegmXrj959KcIKctyA14K2dAxK5EPi3IU
 FnFqin4bCemG/IK516tUXoZ9Z0N1tV/VzoLHVoc6Es9cEO16U7RzWjrdQPWTZGBo28n0upPGovT
 42SPvlzRwb83Btcumna2P4wGLc6yAV7Mu+eafxLfUeZFadRKK3qD2J+06pjJsixpUeItZPiVETe
 U8it+EgneiTQVhq4WWit6YWSUYhrWZsN6ICUtfKwX0s2PYgjsHfTnBStUd6IteSPR4zi1jw0Z06
 W73zvD84pdQ6PxRJphLZm/5LopyrH7MzlvOrBIR+7uwtG80iX9aqC1SRJWy7kltk2HPD+caXBm2
 J4plRlTJtkk9avoDHBlpm7+7MiUkzz9RZJIXqVveyHqCJrY5tC4SMHSaX2+S9V5wnoh/c3684OB
 pQ1sRV/jGYFJ7K5I3ZWZzMeN9BPWcTmZkhbO3kYcsOB+Og/RxCRqAqmBlbziBl3ytAw0XluMvaK
 NLxY6LENQoYm94w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow drivers to set the maximum I/O size when building a `GenDisk`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index b5291bc3e051d..b428e3f4207f4 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -36,6 +36,7 @@ pub struct GenDiskBuilder<T> {
     zone_append_max_sectors: u32,
     write_cache: bool,
     forced_unit_access: bool,
+    max_sectors: u32,
     _p: PhantomData<T>,
 }
 
@@ -55,6 +56,7 @@ fn default() -> Self {
             zone_append_max_sectors: 0,
             write_cache: false,
             forced_unit_access: false,
+            max_sectors: 0,
             _p: PhantomData,
         }
     }
@@ -159,6 +161,12 @@ pub fn write_cache(mut self, enable: bool) -> Self {
         self
     }
 
+    /// Maximum size of a command in 512 byte sectors.
+    pub fn max_sectors(mut self, sectors: u32) -> Self {
+        self.max_sectors = sectors;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build(
         self,
@@ -178,6 +186,7 @@ pub fn build(
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
+        lim.max_sectors = self.max_sectors;
         if self.rotational {
             lim.features = Feature::Rotational.into();
         }

-- 
2.51.2


