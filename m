Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F8381B0A
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444010; cv=none; b=eG1aqz7YGtgQEyfab9FHRV/cwVCneZVYhqXQHHdFN2J9uFIagCnB2OEwarxSx20HvGQveCWVfF2x4jhTUeByFScobFuEqGZQIza/wyFI74LQakkiMHu07B4jVSiJcSJF2NoNU+TD5wdLBTy5op1Vf6KeAtLdnBOZA0De8Si/DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444010; c=relaxed/simple;
	bh=kF13SbON5k5Arvp0ikMg5xGDnjZmmTCAm+geeOVzYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI9/nyMeJ8p54d6MMTqNgKxAQsn67hcUqhF6B7O1VBM2yyrrIloy1Y8YMHYcCw3MpbLf/YwYr5wWsWFMk8FVGkHSket2ChtDQHLSTT2LDJIzqfC3lhOY9bFbd7Y4R8/sB2slZmV698DakeIW612U9fIYrAOUv+widzE15YIrjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io5hzDwL; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io5hzDwL"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so3951455e9.0
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444003; x=1791048803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=Io5hzDwLZnNhse/D3h+ME/+td4XWA65rfniDJD+4WPNsQKhynYvNhga9dvh7JRtLOI
         nQuKuKKHSh9LRl1kHl00BtugSq7BpGM3FoYo3r0uXGMkoeQT+tAo73H7JX7M1uQuwtHQ
         r+3DJHkaliXquVdamFUIMd4ulRMboXGgIfXsOQy99M2ZugNPFaF3AIPAwx8Uv0NePYiW
         WanRUq15FDo0ETwrweB54kpDY/RRidmgXYiA6s4fEdix/lDAUyZ5ysqzUsfHmbeB+Sz8
         ryVwcVgKayghLGnf1H6ir36FoSZoQF1+CQvLpt5vSkpx9GKrPw3YmjGKrFVDDDbg88xd
         O64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444003; x=1791048803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=C9xI3ACOK032wIZ4a6jVGkRUUtNTt4jmjh0TOe4fcRcCvTGZe6ZOt4vBovLnL8fVzp
         fod/IZqMEXg3CHHD9swkW5/5gpgPFLCvbQooXbseD9E8DWEP1HO095wcEFX42O6AJGg0
         FgJCRxhu/Ro+3RMMoNkUKTBzeHyDAe30s2lRhrApEv1D85YZjk8daOB55acfecaRiZm6
         wsWcx1GrhTJ7M8ugc/rTwS7onsns1zivXfBQrBzsAmPlI2X+LcAyp+te7LoI9v+oJX7p
         NeZQPBdZICnbbdrgPOCKDUmBd3kR9Ar229bjcxQo7eH+W/e2ySTDHwMst55GLKIH5T1+
         3R1g==
X-Forwarded-Encrypted: i=1; AKwUvBx5QwkTFAvYkkedmJKDK++CJfDT96sOK/6JMsLbOn/vyHyjgSLpgOOpU8Z+DQ5JVe4a5aM2jBCNed8Ruw==@vger.kernel.org
X-Gm-Message-State: AFuF++lFKfwN25HBHGUAhyX0vU0539jr38eGn1k5T4PQaLWTFYcEYs43
	U9YepGq4mqMTueIX+R9axGAyry0DNBvWqu04DQI0P6Lx2cCcejTsQNgy
X-Gm-Gg: AYBFou2I42X4PJCwxy5dbZMU1UwoC4AQ2ebvdXb2dy8TfPabMLa2Sk35oz2/SHN68WY
	L6A9uViQYqUtEp/T4HYAbmqoJ+7X1DJplps0OtEkByW1yTEhH7jmV0n/YZ3lC7o1l3p0OmfSPHX
	Mteb9aeB1ZJsrVAbZ/UX6ubzhs2SY5Awgj0Z24DOsfOhSueXFsZ42dwACSfdjygd3gtq/SAouAP
	WJQ+PWPL5Ceg4asXVYspme3Rv1fKcE1UAi/NiqnHwGi2wZVWo0QbD3f5UcH7GNH9X7vuESutejd
	gQCrW95Ltkgx1wvyiUxdaMFV4B0DRYi1IBT9yNp6DXGqsmVSPVhbo8b3SjkRFhoyTMbPmmtz6rY
	/G8qBSucgifJq/EC1tIeLUaRflk3iT06J6iOQj0KmsJYjTBByNXp/TUcXriYLOlywZ7jnv96zui
	Pt0Qark4b+2MTzN8WgAZSpNwFUKnrg0HSzl//ZZdmUwMNSdo40uqFw7gziMPxZEcNODY6cW7Pun
	H+1pKPgq/NRCtlCeK+2B/GgJPNJbKtamyMhPm0YWXKQaJiX2Bx77S9mOf+ypOtA4PQ=
X-Received: by 2002:a05:600d:8482:20b0:49f:c451:b4ab with SMTP id 5b1f17b1804b1-49fe67bc264mr118603405e9.29.1790444003312;
        Sat, 26 Sep 2026 10:33:23 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:23 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] rust: block: gen_disk: use DropGuard
Date: Sat, 26 Sep 2026 20:33:13 +0300
Message-ID: <20260926173315.56772-4-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the ScopeGuard instances in the Rust block layer generic disk
implementation with DropGuard.

DropGuard provides the same scope-exit cleanup behavior while using the
new Rust kernel memory API.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/block/mq/gen_disk.rs | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..d9019fbbb361 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -10,11 +10,12 @@
     block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
+    mem::DropGuard,
     prelude::*,
     static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
-    types::{ForeignOwnable, ScopeGuard},
+    types::ForeignOwnable,
 };
 
 /// A builder for [`GenDisk`].
@@ -102,7 +103,7 @@ pub fn build<T: Operations>(
         queue_data: T::QueueData,
     ) -> Result<GenDisk<T>> {
         let data = queue_data.into_foreign();
-        let recover_data = ScopeGuard::new(|| {
+        let recover_data = DropGuard::new((), |_| {
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
@@ -150,7 +151,7 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+        let cleanup_failure = DropGuard::new((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
             // has not been added to the VFS on this cleanup path.
             unsafe { bindings::put_disk(gendisk) };
@@ -161,7 +162,7 @@ pub fn build<T: Operations>(
 
         // The failure guard now owns both pieces of cleanup; the early guard
         // must not run on this path anymore.
-        recover_data.dismiss();
+        DropGuard::dismiss(recover_data);
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
@@ -185,7 +186,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        cleanup_failure.dismiss();
+        DropGuard::dismiss(cleanup_failure);
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
-- 
2.43.0

