Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D626ED35;
	Mon, 22 Dec 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406385; cv=none; b=R/qeZyDjoFUjZ/OqCa6qM421TrHkY9O3WfrQYTECBO8tDu5kBMEZ1a0NtIExpe1+hIpn7G5NUzjkJ2u95xjiK7LkRJTjMUnP6h25GN952da0thUywlOyyGYPyFvW1n/YnslEdlFotuID+kUGMZuNdnz2XkhSXAs1jEygq3volyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406385; c=relaxed/simple;
	bh=C83cMAc+Qm72aZHniZ8ixLKEmDFDmDOxhH3UUiwkf34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ackAITyazoU+4e50p0byEv+yZNmM+nMiITl9FbWF2206mEvjbEKI4a0OXfWhTB9vz3AG/waA0RvnBYIFstm5WOJHXhxuAJnA0kmLJeiowJ9Mw+eM6oIfkSOsmuOWI5pIxgKHx8IEVe3yZ9n3QWFix37YQ3alZ+y4XYUCvpItPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCA7Fr34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCA7Fr34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE5EC4CEF1;
	Mon, 22 Dec 2025 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406385;
	bh=C83cMAc+Qm72aZHniZ8ixLKEmDFDmDOxhH3UUiwkf34=;
	h=From:Date:Subject:To:Cc:From;
	b=OCA7Fr34sBo7tuI5WRxGL96okO9XLCipgpZwrgR3ukE9xfXyi83dQrFGaeqU2sAFS
	 GeM6IamYQsviLfM2kXxSploP1QKuBGTW7Gmi6GD/zkDsqS1eZsIn+3KkI48jv7a9L6
	 fTZXpgTAStKrlwTQ+nqU174NlwCdIHrX3CO/Z1oEBp8CbPSw5NS02K/653MGb55MWC
	 QK8ZP41a0MDchRvKooJu+Kb/BaEyg2PBWs5+gtT+4UNaT2MQV0mGfPI4JqtnFvfWIw
	 +mANtrdBPe910uZPBV0aFY17mwW3lU6HwUp1ZbdF7NuyUfdKYDPgOdeOt4WJcLT1ka
	 ceURDOjk3ApQg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:26:19 +0100
Subject: [PATCH] rnull: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-block-v1-1-fdab28bb7367@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AQAxA0atI1yaZqbBwFbGgiiLIFJGIuxss3
 +L/C5S9sEIeXeD5EJVlDnBxBNRXc8dGmmBAi6lDREO6eVNPC43GZs6RJZuknEAIVs+tnN+sKH/
 rXg9M23uA+34AB5+06W4AAAA=
X-Change-ID: 20251222-cstr-block-0611c0c035e3
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406381; l=963;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jckVvAGaqWytLY6U2KXqXNq5LzikvWjoi+HO/1XhgGI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLjUhNmVwL9D98z/Y1F4jCL9lXG8CCiBWFkbPgo55mK9nxtfegpTxIGKg/yP+P1CZIol99QApMd
 p0Ej8JJqacwg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 6713a6d92391..2f5a7da03af5 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -25,7 +25,7 @@ pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, E
         ],
     };
 
-    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, try_pin_init!(Config {}))
+    kernel::configfs::Subsystem::new(c"rnull", item_type, try_pin_init!(Config {}))
 }
 
 #[pin_data]

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-block-0611c0c035e3

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

