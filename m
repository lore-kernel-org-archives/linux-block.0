Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410482D7803
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808540; cv=none; b=ZDoKIyjhBDlLQ4TQMS633ojEpnRpixfyg+/cr4I4XH6KCKSqqNhNhBV7QW7iEOAGbPP9u9VOvJ6v+K4OZFffSmm9f7Ef2xHFT2TxD/mS82Ut5HGdmonVvz8j0qpp09KS3zjer/D0zITCLANfsWsBEIDV6eJlm1rAsXusYk7yPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808540; c=relaxed/simple;
	bh=9ZmEu11QXJ8phGJATObrsBrPngKGUQeOptVynfUL8WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJ/3feZ2bqlg+EqLJ291K5pC9ag8yHuuyz/1KxfCsVh4DLLsYQ6BVkTJCpjzalWHUiCQq+VnB+YggCrXnLCFNPk0jgseq9GryK9g070BApf2HGeh0K19sjQWSlPgk+Deanr99cmW9YYTwae8maXXYbr5/CpsjuRnijJtQa2KwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfosiNOI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfosiNOI"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79599d65f75so7326476d6.2
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808537; x=1759413337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mswzqg1rIlmw6HicVVCtXv0e5vufLTaFX3VKtK98wJ4=;
        b=OfosiNOI6HdmuS6bpjzcl5fODl9n35fCh7xdTjfT2ExCu+lpF1+YgVYf8Emnwzm+oe
         +aVYsc2liL0RJevBRu8j8atyTHlxwgscCJvnetkP8tqejNrdr2gVgiWVukDe28fZ/qX9
         ymyEZ9QZmXmEah5zJTTcF7n7DpNK3v59CsrU635x0fafsNef7B4/zMdU/wsnzaaNEsPP
         C7P49OuJpFFwOyuU/T6lY/eVYwY9TCEWc32ekvJKVLxqvwEVTaw9b1DWXZv8bJIErqA+
         JvbkXnwOQPZAWofUX0RdilxVZdsda2j7e112eYDahXdSIo8LEQtJjj1pdP981SVGPGmr
         iSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808537; x=1759413337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mswzqg1rIlmw6HicVVCtXv0e5vufLTaFX3VKtK98wJ4=;
        b=aaUQ7+4Kd0aMJt4SY/FI+aylaOtuA6llH8RE0r+IPi3cLd0nlPGnVRJL9lzcGwC6Iq
         zrRkHrqJYjim5XGhcU398tkHj/RVfQrJmRHDtb42LV2AYecVEjjWqHUmhxeWyM+bNF6E
         uCDoIvJb143eJ3SDoO9zBJknrBLhi12PpuVp1fL8WN8woW+SGjAM3itO1PGwTjfzqwtv
         IPcqWXW72DdCHLFw7WD8kAlXKl2AKKTv5UwKJFgvLQX2wJo4Wjyl1ZpNkoEt7amiu7f/
         7sRYAm0deWwXepeqLgYVqKey6+ZWTh7aIebz9NER3puDIp1XPU7UV8uzoCii74502TWm
         6bWw==
X-Forwarded-Encrypted: i=1; AJvYcCVbTcabZtqr/FpF8Vm5jri6Qzl9xoLdlvGeUEy95B/1/0lD5M8Zgxqlp3S6/v7yZQzZBitRAJTqgyahRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeD2pprqaR40RukmzjwJXjb+eD8bGo7l3zDvHZ8c3/HkSNQdxX
	eOLboyJIOGar9rKS2+OMpQ7I77Oq1exDIc/8iqHj0VADBzk/6LjNxrz0
X-Gm-Gg: ASbGncuNpzz5E/4UH1tQYINVKJBWvARbC8DjG34B7h9o7ODLN//JSyw6+8Sfaa2MwS+
	d8//6z1TZcwEk7244Q3x6l3Gl9vs3IOh/YLUwc/2pftiWl50R3T0ixrh5Pgs6qYZosO9Miai4Nz
	ofNFrVyvPXtGnnshykerIyKpCljVVkENgfgEF+xRisBgovAdEZ1bd9CB/TvhgojDso/1u12n1Qv
	HuAudH9tDhCRxqQuh7F8uD1zbAFow2uOMl6onC+mG1uDChLL5MVDERwDcRuyhDmukKIOITc7Scv
	knPLJra+iLuLKcxtgiiJcINe51AB+uc+vM63V5JNYkevGniyoyoOKvw5SJ4uq+TI05x1uB/ADOp
	jsOaU7proam8/7uGD0lr2K79JO+Rqm4Rhi2RlRuIu0Ff6klMifI1dgY0ms2sHNjnLCbqMwV586q
	iGGsM9YX/oUT+GYFjw0bjSzdw2ss0ID9eUKyJuDir5jGlSf26WfJ/s5DDEZtb5iTjFOFs+
X-Google-Smtp-Source: AGHT+IG0JSBlGu1RB4uMilSaBh7PnIkXhnuatHF4cSQpYwaqP/zzSQ9G+tSnzQTTn3K53FoLTANywA==
X-Received: by 2002:a05:6214:4001:b0:70d:6de2:50c0 with SMTP id 6a1803df08f44-7fc43a4e9e0mr40876536d6.61.1758808535790;
        Thu, 25 Sep 2025 06:55:35 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:35 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:01 -0400
Subject: [PATCH v2 13/19] rust: pci: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-13-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1469;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=9ZmEu11QXJ8phGJATObrsBrPngKGUQeOptVynfUL8WM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLLvUlNLZLAaXK2MqYDhZdBweEQ8R3sKV9FI/C2n7BV5P0I7OA8y5a1a/1zJuYaQ3obw7TFfFmi
 JTjNJLSMGawU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..e0e9d9fda484 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -79,7 +79,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
         let drvdata = KBox::pin_init(
             try_pin_init!(Self {
                 pdev: pdev.into(),
-                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
+                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci"),
                 index: *info,
             }),
             GFP_KERNEL,

-- 
2.51.0

