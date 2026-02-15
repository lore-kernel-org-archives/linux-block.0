Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30047312826;
	Sun, 15 Feb 2026 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199211; cv=none; b=KzEUySZKs78TGzK5i+iDuEw9Wj8IvKFIgnqg6gafOGb9+c3v+iUUn3o/xrW7iLh3kqTY9DizQIezRl3lYZqo/YSR0V9egvj0/jCNYwZPsdRWUKTnvd+/fjrJVbMsz2sLpQCNr/E6PlRELDPTRYgu7YU9IiWyasTSylIhyY4cgh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199211; c=relaxed/simple;
	bh=rgMlD4sSCyRxG8oxO2Pb6vDkLa6w1B6y8QPvsSGTaZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS2e1AiehrjzVGtagNHJcg2N+hhIMWwQbapiJ+vpGTTOTePo4oKq3B7MrvUYzv86gjCm63L05cC8cBAyvZ6KGvW70OITCTEV9oq+S3NzU1hh93TbpgxeDI1ZtyIg8A7/cZYOsh9ODC8moFHsxW2wvz1gyv9X/5++ZTg7ALw6tHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmPoQJMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmPoQJMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05CFC4CEF7;
	Sun, 15 Feb 2026 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199211;
	bh=rgMlD4sSCyRxG8oxO2Pb6vDkLa6w1B6y8QPvsSGTaZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WmPoQJMOP0UiKshCcGC2ekbgXi4gGMlJFjAOZ5MxskaSSSd+rXiJqBFSm59d9+B3m
	 0s5y1/PJFCE3IQLKtRAlU/wup1FgMbqxO4DKfmsSGzk6bQlt56ouh40xpjiJIu+xQ+
	 wUp4adpOBJ4FzHFcEec+9kxPGsWy9C69T3jmsLiZoXBV0KfD5lTEx8XwdR7Wv3vcfk
	 gopZcVsalEwSnEnreQVd+cFZIwC2gG5zdA9SFBdB2aLCV5v7uKeHzK9IeUHgcOLghj
	 ZfPFSozibHnKLdm772y85ZlrajGlHVSPadvHQKgUENZtO9GBKw4L2VHOOciApLT+5c
	 KSkkG/y80PoXw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:49 +0100
Subject: [PATCH 02/79] block: rnull: add module parameters
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-2-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=rgMlD4sSCyRxG8oxO2Pb6vDkLa6w1B6y8QPvsSGTaZc=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgdRABPWARqS1bNRC+vWhj9vKzZMZZcE3x1J
 YLYupX3Y7yJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYHQAKCRDhuBo+eShj
 d9LAD/9LvTRLSgtyV5rn6DK63XIy00fXEsKbYH8ZTfptYGBha30Wxnq4BRbzlAGzSI7eseVirtu
 U2fUA67OrAjwLTSxPkmJhR53AM7ylkIh+qc60AWS9hwAu0T5MyOK8jphpvwA0rWLKHaKw8JOFjA
 v4I49NQ7hDBxCmBG6svW1KzaxBnEN3sLb5zn7bAE6+wDppgTZc+pBYJXRK2ITRlWSl3BsDAY6fX
 eMajzH3BrBzqbS49rnM0/yjEGCyezkbXE+KCLx54uudBjCle9yLGzBqcTa6iFsxsgbj3xQl3W5d
 UUFXc3j/AjYSOLJaQPRE/AUjaFuXjdoEi72vpE5Be5eiikPFPU1N5KESsjdZ0rziWu7N5n2zBmI
 xUFRcHYOGWJlCoasEcDU1LzAy7NTFzrxsFs2c1oLrFLgVfbC/C4sQW3VDJ8S2OGeUsRhu7vdHtH
 SHF5YH9h5dksV5cM8rhy0uh+BC63HhvCM6ZqByKuFvxhd6Fh4al+YYmVYoYQgmFLMYcHprOo32D
 Oh+mJ02nU0YBCHqy0HGNrwQQBloNC864jBfkOPR62speL9TbdseULqpzx96q5EY1BBzzolCMUss
 lUP0KXF3Sp4JTC+3IqQ5sB3l/ZjUTARO52gSRtkLFn4XTHn5rP77RTo8Si+9U17qsEQvvKHrZt8
 vbnD6kdgtG+8tPw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Module parameter support for Rust modules was merged a few releases back.
Add module parameter support to the rnull driver.

This allows the user to control the driver either via configfs or module
parameters, just like the C counterpart.

Please note that the rust module parameters do not support boolean values.
Flags that should have been booleans are parsed as integers and compared to
zero.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs | 51 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 2c83b014b05e9..bd883a5061cab 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -19,11 +19,13 @@
         },
     },
     error::Result,
-    pr_info,
+    new_mutex, pr_info,
     prelude::*,
+    str::CString,
     sync::{
         aref::ARef,
-        Arc, //
+        Arc,
+        Mutex, //
     },
 };
 use pin_init::PinInit;
@@ -34,20 +36,65 @@
     authors: ["Andreas Hindborg"],
     description: "Rust implementation of the C null block driver",
     license: "GPL v2",
+    params: {
+        gb: u64 {
+            default: 4,
+            description: "Device capacity in GiB",
+        },
+        rotational: u8 {
+            default: 0,
+            description:
+            "Set the rotational feature for the device (0 for false, 1 for true). Default: 0",
+        },
+        bs: u32 {
+            default: 4096,
+            description: "Block size (in bytes)",
+        },
+        nr_devices: u64 {
+            default: 1,
+            description: "Number of devices to register",
+        },
+        irqmode: u8 {
+            default: 0,
+            description:  "IRQ completion handler. 0-none, 1-softirq",
+        },
+    },
 }
 
 #[pin_data]
 struct NullBlkModule {
     #[pin]
     configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
+    #[pin]
+    param_disks: Mutex<KVec<GenDisk<NullBlkDevice>>>,
 }
 
 impl kernel::InPlaceModule for NullBlkModule {
     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Rust null_blk loaded\n");
 
+        let mut disks = KVec::new();
+
+        let defer_init = move || -> Result<_, Error> {
+            for i in 0..(*module_parameters::nr_devices.value()) {
+                let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
+
+                let disk = NullBlkDevice::new(
+                    &name,
+                    *module_parameters::bs.value(),
+                    *module_parameters::rotational.value() != 0,
+                    *module_parameters::gb.value() * 1024,
+                    (*module_parameters::irqmode.value()).try_into()?,
+                )?;
+                disks.push(disk, GFP_KERNEL)?;
+            }
+
+            Ok(disks)
+        };
+
         try_pin_init!(Self {
             configfs_subsystem <- configfs::subsystem(),
+            param_disks <- new_mutex!(defer_init()?),
         })
     }
 }

-- 
2.51.2


