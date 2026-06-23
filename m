Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3B3C4554;
	Tue, 23 Jun 2026 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196210; cv=none; b=EYRL+SEGcFFy56+mEN+ouHAuAyX4HeeURkB5wZCJ6AnfUjPhVzX8hSH3UE8mBOwZQNo4Bmtfacl0ZfHCdzCZ5c2tndhrsa61Tv2kV7EI4MlIXgj+EhVbZCinTxRpq90UqolkSD6TCh6qO9hsy2+E9jgBcabYZeQXvZL67kT9SVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196210; c=relaxed/simple;
	bh=UpI9p9cSp2Ii3d4RVVYEVHNvSOxoRDUiBS4Pr+8Z+2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPJ4AojKUefnDNM1j4iMZf1IU3wHPw94Yf3MsBI/P65GBCuCYSa7CgygNsGQye4p9ETBioUaTbzoEMDEz/lO+uUQnpP58vf+g5KrzRkHLdWQ7X5/SlWqGDYpQKwCYvzxQdfAVujKk5VKUYpP+hnoKP7XMBNp2FWntVBd5SuB0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kvyt4ILX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kvyt4ILX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0E4DC2BCF6;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782196210; bh=UpI9p9cSp2Ii3d4RVVYEVHNvSOxoRDUiBS4Pr+8Z+2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kvyt4ILXq1pLkObq2EcAb6CXYsHyceEnPQP3DsKB4AX44/ug8Q746+XHQDf/3GCUR
	 p39XGy/TmVst2v+Hve8swncMamJ9Gf5IASX8VfAiyRVjj3pp1u5ITk0eNRHHtvvqLy
	 nlRT1KSwCknKLX0fgK3ipkndYIDgXRcKoM1wTMeA=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4091CD4F26;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 23 Jun 2026 14:29:51 +0800
Subject: [PATCH v4 8/9] rust: binder: use `LocalModule` for `THIS_MODULE`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-fix-fops-owner-v4-8-0daf5f077d5c@linux.dev>
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782196206; l=1258;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=UpI9p9cSp2Ii3d4RVVYEVHNvSOxoRDUiBS4Pr+8Z+2c=;
 b=HkL1+er7vHj//9B4WFmJtd5WPXvI4isc0vrQcbic+R9vXop0PiA3q8nnGehnRDAmT8ej+ahIb
 Qil2mKF4R2WBd5PnuQpWAmC4QJe5oGxkyMnIKmprCo+Ptk4seBNoGJm
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Replace the `THIS_MODULE` static reference in the binder fops with
`this_module::<LocalModule>()`, consistent with the move of
`THIS_MODULE` into the `ModuleMetadata` trait.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/android/binder/rust_binder_main.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index dc1941cd2407b..d6ceebbd5f94e 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -17,6 +17,7 @@
     bindings::{self, seq_file},
     fs::File,
     list::{ListArc, ListArcSafe, ListLinksSelfPtr, TryNewListArc},
+    module::this_module,
     prelude::*,
     seq_file::SeqFile,
     seq_print,
@@ -318,7 +319,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
     let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
 
     let ops = kernel::bindings::file_operations {
-        owner: THIS_MODULE.as_ptr(),
+        owner: this_module::<LocalModule>().as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
         compat_ioctl: bindings::compat_ptr_ioctl,

-- 
2.43.0


