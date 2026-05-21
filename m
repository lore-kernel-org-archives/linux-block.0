Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9938395AC2;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346633; cv=none; b=PdPv/iheNOKkZ7BK95YKzjYNBJ7UdOKbt8r/Eqfa5p2ofiq0rWzvrg7jwYUEfeNVi7TgjfHbaYAlKsXsU2V+/cOQxW+LKz9RZhVGTLHv/fc48oD7h4cLaOgK9M5r8GzKH/X3q4RFa2SRjDbm9MkXU8h6uaJZ8iSGItf/wn6O5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346633; c=relaxed/simple;
	bh=VBLRqj4ChOybBZhMTp5zBCaU6pJDNwNCjW29RUtQRLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhvLUn4lRdSBSl9AO17Sgf67xUZRTe86fU1NO5T3vUAHJSMyGhu3/Rzg8aEhy9vdIkEILtQVQCoxbUJTzK55PG729XN1YfsT3BOCIUWiuZbZozqYBxnVMSuwvGKuzrpct7greQ8IKUZr0HUMsC0btUO55jsg4jj2/9OJEpCKcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYgWm3A2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYgWm3A2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAE27C2BCFA;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=VBLRqj4ChOybBZhMTp5zBCaU6pJDNwNCjW29RUtQRLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uYgWm3A2ZoTXWmrxHxSJ8V0RxEmcmxPzQsdNhDJrw8UpR8yApGykTBoxNE1YrxWrj
	 F3DTDN0oKlO2PunwSHT3kwFeMQsXw7qHlsMNe4bBh9a43xkf74usXO0bXDOIgVXPV3
	 7z+JJvGgBA1dUCI6AYhkxNssQ/sA4/cbGNzIRTsU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2243CD5BAB;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 14:57:13 +0800
Subject: [PATCH v3 7/7] rust: doctest: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-miscdev-use-format-v3-7-56240ca70d0c@linux.dev>
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
In-Reply-To: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=807;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=VBLRqj4ChOybBZhMTp5zBCaU6pJDNwNCjW29RUtQRLw=;
 b=QcsXlH4hnT+idKhT7B3U23jMM0PEsHmzqMMiWE+xKaoVssd1BspYb8wAMrz5YNZSh+ff7Z7ze
 moeSyg+d7XSDhMJUuPBOYHkqRfCIae0PSelX4W6aMGqsCxAz8gd4lnU
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 scripts/rustdoc_test_gen.rs | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index d61a77219a8c2..ee76e96b41eea 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -31,8 +31,15 @@
 use std::{
     fs,
     fs::File,
-    io::{BufWriter, Read, Write},
-    path::{Path, PathBuf},
+    io::{
+        BufWriter,
+        Read,
+        Write, //
+    },
+    path::{
+        Path,
+        PathBuf, //
+    }, //
 };
 
 /// Find the real path to the original file based on the `file` portion of the test name.

-- 
2.43.0


