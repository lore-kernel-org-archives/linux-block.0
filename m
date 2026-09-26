Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002683822B4
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440568; cv=none; b=mJiOnSxWqClw/NHMVIos7uRoFST83KQC2JBRMLfEe60ZpsqRUy5Qn8XV9Cc39mq7IwXtoZlUjYSIGmoboqDLIxwduT7SvBS5jdmn5GI4eDFXaKyJjtCHnyujuwKH4WikOwIIHsdDYWtxJC2ia6pUbK9l5FB9z7TlE+/3HCk4mXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440568; c=relaxed/simple;
	bh=homsJuCQjKnZ0xNxouQDRH+hnm4JjTgYjqEZCArzYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEKT3B7cg6Xi7WkNZcvCT904ecgao/2SVIBvrQEG3GW8bOgWGRyxoBTmDOG3v6PLTEuWR65XOHhGoPdDWjVSmaNsroWOoOYzuPODcz5wJIFmz9ykb69rXWxwUA39SQ8ufboBu2y48z6dZXUXb6HSwd++AvAvIVrrZ/w+WyXX1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDk6RWCO; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDk6RWCO"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so594770f8f.0
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440561; x=1791045361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=iDk6RWCOBJSBW04OJUhZECHaKyxqjcKQSSR4qMu3CLMP2c21hdHwXjduwSW1uvg6GP
         g+45Zch6/ufh7FTJp+rpyWG7PvLnvKXp3aMAH7b+ocseRt9kUA7a/T12PfeMujaG5pDv
         uRJuapewlnnhZ/KyViJ0yg3EXQdlsgVTIX0wTYKqeq1O7vZPUxOMbDiRQguvtn68DJc7
         pHtOSH1qTr1Pbea57l2PCDf+8n9wjoms7z33nBO8Mz+xUT6FrHmHD9xzXonEN0X70830
         8ua9oO0bgTl1oIFKyYU06qEbaPrxqbxxI+7V1HFZwyHWT5hDF0CI4m0WaADgl9uJyQin
         h8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440561; x=1791045361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=nZKG5C6fPYVt4vomAIt7cai9iCEus1Wk8eYnmBZheKhHOWN1upkvjO7xgyTP9fLgOi
         XlhQ8xOf7Fd6IXMyjoqLAh5YMwucHVyAj0AvR9CwP8QSls6gxKGSzi0yz4RnCAv9WWOQ
         6fNipkiF1YxGlJ6ihRSGIorG+IUpnfEAifMmCASqf0jacdCWZjKeAgskDsGxMmAwZT5e
         h3pwrtSR/kypt9IzJZdlv/X0xg0OR0EOWVn/P63Nh4IKOcN66m/zUll7/iA2UjGlL+mk
         xCXmZG1b8/FdqAgqYMycUncYtY6pFlYHJIQcLurSNJGro8btcsjNTUe9UZ5NSh2isZl9
         hTGg==
X-Forwarded-Encrypted: i=1; AKwUvBwiSDwPYdA1q+vYQjDmqZDpi6Guad72UVW0SFjqIUDq6FYeWg6RJTT02kFUx+InyfknR6ICiYolLhDiDQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJSmBqhHn2XDGv488m6t7xjz1frprimj9GFGSAto9cqGsyfBmY1
	gI9Jez8PXpZp4qV9DlbxfhGKTgyeBuIwH1hcVgK7KLp8cimz1/9lcq3E
X-Gm-Gg: AYBFou3cjP/2SAZnr1RHff0XNz7GN3EAI+5/wPZBpY3WI7MsuZq3wIovXGaO6xvR/aH
	NaSVrSzNi1+ELdOjocfi+8jjt7d7+DGihl7UNX+EmHCMWILWtyUp7KjuR7SP8Z+8AxX4Y56zDjM
	Gnh5DbUoz6PRRO3KBKgkBwLfQKQRX5D5w7R4ZSLIszM7MA+tttHtf7z3JPx3Byu2FtOsFATj9Mz
	Cx7rSZ6L4rqsAal+2dy3Le8f7s2Y/6/5jjxihkK1T9av/BEdnCqE5HqSna0B1IXfEPVpyFo7KPd
	FN4Oskr2P2z5Ezaiyy/2nHGLYiM7zq6GqPuVuvbGAfqN7vQN9bhrLfh2TiCprqi49DGxKiivnjI
	+z8uOg/E7xo7WSOCWV6jzfpsNrgNmSLkjPZpUPlj9FlUu8M8mSXPs7Tyl5ISAu8Z9RjX9szHFUy
	rC5rvIozcXlDYv2k56uTBkkfc8J0SFL8v33evA/cBzYriL102FR6O7IhiHwbvH4/kfi9cmR62Po
	qv1qv4824mwdZeimZw6lwPRT0+tmcDdmjC3Z6BVHOAOhwlT1vT7o3FVZIV5jfUvnIw=
X-Received: by 2002:a05:6000:2383:b0:488:81d4:8bfc with SMTP id ffacd0b85a97d-48881d48c0bmr9652514f8f.11.1790440561402;
        Sat, 26 Sep 2026 09:36:01 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:36:01 -0700 (PDT)
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
Subject: [PATCH v2 4/5] rust: serdev: use DropGuard
Date: Sat, 26 Sep 2026 19:35:50 +0300
Message-ID: <20260926163551.52371-5-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the ScopeGuard usage in the serial device bus implementation
with DropGuard.

Use DropGuard::dismiss() when ownership of the private data needs to be
transferred without running the cleanup callback.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/serdev.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..dd43b159b461 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -13,6 +13,7 @@
         to_result,
         VTABLE_DEFAULT_ERROR, //
     },
+    mem::DropGuard,
     new_mutex,
     of,
     prelude::*,
@@ -21,10 +22,7 @@
         Mutex, //
     },
     time::Jiffies,
-    types::{
-        Opaque,
-        ScopeGuard, //
-    }, //
+    types::Opaque, //
 };
 
 use core::{
@@ -174,7 +172,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             }))?;
             // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-            let private_data = ScopeGuard::new_with_data(private_data, |_| {
+            let private_data = DropGuard::new(private_data, |_| {
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
                 drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
             });
@@ -204,7 +202,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             drop(active);
 
             result.map(|()| {
-                private_data.dismiss();
+                DropGuard::dismiss(private_data);
                 0
             })
         })
-- 
2.43.0

