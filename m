Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8040C208;
	Tue,  9 Jun 2026 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032696; cv=none; b=MEtPRnpDLdyw6pTuZ8YmpYPvkNOmeFYwd0QiPkJgWx4lLiIgJQM3eEhx8VC19l+GsSyshvQLqnqCFIrs3aUDLq8YuYzzOjVTKMCQPdr4aqFLrX0GUJK2DSzpPgtKjtT3tHwRZaJ1iDXCIXH/7MRsiYr4sFSd9VFqwMSV1d5r+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032696; c=relaxed/simple;
	bh=lmxiQlFN4F/4ZyV264h2eAjCgTfWmHi9M8lfy1C7H1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5xYU2kXhIYAwo5mRnpcefYbP3EqAdBJDVNCDCImvaz7Y/HBKg56plbzbmqFXKamKDMii8ZYXtd7uQIp8m4Tf/+wHYOxSfywFBbzYD0xKKRwF+Ig8IYQXrjP6G7JpLsblYWw3JPXuZ1KrRRLzbttecXVNVbuaxSaWl6ZdfAhekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avj6ZWt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avj6ZWt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7501F00893;
	Tue,  9 Jun 2026 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032695;
	bh=uscdNJwwl8XqBYBhj9sseM+ELakppynPqvLUaYkMsEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Avj6ZWt9pyUdKva4jyLrRWrEGIc5qrLQcx1ciDPuZRvwlPxdmI+rdUb48SJ3Cytjk
	 U529xgXBl/pmejgxhzzGCvpCLn8XYDOIKug3ZUHdtGbztugR3slzzeLs/NScyu2Bua
	 0GWaP64jk/bcpXYC51pJynhkoMj/t5VdA3viPk9JiqVFuIgBTA26EgN7fxGUYKDdYv
	 9JRcuLKV6Eo0u7OWd0Wv4us8J2/Sd4IPpq+UAD9fE7m/ptbvJt/bkZFBBFJ+7yjH5V
	 a0XELaraRhArqjPXP+zACi/VPsIv05NW2S/1OQOV9zmmVy9Tg2jyy1T/lPF1lS7ARt
	 QVQH1dK4yF5QQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:45 +0200
Subject: [PATCH v2 66/83] block: rust: add `TagSet::update_hw_queue_count`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-66-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lmxiQlFN4F/4ZyV264h2eAjCgTfWmHi9M8lfy1C7H1w=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTwVD2rB/lbhBXJY9WqF8y/XOfulLI3AS2U/
 50nQzCG89CJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk8AAKCRD6UCkIqsW9
 0KpZD/9Etz799ndlt+Bh6QO59f5AYdztn2sHE5grM0Rq44vTgyQrPIcUtZ0k7gHcl9ORVH+I8wI
 JsLwUzfhmM0YMr8e42dMLGbaZizg50DtAgDNquDXaDbTyyBa3eVSrcgzEEX3BYWDnr6aHong4aQ
 iXz/x6pvWXstmacukGPKrcoHwL3bqLa57k8IotdrqAhkoNhEMe36n90krLBxrydyPWzGira8QQr
 NZkPon5yJR4rb3yCTn1JC76RZ1l3lUATCz0Ht1Z/rcyHHM3SFkWp6tiOh6YG7+eHtxfrczoVVtV
 9KsMcvW2WnxX65N/96qL4kFSh6h01gOkJ0Ip1E23+onzt3VyGS4S8Xjs3s4wXP92hXnO3s+/dOv
 J9INh46w8FRpbHngW+g7ncoGB284Nyek22DW5F72WzkRwyB4sOevBaxuTxWDgatBH8U/qwyunUq
 NjmaQBTOjui8AEBizBKibIcF0hlGFW/v9aUg8dDAKnSHapcT7KhUixSwaiuZCfgJQtZgkmpYFhx
 9iWpJ22epXsC7zkmsWm6yCJRrDdDXqufL94+6QSEeu3PAr5lJZjsc3L9oRdCQTxbV2QvP34Q4/L
 Wupt5tIpG/XJv0eb+1kvVN+E5vJ23uQUHgOCByzlxPxVKG1qGqlWyN/sX8Jed74UiEd6ln3Xnz6
 pgSBJ+DnvEbhkEw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `TagSet` that allows changing the number of hardware queues
dynamically.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 858c1b952b00..e89c76987b54 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -170,6 +170,20 @@ pub fn hw_queue_count(&self) -> u32 {
         unsafe { (*self.inner.get()).nr_hw_queues }
     }
 
+    /// Update the number of hardware queues for this tag set.
+    ///
+    /// This operation may fail if memory for tags cannot be allocated.
+    pub fn update_hw_queue_count(&self, nr_hw_queues: u32) -> Result {
+        // SAFETY: blk_mq_update_nr_hw_queues applies internal synchronization.
+        unsafe { bindings::blk_mq_update_nr_hw_queues(self.inner.get(), nr_hw_queues) }
+
+        if self.hw_queue_count() == nr_hw_queues {
+            Ok(())
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
     /// Borrow the [`T::TagSetData`] associated with this tag set.
     pub fn data(&self) -> <T::TagSetData as ForeignOwnable>::Borrowed<'_> {
         // SAFETY: By type invariant, `self.inner` is valid.

-- 
2.51.2


