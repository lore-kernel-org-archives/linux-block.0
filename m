Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF4307AC7
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228590; cv=none; b=l9cLh7pZIbYQbCC6QoBIOioCSH6oTfE3eFz/tksXyWvgt4/AJxQ7+AJXgxLGSuGYRjLXdOL6pHgmtVTBo1NNtoCXEHznvGdBlF9Rrju4PGvmEYUEbsa0eHZ8FWROsBFsMCVX5Toqa5IsjXQ1Al5jEyzjycLAcYeuifroOFFM7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228590; c=relaxed/simple;
	bh=X63UHz0qWW55kaT+C6+HLfCvDytNqyZnVYp33HW2dWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxd7PkPxYtgasU/GmWIi8nkm/V8jvRQYbMFRtto+hqHSt9SbfR37aAt3Z2BBDloO34Qp4tIL0oqJ2K+niyjd0qMK2/XRpyFhe9qElid06FJnMBsxX+92SbH+kDSLxPP5qemZs54V1oHWL4VyZBT3a6t1Yk/GqgM7zG4BQPJdquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBXcdwyY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBXcdwyY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso2570115b3a.3
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 03:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766228588; x=1766833388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdk30fl3+WxdOLA0QiGygI7T24j/N41MKw7RxS8QmMs=;
        b=lBXcdwyYCwKcK75i24inBsK5xsndNpiDEHKRjHNpudH+6rhqntRPEaJuEYBRBAXu/T
         2egFWXdXPoC41WKYYf3zLyko40oMNjEj4rwWMHfiG3qwofVXQHZbRVzBOEcqL7KfXZ/4
         1pws1XLs7GQ2UpS3lYKDyoGGcc5WaDY2uCPpiNBz535OFi/dU0JxtLXx3D/gA0BgSvkf
         ZuDxDn3l1Al5uNrH9P30Gls+SzKo7ezqU3qIlLk8KZlVTAgDBUYeY+RJp9u9c2TpX2wK
         FwYTymeaZMWFXJnOyU6RfidnD5vved5elcVNWTM+Gq47zncrDGDr/FFKUW2iR2NSrfn3
         9/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766228588; x=1766833388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdk30fl3+WxdOLA0QiGygI7T24j/N41MKw7RxS8QmMs=;
        b=YefVr+yEJ10oms4fltJJQDZQfgy4WLPZ5YjLjEmnpo8FqMRG88/oB7Ty+jJ4ur+cel
         f9esv/ue/S48yFROzsuoIRndB205PqcFZcinv/7QjBdNG6uvYP9Mx7NpaNAMvc5yU5nX
         rolQZOBFlTDfkwO5phI+RAIgGhYydHIIm9zfOmXeBYOsOelAcZ6Pf+S7HgfxR7Is6Iik
         /BpXMiYyQo90CGKjtCnMBFTDW8MNdgKXilAsWss+fBhKPq7d2T47Byq6rtpQ53dqWELm
         PWUYT/uxpfdPsllVOLVnttWzidth0KTWKIPwhktU+LncM7QMydIZUcFnBA3WOsAXidUy
         Rqow==
X-Forwarded-Encrypted: i=1; AJvYcCVSXV8cEUr+0aR5YAEi3m94kPVV8SaHUWrWuB38Q2AM9ZR5PSpA0NHeSTnEG5TS95pd/IH6tHDye6TR5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHJsE1r4xHh/8eJT9sffjsArZoQ9QXRujg5A9dDbVFV8yG0QJ
	kwmQhSrZswLvruDqWYe8Njby0anY5izyPHUvGk289QmtwujeYZiOIe78
X-Gm-Gg: AY/fxX69FGSm9XsAGrBQAffvrRHp459Dpg/mJ1p2kRaSBRg2jNGvSVCRsI8yanaNF9Z
	NM3r8DHRKVtV6D5YtPCBhnxdps8zdj4ens5ChGQ/mx2udyQlXSHHm2K6fJfHyBuTlAhaPOoq4oQ
	0hnyj1AL48bf6EGWpBfeZj2lgIozHnw072am3Ejh3oNXqKEmnnQPKRca8Fhj6HGJzYHIBgRxIP7
	icm8ak7O5hCiigLHPrmsLxltsXgDjnJa7ivxa/nXOUwhLTBBl7c/kdlgK1xT/f5OJqPVGS0VyCi
	6hBcTBKhAWwh9by8cVtBVhvErDlp/hMLlaUlj6Q7bWrx4+xCSyHYqD5NEOajhq7MClV8bO0v98H
	qB0LGd2ulxlnqOq6EIV2QbPboErJaJ3EifNtQIeYn5OA6Yrf1oQKRVU+4dZBJf6pT41UDl13p9G
	H8bmT9kdtyluHvw/DQrdJOCZH5lCcNf+HP/ILXUJX/qUKb9FH5g6k=
X-Google-Smtp-Source: AGHT+IHEZA0PlL34m7yNPdJr3Fq6Se8nfkRk1RvfpC41M1UWR1oVofl4k9hWmNXMFRfN5WzwylRClA==
X-Received: by 2002:a05:6a00:4512:b0:7e8:450c:61c8 with SMTP id d2e1a72fcca58-7ff6667c5a7mr5734984b3a.56.1766228588397;
        Sat, 20 Dec 2025 03:03:08 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:c406:a500:4e4:f8f7:202b:9c23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a84368dsm5015547b3a.2.2025.12.20.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:03:07 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 0/2] block/blk-mq: fix RT kernel performance regressions
Date: Sat, 20 Dec 2025 13:02:39 +0200
Message-ID: <20251220110241.8435-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

This series addresses two critical performance regressions in the block
layer multiqueue (blk-mq) subsystem when running on PREEMPT_RT kernels.

On RT kernels, regular spinlocks are converted to sleeping rt_mutex locks,
which can cause severe performance degradation in the I/O hot path. This
series converts two problematic locking patterns to prevent IRQ threads
from sleeping during I/O operations.

Testing on MegaRAID 12GSAS controller with 8 MSI-X vectors shows:
- v6.6.52-rt (before regression): 640 MB/s sequential read
- v6.6.64-rt (regression introduced): 153 MB/s (-76% regression)
- v6.6.68-rt with queue_lock fix only: 640 MB/s (performance restored)
- v6.6.69-rt with both fixes: expected similar or better performance

The first patch replaces queue_lock with memory barriers in the I/O
completion hot path, eliminating the contention that caused IRQ threads
to sleep. The second patch converts the global blk_mq_cpuhp_lock from
mutex to raw_spinlock to prevent sleeping during CPU hotplug operations.

Both conversions are safe because the protected code paths only perform
fast, non-blocking operations (memory barriers, list/hlist manipulation,
flag checks).

Ionut Nechita (2):
  block/blk-mq: fix RT kernel regression with queue_lock in hot path
  block/blk-mq: convert blk_mq_cpuhp_lock to raw_spinlock for RT

 block/blk-mq.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

--
2.52.0
