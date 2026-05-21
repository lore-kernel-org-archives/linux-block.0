Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029D39AD3B;
	Thu, 21 May 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349978; cv=none; b=QIBUjTkExcOwaeoVKgh3Y0qTU8S4udEjXAUYxTC5nBE6D13DC01Q12tSWHJgpcG4jJbbasLqbUHsPjdh1n9Amqg7zANJMJwOf8bbyay6Gdh2JjFB6rXee5da5hBYGA9+xw2Imvnn/kP//jV447Y4me+wcBg4SZoxlJdcIMEeb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349978; c=relaxed/simple;
	bh=ZLZg3IepeQ/FIWdBo7ULWIJqtzCz5tUnDaQV8pb6xjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha1XpjngElciWibnfEYTSkyEE/4woRZuICVes6ncEFd7Nymi3iUo4rdVprlxBQQH28zMvJl0j6bgKYSUJWVPCs/QLoSvQKTXQzhNjwBC8PQRNtWKDoIMiMHdf5vhzPU5jdpVVpzKrSbEdxBRZUJ9X6SwfbJz1Zsb1BjYNehi9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDWkfj9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDWkfj9q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C437AC4AF0F;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779349977; bh=ZLZg3IepeQ/FIWdBo7ULWIJqtzCz5tUnDaQV8pb6xjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pDWkfj9qzfufJelx4OK0KKcWNMMIuB1wexLtWA8zNVjVn+c5Chit3trh2ke8ypAXw
	 bn7rSFJ9WjkGiQQNqUN1VAQ6eV8xPGxyrYGsCe/SOWrvjf5ia5QtVZa9H/20C3TrTo
	 6BYr/vjzzz1mO3NbW+QjYJRkfbg4xsgTwcVsTPhI=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4CCD5BAC;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 15:52:57 +0800
Subject: [PATCH v2 5/7] rust: miscdevice: set fops.owner from driver module
 pointer
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fix-fops-owner-v2-5-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
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
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779349975; l=845;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=ZLZg3IepeQ/FIWdBo7ULWIJqtzCz5tUnDaQV8pb6xjo=;
 b=ZPcQW+ke2M5roVi8hqjSu2tTV/KUO5SrxqOBAl4HnOX0EguwitDtpC+1e+TOpKDo8ODRgHXl6
 2TlCA91puNbAnSKac6TUK9BwTyx90qtpGPx93nCS4GVpkfpiQPIHcmg
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Set the miscdevice fops owner field from the driver module pointer
via `<T::ThisModule as ModuleMetadata>::THIS_MODULE`, instead of
defaulting to null.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 83ce50def5ac9..16837c46bca49 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -30,6 +30,7 @@
         ForeignOwnable,
         Opaque, //
     },
+    ModuleMetadata, //
 };
 use core::marker::PhantomData;
 
@@ -430,6 +431,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         } else {
             None
         },
+        owner: <T::ThisModule as ModuleMetadata>::THIS_MODULE.as_ptr(),
         ..pin_init::zeroed()
     };
 

-- 
2.43.0


