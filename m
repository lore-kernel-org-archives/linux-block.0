Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E23128B6;
	Sun, 15 Feb 2026 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199221; cv=none; b=hKIoV9rtO2b16ESf9CSA/PGaBeYVcZf7+SL3Dr7LsVzU72WO4WWONrVwvnDzjcjvNVbaZwgcZqEH9Dz7w9nIkuOAen7W5ZERQAK0m36kYKNJOFIfgJbvN7zjVrjdl+PPvqAH3rGKCMOGBknqBN9pQ5EXJ9aOViklaSoDfABCECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199221; c=relaxed/simple;
	bh=+9VoTKjKEOvBExxZyNph/soC3n95VmzkDwZhpUL6gGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQnos+EeQ3QsYl73HwcNNobYQBxSbKqTsyW0CtzQ2/7RpH5mf0NrZj13s2wGug8JJXY7C117gsGj7GidB4qP1AH7IArMmk44DILEJCu6ksZ7A8KbcQh4A8vWgL/akQOJRZfOH/ipYnPyTuvDM1Aty9vU/fqYgolkUFfNGpVzOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6yFBLnh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6yFBLnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89508C4CEF7;
	Sun, 15 Feb 2026 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199220;
	bh=+9VoTKjKEOvBExxZyNph/soC3n95VmzkDwZhpUL6gGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p6yFBLnh1+UCZDBzNagelOCQiAZTy6t9bFvCt3DfPY2kQjp89cxxnx/WqzR7uPkja
	 XtFGPzD709kaFS8rYUarJHVM5GG9Ji4D/BEmVk7PNzGqp6vPNfsy+s1KPD1tzNyA8/
	 kUp2P3pl+lqLRVQCboXDNycR9wZdV5J7kDe9/J7Pzji3+YlPfufknDWmzv02HHD9Rb
	 Oy6tumJ0FYF4Fy+rwaPqkV8EERwiTTka5MsM6Z2EXPPqyza5mQ+q53Nl+f4snLPddz
	 vNh/wt5/YsJA2FppjhCbiJIX11xf2/8kjwATVyvsSIAj+i1PGPC8ofwodRrTys3fVZ
	 v/AlL1tiw4nZw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:02 +0100
Subject: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+9VoTKjKEOvBExxZyNph/soC3n95VmzkDwZhpUL6gGk=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgp/QnG7POfeQUiu6svmmlJXvglJFlTee9SK
 tUtnVeNTJqJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYKQAKCRDhuBo+eShj
 d/YcEADDBnyhEHkcnKjgjSOfCTFCpflKQjLLvFu6y+3h6U/AAMU78Ooa0UWjtF/iAX3ljz+Jw38
 +38ZE28EZIEB3oKXNFlW+Bu5c0Gl+sGHnDr9pWorObN7SOuzgXrqT20MVvUCfmBT7ZvhaSOJ1cU
 kdaZrlwcTmlB+TeD2Zf2MDIrdSgwoRdbRj7MjtFnWmmUEYeXBlAriFw9w6MTmNg5cuIu86YyV8G
 SMwkCgo8520RMC1HPaIMdnfafpsaSU+wwlOLWWmqRBGinA/yFpC64y0UjskOCk7PlsWYkKKrBXw
 N/sDKTZ8k9e1d/LTJctLsOKbdd3neRxwbJ+l+UNtu8qzgZhQR/CKepJxeHk5csYXyKosM7lZ8VL
 iBexxDt3LaW/TgzxQYlKqAR6cgVpDxCqLPGXN6N3lILjfobVN17IIIBMeS/dMaU9iIPUzRpE9c8
 xFVesd0gonPwZU+0MngZ71gXTW7zoeG9UsufKNxQRc8KqmHik976k+KwoPxL34GdAd3iOsLBtgB
 cBqPbCD77dmJumgXnYPM4PXREAE748c76L66EeBrq1bJ/cEfek3j0jT+dOVA8Iro47s2HwJm7NN
 YGi/5HKi90LE3zlnMj+ayAvpkvKnvl3sYgkmwFijBqbX0hz0Wfiwa/tJJ3EzCpbKl94uhHlcPY/
 HGlnL5hJHMYoRiw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute to enable per-NUMA-node hardware contexts.
When enabled, the driver creates one hardware queue per NUMA node
instead of the default configuration.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 26 ++++++++++++++++++++++++--
 drivers/block/rnull/rnull.rs    | 28 ++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index fd3cbf7aa012e..b05bfc23090c2 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -30,8 +30,11 @@
     time, //
 };
 use macros::{
+    configfs_attribute,
     configfs_simple_bool_field,
-    configfs_simple_field, //
+    configfs_simple_field,
+    show_field,
+    store_with_power_check, //
 };
 use pin_init::PinInit;
 
@@ -61,7 +64,7 @@ impl AttributeOperations<0> for Config {
         let mut writer = kernel::str::Formatter::new(page);
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed\
-             submit_queues\n",
+             submit_queues,use_per_node_hctx\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -88,6 +91,7 @@ fn make_group(
                 completion_nsec: 5,
                 memory_backed: 6,
                 submit_queues: 7,
+                use_per_node_hctx: 8,
             ],
         };
 
@@ -280,3 +284,21 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
+
+configfs_attribute!(DeviceConfig, 8,
+    show: |this, page| show_field(
+        this.data.lock().submit_queues == kernel::num_online_nodes(), page
+    ),
+    store: |this, page| store_with_power_check(this, page, |this, page| {
+        let value = core::str::from_utf8(page)?
+            .trim()
+            .parse::<u8>()
+            .map_err(|_| kernel::error::code::EINVAL)?
+            != 0;
+
+        if value {
+            this.data.lock().submit_queues *= kernel::num_online_nodes();
+        }
+        Ok(())
+    })
+);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 55ee5165b90b3..990dfcf95c9de 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -21,12 +21,17 @@
         },
     },
     error::Result,
-    new_mutex, new_xarray,
+    new_mutex,
+    new_xarray,
     page::SafePage,
     pr_info,
     prelude::*,
     str::CString,
-    sync::{aref::ARef, Arc, Mutex},
+    sync::{
+        aref::ARef,
+        Arc,
+        Mutex, //
+    },
     time::{
         hrtimer::{
             HrTimerCallback,
@@ -40,7 +45,7 @@
         OwnableRefCounted,
         Owned, //
     },
-    xarray::XArray,
+    xarray::XArray, //
 };
 use pin_init::PinInit;
 
@@ -73,8 +78,9 @@
             description:  "IRQ completion handler. 0-none, 1-softirq, 2-timer",
         },
         completion_nsec: u64 {
-            default: 10_000,
-            description:  "Time in ns to complete a request in hardware. Default: 10,000ns",
+                default: 10_000,
+                description:
+            "Time in ns to complete a request in hardware. Default: 10,000ns",
         },
         memory_backed: u8 {
             default: 0,
@@ -84,6 +90,11 @@
             default: 1,
             description: "Number of submission queues",
         },
+        use_per_node_hctx: u8 {
+            default: 0,
+            description:
+        "Use per-node allocation for hardware context queues, 0-false, 1-true. Default: 0-false",
+        },
     },
 }
 
@@ -106,6 +117,11 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             for i in 0..(*module_parameters::nr_devices.value()) {
                 let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
 
+                let submit_queues = if *module_parameters::use_per_node_hctx.value() != 0 {
+                    kernel::num_online_nodes()
+                } else {
+                    *module_parameters::submit_queues.value()
+                };
                 let disk = NullBlkDevice::new(NullBlkOptions {
                     name: &name,
                     block_size: *module_parameters::bs.value(),
@@ -114,7 +130,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     irq_mode: (*module_parameters::irqmode.value()).try_into()?,
                     completion_time: Delta::from_nanos(completion_time),
                     memory_backed: *module_parameters::memory_backed.value() != 0,
-                    submit_queues: *module_parameters::submit_queues.value(),
+                    submit_queues,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }

-- 
2.51.2


