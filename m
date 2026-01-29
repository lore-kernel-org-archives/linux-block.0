Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF8346A0F
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656060; cv=none; b=eSVzMfpnjOAQ0PknLFeu+q3YKtFKjre3cX3jY2fo5BoisTXXb6pEaV4pCzYo1Sr9RqhAqPmDFOH4b0KIu7E3aELUrTW/tK0xG4kT1uScjoGYOkJH5MShHO7kcZ1F4rA6f7tQHMlQ73YkNCoHs5jclbzVkh4D9rRt/P0loWTFdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656060; c=relaxed/simple;
	bh=D5HvBwq9KBBQtckyDJ0vATtGRTcFt8eQ11FoGa6LSMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9dUvdm5Ju1oBLTQwfxnlM5qbv9TOu7BZ8EA6t8WnZfeA//w+7Yj1QCevtaXR0QczeVQk2KiWt4zLqF2klyCoI351ui7QwDENrTasdW9ul4ZZBu03vAbmx19e3z9Jh4At68guGeQOxxpZ2MOAmLmSrPSBPpoDs8C8zLF3IgjIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSRk3aFf; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSRk3aFf"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1097053eec.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 19:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769656056; x=1770260856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idXYF6OFRh6A7qWjhos4p7dP5Z9noDDpuntJy2Lqy8M=;
        b=RSRk3aFfAz2AuqzfDRtuYjC3W5nKLI8HfvVaBvYtTKQeJh7DZjKHGKCMrcUDWBGhiO
         WmODnN+eai5a8E0eRlKasM8Er1FGFFONBPK5o4PDEURUs86jxYoEQUZJxcvw9TbZdshQ
         hjFukFeISdM83t/h3Au4JafG74xOO/ND/Qp1MaJAy0LPkKfodTNBpz815jfWIH6yq9Hk
         fxuCYT4Kqsm7o8Uut+4+HfXCxNVSc8Rz8dUmRoVVFCc7248IEM7SrNHGhQtC93y3LWPn
         lPJXUGdtoYzX3k7CiaX+fBKjVjmAVasmmONaUmn9RbKp863llQ/dwfBRVo+7gB/gI78b
         lHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769656056; x=1770260856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idXYF6OFRh6A7qWjhos4p7dP5Z9noDDpuntJy2Lqy8M=;
        b=faIIrksndw0tmnRYwvWKglFPvKc/qwHbyPvj39/X3lZvgnTEEiuuIDGng7H6szYle3
         jBS0OONC60abWnr5GEVow5p60dcj9Xnf6IQaBk2x31bVdFESZCRbx17R5aCoQYguDOar
         zLo4eA1z+ddIFWyA5h5APERWFFfNViF22rPCeMQ0IICBqWHqXk27MRo8WlnsLJY7KymS
         Go9kET6JmVW6F7g97KALufUh4rxH23twdxZCU9Kaedxmjce/3TpwNOctVlxdIxHhVOfq
         VOQY7QURAhBz1pPZcjjsUlE4+cCybu7mDxel/3tGtzxNqLr2haxCN77HvqYg2u8+WvJ0
         sEBw==
X-Forwarded-Encrypted: i=1; AJvYcCXixuCsH1tEdNPpfbeLKaA+rsJwkFZBknLhgWRkYv09vdvI6LuLmhheDU4f5QM0Gg/QT5Vv39OXEkrWuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+02QdVwcge9lAU5Q2ba1dTsZReo2yBDx47bSq4HfxkOAM+gS
	Hd5HZAulb7Rp5VrzNh64UBhplAozhlbSkk7TYFP8JWzeRsBtbj2hLDyz
X-Gm-Gg: AZuq6aIJ/AX6RlCLYdtGDuCLw7HiaSUwItq9NCzZfxsLLLcLerMQ+fWWzwwat9+Rhr+
	XKniOgNy6oh07XdGPCwAqvTJ1XEM+d+qN6pElpVuc5CRBb8IPr9rfCF4xuNk+U7LEWXW1XxHeXK
	iLeIpJXxpJxYMKTmBzsAZ+xPWYueMc2Cegt6cDz5FB0fWSOgQVmw5zrnDJv4W3BR79kkBfuPV2c
	GQaN5MQCBtuazwDP/NmtGG6rXICvarcmBOpkD/kPCrZDDCaior+Zvcpncsg9T95xZMC+sVzpuGB
	5g2gt+D+OSoPhjhrBTteWgGLNIrn1c+1WdRonXP814aUUkT2+a0h7+w7feqJKRqEjMlGknj05Mt
	MiMgPMyypWSQg94sQxwTL/jOo5Z366bG+bq5zWKmcQLWhgoYtYX8jBFVpSlplJ//UXxa7iC7080
	CF01kLjdOZun/0Qzr8ra4xo5d3P36raIkkK9p3SAzDqDPbhrH530TYO7L3IFk466GIadtXB0qW
X-Received: by 2002:a05:7022:68b:b0:11e:528:4185 with SMTP id a92af1059eb24-124a0119a2cmr4602564c88.38.1769656056476;
        Wed, 28 Jan 2026 19:07:36 -0800 (PST)
Received: from jason-hall-A520-B.. ([2600:8800:41a0:8000:4e1:6e5f:e09f:d45a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f597sm4855682c88.5.2026.01.28.19.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 19:07:35 -0800 (PST)
From: Jason Hall <jason.kei.hall@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: lossin@kernel.org,
	boqun.feng@gmail.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jason Hall <jason.kei.hall@gmail.com>
Subject: [PATCH v2] rust: block: use pin_init::zeroed
Date: Wed, 28 Jan 2026 20:07:32 -0700
Message-ID: <20260129030732.1072223-1-jason.kei.hall@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual unsafe zeroing of block structures with the safe
pin_init::zeroed() helper.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1189
Signed-off-by: Jason Hall <jason.kei.hall@gmail.com>
---
 rust/kernel/block/mq/gen_disk.rs | 4 +---
 rust/kernel/block/mq/tag_set.rs  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 1ce815c8cdab..649c3d9b1ff9 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -106,9 +106,7 @@ pub fn build<T: Operations>(
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
-
-        // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
-        let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
+        let mut lim: bindings::queue_limits = pin_init::zeroed();
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index c3cf56d52bee..dae9df408a86 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -38,9 +38,7 @@ pub fn new(
         num_tags: u32,
         num_maps: u32,
     ) -> impl PinInit<Self, error::Error> {
-        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
-        // all are allowed to be 0.
-        let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
+        let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
         let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
             .map(|cmd_size| {
-- 
2.43.0

