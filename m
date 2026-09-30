Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CF38F249;
	Wed, 30 Sep 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797461; cv=none; b=RZ82BSLaRu2cH+owV992iOSmKy7CjSLmKbzoOR6TMCZTaRpk0NkvzY/RgqF/+7b02jcS1hHbSVbzm7IHXpikjZLhXQrbizZOOMU72b8My64t4PHy91QZ5WyPAi51JEmUnEZR1Qu4ln0XdjpSX/kAnsFT8un7oOx0Sxy/THwFX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797461; c=relaxed/simple;
	bh=leG+KYeMecwefNn3L8fO7Ys/JSrQICGvkRv9x3AvfgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CAp3oRyVv/+BMSxlm2BCMrUd8V/XAYfIU9u+0i7EkSbcpyfG8U10Ry0yzuqFTa+OtKkTfs7LeT1AzaCSJODXzjq5sZbdfS7b8zjtqHRajmaeH4fKKRzY+Gc2T1RUpne5KZpBK0CVxj1+cx3bF72zWOt1RxibadKfyEHGP5oDM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPNkegk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPNkegk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4431D1F000FF;
	Wed, 30 Sep 2026 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797460;
	bh=OFImjkr9ZJupqvHYnBoqpp0icOp41KnUwRZeP8bQc5I=;
	h=From:Date:Subject:To:Cc;
	b=LPNkegk9RXC05RGxdiAl4ldyTuAeoeyViY0lP+p34gdbBl6CcI6PNu7f6q08ghDGT
	 NL6rN8YsDe3YEcIxBxUO2jbgoMw0egQzmF7ivQ1EsvMEM427qqQgVhUBUdRvRnfba2
	 TbtLNRUgZ3EkmHvOw0OBcKYpsDacdqFZB9jZt1KapL+pQurYP4icnrZZsw9XB+PRRd
	 ZNBX78lSQK6Ejg3Oa9febQIigI5NvUi+nCDRLvQYZYmZzZj/Wo9299VkUlqbCOWB31
	 Si/D3X+k5HrfBpz+YyqjtATXApXhN8ZaA8P0e6fQufzNRNq9C6/Y549/CF1Roma6O8
	 NCtVUK0gQzTEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 30 Sep 2026 21:43:55 +0200
Subject: [PATCH] rust: block: implement `Send` and `Sync` for `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-tag-set-send-sync-v1-1-51acdb36f4bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHpmvWoC/yXMMQ6DMBBE0augrVnJJoAEV4koiD0hm8JEXoMSI
 e6OIcUUr5i/kSIKlPpio4hVVOaQYcuC3GsME1h8NlWmak13M5zGiRUpL3jWX3Dsat/WjW1gYSj
 /PhFP+V7N+/C3Lo83XDpDtO8HiZZuRnUAAAA=
X-Change-ID: 20260930-tag-set-send-sync-c4d64515e1e0
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=leG+KYeMecwefNn3L8fO7Ys/JSrQICGvkRv9x3AvfgE=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqvWaAXiJhiIrfd2oNYRlrnpRfVkoC3C6m8r4DH
 VY6XRN7LkyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCar1mgAAKCRD6UCkIqsW9
 0JYED/4n5gj6Blm4y7ot1QcNTsHXJ+I1rgKjbWpH2WbtKyBSUTjmHFwJ68YPJ2C58FfNE3yntOy
 FS6FkfYYmt40M5KXL9Fg1ZAwKEBWIQdYAM0SFWc1ZzorNBEgxqzZDfnL19TB562O/zoUEwhe7fY
 Ru9jbfOeRKTiQviVkd1uiN9zA+i0KXoStglEgoceL4u15dBqeGaBkV6GSpkH17l4AqzL7K/tOQW
 kpAWqH0GooXvncxrRwsHMKZptJqd5R5745Z1A7Ge6WjTzLam1uV2y3jJsATizbtH44jrtwRs+gw
 2VzxfEZneBnoTIEperYhFc7WrPS8l74A0yV9CM8nvkRwNu0NTn6ysVosxeornosqhKF1qrjfh3X
 umXd4lmvkgVDvxsjd5PUBd6yjj+ssQV0tsACJ48/jCTgyR5GeDW8dDSGAtM9YHZTTW6FlpSQqQi
 fGyla98K74N5YrXBJrZ6ykT1YeI9Y+kwuVOjCKhEJ4XkXBD/nGbvhkZQ5NhkMBHKN/YbaBM0Ayu
 /OFiMupuwKTbNFGhUrp3Pz+JLne7QIFXt5PZ1yjOIidTorLoUiv0jmDdmzr/IF/K3Gtoeu6F8op
 8EkVV8kexsffyfv1LibkAdRdiS3g2bTNtsSrjjAwuQP0QtkHlZySVeinvN18xYpH7iF4UWmlKIP
 aOGYoMqmsdCbytA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`TagSet` never implemented `Send` or `Sync`. This did not matter until
commit "rust: block: fix `Send` bound for `GenDisk`" made `GenDisk: Send`
depend on `Arc<TagSet<T>>: Send`, which in turn requires `TagSet<T>: Send +
Sync`. With that bound unsatisfiable, `GenDisk` is never `Send`, and the
rnull driver fails to build once configfs requires `GroupOperations::Child:
Send`.

`TagSet` owns no data typed by `T`. It only wraps the C `struct
blk_mq_tag_set`, which can be dropped from any thread by calling
`blk_mq_free_tag_set`. Thus, implement `Send` and `Sync` for `TagSet`
unconditionally.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/r/d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Hi Jens,

Please pick this patch to resolve a problematic rust configfs/block
interaction in linux-next [1].

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info
---
 rust/kernel/block/mq/tag_set.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index dae9df408a86..00d29688f920 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -83,3 +83,10 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::blk_mq_free_tag_set(self.inner.get()) };
     }
 }
+
+// SAFETY: It is safe to transfer ownership of `TagSet` between threads.
+unsafe impl<T: Operations> Send for TagSet<T> {}
+
+// SAFETY: It is safe to share `&TagSet` across threads. `TagSet` exposes no
+// `&self` methods that mutate the contained `blk_mq_tag_set`.
+unsafe impl<T: Operations> Sync for TagSet<T> {}

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260930-tag-set-send-sync-c4d64515e1e0

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


