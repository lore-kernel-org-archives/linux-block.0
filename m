Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9724BCAA2;
	Tue,  9 Jun 2026 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032252; cv=none; b=IH7B7IagJphf9sw6jv4R0GdAzLxPMATcKRtZpehppe0JEnMxdx7jdi2E3Yu8ygxSrsgciZWcook7P7buPqPAlqoAWj7gyCjCdKIAVK6Rsz4rZ3FAuIARejL18a80vrURdV020n1E8qXYrkZPAgWx81N0v4dodHoRHWf1Hpo0brQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032252; c=relaxed/simple;
	bh=/gyZSLKa2TzHdBLdP1ZJPQOHQ8gDmiUSAZ/ZBCdP9G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtFvB7Vw3VU4QHDmJNHe3qD9XlKlidFQMx4022lJq505zrKtoAliH5xTr+N3mtez3UT3686X1o5VuByjN+ErOtg+DBzVOA0IJO0LUOyQMn44rq3Mrk9rjMa3vwn3QcEZp+NiL7mfDCEENBck+M4p+UIXoxVaQ61U0db3GDhdn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6D/bcpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6D/bcpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B01F00898;
	Tue,  9 Jun 2026 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032251;
	bh=6HqbIExdtN+AFhFGHKtY0qW2xobLkHXMaLIXspxSgS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l6D/bcpSBHJLSkUvVBypuKACqnuIrkZBk+O3bR/NcXh4yg6VprxqYRJdD8mi33lzi
	 uQ2HmLjWQqdo6F5rNTZU+sGh4hTf2xdX8xiX82z9pTwLYFa17wFMl/CfwGTu51KZNu
	 k5EzAHtnLS7/2Na+8Wc30PUDOcGdKvFfIt0YU+ECG8oFIWdIeHzgXhCFy9bfRDBa1A
	 pMN97/jjWoi+KGZv7D1v9lbz/cAaz89L1UgVDxSbNLBo39tLNclsRpF0Vb1OZvqNbE
	 gXo9gX1PS6ug3TwCVOwX5e3ytkJm1EpTQ5EilMEVMW/C6sQSt1kXK+wW/w/WJT+KfZ
	 L4KPp2m0QiRgQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:59 +0200
Subject: [PATCH v2 80/83] block: rust: add `virt_boundary_mask` option to
 `GenDiskBuilder`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-80-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=/gyZSLKa2TzHdBLdP1ZJPQOHQ8gDmiUSAZ/ZBCdP9G0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT9TT0R4aUtBtSeuFFz1LbiE1VCD8K7ODM7E
 HRL8FuebEOJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk/QAKCRD6UCkIqsW9
 0AZRD/9o4BTmJllPti16gUC3pq38UjvIoqBZxFPKYSys1RmxO+GlJRTZhPxaMmMvC3xZiw4wO3D
 WoiymkCJM16OQvte0AYdP3F7/GsJBlASsCR26pDFFbbFp8xG1UnwouPXwA/gJjWfQ5IhjA14IC8
 MVjQ8guFgpMDjzcrdOlbrq+x62bDx6Bh3eZImuQnZJ0vRGnFWM5J2H9GTGbSEUJ7cMNxAY7I64A
 hlcjpdPTpTbrEQjf07jqihO+UQ+1TE/45VcWtwdqFzws1IocOuarZVN+UQRjTULDzjh6ZbO8E6G
 QJCxvd7NoofCN7ykAra33D2JQlM9WOK9uRzcM5T3/UJZCGJ/9ddd6QKq7zZqPDWB+uGIbLPpAI8
 vKEaFpCx84GwO4Q6S/z4DIq0AJRwfvCYqzn4YocMN/RSajWK/n4Zsh27llz/xmi8Fwpexy4um1d
 ZfdlHNnc+N9fzzAw7msyM3cM5JcW2hKp7Ld4qtDOxZ3V6EHSGfyIN3wcoYThPZxYOT99SwZF2c7
 cqen7CXW6JUdqbdgpnskGdzXm6b73Jxjozc0Mf+ZGn/un8dkRV7R9dKbyy71NV6rOTrWqusoqxo
 wyU+nt1pe/SKYe1opyuU+H9rGDE4wg7Mo6LH8H0c87jgCScnJ1N+Y8iVSziHlxesRcv52u5Bcqb
 n8L8bBljBkJo53g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow Rust device drivers to set the `virt_boundary_mask` property for
block devices.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 6d760dafade5..38057ebc0878 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -59,6 +59,7 @@ pub struct GenDiskBuilder<T> {
     write_cache: bool,
     forced_unit_access: bool,
     max_sectors: u32,
+    virt_boundary_mask: usize,
     _p: PhantomData<T>,
 }
 
@@ -79,6 +80,7 @@ fn default() -> Self {
             write_cache: false,
             forced_unit_access: false,
             max_sectors: 0,
+            virt_boundary_mask: 0,
             _p: PhantomData,
         }
     }
@@ -189,6 +191,15 @@ pub fn max_sectors(mut self, sectors: u32) -> Self {
         self
     }
 
+    /// Set the I/O segment memory alignment mask for the block device. I/O requests to this device
+    /// will be split between segments wherever either the memory address of the end of the previous
+    /// segment or the memory address of the beginning of the current segment is not aligned to
+    /// virt_boundary_mask + 1 bytes.
+    pub fn virt_boundary_mask(mut self, mask: usize) -> Self {
+        self.virt_boundary_mask = mask;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build(
         self,
@@ -208,6 +219,7 @@ pub fn build(
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         lim.max_sectors = self.max_sectors;
+        lim.virt_boundary_mask = self.virt_boundary_mask;
         if self.rotational {
             lim.features = Feature::Rotational.into();
         }

-- 
2.51.2


