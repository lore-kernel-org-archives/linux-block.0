Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C62EF657;
	Tue,  2 Sep 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806944; cv=none; b=dCNoUngCDsa8sWkZrINzekcDI3CBroo6iMdshbmCeoEaHc5yN7q9QCb6x6I1uynC6cKYpjgj3zzYGLGunQAZblsxXHVJDKxhUUYjm661zkVVodnouN8O6pd+7Zxgcu58FXGqwdnzHZ6fU2e3eYIWL82kpQOglQ2QKmb5mjIT3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806944; c=relaxed/simple;
	bh=nwKi1FGptwRfXIELQTuMx2CYoPiscRWnpzAnP5fcCw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLJ82vLSFR6qTWu8vwaWxCsn5hSZNZUNc+Zh8aQ6pVzktK5cxbodAMonRBoTmMjznnfGLpRSarqAbdxLx8yJnkqCaVgVBC5YC0w5yQZ2fztuJZ7KlmXepXzagdZnvfLdQU7AnNyEUAHc+UIT0ld35qPnB8H2K1Y1/idW4qC/zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnTiX9CV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnTiX9CV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D1DC4CEF5;
	Tue,  2 Sep 2025 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806943;
	bh=nwKi1FGptwRfXIELQTuMx2CYoPiscRWnpzAnP5fcCw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HnTiX9CVzwT/BoVDHWh0NnYwjx5NSS7a4yXI5nhM/SfOlp+tMgeVkJ2ZMPBkKUEyN
	 K5r6xxH0otPBBDcL702IREHPQBzm+j71uhC6W/oGcVLiJyFEqWxaPkHiPmbyhVPKgT
	 cVm+ruWWCEj8W2IBGbpHxl0j7mvlIEZYd72s96WslaTUSXf3M8orQjRI7bxnikqtem
	 BzcoEtfYCpLLub9/zeu5sCoF7xq8Khcct6WQTWzw0HbOK7N7yxy8uL9bIr16fAEEJr
	 /0bpHIgKN6BTuE6VoWgtND9xcm9BS0oLHtrxIjNBY4/wPiqnIirE4Ny2RCR7Tv+xQg
	 +6Eq/o4RpgQhQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:00 +0200
Subject: [PATCH v7 06/17] rust: configfs: re-export `configfs_attrs` from
 `configfs` module
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-6-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nwKi1FGptwRfXIELQTuMx2CYoPiscRWnpzAnP5fcCw4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr7+i+yQ3swVe5U9MLrSxaZg5jxxn784e/SvU
 q+ylRqmmC+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa+/gAKCRDhuBo+eShj
 d3iuD/9L8zSZvRa4HWcj9rN3REcp2gI7x5Z59IyF5rjRNVv+DbZE3RVAmoQutGL4FVjkxHKRPDa
 oIRP0+w2azN3CS3t+aNNBvsLZ+nSS6q5OCxUo1W523ZrKqBHFAxb1DctxBYTSTKG1IrsIAXDHNA
 w5yHzibzWChVdBrXz8yZ5aN2av36kCkBJ/4H/JVYRaI7Pa/WVtgCEtieGCeCHOo0x2V5iTTFpLu
 +UsYONTfZmnSAJEAZJYfxvfaoF6XYHUGEk8EZWTtv0mYnJAVli+tmz0PetzuCGbX6F8oCCi6qk/
 QqTGUgO/mwaOYIP+egJJssAsgAuxDVsHEWBDJxtutHiuh9zsCeJ5iTLx8+roTd3G906wvMek9hv
 T0Qmu/EOsXIkPBIVXY98KjFfez6ajw8rO8LEmJ6Bluke7m3ZvUpyuCDcQXzyc1nWMa/g/4baE5x
 /mSZIpMwQBevLsv3/zzN6snBmdP5K5T2Q65lEyMomb6meRTvsjohP0ogf4H3trybXBdv5R9P0M4
 GmmilFnDOofcZ+lGBb3Zn7u1zpFZ2ZOfFjWwVRnvMZymw+B0+wGEkkRNCLLjMn//by3RBUa0Cyu
 h6saa7xuDBWCm4UGzhZhxoXymx/vO01V20hkwNsbCRIOlbZ9dNG7t86my99nqxChhCNsH7dSfhx
 MginnAqqtuuSkbg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Re-export `configfs_attrs` from `configfs` module, so that users can import
the macro from the `configfs` module rather than the root of the `kernel`
crate.

Also update users to import from the new path.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/configfs.rs       | 2 ++
 samples/rust/rust_configfs.rs | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2736b798cdc6..318a2f073d1c 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -1039,3 +1039,5 @@ macro_rules! configfs_attrs {
     };
 
 }
+
+pub use crate::configfs_attrs;
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index af04bfa35cb2..ad364fb93e53 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -5,7 +5,7 @@
 use kernel::alloc::flags;
 use kernel::c_str;
 use kernel::configfs;
-use kernel::configfs_attrs;
+use kernel::configfs::configfs_attrs;
 use kernel::new_mutex;
 use kernel::page::PAGE_SIZE;
 use kernel::prelude::*;

-- 
2.47.2


