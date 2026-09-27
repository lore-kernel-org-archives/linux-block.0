Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE83D332A
	for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505940; cv=none; b=imE1jrDeLKOhJJ4MyECOMmHNOQ1wPyFgcUKkzLIotWFhgfBDidnof/DE8hYnRbKWEXo6Q1qOytq2vos74DPN4UCEa3af/K/lfutnWNL+UAANp31hXRAmlQe3mRodLBlMuuR0wbdM9VtNzyyERRm/lrfruCtgO/HYjuRm9XnPG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505940; c=relaxed/simple;
	bh=homsJuCQjKnZ0xNxouQDRH+hnm4JjTgYjqEZCArzYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3sWjgpVdvZHFMSAPwKoHHYA7Ut8rKd/WskVPP6prG53l103PoZvFr7eW7cPJUcFspnPoCfFYUoRQOErU9ZAMXcTaaQVncuvhAFOJjcHaJINYhEoVWpkVvLysN+dKPdq5QvBNoRcaytsILhc6FL9N7UGo4v+FUrlDNLoNKSr+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQEdWXFm; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQEdWXFm"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so1396393f8f.1
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505936; x=1791110736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=EQEdWXFmy9ti9tUZ6xGQ5Xrd78VOiGMy/Ymq4O0XQB89MelfjgsM4Y1dW3yIJhy40X
         6HyKTERfAiF+/6wO4rs8cvgKpKDu8qcAq5d8PGZNoQDK9cM5N3hUDKxqE7HRCKAmhDjW
         QoVshXC/2OQLun4RiEsUmCUL6X39zojyjPSAYH2ACHHg1PBajhWgok4NarzuMmkzUICO
         +ktaX8BeXYvkiOnBDs4lUtqb0GHze+Hz7h13I3uvHiXFStBoEfYKmAapWKOcfUREX+Hl
         aGv6omBzA1D1uINsJ3YqSzAeFqECCOdyo/m/a1+75BVtzByqPpYj0lpqXOaZIfYpSUbJ
         +bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505936; x=1791110736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSUQA8gq1RkCRhOMqlGaEY8nMSV691WlNynGk1mNlWM=;
        b=OkywzlgOL/VRWCej8ay7aBOInGYZ0Y9WM94pUoRWZKanPxVLPZL5hwo/wgF7cxSCga
         2xfHA8Q5H6PceKCwUmeNJ1I9H2FoRkfNMNNLc0DIIP0/31SQEuQ4WruI1v6797iOkAAQ
         qgbdCykiwvDoVyR/aZm4W6cFC/CBIPCWUba5/2IQG3YWf4J3shoaevcrzV+o9XxUR49O
         v3IxVK2wS65pLbSNXOqdv6JTSmtZeT6Zxce6f6xl+KpkWZqt7oDdmfIOPFi11xM/pEei
         GqnuwaPgZ1EzYKinU/hJO0u27GJUJ7GmIno+fRAnk7UwySyE6Z2Z8oIu+wvBrjz9yaZV
         pYgA==
X-Forwarded-Encrypted: i=1; AKwUvBxTpTwqt8YmnfowllYp+I/2xj3vfhm5KIBemLhKB8S/QTYNPzlnjZTSs8tfNGHyQnnhKLB+EQazVr20nA==@vger.kernel.org
X-Gm-Message-State: AFuF++khB0ELxTQ1QnmVrzwHrlshFDXjane5GwAxzwOLQfNerSFTc7dQ
	rrwAeRB+byX+QbgQv9oCpj90LOdg4D8GAVNen6F0nt3GvKCt1NfePrGA
X-Gm-Gg: AYBFou0b98WBqoit78b2J67vuEwSUZj4eOl9JujajTWAQlrB+MQdnb6sCS/jI0fOcWX
	mpvSy7L9mZL2yq6AmnGzj91GmIZt8WkhKZXp0L4MnLxv993bjgjjnSll3S6g05RIvPUdfIrm/fe
	hYXqUwn6Ues3bhqt7dN0iKC+kuQDy8HTLzPIyDMWfMbosUztNJzVCAVWmUVWrB8MgaITKne6S65
	6U+bM73Bi6vDASTC8clQj7S+BmyAIuukN6qk+B3VMtoAyosw57fLhFpI0y98hOf4fJ9MxLfECxi
	wpdF/kpzO1YS/3HdnBFMYcam+W44lIIZmCrTAQkb5havQgPy3iMuAFsDM8wvhAfB5wINgat/VS5
	+8UfMQCnZQOPhn2m+I8Q8fJ/LsLUeh7JV/DXbJaJQsImY1QfEmB110z/ao8Vw7J7Kn3Pou8bs6w
	6e+wl7V/wWeqcY4oXAUEHmG0AvzD83Cv1HKxIfhCPcUR+JJbDQWwyjXs9r4abRSIeBJYA7vOlOD
	wuxdh+pKl006FgGu3dOCa5HBkkvYCv9GgOibtpyis+WSjMbko1RZSdpIrIffR93gxo=
X-Received: by 2002:a05:600c:3b98:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fe66f187cmr202438815e9.21.1790505936299;
        Sun, 27 Sep 2026 03:45:36 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:35 -0700 (PDT)
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
Subject: [PATCH 3/4] rust: serdev: use DropGuard
Date: Sun, 27 Sep 2026 13:45:27 +0300
Message-ID: <20260927104528.103881-4-mohamed.osama189110@gmail.com>
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

