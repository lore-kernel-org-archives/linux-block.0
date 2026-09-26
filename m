Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A83876CD
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444011; cv=none; b=P5jS8KuhrkLayggaw7YWkrOWdHIub0z1TEwJXt6Lh7IkMZnoUAptwF+XwX1dJedw5e2uBHO9UqyGpdtr7ia4gkF02CMWn4PjDndh+nalZwshmxg+doXYEGPKkX2hrgfvP98A7+BfBtzKW6DsDcGS69q3hylbCnZrRuD9KfFM/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444011; c=relaxed/simple;
	bh=homsJuCQjKnZ0xNxouQDRH+hnm4JjTgYjqEZCArzYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioe6f75+nenuYRZs6JxEnZ4jeZAYE8W+jCASoeKHuOTAu3pIwGWdjagtLdPCNalUUN6rwnm2xyVm1iPvrHEW4JFcF44dRe3QrOXjx2vWFZMM2/iudAYGuCHBxKhwvdW3nZcnrQSH1SlkWI+v/qmJAgMDKA2vSqHhw4WfcaOLQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH8kiDZs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH8kiDZs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso3179075e9.2
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444005; x=1791048805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=DH8kiDZsinWXHkuLDmdFp6BNs2gcCQ3SwEmHQz366D6QpjmhArX04KpKOGHWY5gug8
         IQW6LSGK+TcWwZxyQ6lhpWhWq8JKLyXxr7SMvBe9ZnxUoFiHSIS3hM8b69QZ+t3LlwKJ
         37Gz1wYm4t2sKqde82rBY3ayLJ9cP6OGzHyHa38Le5xsfJpNmQgYrsOMZGeINICs88+3
         FCv7ZQEbRBIc+6c7s/xsQttA2mazzVU/QKZkgFvA7l/ZJ5RsHI/ALG8mhA/CZeE//v4i
         nOJT9AX+pIjLpcAohRbp5mmX4YCx1SJIoSIYmE+068fUUhGsMF0pQLt5sG7P4Tns7faF
         c7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444005; x=1791048805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=xjm2rvnF7VKr8MPtfaAzwfI6su3fdmKb41K9/m0G60vWnBgJ9PQA32kTlsv+RtyGTP
         I0t5s9FMBwWTx0UIs4YfvFjy2FNUYiXxOH7M1Rkwh4EVofx67gEWXOmZ/ic0tVXzDjw8
         Gq1B9650C5RW4MNRFbdiLUBIon0c5r0jf16QZG3SdXHdlkzLumD5/Xhk0Ph8EMqXTU7z
         Gdomk9yf9C+ULTsu94bFuF3bR/lzndW6JAf1WLJ7U3ZXKXgMtRr/xxQXhmbA3hM63JaJ
         ebSSvshT9UYdPocBVSeUoZ0RAEtmpX+oLNN/yQ/cCEMN6kqR6c5BZ0fdhFoHeeUJVpKR
         srtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIXOIme1uIXItmfwGIRoOeLuuWC2CwDfquU2jsj6vBLb6pTszFjOlgJyMQRHcfLKV7lABjwOxzxRBLhA==@vger.kernel.org
X-Gm-Message-State: AFuF++mHfZig0SDB6DTJU7y/BTnjNY3ap+KxkXcqhrGPhUvzFsPtgFsN
	D8IaUG0OynEpFmUhwz60QDY8+L3xVO+esrXJyhqn0ycOjSK9vC/cPSEG
X-Gm-Gg: AYBFou2I6v7ZDtLLfb9safiysYeDMGgUIE3ceITc6SZGUaVsQmu4q/iI9y6Mn+kxGo7
	gvsOpeARMqJdOjgLBc6dOBSso65Zv1vDqp1yweOBIQqdA4mQi8KkITHJwc2jQMx4Ts390FU5n46
	NOU4wCfoE/y37PooI3P6Q9UE8+K4OIVa2LAHx6aSPCgYG6HcKINOLTUKtQBhvSoZUQdoL2u1b2l
	hrGLh9acwjxeAAqTVGMQ5GDqYPzNAm7ZsmNzCtLkOfR+UHQXUM8ALiohjnQJfY8gHae4+ITy2AT
	HPmMvH6sk+OPpaXrWbkR2yvH/lmjViqWANPbwxcUxbgqs4czyFqhPZntiFnQWiF3Te0EZHDOMyT
	feboprf8Hq9/LL62l6hjhgfJIalG8sYYuhwVxGCNsNOKh0vvbIR652AtaAixLUHfZOwELzaVp42
	hTcsCvwqPoAoEtq89pWk+rJDJAqxcR9itDWzKSJ/sxACuZn3OJqrEsotWmdLs1gG+KFGg9njII9
	fmYik4xnPavY/thy8huUp5vjB/9OEsBefSYkJg2wGXRC+xNRAjGSpQby7SiQWWh9Qw=
X-Received: by 2002:a05:600d:6409:20b0:49f:f099:6f8c with SMTP id 5b1f17b1804b1-49ff0996fd6mr68193415e9.9.1790444004921;
        Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
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
Subject: [PATCH v3 4/5] rust: serdev: use DropGuard
Date: Sat, 26 Sep 2026 20:33:14 +0300
Message-ID: <20260926173315.56772-5-mohamed.osama189110@gmail.com>
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

