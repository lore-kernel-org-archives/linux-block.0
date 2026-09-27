Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A823CB2EA
	for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505938; cv=none; b=tXVbnwgFFD7vzkQcGeW0FCdB94UGJa4uQITmtTzfkansO6gaM0FE6N5MRGREmAZ4IfonhG8RzkgzxaWuYfLpLTpvLjZIO2KrY3/zOzhjg2vqecKWHSx1OrOwGe+xrWiQWs6tSZaNmZnEg0Cw4i32MockHu4vt3qQ20X9RLGtBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505938; c=relaxed/simple;
	bh=kF13SbON5k5Arvp0ikMg5xGDnjZmmTCAm+geeOVzYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPXToGJGp+esm4bWL34zF29hJ57jln1PX8m85ZOADc9sUtaiNV9nhgRvVQkiNRz7KjuaZwDgBHj2KUB+hkE4NWxt6ApvS6zuO9zBjiAetTnCDNjau+AdZYDFHfbthdInnZ6aRwsgV0eko0fvHGY1YInWhV4GsTkgBoCR1U8MqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRwjAR+R; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRwjAR+R"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48882c1f261so659027f8f.0
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505935; x=1791110735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=HRwjAR+RDJvhjDlWNHdaHGoE7tGYVCQTdZNIxIvxOd2MMM7dzhzB+d2gF3PiGCFADF
         f4sAjxcRDbIyIfYJCFakMQNlEUwTMsrKGqj0A2gt7uQWOIf6zSaNhWwSEz1xY2WduwPy
         CY/2/OD5qdHTlx1clccx39+kV7o8rKMrq/oBbsINlJLHTgROOeRUcZemUzVcFMD5q2oQ
         j7Q+EpNzc+aoqrbUu+7tLQeyQ4Lp4puJNQb45Q4Xw8LVI5O1JWUJANUNAWxSGKKW/J0z
         lWk1qE5dI0zM5HAj8g7BPX4bPMrhXCTGAC+dvQAe4J9+VtSSsyvTMPzTnVeltdCZ3u0i
         EX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505935; x=1791110735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JwW6U3iTEHgPApFOC8Hbz3JJt/r5iD7r/z62SOkAVw=;
        b=wpeDLSEfPNqzNVNMqKzUq4znQPIk9A21bNN4L8Ve++MSidwRVvUvnAG9+sg5WnHmUU
         22BHoT1uU1o6J/AChL7hWY8eT/wbN/TROepv1lpMc4ysnZqyrwmpz1+oaGx+jgaICW4p
         BjMIvtE+nk5awPjvTL+CHhEBRlMzHofYt3uJ5UsTVQTcgSMh6LZHm6/OCAlvHkCA6hla
         mVXWhL8tcsg4pH6VTlNSZfTrwiDxy6toZBaTTiSDuRRNv/wDezTGfaCtTV4u3ojhdFdo
         /UFFDjB8fwCinNxjr6vClae1NvQI0dmux6mDq+bWtyyDdD7jRqeZaGEuoMtu/3Z6f++f
         TkYw==
X-Forwarded-Encrypted: i=1; AKwUvBz9nU5YLU1fiPrWJr9jWyG+CWqruavSutHSAr+ku40RJnzdcUmFMEbOpafugM7wc0QPJ8YNaFlqzn3EWg==@vger.kernel.org
X-Gm-Message-State: AFuF++lF+2pwCOhgnSJkvw/4bwzfxckKDGmhsxkfaoRHu23XbBaumeh4
	xKMPRwDkdr+/XN4VoMjzyn7qjIYfx24OmWpX15/1Yd4rkR+zI1u0oCwl
X-Gm-Gg: AYBFou2QYDV41Hke3hmv8dTENonDqIczuKOwyeAbBhErZCGmbYRr6Yj90YAZsh2VDr4
	+UKjPac591lwq6FWcaRQyvsBfGS31eQ/+LuqBQjmLD1KR0RfLISK61/0y6pSwUEVbjV74j8YAEr
	V8N8hHdPrkL77R5cOQOaatumuEiQ0/nbOC70nHRVRXLWI+Ioaaso6LLX/wsx5w1NQHGbDH641zw
	MLAdzWBPixi8pdF7/xiBJdEh7hld2PnopwYKiImTEYO1C07xYfB8NFKHJmq5WIQTds4R75NJ7Uh
	MsHdiH1HYG0K6wD91RYkN/ADbinouEWaUVf/e/pq3vpZkbyZ5wrVqyx8zpsras9e/SaPGK8nEPP
	R8vHQ79QfvY1Ds0hRxQWntiMoQzdh/jcMMTSxAifREz5UH9wy6BR8kqUKreIFKVixDDIPqm1CH9
	UkxErjLn63brxyOidBB/H52OJxrNiPs6HR1mbZJ1ewpS3VeH87pDMvgF4zwGUd4v6adSMD5OX21
	tN2Y9pjMIu+fTjuhkuJW1vRPBnnwEZArWDRX6v4g9evwzu1CUiNudLcv+rObpH57iI=
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr182387845e9.3.1790505934598;
        Sun, 27 Sep 2026 03:45:34 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:34 -0700 (PDT)
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
Subject: [PATCH 2/4] rust: block: gen_disk: use DropGuard
Date: Sun, 27 Sep 2026 13:45:26 +0300
Message-ID: <20260927104528.103881-3-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
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

