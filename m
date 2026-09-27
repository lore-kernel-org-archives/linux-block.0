Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035A394783
	for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505936; cv=none; b=B9yDd71rKEf8vVRhrvrYj5skAhzrIyGb3dS7OD8T7t+/4Hy4hz2bIoGyGOWvfMA3jz7dcbUEMxS6TbCDemfobVKvT8usbovhMYbSN7PRkWDgZsH1e1ZI0A8izSHOk4zFj8IDp5x4c0fkGBaAjv6qlMjQgJUIPn0BKFJsbigfMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505936; c=relaxed/simple;
	bh=E51DzdcULzRpdMmr1jtr31t0PUWLCjXdu2/DDghqgsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWZLVyxNNYn4RwInYTXGrI+iTMapB0rL7aNKOsPJDjigMj2dR6+xSX0q/k25j8L2qen59Kah/sN11g7Tv3ogkOkQao6s5rMfTNKbdqkH1KP3+2KT2jAo5b3JeKHXiTRXeDe4zKyF5pyzOz4E0ixCWjUbkiVXqa8kSSXrUGcgjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF732jaA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF732jaA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so16879075e9.3
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505931; x=1791110731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfJP6yt1DXJx4cKd4gNx9tniZWIU3EM+Tzk+BM3HamA=;
        b=bF732jaALJFqlUdyPcCLlGUxstiCcmpPUlPHD4GBFB2i/K0BrjyIOP4DwoJQY/50wH
         GSZdjbbubmcOMxk/m2T7/JG3ctFKcNh0dh0T0MpBbml18a9Ro07IfZJqqDMb4CSWunCc
         bcqN4Nm283SNP3PhcQURgTTTU26BgFf75xJGAE49Ndw+nbZ3pBOOmdhyOnfRTXI3/O4H
         HrhoB/Rz9G0MWdu7hQ8IVQA2xahRVQDr4kVCZI0nXhVdbl8EcmDpCL91knjR8x3wzjcX
         3zyiI7xgu8sFsOSUA5KUCU2ZqLepJe2o+zBCVNGnSA0v9ghxDb/fcSJUy4f4cYkfThmJ
         YKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505931; x=1791110731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfJP6yt1DXJx4cKd4gNx9tniZWIU3EM+Tzk+BM3HamA=;
        b=N9eYDPpH8zDaaHhcfRnNFzQBqHUhdFuHQOWMw3VWig58BMdZ293o9jjFM78b5Cb12l
         F9PK8VyxF+yWmABgSaUEWvuZVuf0aqq0v/CvCb8eFeDw/JTx3+zHCW5WKgMpDdJ4vGAq
         kc9LIoQsbgYJIktxjLbeGv1XPVRrpEj2KhNjjYj2LiSTSyXJg1vzwbWwilC1P9rsLu7d
         9ndvg7FMC2imljnHK8ps1IQXonk3ridLne806BoxRMYqqSGsbbglxWL9ZfpD5v4nfH+V
         EmxVNXANy09DNXHeso3PpPR6FcdhYfPHNM75XB8UiN4nSjqAfSxJThg+fvS31DFlkEZI
         5tpA==
X-Forwarded-Encrypted: i=1; AKwUvByY87UYcxI2FIKjFHjqZQAc+cDOuR5JqDPpariIAEvxIi8A9E8iMAKJr+9i+XrN1ap8DLdQ6Eeviocotg==@vger.kernel.org
X-Gm-Message-State: AFuF++ngeTRBi69yQVx9Q5qJHk1Pz+xkRk5f9W7CZz9rL6C9tKL4+qju
	Nyw1WBq2eKm6AmsvOyjKv57Ai+HUniu9svw3bbN8mhd1Rmk1C2sKLs/H
X-Gm-Gg: AYBFou0dz3B0OCrFq7RxESWnCbTI7j7ARmOhlLbCmecKcm0+tKl7drqGHtmGZrbITI5
	q6Twr9uXLSlGt3mWR01/Q0eO3gpPJvZdZdz8orsV/P1vAEDd/p3OZUqCX+CXHYjT/RrxSm2mttU
	bzOMnth2ux5yYP4oXG2pXzIfqnP5EiCFTJ0U16viquKlQs1EeaXtqZuuCV8pVBrtIK1nJH43Yrb
	dGdi98oR0SQTwyMYjP3rnIzul9Fa40OWFgIKk3iG7v4bLakbltJSJK9nRmfrjq/T9xoDtWi32lV
	22o9SLGyFuHo92/zo9TSeiM1W4p5t2OyMOVs3UN1n0Zb5yPvgJf//7KOgJqx1hsoTmuVl2/jswB
	tbqO2sRDAO0UjMBuymsXP4hlVBqZ6BeMQuoYdgmV5J3QCPwSTnOPxVQ4xalk+l7MONqbGCdRRRh
	AjJ6fdxDhIJozZWxU1TB/bRAntg1KCBXq4Rjr1tsYEiIKnT8k0kNBrGCpDoX1BgWcNFZFwvBmoS
	SCSwZix5Rblq96Z5lOBz1n2u/SaoRPgDXnHiGcIDEs1FlOkiobLxBf25hAtz6NdHiA=
X-Received: by 2002:a05:600c:3ba5:b0:49f:fe79:62f9 with SMTP id 5b1f17b1804b1-49ffe796457mr53954805e9.25.1790505931369;
        Sun, 27 Sep 2026 03:45:31 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:30 -0700 (PDT)
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
Subject: [PATCH v4 0/4] rust: introduce DropGuard
Date: Sun, 27 Sep 2026 13:45:24 +0300
Message-ID: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the Rust kernel DropGuard API and migrates existing
cleanup guards in the block, serdev, and locking code to use it.

DropGuard is vendored from the Rust standard library and re-exported
through kernel::mem.

Changes since v3:
- Vendor DropGuard in rust/kernel/std_vendor.rs and re-export it from
  kernel::mem, following Gary Guo's review.
- Remove the DropGuard KUnit tests and Kconfig option since the
  implementation is vendored from the standard library.
- Keep the existing ScopeGuard API unchanged.

Testing:
- make LLVM=1 rustfmtcheck
- make LLVM=1 -j$(nproc)

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Mohamed Osama (4):
  rust: mem: add DropGuard
  rust: block: gen_disk: use DropGuard
  rust: serdev: use DropGuard
  rust: sync: lock: use DropGuard

 rust/kernel/block/mq/gen_disk.rs | 11 ++--
 rust/kernel/mem.rs               |  2 +
 rust/kernel/serdev.rs            | 10 ++--
 rust/kernel/std_vendor.rs        | 87 ++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs         |  5 +-
 5 files changed, 102 insertions(+), 13 deletions(-)

-- 
2.43.0

