Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278829ACF6
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808491; cv=none; b=K6NTCBy51peMRzIIfcw8xeY/8+nmAz/HC56NC4fSsz+mfDnRT9L+2nNpd5SDOrvGBi+22LGb3ZsfHgBOyMBrxS28aYerVGfdHIzXhxyopCLJ7KkY/X0C3Ez6beuXY4aQW0BSCenzbEw8BlizELmQ/YjibdfL6MqRLlu5loXAe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808491; c=relaxed/simple;
	bh=JsC9L09JB7c5Qto+RbQqrQ01xP/c2mn8RT/NxDHSNBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tThBkN53QXTalH5S7pipq+nZVq5guyjElxOfVFdGb35dVKXb6vfRu2T8HErJz6IpvY/qMr0WA2oXIcFpSfab9UjUU7IR/c7jZ4HuBzglOxYKebOdtyyh85LWzfTPSL4hJpX8b/Zr1nnE1amJGW46mwy8LhCpeslAK65MSQoSUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1gv5qj8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1gv5qj8"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-79599d65f75so7318836d6.2
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808488; x=1759413288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVNYKpGpulAPMt7+7S4cKU51h0g+oImaV0zrihGhT7E=;
        b=H1gv5qj8GfIQ9NRTPG29jnfP5KbJmrzGm60wuBegQlxfzi4jxkdpfIylfdPN4xZk3c
         q2QUApB4uLNi93Kc/1NIhhyFmnA1rPCsUs5s2XW2e/JrEsLPA/pxZAybOsQYypiNyJeZ
         F8E9r7EDbtojWKa2jPZRZriZjW06M/jx9c2eSyWMVQyNRvbS2OQdR1jjMRqF2a5aOqZO
         QS8CHo2QP6ms+mSoi/5P0ntPuvt88siRyvIedXZ/900jgvPk/aMHzzqGqC+Cpd/7m7Zu
         Pzva6Sy1sPibjooacQDQ/Sn+UIF8g3VST6P5tLbOeD9V7u87lsIOCbavrZPRrtxhJODn
         qeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808488; x=1759413288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVNYKpGpulAPMt7+7S4cKU51h0g+oImaV0zrihGhT7E=;
        b=WYrQUQMofpm7ZHtCrpbTqGvhYANvei5MdtEFIEDPZHagLkTSBvumsaIzS9BuWNdIdq
         ar9O+qQQblm0WzuGFatHWNSQPRnwg8a1tYKdjbhsUMi2KriPsKpCQZpZWMgNhR0HoJ+I
         iGM0p38iacdRGLPWBlxGnAas69xCHeiAplO9fvvqoR6sBpM3pkh9woPfnjiaCTvR4vxP
         X2FqFvDhiUagDk28KZCYQXzykG8W88hFKidOJEtAP5N/Q4jiwK6sfhPZ70e8dPU4dgnH
         mLSFY6nyEStL3NK+Boucm57BSpFVI+6phDN/MqZh4FRL8Lfr4JCoQ/vRKwi81D71+/i/
         a0cw==
X-Forwarded-Encrypted: i=1; AJvYcCWExmZwAjlHPGA0dOnFL34ti1FbBt+dQVl9jY/Bi53hgSRcLv42Pj5n2RxaO5XrRxiNhPGHNn+nm6J+iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjaj/OxAbpL2snosex5yCj2jZ+gxRRQVlgrxromLQizrTWrzG9
	xCr6qSAqvHeEpsuKwnBi1uRX8Gim2yJ4hL+Qoryole4PJTp5jQfsxWdB
X-Gm-Gg: ASbGncsR55sl+0PguTwDPbdVC4+i9W+86PNGt+iDx3mrVNq8Oe4dFNN1+Oe8d87BsJp
	mGBU5TcGEt0hblsthTgV8rQ+57h+YaRS28l3AvtNz8540gCF6plhnwyrDbtnLV1Pi/M5GWxO2Hn
	F8i/vTZgM7MXEBbNu7S7LJjEotX4zwrpBmeVfjxQVMo7JuLZr414iIk9gzFNiiG7J2nXZIXaRm6
	05jTx8ZU1Ngmp8ziwvq0cvHM2ZuGkMNFVcuowOE5dErOkq2HOwNgaGgLeXiYFAYO//2EaLKxX0v
	9ocu6zjO6HyfRArxKg01Ow4xy52e3tYkgzHyKC3xLONTdAP3uP3Psg+Oo7nQqJkqQoL65C9huHo
	opC2SLZmiyKYWHnoJ7a/FluB/sxWOk1RRoi38B8CZ4ssZU2DL3Ro8p70qtMmXGEvU3YX/wBfdni
	/K5U3Ia5hDgHc5z/8ntbW3oxDzOjFJ6KknCrScLpTroHFT62zVr73+HpiyxdrFvy94YzLa
X-Google-Smtp-Source: AGHT+IGcSCDHxLWEAv2+tvuTndpWh14kIE0XwxqS1qORz7M/FkaXk4hS2hKSF3fui4XqH/sHYATWuw==
X-Received: by 2002:a05:6214:c87:b0:77e:443f:dfab with SMTP id 6a1803df08f44-7fc3bf7dbbfmr47922816d6.32.1758808487268;
        Thu, 25 Sep 2025 06:54:47 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:53 -0400
Subject: [PATCH v2 05/19] rust: configfs: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-5-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=3197;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=JsC9L09JB7c5Qto+RbQqrQ01xP/c2mn8RT/NxDHSNBk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCiWFaUQLEh7L6qOIxKWop5VB/xMpVQ3YvBt09OraNycfeOEzMuEQ7DscsvKM0CSzPbqArJQKNv
 7EXOamgAaLgc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/configfs.rs       | 9 +++++----
 samples/rust/rust_configfs.rs | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 9fb5ef825e41..69bb1fb53543 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -21,7 +21,6 @@
 //!
 //! ```ignore
 //! use kernel::alloc::flags;
-//! use kernel::c_str;
 //! use kernel::configfs_attrs;
 //! use kernel::configfs;
 //! use kernel::new_mutex;
@@ -50,7 +49,7 @@
 //!
 //!         try_pin_init!(Self {
 //!             config <- configfs::Subsystem::new(
-//!                 c_str!("rust_configfs"), item_type, Configuration::new()
+//!                 c"rust_configfs", item_type, Configuration::new()
 //!             ),
 //!         })
 //!     }
@@ -66,7 +65,7 @@
 //! impl Configuration {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
-//!             message: c_str!("Hello World\n"),
+//!             message: c"Hello World\n",
 //!             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
 //!         })
 //!     }
@@ -1000,7 +999,9 @@ macro_rules! configfs_attrs {
                     static [< $data:upper _ $name:upper _ATTR >]:
                         $crate::configfs::Attribute<$attr, $data, $data> =
                             unsafe {
-                                $crate::configfs::Attribute::new(c_str!(::core::stringify!($name)))
+                                $crate::configfs::Attribute::new(
+                                    $crate::c_str!(::core::stringify!($name)),
+                                )
                             };
                 )*
 
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 5005453f874d..ea84c23b784b 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -3,7 +3,6 @@
 //! Rust configfs sample.
 
 use kernel::alloc::flags;
-use kernel::c_str;
 use kernel::configfs;
 use kernel::configfs_attrs;
 use kernel::new_mutex;
@@ -35,7 +34,7 @@ struct Configuration {
 impl Configuration {
     fn new() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
-            message: c_str!("Hello World\n"),
+            message: c"Hello World\n",
             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
         })
     }
@@ -61,7 +60,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
         try_pin_init!(Self {
             config <- configfs::Subsystem::new(
-                c_str!("rust_configfs"), item_type, Configuration::new()
+                c"rust_configfs", item_type, Configuration::new()
             ),
         })
     }

-- 
2.51.0

