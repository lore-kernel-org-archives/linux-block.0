Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2489406072;
	Tue,  9 Jun 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032636; cv=none; b=jskpnxrNfLBTdkY9TN/XLGgvwvmRI7s6BRB4Uof5AkIqz+qFxBTV5N3cnLTMPGugWKGYftcszIFP8vT90AIkf/DcXjmsJhpHxvhOuV7vZRPohOCFjmIa0VemtEimjEr8k7orT4o6M5KMboFibukv5D3cPRSF//Nj5BsfJxYMZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032636; c=relaxed/simple;
	bh=HoPPP8LHyfFhtce3K0cUJuW8NUYoe+z4X7dgaxFLGfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3WuSDlvVHK8rsh6X5Z7jPGS5xoTTB78DLmcEdliqpVZLK8OVW8rnGHUPEpjS+lZb5rAGcTJzwuZLihp+0JRSW0Z9zdSuHmtZU8XKBYhgwIQl2YQ9oytvduZJoPxyRaCW2t0xoyE4pJWfZ/Ej2lrGhwuNpKU3LryoZVlIp+ac34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJGWcflN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJGWcflN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD21F00898;
	Tue,  9 Jun 2026 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032635;
	bh=0vBcgswxHnJVjRfzfe4sol9/FUdXWuk9h/h15LXryYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QJGWcflNSh6sOYC4ukSS5Gx/oNMYV0HgjwWjG0RF2pFsvZU8qk1Klls5Ps0LskIVr
	 QZAdRfPu5eTf1wFPIVYIg5jfHlJ4v2vjSSHik2KzVdv02pYwOnwv1IEfzma9XETfdP
	 w9ECu9XPIWVQfwA/bU6cQqXn5jZqvetAYF2/Z4jfRqZpDeTUvGJXJC///PmnT59Bx4
	 p1Ya9/0kdz9iVuA6Tk4ThQfJ6t7uFQHnf/jEqy6HbQVvBb/pGPTQ0wtHd9U3Q3O768
	 m80m/joroPPzC9tzm9LeWFs+dv7j0VChFsMQLhEsViifiouT96slfEkJj06Ba6nscQ
	 TyIqJQnGJYuCw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:57 +0200
Subject: [PATCH v2 78/83] block: rust: add max_sectors option to
 `GenDiskBuilder`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-78-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=HoPPP8LHyfFhtce3K0cUJuW8NUYoe+z4X7dgaxFLGfE=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT7S1gTtW+R1WhBEPArVYTcHteX7mgWXqCHu
 TgIUJ9j4RmJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk+wAKCRD6UCkIqsW9
 0MPdD/0diJL/A2gSYUNUwHklP3bHcD/77AQjbTl7KVNQrN/kmQvABFD9xTfID5LimPN5gwnDeBK
 vm2AJdxSZ3PbOyQs2aBEXnm0c7ossw/opjWZ2lMbc7uxV55+wNurDPo9CjVtqzNCjy7QIs21dBs
 Y2bUvKFpQsbNkgiuGSF7HEGuaFdpabmHDTrYyR7YM+Pmx4vLs0qiWiQygWTNIwn7iIIN0fpmjkA
 VrBc4LfNcHsCMtNb10VS1TQzSJa+77ceu08WfF9acCVJ44jhF/BDMu8lSgD0fPmS7jZqWKZTuIe
 jmMxx4XRYFIHfgD/5DRd3HnGSvA9q800AlCTrcxyYdVIrAR4/4eCobhxFyXnkLYojGJiy20O/9Y
 wwwcCEiHuHYiBvmXA0nMhkAvfshZcJu1raF9gtUDBgxyDSDrHaDPDP8ay+spS+UYdTP3u6yMiYi
 pGeYRQzkhA4ZnhcGZy45GadpiPZ8sf2z/4/6xJliKLX9N/yDPJ04Mwq6mvwTRYOpdzr8URH6jHW
 ygCAqRZpjDI3sF4jpVMaF2VDsPfgH7fRycsHCc5c6vhaSHWfSXJkxUc+B5I0YzQryV5UIo3mtPZ
 vWnoO1tFE6ZjT7pMk31qA+VnVKnOk+7BstKDYXsMhgynKA6amnzncerTtDgswXJLlwANnaXwddT
 T2INwiJ1HtR0AiA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow drivers to set the maximum I/O size when building a `GenDisk`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index a50ba7b605d7..6d760dafade5 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -58,6 +58,7 @@ pub struct GenDiskBuilder<T> {
     zone_append_max_sectors: u32,
     write_cache: bool,
     forced_unit_access: bool,
+    max_sectors: u32,
     _p: PhantomData<T>,
 }
 
@@ -77,6 +78,7 @@ fn default() -> Self {
             zone_append_max_sectors: 0,
             write_cache: false,
             forced_unit_access: false,
+            max_sectors: 0,
             _p: PhantomData,
         }
     }
@@ -181,6 +183,12 @@ pub fn write_cache(mut self, enable: bool) -> Self {
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
@@ -199,6 +207,7 @@ pub fn build(
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
+        lim.max_sectors = self.max_sectors;
         if self.rotational {
             lim.features = Feature::Rotational.into();
         }

-- 
2.51.2


