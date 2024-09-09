Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243E136350;
	Mon,  9 Sep 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898780; cv=none; b=aMlN5R96xZS/bV5sHtALWLYCuc1+Zd1N/7KMtq9unsmI+oc9hvn1C3WTZaLdLHfXmO3PnRx1OUpWj7qaRuUAqmos4vpPZyUDz0vubQjaxHeJM1AOhFmkjOLiOQ7OQgUuJPF+VGq8D0FzWUwH8vhd7hJToOMOQYhDeAn0OQ5mUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898780; c=relaxed/simple;
	bh=3E1vNeXifDfEflO3LDILWI9jG8ShVMgUD3hbllTgKZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbKqbxWsiuqNyZjWXBOdYnuP5uB1iZmwZf+TwLo9BBPDvCWtRdlDGm+kLOHnq6f9Asdm1QZ648HQWCTyrKtTHjhl+nm0f73Qe9Xb6+yQ+40pVg49SsZyYo/UxFpsg2Zem2V1SYQUjvHq4pUces/8vQC+ZmWot5Nh7QyVNhKDBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc5gxHaO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc5gxHaO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718d962ad64so3022149b3a.0;
        Mon, 09 Sep 2024 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725898778; x=1726503578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+5mOJ9KTyis/m6s9MBCxxTTuhaf/SWjwjVEMzQ1iXI=;
        b=Tc5gxHaO89JOk6Fi8OKSmx3dzlSFkjZD0Q3KQuXFBkxfLxikjebAxrGTa/ZyVuQtVo
         JlC93Ukxgst8tIFYky+xGrP54JbPL7h2r1tRTWzInFD1FHkZYDaD4titkwaoXD5/2bSp
         twMpszx3BTA5/2Ri3fPe68MP4HYrXZMVqtCJ2krPQKL15hZfZKlyUeEo//+s1VH/fsfH
         s6grgzs7PGMkgzp0tbhi9s9uD4DMLIjvvbBcPGDDKVCfGRHRuwq1M/hUBJTtL8D5zCOf
         iU5rxmKaGGFxsj3aOP4dNUMRu1IQuozXnovhGsH8jNVTW+sLqJzNZVs7ZcoU6eTBi4Pa
         svhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898778; x=1726503578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+5mOJ9KTyis/m6s9MBCxxTTuhaf/SWjwjVEMzQ1iXI=;
        b=pRBZ1G7qOprgLAPzwlgb/RG+23sGyjof26mv7uWyB8J6PH4kM5odkHrnk0VMMHpbvO
         Hhh+GCMXcTWHTDBB1zRcb8Ct3LMRTLW1YCMD6Yin2n9L0pCDqzrYt0iPlnAdew6ejVfP
         63lY46A9kSuVdeknN9uoBz56i2ObhyAu+7CPxTOc9Uw1zn9y38JNfYX9MPzoNTzEnkdT
         aKcI3FFc8cLiejc0Bft+Vi4malAADaon1SV9NeMi++qnmhJJiwj1iUgZ5/msEhd+rGOE
         AJUZFX2vboDwADqAIHp0fBBuJ7l/+dNlk2dGg2N00SAY2zXJ30ZnWEYpby7znte5Fip5
         xbww==
X-Forwarded-Encrypted: i=1; AJvYcCW5w8E+zbnU5mYductpr5XYt3D9FdWfzLroDhkR9d282ejSMu9OC77jSoYFJpWRu67YHY9OGEO1OHntlgCBEZI=@vger.kernel.org, AJvYcCXDIJdBPhZg20ltSFcaXoDJe/0gk+4wBXRba29QZDz4v3pJsukfJWr96VCIgg+hXS6RpufjG4HmHuf6efc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+EODFeAOC/9gEBq+DUa0ijaq8jAIVA2sx9Ay+LPkGL8pIzAw
	QFBbE9EmFf7fNNCyZ2isTlnO5TkhH4q1D0ebupX8Zr5Ois79SsKHZMCBadnR6wg=
X-Google-Smtp-Source: AGHT+IFnATl+DLChu7XoNEYzhQgVwvA9vDeK2N1S83tV90po1K5wwLyJ2BR3tgiVRpY8Pz6tsaum9Q==
X-Received: by 2002:a05:6a00:139d:b0:706:6af8:e08a with SMTP id d2e1a72fcca58-718d5ded05emr18528217b3a.2.1725898778369;
        Mon, 09 Sep 2024 09:19:38 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e59687f8sm3700551b3a.105.2024.09.09.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:19:37 -0700 (PDT)
From: hridesh <hridesh699@gmail.com>
To: linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?=27Bj=C3=B6rn=20Roy=20Baron=27?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>,
	hridesh <hridesh699@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] docs: rust: clean up empty `\\\` lines and improve rustdoc formatting
Date: Mon,  9 Sep 2024 21:47:49 +0530
Message-ID: <20240909161749.147076-1-hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary empty `\\\` lines in the rust docs. Also add linebreaks
in kernel::block::mq::Request to fix formatting

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1109
Signed-off-by: hridesh <hridesh699@gmail.com>
---
 rust/kernel/block/mq/request.rs | 7 +++----
 rust/kernel/rbtree.rs           | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..3ab2917c9d25 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -22,15 +22,14 @@
 ///
 /// There are four states for a request that the Rust bindings care about:
 ///
-/// A) Request is owned by block layer (refcount 0)
+/// A) Request is owned by block layer (refcount 0)\
 /// B) Request is owned by driver but with zero `ARef`s in existence
-///    (refcount 1)
+///    (refcount 1)\
 /// C) Request is owned by driver with exactly one `ARef` in existence
-///    (refcount 2)
+///    (refcount 2)\
 /// D) Request is owned by driver with more than one `ARef` in existence
 ///    (refcount > 2)
 ///
-///
 /// We need to track A and B to ensure we fail tag to request conversions for
 /// requests that are not owned by the driver.
 ///
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 25eb36fd1cdc..006f6e03aba5 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -1031,7 +1031,6 @@ fn next(&mut self) -> Option<Self::Item> {
 
 /// A memory reservation for a red-black tree node.
 ///
-///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
 /// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
 pub struct RBTreeNodeReservation<K, V> {
-- 
2.46.0

