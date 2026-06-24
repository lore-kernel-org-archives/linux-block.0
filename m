Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570963B442B;
	Wed, 24 Jun 2026 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305855; cv=none; b=H7dH4xBjseO5ZiMF2m9U7vaVhqag9i8tns6m1pZJAsmuoypXq4tNQXWwQ5wFh0O5b9vvtu3Y5GTZwoQhSsTBgqMbGJ+S4UYy2ArUP4VKhej9Tr68Wqsb+pTQuok4CF+RSAA1z6G5IbXTrwq/QOwy0aQppZp6qggxbejIteHQIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305855; c=relaxed/simple;
	bh=22JzG9JO3CkX3gbD+EPMrCHjJkU6XeFIY/WRO8iDOoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btdUq2EHAvrdkyid5Rpy7Syq/BlshIw/cmwhooB4iCBT42ibqD51EkzHiBxKC33fxtG0OJhKIx5zUQUV+iJikZyJbLOzs7vnt7U+NhqOMNUV3oAvyyDgczKx6t9fVX/UmU+SdmULrVnBRv65WnzozBjIApmR3xA+7xQY6M/akrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJANETAE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJANETAE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CBA6C2BCB4;
	Wed, 24 Jun 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782305855; bh=22JzG9JO3CkX3gbD+EPMrCHjJkU6XeFIY/WRO8iDOoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJANETAEGJOThZwa3z81ui4K1G9b/GJAkP3L7c0xeoRMHA+aBEVibCrk/mPBNKBZJ
	 eH1Aj4xGA9aICQMvXq3XQ/oz1niTG07NjowOP7ePUIglCikTdY8/aeMx2JmOo0wXZp
	 DIw5vlVBlORhRjgJ459vEHaIF9N7gHS45PXdic0g=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2262CDB47F;
	Wed, 24 Jun 2026 12:57:34 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 24 Jun 2026 20:57:29 +0800
Subject: [PATCH v5 6/9] rust: miscdevice: set fops.owner from driver module
 pointer
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-fix-fops-owner-v5-6-aa1cba242f05@linux.dev>
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782305851; l=1106;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=22JzG9JO3CkX3gbD+EPMrCHjJkU6XeFIY/WRO8iDOoc=;
 b=+r8NvhZxlKUigASt7OKpAhHHDUIJ9QKOKivclwnKRKuu90xxFtdzozyg2dPZyWLEnN0O/Rwej
 eUzDYKRwUyLC8aiO224atTOL16tbBlJqF0yXpzIqr6FkfKhF2L538DY
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Set the miscdevice fops owner field from the driver module pointer
via the `this_module::<T::OwnerModule>()` helper, instead of
defaulting to null.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 83ce50def5ac9..2a4329f98614e 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -24,12 +24,13 @@
         IovIterSource, //
     },
     mm::virt::VmaNew,
+    module::this_module,
     prelude::*,
     seq_file::SeqFile,
     types::{
         ForeignOwnable,
         Opaque, //
-    },
+    }, //
 };
 use core::marker::PhantomData;
 
@@ -430,6 +431,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         } else {
             None
         },
+        owner: this_module::<T::OwnerModule>().as_ptr(),
         ..pin_init::zeroed()
     };
 

-- 
2.43.0


