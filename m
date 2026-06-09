Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17884D8D96;
	Tue,  9 Jun 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032347; cv=none; b=rusEJm0aLxWqOmPUh7qCqxAMONYGzjTUoMGDpBYeCcATmszolTnFAg6JmOZPWotyOn8a1lRsitid4v/Gh8Ds9YapKwa3MYMZ2gBWE0CYaG0bSaAFaDzwMgu/Jd9Y7A/G4jAEXr+CvUCSETAt/RfjkN3xWtxEacjeADC0O70Y1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032347; c=relaxed/simple;
	bh=NlaHBwDAyKNiiMVG0I8yNPspfiq5/k+1/1/ufIcyrYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgDKrMBE660I48/2tB78knEsWswMpb6jPHFVWHaf/8+6snoehk24YVfz6eQJely17+fXBclQfXGDxYp67NVFBDKJOT//64H60qZJuqmbEV1uODUrH8QfZtpIYjkE4L1K9D5hIybPoz5GKXVNcFUQNhWf6eUVe22KdQa1+wC8/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCuQ//BL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCuQ//BL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD2B1F00893;
	Tue,  9 Jun 2026 19:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032346;
	bh=3hqK4pNL6S2JPG/y7ZeGzzjDNeUcKa36Uf2X4yV6K44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OCuQ//BLNvPCd7LUKo8DdrDPmpPEjSN9j54i865qFnGncdfHVKv/F835XUWzh5fmy
	 1JqGuqfN0CppEcDMWMOKkw6y5kScMLdiIu6c0TWVFWXh1zMNTmAWIc55NOsYCb+vaH
	 doQxW//kLze1PHhaTv32DdIJB9OTNJsV3VSELUTo4Rn/mVcD4nrDYWqyk2I/iKy8Wd
	 msbDktIdNVuE5R4eHhFgVlT4tfoSTIg5NcQ5Hl46AxYz6fWJsXTGuS9O9SHKbatsUB
	 /hZh+nP0fG2dcpB2BkxCTvQCgya+YTpvERbdLpOTXd0GsiM0SAatO9BdhX4vfMJS2G
	 A65ui9BiHP91g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:43 +0200
Subject: [PATCH v2 04/83] block: rnull: add module parameters
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-4-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3121; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=NlaHBwDAyKNiiMVG0I8yNPspfiq5/k+1/1/ufIcyrYs=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS4fPIeIol1rMY3VBolkA8u3anuZt9v8wBBi
 QcjjYrJYrOJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkuAAKCRD6UCkIqsW9
 0HJ6D/4r6Srm+0SmXV4+YiMjaedQ8+3HXt5ttbJCmfe6w8sTEOmVS4RG3Ad9QUVLBtvt+SGICwl
 X40VacPNolbomVbsQJVcRJxX2TW6uuLVLT9l07xKio8sYaVcpPzDH+fwcFuGygsFCsH/O1j3OGh
 LrhgVvAG4wN3MIUXnb8lGwObPBrX1ep1DYt1UXSF6kjIyYxifSvvRQFvlbGBO9gSaoPbrPUJtuB
 g+zWGGFXFMp44VS22ZC5Go2OMIFtt4b4h+scV5r5d0c4pvf0/MermHK1kNeD9akvoL447uDrTn5
 AlBLrCDd3t70vrObkRGn6zzCT/SDFZPxlXOXT6HTDeGN+oOR0+LnR4pJzMJLg97b1ATobsnzINz
 BEwkx5fSncNaS8cHptLLk4+jPGES7hwmzSRE7G35rcoBMBOgYSi2lvAunsY0qFIZXe0wNYf+GaJ
 Azf0qrluNYhjkGZ7enOmevTOYJcHWM8N/sRH6/p8P30s+qbMus3yMKmVkxYYACBpdpZrzVQINmT
 9ksQpRsnzpJyABIgID+RNrNL4r++AWi6eevjw6K78gOrs31gbs7n55dUnATPUb+g9Bf026YXp9K
 qukh4y9TLviUUojh2BBgjMK1hm+T5LBsWEqf95Wr+on7CHJBLcBAwqokliJpr62JH+VR9XUyZyf
 6XZhZ0jatT97k9g==
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
 drivers/block/rnull/rnull.rs | 50 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index d58d2c4c5f63..77ccc6850961 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -18,10 +18,14 @@
             TagSet, //
         },
     },
+    error::Result,
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
 
@@ -31,20 +35,64 @@
     authors: ["Andreas Hindborg"],
     description: "Rust implementation of the C null block driver",
     license: "GPL v2",
+    params: {
+        gb: u64 {
+            default: 4,
+            description: "Device capacity in GiB",
+        },
+        rotational: bool {
+            default: false,
+            description: "Set the rotational feature for the device.",
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
+            for i in 0..module_parameters::nr_devices.value() {
+                let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
+
+                let disk = NullBlkDevice::new(
+                    &name,
+                    module_parameters::bs.value(),
+                    module_parameters::rotational.value(),
+                    module_parameters::gb.value() * 1024,
+                    module_parameters::irqmode.value().try_into()?,
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


