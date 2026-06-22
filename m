Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AB33A71B;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096303; cv=none; b=dEQwtUbiq0KNMejUpcoYKBfY8Ps6yYHwri0nzXqbhBXadD/EvP+Ecj3XM7RL0H/mpnVI0aOUol50bgYizHYsmIPwVwAWXnZehfc4kyWZFHN0foaaN5G/NthlCA45tE3+S6hGSkTTOKPfBiKLYfzzBaRTuZYOfinOdalVBb+72c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096303; c=relaxed/simple;
	bh=A9lpJTE9i+SErDM9bVa4MkYn0noMli/rMWQ6+DXIokU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoYUXwzsAzIvrn4n1vJWk/Rswrs8BQeq+40vcmJ3tzix5voF2KcsSk9d7VRwQKzpfa5zf97WX3nqQmeiFkDWFSGtMLHWqYZ1JE8b0+KZn/lUtiAhDYJIsPcFlCc2wcE3UpZhYpx4HocXvOqYlWjjwslAD9eTtBhDRbYF5DGfdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2RHi7M0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2RHi7M0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B95CC2BCFF;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782096302; bh=A9lpJTE9i+SErDM9bVa4MkYn0noMli/rMWQ6+DXIokU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m2RHi7M034JHhsUzO6KBTEpmvjGXHs/GgDlRnL7GbovpjnxITbHBsbLmbW3+Qcjp7
	 7uLsFUnDPPF3PxGLZbAN9XdP4/8Orle0BQOIXUjwqlqBhA8/tgQE22aISlGxBCQnvt
	 5uPoF2wDAAYPjb4tWqAGYEHxKlgqYZPluGOrwxHk=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3245FCDB46F;
	Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 22 Jun 2026 10:44:58 +0800
Subject: [PATCH v3 4/6] rust: drm: set fops.owner from driver module
 pointer
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-fix-fops-owner-v3-4-49d45cb37032@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782096299; l=1744;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=A9lpJTE9i+SErDM9bVa4MkYn0noMli/rMWQ6+DXIokU=;
 b=IrbsyXU//+NNYPJbThL6GUA/f8+w5gYrQRvZEeQ6Yp6HuLoRr4dFRdkAzv3B8hfuh8roEXwP2
 CweFv5WUUCJA4/XAat0YPQ7idbYTiDSe74si0FkVYwcNbAK0UGCKBKs
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Change `create_fops()` to accept an owner module pointer instead of
hardcoding `null_mut()`, ensuring the kernel correctly tracks the
module owning the DRM device's file operations.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/drm/device.rs  | 3 ++-
 rust/kernel/drm/gem/mod.rs | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 403fc35353c74..221667d843c41 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -111,7 +111,8 @@ impl<T: drm::Driver> Device<T> {
         fops: &Self::GEM_FOPS,
     };
 
-    const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
+    const GEM_FOPS: bindings::file_operations =
+        drm::gem::create_fops(crate::this_module::<T::OwnerModule>().as_ptr());
 
     /// Create a new `drm::Device` for a `drm::Driver`.
     pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<ARef<Self>> {
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 01b5bd47a3332..9a203efc59116 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -357,10 +357,10 @@ impl<T: DriverObject> AllocImpl for Object<T> {
     };
 }
 
-pub(super) const fn create_fops() -> bindings::file_operations {
+pub(super) const fn create_fops(owner: *mut bindings::module) -> bindings::file_operations {
     let mut fops: bindings::file_operations = pin_init::zeroed();
 
-    fops.owner = core::ptr::null_mut();
+    fops.owner = owner;
     fops.open = Some(bindings::drm_open);
     fops.release = Some(bindings::drm_release);
     fops.unlocked_ioctl = Some(bindings::drm_ioctl);

-- 
2.43.0


