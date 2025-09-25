Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770328AAEE
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808527; cv=none; b=QmGYljGRyrk5PPXIRLnIurfzA3guJhsT07ZtEuWX8mPsHjTGrUU3liro41K7cFRAj12DSRQeNqg4NKlQZhg3IVsWdMTKNZunUptPfd3RVRUELgUCevaOAH1pmJAA3Xo9s3e/4HoZzKms6SCaLNlbh0qVG3A/BG+s7K77NtMe7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808527; c=relaxed/simple;
	bh=G1wsZhjB9YFMrkpz5gcBxDMgotSl9l62JYKqp+2kvv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abjxv45dowzOiXWPHYYmvA5e4xFyb4mfDdNx6i1atHxIj/g4YggFl1xEMLFML91qV5t9vq3XvM+d9p+BK91T1GEDklFDgDZJJ4Jj19oIYM16xoucUNFdhqjIpUY+oFv7Nmg66QlvhKxH0JU3OEEaw2L14pYyyNQNPWG/wDKNvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbV65Ngf; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbV65Ngf"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78f58f4230cso7298696d6.1
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808524; x=1759413324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9F//OQcCcTSCVUN93IinXT3LeiwclsyrHd76W2OsUHM=;
        b=cbV65Ngfv2wRlEQycfdgsdZ4HyL0QMsjiUgFkW3x6wmAA4RJNKRWCzbOWivIDV3PsC
         7b+sL8NR+96IIeE20jn88m12eoaaT5clg/qTv76iOKiW2TNEx0WjLvHkS7tFU14cNsAQ
         B0LPn3uFZVOm2LLgF5xsO1es5hzs+DTWEyhe3ufC0x3dlZzGvCFUSbEU8Nf9JEydJMJL
         mgkgXp7ydD7pec4+bV4VWpSLqAsIYhgFBAMNaTC1and1dW7vfAk7WLilJkUTb3rdF3mC
         5EJjUMqF5AdTatgsWuHsKenJjxu89sJW+zn4zQUwjemPdSVpx1Cho6LvB5I7aWyGqDQ0
         p1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808524; x=1759413324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F//OQcCcTSCVUN93IinXT3LeiwclsyrHd76W2OsUHM=;
        b=w0SJSx+BrliiIMpSTN3p2kF4pO9MbL28Lx4lrXPsU1ttONQ+XUV4SCQRqyaJ4YM3ld
         zRCB0sUiuLuJq8jZt/LPStbQLssq/r2CzPiBVqu2iDE8XrXvanwKWEDNQmZeoLV61t8k
         9bFaUEnxgcgWunN+X/RWwWZonDN/d8bc2R+62DK5PFWa9azzpk/t93pc1FnnJzpbGqbz
         ZDRhVspcQ0oI9KASiDMd7hwGI8nzkiibIafVFMX0IACObaphfobJoU9pCyh4PGBri8w5
         5VOc2WNTiBYfR7fnuzLmy/cNqeg9gV6mP099tgs8E56uI+CIVINplnETLE0MoaOqOehT
         YJDw==
X-Forwarded-Encrypted: i=1; AJvYcCW66q5jHOY7oF+Xbw+X4nkp8THJF1xcB8L7MD/Duuxmbvo8v2wAV6cFiRXuhKXafM0/k9deairbAaC+RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytuuiXR+Xj1WmmfQlmXehok+THAJOSmwCy9XCEPeT4eOdDS6eZ
	xlh7qDMAnJBksIy/arDTUm9PB0HQRoka2EVNXTEEurc6qCF1hBilkT7C
X-Gm-Gg: ASbGncs05LChUQiuK+y0x1qel/A4weCo/cUgWcRxz3LaEpBupcxF5Ghch4KSy7bvyfQ
	EaufGSork0c0zqLh4qXnx9S1zVGFf6XzlB6ZdXxxf+NWE9pFUm+ZKCHT0opiTwBYWkIVZTFir2+
	Ju5C3cBe8ykb5K+UxGE1O8E3eUpV/UxccziO6Fk+/y8ULa72kaYezG04szh/BVmnpGd9lee/j/4
	vCwhbuyEbDQJqNHs/gw/CDtU8jAulRCHMi89bZwsZWnIDw1X4tpE1UVFgznV8P8+BrWckMKWLb3
	sAlqka4C6Nh1WhXzCQRatHiTJ8ne4nF3VAmDoFbDPdUPzfGFatoFw6w2uMWKZvTGimyzz67XmjC
	wVSz3meWzbWKZLd8/E6uXU071YB+GS2bhRaMGDRrTQu4b6VuzME7rYxe7ElsPAii65JpcttLVAn
	SUlxxD1r3C5BeMXteTHi5KtUd5hAdPpb9nsDDYm2UMe4Pur81RhiBuw2GTO7XZAwFS4DVX
X-Google-Smtp-Source: AGHT+IG8Gyrq/9aswoyGrByufUDOEDDpB4vAZLNl1cBk/1ws0VqwO4eeWj7YZE4dhPO66F/wFvg1uw==
X-Received: by 2002:a05:6214:1d28:b0:7d6:c615:ecd1 with SMTP id 6a1803df08f44-7fc4ec0e7dcmr46038496d6.61.1758808522761;
        Thu, 25 Sep 2025 06:55:22 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:59 -0400
Subject: [PATCH v2 11/19] rust: miscdevice: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-11-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1136;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=G1wsZhjB9YFMrkpz5gcBxDMgotSl9l62JYKqp+2kvv0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDPHa5h0Ln008NycRhnUYHSwita6ft61YpP6UIaouguWtU37E7gPYJQE7EoOJeFshI2ze3iWBrO
 I6yLKReNrlA0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_misc_device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..60ab10b02574 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -98,7 +98,6 @@
 use core::pin::Pin;
 
 use kernel::{
-    c_str,
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
@@ -133,7 +132,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
-            name: c_str!("rust-misc-device"),
+            name: c"rust-misc-device",
         };
 
         try_pin_init!(Self {

-- 
2.51.0

