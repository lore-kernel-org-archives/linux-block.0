Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241C408A0B;
	Tue,  9 Jun 2026 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032642; cv=none; b=nurx5bKByJBkpeWciFweJzKw7SESah86NyYXdIB7tLBNw+2+BikuBLOX9NjTuH9Hj2/xT5bydtKR2GzZAqwS9QbApBfegzPaD0aF6XZFEBh4iY5eK38udb7rK/Pn+QmIycLuEp+efQoWIzyOAPEI8MpzCK3LZNwdJsqRzPh3Qxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032642; c=relaxed/simple;
	bh=O+jl2F2xzeizmKeEFp6OfGRrahz8fj9S64rA8TqH02s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efceYAvUtc8lMH+E+Vz1NuUJQ15vRgTGHXNqEd+RgL5G1AfE/taX9fJWeeFnSRKal12++Tv+BofT2heDkzEXbCLolPYucqifN3H1Iwjz0A/cDL4nSCaC1LeFTJvzLHEanWIhVK3wt5O/u16FrpN+Ec3gzhOGxPkNurIPBw1iwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRZMzO2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRZMzO2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E801F00893;
	Tue,  9 Jun 2026 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032641;
	bh=67YOcpbRpSvyeMAWDdHjO8J84Lo+TPp/ZYE9AcqGdYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XRZMzO2nzYm/oXccW/HVI5Dk5QvbHo+TtdY3/UR6W3/B08le5NVKnk551rf9JD85Y
	 5LTO9PZTcuWeC8lUNCkMTwYZazubh9vN0OCO78aOBhXmKkds3ilmrKFObR0ZDY865T
	 yZJz7FAbsCVk1N3mDDlXCcHJg+liy+vXk2QRmWD7flbbPJO/mJT37SlvO3+xHV9DvV
	 XnqNOhi3ANXS3m/GB1H+XxwB1BYDfiuIaywBqfOWrDsRuSUijJEGoWVNKWyIu9VTIs
	 kjqF+7h2oqA9wncI7Smy3PRK1TQnKdSv+yrdMXHMx1g3Z34NfCrdb5adK8sXvtzyxD
	 xO0iGaW3vjokg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:04 +0200
Subject: [PATCH v2 25/83] block: rnull: add no_sched module parameter and
 configfs attribute
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-25-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4147; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=O+jl2F2xzeizmKeEFp6OfGRrahz8fj9S64rA8TqH02s=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTL8JCj0D2bsrjx8If5DE09F4g67MwSLHApp
 73TkQ+1MHWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkywAKCRD6UCkIqsW9
 0J9pD/0ZofgGrMZ//q3Xy/zRBs9l2Vn3GJKNw929z8MAETbFVoorBU4y/U2yUDQdOC/XDmdXoWe
 4Nad5uh/xRXZLpOBiImot9EG5hP6Thp9W3yxSZid30wvFnEQmd6AFD4aeT6XxuZCKQo39OI4dVM
 ARB1aecc9qrZoBbKU1ENcIcdx62S/9bYRzzNb4rHA2k2ud8A1qLJOpTHSY/nhLm/tUd7RyyT4wg
 +R+I6e0hBErrB8mvUDaWQqwH5PJ3XbO/ZpJLnPzjyTgaIO0rOvRdnSBAs3tc5Rv1rKWDSSk3tDs
 G8g+HH+/i6eikJIifHkiCzoz57AUBNGhuoSdcPuXIKF93tV78JMecTIeTt1zHa/F8ww5WE9GFlz
 0weMV4RIuJDvJ8j2DibdYfEBBit84BFLl3cDiqKVDcdwn0fyrPPatCCMWKnO/uEf4LbW950oFWT
 YAmEGjCQrE3TEs8aB6Y8MR1fUOvEkT4MVsHWlTL3LKbgfImUIaZFxI5rgVYF3f/QImdzmCgbFhF
 JMOmNxi6kPiilGy/70601nmr17+xmJ438F5FASSqQ0w5UPM/xinWQNrjAiyQcZHaVukg/uVQ4ni
 VnVwDn8bBaoX5wZc618giL/7vqrVikGfPITYl6S9Zw7UC9rA8WMOlGk3O41AWuSmGlIj1mDiKu8
 aypOiV//2X6dgCA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for disabling the default IO scheduler by adding:
- no_sched module parameter to control scheduler selection at device
  creation.
- no_sched configfs attribute (ID 11) for runtime configuration.
- Use of NO_DEFAULT_SCHEDULER flag when no_sched is enabled.

This allows bypassing the default 'mq-deadline' scheduler and using 'none'
instead, which can improve performance for certain workloads. The flag
selection logic is updated to use compound assignment operators for better
readability.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  6 ++++++
 drivers/block/rnull/rnull.rs    | 25 ++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index e47399cd45a4..d9aead646ae0 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -94,6 +94,7 @@ fn make_group(
                 use_per_node_hctx: 8,
                 home_node: 9,
                 discard: 10,
+                no_sched:11,
             ],
         };
 
@@ -115,6 +116,7 @@ fn make_group(
                     submit_queues: 1,
                     home_node: bindings::NUMA_NO_NODE,
                     discard: false,
+                    no_sched: false,
                 }),
             }),
             core::iter::empty(),
@@ -183,6 +185,7 @@ struct DeviceConfigInner {
     submit_queues: u32,
     home_node: i32,
     discard: bool,
+    no_sched: bool,
 }
 
 #[vtable]
@@ -217,6 +220,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 submit_queues: guard.submit_queues,
                 home_node: guard.home_node,
                 discard: guard.discard,
+                no_sched: guard.no_sched,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -322,3 +326,5 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     })
 );
+
+configfs_simple_bool_field!(DeviceConfig, 11, no_sched);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index bdc05b3f6072..cb5b642f68e5 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -30,8 +30,8 @@
     new_mutex,
     new_xarray,
     page::{
-        SafePage, //
-        PAGE_SIZE,
+        SafePage,
+        PAGE_SIZE, //
     },
     pr_info,
     prelude::*,
@@ -110,6 +110,10 @@
             description:
                 "Support discard operations (requires memory-backed null_blk device).",
         },
+        no_sched: bool {
+            default: false,
+            description: "No IO scheduler",
+        },
     },
 }
 
@@ -148,6 +152,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     submit_queues,
                     home_node: module_parameters::home_node.value(),
                     discard: module_parameters::discard.value(),
+                    no_sched: module_parameters::no_sched.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -173,6 +178,7 @@ struct NullBlkOptions<'a> {
     submit_queues: u32,
     home_node: i32,
     discard: bool,
+    no_sched: bool,
 }
 struct NullBlkDevice;
 
@@ -189,13 +195,18 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             submit_queues,
             home_node,
             discard,
+            no_sched,
         } = options;
 
-        let flags = if memory_backed {
-            mq::tag_set::Flag::Blocking.into()
-        } else {
-            mq::tag_set::Flags::default()
-        };
+        let mut flags = mq::tag_set::Flags::default();
+
+        if memory_backed {
+            flags |= mq::tag_set::Flag::Blocking;
+        }
+
+        if no_sched {
+            flags |= mq::tag_set::Flag::NoDefaultScheduler;
+        }
 
         if home_node > kernel::numa::num_online_nodes().try_into()? {
             return Err(code::EINVAL);

-- 
2.51.2


