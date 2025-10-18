Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B920242D9B
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809546; cv=none; b=VmaQwQGAl+75BmdxcOpkd8yRr2bc0Euk9e6n2kZsGqPR0HokyzpsKvDFkm1hWcc8IkuOv/0ya2SPbQHO1oDJeaQNHTQnLzqNqMeljvvhQzFamtyVGn+yX0laiz71Uqyr+TAO/JVJLc0XbgKFhe+3gEH25yqoW1/AXS2HcIOXfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809546; c=relaxed/simple;
	bh=872/2/9eITdb9tB+ajd4McXNzNIKi7XLnXFm8ifjokI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7VmC39PSHzBvJC/a9D7KNrEAwbN/+AuRAxkKn9yp9xMq6rDgEPe8ATVjvh/W35H2dr+ariCwR3tM8cMDA+HC5MsAczG/nlGSTFZKeSIkn4X8WWVUP3F0mXu0JNnmdXCNi7KXI0sHP38m+F79Eg+y/gtVOV9th0MdlJJw2vC7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiUSbTna; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiUSbTna"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f26db50b4so415190385a.2
        for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809543; x=1761414343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxxD2K5FdBz/EnZVjAulq7wLhETf3uBIbeo+/VSTI5o=;
        b=PiUSbTnawi0Y2gAOle6WmnfWCMP15/NZEFmhoWZ/P8IE/4TCxmGjSoi53OpB/Yl7Lo
         /Zswgw8ol5/9UeFvKlNkHdyWX81ZKlWnsSmTb9/L9ttW3D+7oojqWaXLXBm5IuaTAWAZ
         zzx7mr2BpUeRb+HK/FjLv/xzNThgx2XnCClmTyRlPo6/twf/ocjqFQWg1IUcESd8hnVP
         m1S44t3z4VO+iQ9fuLTi03/HdihgxNiTi9JqOcYIdKACT2i21syOexoVSijXEAZWEM/w
         TBLUaURZjJI2t4IhEj9sagARG3zDp0VCz56QWREA0Z1RqrYl7Pz/sZAalkncJcCLNSGL
         xVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809543; x=1761414343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxxD2K5FdBz/EnZVjAulq7wLhETf3uBIbeo+/VSTI5o=;
        b=BHK3+BicPj5un+I2QTTVyjCHhZBKYQiVyCOagCWFW//yZKTBwaplXsMB1XlIMTyC5P
         QJOI+PZyXG4ikH1Uarr+7stoA0m0pGAyoqHko0vURYA7ucaDE9UE6kVApVdMJr45nReI
         lTOlBW0+Svi7DjS6oo/57ChJG4b09KXOj10Z3lcfTH1Gu8SN5DjavWq733PupA7hqt23
         eso/wyOwmI94VNb6cYFtU3L5z25jWNPBZNJpU8NuXzoNyzE8rGlz4fA0iAAxFL+hLiaD
         vhNy/hUcN820n4wAWYKOm88eorBYkmyKri+AHQvaqShBy07X6S80GWPW/MOTpIwK3w0E
         bZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTqt3nErfiZSjAkczTLPAKBBxRpuuzdKdgcNc2UKxEXkq0M+3d1hpggRo3/ULPpZrMi3/q2wGcLjC0BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCi1CFknYzLTrWpfdMoa2NPvRcc0MF0YV60vnsQJ5enP6ITw0J
	GjJNgdqweITul4bWJPFpTQcq93JHb5yTu7cU9r+TaXh407988ncMsUKT
X-Gm-Gg: ASbGncsI5M7hbxM+8JOl53HX4oyk9VySdYDcKCEg/2UFD3HEaJeQtLgr/VBhfgdk4ba
	1bxYAc7gTMWspGZijgClV0U2wpO+imKvdpY9JaeDeuukeZkthltylhG+2Nr7WcDMZIazcbW5rx4
	KrYx0LaRc2dWiF7sED78aDJlgmAsrsN4cnqIekJui4E/czFybq3yojObVDyUswMAY37RdCGclOZ
	X+Iiz+cI8fij4Y/9F+rRS5LKG7Sw5oXraeJhbtoZ7EV8PfWS6BKQbfpg6vH50ZnhaHrXkLygZzE
	b0m1Q9R4nxuX/hIxaDzzwPbQaO/EZhHWjv4K9jLy7Ygdpiw4uz4QMde4CLnnyG7/iH6YgkZXhBI
	pLbn7VlTODA25ZpCelcdaW2aPSsBqqpQa6Z9GP6LNLJ4uM7Syz4g4phDYaEOmYzq+ycL6y2fQry
	DHACLpc/ByZIJ/TllRnGmwRyJjjxiYMHPo/jgq6GG5Mf5vbjGpC0mZ8IKoYUlgejkIZqB2ipIMo
	jmMTbnamlvXEkH8Fum0wVLw5SWpvBZ94KD+A9J+sV2ixYdzPaRJu5FEg0UR3Gk=
X-Google-Smtp-Source: AGHT+IFKKdVLl3mAPx5GW1O57JDFIbYY3aQNyGp5ohShtikkzbyW7xTlAHv9ByPokofKb8ncQ992Dw==
X-Received: by 2002:a05:620a:28d0:b0:891:7def:94a5 with SMTP id af79cd13be357-8917def9615mr601979985a.89.1760809543355;
        Sat, 18 Oct 2025 10:45:43 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:14 -0400
Subject: [PATCH v18 03/16] rust_binder: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-3-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809526; l=1195;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=872/2/9eITdb9tB+ajd4McXNzNIKi7XLnXFm8ifjokI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNpeE2O2veZx/WAQcXn2BPsuVFmwejvaIZ814PGVaIzTcLISv+9UjXgL3SnRuXBWt3P0YjfBZ5X
 ySAtgUYGZcgw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/error.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 9921827267d0..b24497cfa292 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -2,6 +2,7 @@
 
 // Copyright (C) 2025 Google LLC.
 
+use kernel::fmt;
 use kernel::prelude::*;
 
 use crate::defs::*;
@@ -76,8 +77,8 @@ fn from(_: kernel::alloc::AllocError) -> Self {
     }
 }
 
-impl core::fmt::Debug for BinderError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BinderError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
                 Some(source) => f

-- 
2.51.1

