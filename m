Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4906EEC0;
	Sun, 15 Feb 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199022; cv=none; b=A61c3FdDlB32zgLLSnKLtK9QpBclgD3w6kliMUDiVrtyTONyirFRZ6PLRboVbOzs1iInS1mnDUZGRTH9rZLVdwNuT8SEyAMaMqjdioCQI3JzDEG0onW2fh6i6OpnRQDGvQNPh2BJUkpqc3L0kp+gO/TnvoXPYyQ4UXbdJ7CaanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199022; c=relaxed/simple;
	bh=/Kuy6Fsv3n8+vl73J+RNkL3tqtg0kG+WMvIfcKimuAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEYbWaOE4E3pUTPva+QQiVhuTZyoXBPGmASuNcP5heolLoEEYZa2T88UjxoFWp2aiS0nY1DeDZp3i8rOzs1H8wQLMQdKCxvsHMsCLC5DI8eYB17HmSLKA/5+bo2TwZd2GnnQMkA8yMaYFrU2wOpHfe7kxZAJ9DevQDpnjcQevHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbOWUKbm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbOWUKbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77798C4CEF7;
	Sun, 15 Feb 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199021;
	bh=/Kuy6Fsv3n8+vl73J+RNkL3tqtg0kG+WMvIfcKimuAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FbOWUKbm4n/CXe3V1um1I3TjOg20nmVQfW2OtVaFFxdNQP6kQ5k2icORCLV9qSFr+
	 yJiiKsSkDyEiyqCVq2kaGn/5bQTqiyXmkFnwID7eGTArXZjDUmy6eLzrqTgQ9v/lG1
	 jZMc3W1bhGJosTvvYjhCHmIuoVx9vC4NnwNMNQu5ZyA/gDXXdGDn/4gnnsYqViu5xV
	 FMcXIeVhnCNDSNNOi41Vih3UrSVlAWYdB6SYUJBcn0XHodtOxIkic31DHfbzH7Blwo
	 AzMlXTinavW6AQNmNAtnunlhJBNafB6RZECUpmoLDCJj3wIxyzObvWNkXPdGvuci1d
	 I1LDxAxNta1Qw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:09 +0100
Subject: [PATCH 22/79] block: rnull: add no_sched module parameter and
 configfs attribute
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-22-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4831; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=/Kuy6Fsv3n8+vl73J+RNkL3tqtg0kG+WMvIfcKimuAY=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgv7mC1vFpEakQN4AFwbqnINSdbK/gHyJEkH
 nv6vJSxCo+JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYLwAKCRDhuBo+eShj
 d/ulD/0aSq4rGdIfmpcbHJkjMKGDZKFnDel5s8/iZYKX0kcfe5vL/96VBuvGiCoRVEkZ8B3AzCm
 JXU5pZeuGOCOYguGpmNw3/Y9W8riH+nzEPUw/tRHjqozu8EruCznv7k8kS/trwHLeYy5WvRVxxL
 8G7TYYyWO3FqZaKQ0eqgvDnUGMIKHCQwnEvkH1/5Wd8wmFfACXM588wRW3G795keARNiosEC636
 JepsEOmCU4dLOdjR/eOXrKvbtlNprOnX1J6YA1lWy9TMBHYA8cIvJ7m2LiwljAH+aU3epkpjIYD
 sXaRS6UlLf8z4ukbBBiEYsFmozNvXeCIQfN9aY1+KHROa6TJInR3Uink/5BUZxuASBgcWZBfoeT
 nRDUsg+8gX1JYv3dCe79oRV8gtmsRmOm+16DB0Wadp/1QNJhAOEtE82SP4vWiwgVXnBP4OZjG3Q
 hzV8bYoCNVVKzJuLqmsyuDpBO5oyY3ddBqfWlmNpBdUhNJAJTPOo9DCZL6HTPAc0kUnynM7C0vt
 18V6eyeYOtNtBrMUqXNuN+hUZGAw10Ofal8hynsLJW+B877Z1Q8lIAHzPnvfFiw6nPSe3s9PDOO
 Wp8cjGQqFBBaOrxxTJyTCDtC1FWxmTTyfW8IaKgkman2/gkTU7pxbl0pdZUzSCH4luV/GtBamh+
 LyYJCEG4DysFIgQ==
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
 drivers/block/rnull/configfs.rs | 31 +++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs    | 25 ++++++++++++++++++-------
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 4ec9be440105d..18e32a87673aa 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -95,6 +95,7 @@ fn make_group(
                 use_per_node_hctx: 8,
                 home_node: 9,
                 discard: 10,
+                no_sched:11,
             ],
         };
 
@@ -116,6 +117,7 @@ fn make_group(
                     submit_queues: 1,
                     home_node: bindings::NUMA_NO_NODE,
                     discard: false,
+                    no_sched: false,
                 }),
             }),
             core::iter::empty(),
@@ -174,6 +176,7 @@ struct DeviceConfigInner {
     submit_queues: u32,
     home_node: i32,
     discard: bool,
+    no_sched: bool,
 }
 
 #[vtable]
@@ -208,6 +211,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 submit_queues: guard.submit_queues,
                 home_node: guard.home_node,
                 discard: guard.discard,
+                no_sched: guard.no_sched,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -336,3 +340,30 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     })
 );
+
+#[vtable]
+impl configfs::AttributeOperations<11> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+
+        if this.data.lock().no_sched {
+            writer.write_str("1\n")?;
+        } else {
+            writer.write_str("0\n")?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        this.data.lock().no_sched = kstrtobool_bytes(page)?;
+
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index d1fb5fbc0c0be..9a301b06fc5e0 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -29,8 +29,8 @@
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
@@ -112,6 +112,10 @@
             description:
             "Support discard operations (requires memory-backed null_blk device). Default: false",
         },
+        no_sched: u8 {
+            default: 0,
+            description: "No IO scheduler",
+        },
     },
 }
 
@@ -150,6 +154,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     submit_queues,
                     home_node: *module_parameters::home_node.value(),
                     discard: *module_parameters::discard.value() != 0,
+                    no_sched: *module_parameters::no_sched.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -175,6 +180,7 @@ struct NullBlkOptions<'a> {
     submit_queues: u32,
     home_node: i32,
     discard: bool,
+    no_sched: bool,
 }
 struct NullBlkDevice;
 
@@ -191,13 +197,18 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
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
 
         if home_node > kernel::num_online_nodes().try_into()? {
             return Err(code::EINVAL);

-- 
2.51.2


