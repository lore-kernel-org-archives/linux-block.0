Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B7403B19;
	Tue,  9 Jun 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032566; cv=none; b=F0kNd8JExZJ6DrxOCWYnFZB+ECIMb9Fm1S8SXFv2QJZyM4EHr7ZahiyOO5qM5VloSUZmKdk4HzkeMVo68kQRRRs6vMqMX75JEcBM5eKI3pIlbgKWqug7DdDOPR+jNbfRmPB8TRjFOwfs/zXa+3Iv6v5u4yl8EukcS8Aix3iUIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032566; c=relaxed/simple;
	bh=v7M+SqjjYm4ifPlbRD5RF/J8lCqCoX2siEspuGsi6JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1FYLpgQUfLKYjJZ9tO+LtrsDCMhzAjMST4Vu8pEWqXatQ4YM8qDXjEZVv0oYNVpOYp+4tAd4HUAkPlYMvORQrCATJ6NStxRTUtmtusYtLcl+h9b0ANRDdwTorbjHr2JcVdcaTsOLeSj0SkeXO5Vl/iLyAms5wypS4vQXYLARZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw3H/Q3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw3H/Q3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3CC1F0089A;
	Tue,  9 Jun 2026 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032565;
	bh=G3lgi4BvnuP8dvWHNylWqJ5utFJtojJuMjE3Nz2Xk8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jw3H/Q3g3yHtjPIAShUuvFoegF8tqdbx/yiX64UeAWL7gLz2R6aeB/6bcgMAFYfX+
	 qdr4L1CerL0er728ZHZ4Vr6lsEleYCtd3dnM1gVcuPNSHRNCKoJDUGyhJOPl29r8Wr
	 1Oil0uJnHHH+WNKeCm+hmTHJVTv4dLZnonRPThd6ol3KUnHqnD/ZzgZeIZ1k2pGy/O
	 yRgp4CsOogjtHlhnDlBLw7GnctxuUYzeFbRPQxvLoZCdzkSLN4TI855YFEqxLge1F/
	 SLFwSDUDMLgj8nG8tj09nSbVLo7TTTl65FtYZyDwBUa1kUk0ivIFg+ayFQh/AHQ5HO
	 Plw+Zl29cAUAA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:33 +0200
Subject: [PATCH v2 54/83] block: rust: add `map_queues` support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-54-82c7404542e2@kernel.org>
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
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3830; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=1/oGMHKJngamxy/YHU0uRCSEeVu7aFtuzPGZ9TvHG3k=;
 b=kA0DAAoB+lApCKrFvdAByyZiAGooZOWj3cCG2U8+E3n3Tx3zuIx6/yQjgqJBN0irwutd75dDd
 okCMwQAAQoAHRYhBFeK2cjZZnYmKsBqhvpQKQiqxb3QBQJqKGTlAAoJEPpQKQiqxb3Ql6oQAIXd
 9lWv1cDgGI7fP3R1gNts3WYj4RA+OhgzhbTerMr1sIBoD0a6gKcGvV0+p6o1sVFZN1iqIka++11
 pSozYjaes478Tbr6cJMx3Q+rvpZfWhuSWzT0kIO3Gx858LHrufA6VpiyzQEMqYfdKM4N8YYZ3kn
 I31DkpEe0tsQ1kphWJ5OeqzzVSLqLmmNhwTtLMVQoLlIiv9L+btIHGNvOyL1FLNxqt5KFnpsg2Q
 FDbbKUSUEC2poyjuCxLGx7X96fCyCoodylGu1pGpedoVJrJx5zxgYLhrbqTYvxsX7S9hO6cuXnj
 wdXrYDMIay2dzq4IEv2RxfIgInhaYr5oQfYZginSxw6xpMlFUOAkpv58qPy1sdd8obSwM/JkwSY
 JfC3oi7LqjzLVuwSoJPMZL/TLG1j5h9/wYTeeJhnws+FmdbuaD8lAQhyqt24+0N285pOEaupAY8
 1aplUuy556oWZH0R36MfNMevlodFy7+Na0Bu8SZr6YrBc6lJmkCcF0LJzEnd4VEDKyIID99DLza
 WO+RHsJnYLWflvvnRqoX7Sv/98qPDWQ7pqmdO4e/wtVyr2MGTw2IiC+piaHEhJqv0ToWuXfNiSe
 ieHwW6vuyMEuinefgYAI8anN6jcQgvPRUEWxdNiltSWXqYW5lDP++LXCzr/ITiruskuIJ5FnOMU
 e+Sce
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Andreas Hindborg <a.hindborg@samsung.com>

Add support for the `map_queues` callback to the Rust block layer
bindings. This callback allows drivers to customize the mapping between
CPUs and hardware queues.

The callback receives a mutable reference to the `TagSet`, and drivers
can use the `TagSet::update_maps` method to configure the mappings for
each queue type.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/operations.rs | 29 +++++++++++++++++++++++++++--
 rust/kernel/block/mq/tag_set.rs    | 13 +++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 71d4192d627f..8a418bf0f3ba 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -12,7 +12,8 @@
             gen_disk::GenDiskRef,
             request::RequestDataWrapper,
             IdleRequest,
-            Request, //
+            Request,
+            TagSet, //
         },
     },
     error::{
@@ -126,6 +127,11 @@ fn report_zones(
     ) -> Result<u32> {
         Err(ENOTSUPP)
     }
+
+    /// Called by the kernel to map submission queues to CPU cores.
+    fn map_queues(_tag_set: &TagSet<Self>) {
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// A vtable for blk-mq to interact with a block device driver.
@@ -418,6 +424,21 @@ impl<T: Operations> OperationsVTable<T> {
         })
     }
 
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `tag_set`
+    /// must be a pointer to a valid and initialized `TagSet<T>`. The pointee
+    /// must be valid for use as a reference at least the duration of this call.
+    unsafe extern "C" fn map_queues_callback(tag_set: *mut bindings::blk_mq_tag_set) {
+        // SAFETY: The safety requirements of this function satiesfies the
+        // requirements of `TagSet::from_ptr`.
+        let tag_set = unsafe { TagSet::from_ptr(tag_set) };
+        T::map_queues(tag_set);
+    }
+
     const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
         queue_rq: Some(Self::queue_rq_callback),
         queue_rqs: None,
@@ -439,7 +460,11 @@ impl<T: Operations> OperationsVTable<T> {
         exit_request: Some(Self::exit_request_callback),
         cleanup_rq: None,
         busy: None,
-        map_queues: None,
+        map_queues: if T::HAS_MAP_QUEUES {
+            Some(Self::map_queues_callback)
+        } else {
+            None
+        },
         #[cfg(CONFIG_BLK_DEBUG_FS)]
         show_rq: None,
     };
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 157c47f64334..d3e93ad98b6e 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -116,6 +116,19 @@ pub fn flags(&self) -> Flags {
         let flags_raw = unsafe { (*this).flags };
         Flags::try_from(flags_raw).expect("Expected valid flags from C struct")
     }
+
+    /// Create a `TagSet<T>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a pointer to a valid and initialized `TagSet<T>`. There
+    /// may be no other mutable references to the tag set. The pointee must be
+    /// live and valid at least for the duration of the returned lifetime `'a`.
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::blk_mq_tag_set) -> &'a Self {
+        // SAFETY: By the safety requirements of this function, `ptr` is valid
+        // for use as a reference for the duration of `'a`.
+        unsafe { &*(ptr.cast::<Self>()) }
+    }
 }
 
 #[pinned_drop]

-- 
2.51.2


