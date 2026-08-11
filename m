Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6D40BCC8;
	Tue, 11 Aug 2026 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430469; cv=none; b=eYmzzV3zU0lnhticotpavj+uy8X1D50X4kYM5vey5zHp2dYJDrCXwctP+bijNuPV/5fHpS6OEIrJASoOV3ybfSmfhmX4ZI0SduRqjSbz9ELCit0s5JequyIQQStw9BkVQYqJdQTNinRy74SnBK+ZAHo4iQfKVLDxYfwsi01dV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430469; c=relaxed/simple;
	bh=210BZtuiFJIMwjT+et+SglHzrJZ9Rn2bfw11ACWgPTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrB6pCEQtoqx0vCiSSYlNvdOqS/iCjKt4aMgcy9rrB36hil5UHpgvyYY2oncZuxVW8ZZF55TNpUyZiC/As+MpKKAYcZ7xN2RuwgH5j+kgXncJjmgw2dgTIjhfLeBbjbl0Nxcu3EL0CjO4ie4zSQgxSHfhp3GT2GTBnwQVEAL7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=yetFBTRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="yetFBTRb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D8E0C2BD05;
	Tue, 11 Aug 2026 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1786430466; bh=210BZtuiFJIMwjT+et+SglHzrJZ9Rn2bfw11ACWgPTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=yetFBTRb+VDdSuviGdTBHAvdWGnnuFzZs4qh2DkEjzU41gcnMzZnILkH4cXkWjbhN
	 8cj42rGCLWyubK2od2kv4BQ5msMNNokOKDIo58z3ptv2XdrRlsm4+7AKBWYJ0WoCDL
	 MAyA71JbdlW9+QOBaDyf4dOo0Tmfg22esov/A6zU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D4C5B574;
	Tue, 11 Aug 2026 06:41:06 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 11 Aug 2026 14:39:52 +0800
Subject: [PATCH v10 10/10] rust: module: update MAINTAINERS to cover
 module.rs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-fix-fops-owner-v10-10-7e71776f9dbe@linux.dev>
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
In-Reply-To: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786430463; l=1044;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=210BZtuiFJIMwjT+et+SglHzrJZ9Rn2bfw11ACWgPTs=;
 b=/IQwQTiwkzMVV5LHOI+tN4/Y4FQ0j0tCL7otA/BSzNwTy46tm7weLpFMixrl/crEC7PWZXm1P
 uT4fRPfNqlKCZFKlsMEq+apubZLWaSyV+hd6WmthWnSyp756fuVsZAb
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Module types now live in `rust/kernel/module.rs` alongside
`rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
files are covered.

Cc: Petr Pavlu <petr.pavlu@suse.com>
Assisted-by: opencode:glm-5.2
Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253ed..ce84c56f21375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18189,7 +18189,7 @@ F:	include/linux/module*.h
 F:	kernel/module/
 F:	lib/test_kmod.c
 F:	lib/tests/module/
-F:	rust/kernel/module_param.rs
+F:	rust/kernel/module*.rs
 F:	rust/macros/module.rs
 F:	scripts/module*
 F:	tools/testing/selftests/kmod/

-- 
2.43.0


