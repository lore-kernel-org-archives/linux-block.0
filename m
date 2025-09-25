Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46D28688C
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808463; cv=none; b=lbTW6vxf57bUKztkYwrbRgO7+K/NxWD5DnJuxBnuKYcLPC1IRavX4b9cVuQMjuvqHC39/Kf5L5g5JrrSkqrB8C9YS8g/4RPbTjXbGxM4pSr/EmepI5n3EHSGTJaZQH7Sv1DWAzCkF4NOCl0hjnRX+cImU1FoRvxPHIcFWMMBouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808463; c=relaxed/simple;
	bh=jCTV/tUAugB6kQuG6h16qXAYA9gVjuY3K+nRw8uudBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh7Qm18CXVX4V8sF+7RAfLzkJHXcEXHjWwhVwCQRDdLGn8SViB2UNfTOi6HML8VFDl1prUKF52rgUA4VfsMsu9GlmWt8xI17C4g3kGOZCcZTmE+tMOJicdEDibFtfFwC/LzNNy6Ma4SbiGoQ2E9ZND7Vn8cp+LoksVin35zbfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6J/uTPs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6J/uTPs"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-854fcb187b2so107202085a.2
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808459; x=1759413259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NalRugr56a/X75BPbSyIQMh/LBa9oMHO7W+8WbDPYnY=;
        b=Z6J/uTPsKBAx6HJvmtIfO7ZFGEZlxiRThXTNdmWpI6dnkrWfEZoIBlrMY8XFP9vkXV
         kzjwUZ2cyShty0w+OGd1mcm/0TBWPX1Vck7YyMRIwlt2uE/SZemGRNTGSoK7wmMT3o6B
         LRfr8ljEB9QhHA6pE03bg5FmyemcnqeNJbjjQ7Emo6yibervgmQ8hMLtHaa/1Pr31JOW
         ThqJQ2sWN34kuFIerLiPC27ilZaIOKZNADlF8WZIY2fkcYHgkin4qh1jy62oyvp+DSLm
         f37Pe+aqxutH6a3OaydVe4TxZ0GTgSzG5Y0kw3MjNzPWkWOWnFbeYGSPOF/L8QRQvhHF
         K/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808459; x=1759413259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NalRugr56a/X75BPbSyIQMh/LBa9oMHO7W+8WbDPYnY=;
        b=fEM1PI4rygcXiIlJMNxHDgWK+OXVJ2frtsiO3WKOxndMrdLo2jNJKfkBSMkzAJHR49
         6nkIU57nEAgZzsDErclVqjzU6QGN1lFDo9ZfSK2RLjSDnCKQVf6w6zJosj9LR2nv80Fr
         em2B3+6D4KH3Z5KHm5neT8VbCQALDPOsb1A4TqtfJLS9G2xu8myokwtP4d47YTyGu9q7
         FgpNNXLt9BgY5WWs/MKjKXXNn0JbYudHn/65JTYXFxjl0zaLTEOOkjhy/H38/5Curwyy
         mwFdDJVbBdWLAlGAF+dcEmVlihvyvGiYf2jpZ2c3JWUkCHTKXKg4sI6PHUwuXHe/rL/y
         NFAw==
X-Forwarded-Encrypted: i=1; AJvYcCXKpNjZrnAA+wHelXKpTL4snkH+qleE00rgORUoRJMx794KD5kSX6rV3MzyIi2pyj2WTxUuZpus7GA+BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKHU5jyZk4LQ5maS6WpboG7ATdmoZaRWAWwFdA0GQrK8TvW/t
	G6+ESxkuq9YL8Ms4RbCyJ6GdqBrKVzZO8TBaPgfwIunp97+l+E4kVnin
X-Gm-Gg: ASbGncvKDgPxBC3Nvnit8j+riDT5qBi45vRnjmhRo+UIMKYB2hkbF8/5UO72aQuavrZ
	JmTLjebIc/3ioQEmV5eKhFZBe+AjJoDzROT+FysZxRXES0oXjKO1npafnxz8BEgRZdu9b8tYHEg
	yO3UvhlaeJWm6BRzYM53ifuf8vU+hQxjUrCNBytmqUl8SNf5j5KT0jiiXhi4sfjB4eGlLqx9Gfr
	cwxEw94+9rHedVqs1leP68MPZnbvJbfXhOEsVJ8FU9NshGIv1gmjl6Uj9w7X3LPQPEDs7hA6yYO
	EJJoxfrZe0x4x4fT3UHC7jwI3FiY7InGhZWe+62BcO4JOMvm/CPVrIjV64+h6X/BpGyLaxAojkf
	rHd+is41eI8zAzNnJGUJI1eGfkCvmPyi9yHNKVhL08E4PYcFmNo0jU9YGoaaVkOHsQ1nFNapGha
	y92RDe05+hhB2FO0ahTq7AmUsu4iD4aIEvS/aSJB2+SDY+ug6hUBl7Q/gAtKXi+/wQ77WT
X-Google-Smtp-Source: AGHT+IGDJTlODDEEGMd+XqS6TrdaLhozVUbA41arvcw2luGPWfwQ5X2fWdHexXOWX/V4ddEWfD+pug==
X-Received: by 2002:a05:6214:500e:b0:784:bd2b:abbf with SMTP id 6a1803df08f44-7fc39460bacmr55347756d6.24.1758808459061;
        Thu, 25 Sep 2025 06:54:19 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:18 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:49 -0400
Subject: [PATCH v2 01/19] drivers: net: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-1-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808436; l=3366;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jCTV/tUAugB6kQuG6h16qXAYA9gVjuY3K+nRw8uudBM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM5FRv8eNJ3CAtJrq8ctlI58A1uhfnem30wXWxndQdEjlI88vgu5PfmeFU3nqX15SZ72W8uXUUc
 90i73MD8nTAw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/net/phy/ax88796b_rust.rs | 7 +++----
 drivers/net/phy/qt2025.rs        | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index bc73ebccc2aa..2d24628a4e58 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,6 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    c_str,
     net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
     uapi,
@@ -41,7 +40,7 @@ fn asix_soft_reset(dev: &mut phy::Device) -> Result {
 #[vtable]
 impl Driver for PhyAX88772A {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const NAME: &'static CStr = c"Asix Electronics AX88772A";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1861);
 
     // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
@@ -105,7 +104,7 @@ fn link_change_notify(dev: &mut phy::Device) {
 #[vtable]
 impl Driver for PhyAX88772C {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
+    const NAME: &'static CStr = c"Asix Electronics AX88772C";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1881);
 
     fn suspend(dev: &mut phy::Device) -> Result {
@@ -125,7 +124,7 @@ fn soft_reset(dev: &mut phy::Device) -> Result {
 
 #[vtable]
 impl Driver for PhyAX88796B {
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
+    const NAME: &'static CStr = c"Asix Electronics AX88796B";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x003b1841);
 
     fn soft_reset(dev: &mut phy::Device) -> Result {
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 0b9400dcb4c1..9ccc75f70219 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -9,7 +9,6 @@
 //!
 //! The QT2025 PHY integrates an Intel 8051 micro-controller.
 
-use kernel::c_str;
 use kernel::error::code;
 use kernel::firmware::Firmware;
 use kernel::net::phy::{
@@ -36,7 +35,7 @@
 
 #[vtable]
 impl Driver for PhyQT2025 {
-    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
+    const NAME: &'static CStr = c"QT2025 10Gpbs SFP+";
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
@@ -69,7 +68,7 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from the boot ROM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x00c0)?;
 
-        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
+        let fw = Firmware::request(c"qt2025-2.0.3.3.fw", dev.as_ref())?;
         if fw.data().len() > SZ_16K + SZ_8K {
             return Err(code::EFBIG);
         }

-- 
2.51.0

