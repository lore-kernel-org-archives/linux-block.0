Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07033986F;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096303; cv=none; b=JkAnT6LkzSzLc7g7YEqD1uliCc3HT1UdTDGqKW2cR00YjkEah8NGdaRIJsiXoS9IcRYcC0z+f9AZaA8OJbTHcs+yigHweI1OAbAzbNadlVypaJpKi++l6lEO44A9Tb+gQY8ladYv6kYOW/mxJggbuznT2nDCRYGVFOBbUP2yCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096303; c=relaxed/simple;
	bh=XqlAKYyTcpktRZqbGKxCncze0Yay8QvqMz2MWsZrx6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvIAAb9EyQf7//4zMt923z2qN7YfaweSDelv9gighkmIl5/I+SgSjx1bhz7yHqTpoVz84kFHHSVfJyE6F9jhlTXOzlfFnmGSrLXH4NK9Gom2hlkvBuI4lOfqXuTTxlg0gAmrt1ZuCfaTjeMq0qzF4d/C5URTXUiHvPNC3scuA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFybzT64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFybzT64"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB78C32782;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782096302; bh=XqlAKYyTcpktRZqbGKxCncze0Yay8QvqMz2MWsZrx6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IFybzT64b5DbfeucnCzEfRSGnYVQ0HKICl9IDWMb3dzjLuJqt7JRgdHvSldLOmb6V
	 Q2Kk/4oatPUTiWZyGsuczuwIfGWkxFPel0IRw/a1fTJaH+JGgizzPuBU6faycdCpIk
	 pKww4xDVLJYkn4gTtXIpXa4nfs7IMV4j2c+OIu1Q=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D3FCD98E4;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 22 Jun 2026 10:44:59 +0800
Subject: [PATCH v3 5/6] rust: miscdevice: set fops.owner from driver module
 pointer
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-fix-fops-owner-v3-5-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
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
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782096299; l=933;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=XqlAKYyTcpktRZqbGKxCncze0Yay8QvqMz2MWsZrx6c=;
 b=gI7W0QWHpwLj3bG+T638uuriPi2CqLC3Fo+Ex/z/JTtCkwRe8LJi6L2BFmlk/TJ+LLtt+FGH1
 V0h8jJtyIitCYLBooeYAzdGmvxMwNnRLN4BsGREZBUH61b0Kg6q0PxC
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Set the miscdevice fops owner field from the driver module pointer
via the `this_module::<T::OwnerModule>()` helper, instead of
defaulting to null.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 83ce50def5ac9..04fe4697ff564 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -26,10 +26,11 @@
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
+    this_module,
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


