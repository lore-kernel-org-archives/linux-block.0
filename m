Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2F2E54AA;
	Sun, 15 Feb 2026 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198982; cv=none; b=o74gUij++bZSPQsgHsrwuTBoLZn0K0fvHegqtN1N8/ZPdlfr5W0wCAofLQvsM4KGMJ7zupuDt1adt/aX3SSQGDlzmDxiwEl0DgJ50Jw2OHSArmTS2f50FKigghRUeusWfQMMnstqoSx1g7YrQGBe30N5mOfg9TdJTvCS2RDsZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198982; c=relaxed/simple;
	bh=fZvIGl58JonxCsHjE1MOz0gJuaXvox3LIYllPG0cQyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2vbekRcItvdpA0rmUWsrcjiRcPz7ZzOEdOFYVk9KN7WjftoDGmQEzS6ncRbW9Fjqn691kCb7Ro3pPkLv3BT8bKoTtVBu/Su4QwpQ9KustGdBpfSpcoKsM/Vh58w/YWL/cjE76lJwI7XKPAJb7v1mMKiek3fkGBDjLVlPq6/QSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpakzWk4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpakzWk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74930C4CEF7;
	Sun, 15 Feb 2026 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198982;
	bh=fZvIGl58JonxCsHjE1MOz0gJuaXvox3LIYllPG0cQyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tpakzWk4TWmcbuhpkBUEC9edsz+5JRgd1QpogL+InpyA0YDVT/qXAZTJK+BcS6IDm
	 4eLxyaf8IQfkbJw7hCl0onMo+VNhknT6ZzMihDkhrt6S9VkdC2fwHD7T26sVa/Pv1b
	 HXwx08mbXDAKhZGPMHdRmOohz8nZB7elUkYYF+Jc2uvEaVxcemosU6VoPBJr3XW/0K
	 dslY/CbFU9/WJYgyDZiCGY5ckt3eIqVvkEQPB28TPuwZGNhXcPEdTOdeA/vWvNPDji
	 4E59Cf0cRQ61S86hTjXM0monf/n3ZjwZVbeoqMoMjkBaV+RNbNZGHVy4G40q55Nhog
	 76Fh5AJmXKyIQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:08 +0100
Subject: [PATCH 21/79] block: rust: add `NoDefaultScheduler` flag for
 `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-21-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=fZvIGl58JonxCsHjE1MOz0gJuaXvox3LIYllPG0cQyo=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklguOLYxvU7ZbLaMRp9Hmd+T5HDAKD73QjHU9
 fYsKhE3Q8OJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYLgAKCRDhuBo+eShj
 d/JHD/0Qi2wOgU0MkzrqlvaS/lF0f0454+YaKacIDMS3nRLwpUa3xzj4xTQe2g3XcReJipitalT
 QVhPor15WdaNkr6AQcEeJs9Mml1rIsQFXWVK/KHwShX/ikW/jZiVME/UC2F1dWrL/P2IscSS8+r
 6jfRd+XsFzduzj11vUU7XlPQDV7TXq+ZJ1if4wVpTLwvR9LyJHp+mHtx/4seUn3pj7/9BI0Obng
 C6PMUYI6JJNsbjcmjO2t7NbZwnlrXkyJxURPsW5B8uTNt/k56NhTKQS5cpjcMkkMozVX6zp8tt1
 xe3GhZW5IsdQAe5XIJ0NiaPs4cL5in6gEx0jefPwu4F9lw+do6qvu1qKqZ+sPofYcLSG+y/9VyW
 QuIYVyAkdmvKwdZj2bId5oa/Ae4QWnioW/oKZ+v0POvs6raOLo9c+F/DMOmYNtb59WaGcU8gFaV
 jZTvQmYfMaS9ZrdUXE0rINFy7S8FcwPa1kmsCTFLzC/C4KCdJ7N32/HKOWACKfY0HIDECz4IRbR
 oxlMt4WWgbLKN6chtkBvXUbxhBR/tBabfHH5NV0US/xMsYc+ODU9JHYiasnbiO3sdP5E6dpLesk
 batWietAxuT0bgcv6zPNYoKn1f4TKNp2BFJKohYo/pW+aLS6Cb8uUVL88jiaW/HQBf7EY6PokTs
 llKN6jpceUvDq8Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a flag that maps to the BLK_MQ_F_NO_SCHED_BY_DEFAULT. This flag selects
the 'none' scheduler during queue registration in case of a single hwq or
shared hwqs instead of 'mq-deadline'.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set/flags.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
index 768db938b9a95..1fca4fcb4dd20 100644
--- a/rust/kernel/block/mq/tag_set/flags.rs
+++ b/rust/kernel/block/mq/tag_set/flags.rs
@@ -15,5 +15,9 @@ pub enum Flag {
         /// processing IO. When this flag is not set, IO is processed in atomic
         /// context. When this flag is set, IO is processed in process context.
         Blocking = bindings::BLK_MQ_F_BLOCKING,
+
+        /// Select 'none' during queue registration in case of a single hwq or shared
+        /// hwqs instead of 'mq-deadline'.
+        NoDefaultScheduler = bindings::BLK_MQ_F_NO_SCHED_BY_DEFAULT,
     }
 }

-- 
2.51.2


