Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491F368D40
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380021; cv=none; b=Hthg/OhKYdvu+5ZMnOTvXJsmSVJl2vsUUZAdTwYn/RimoQMAWByblAZjW/qi9crzfv/fK5rFiJnTz8xm6gJUo0eiE34eywY6gUnMwP7Uv3tFq1tGmrrs4d/08L7d3U4mkCcFjAHauykKhqcIDWkpyjwCu3kfGoi+cvCYyr26CKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380021; c=relaxed/simple;
	bh=LQVi50JmZvMXlo7oCZRzoZ6j7iMIn3gpQwuYHxYPk2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+B1t+5RctNtk+QgW3ZS/pTUuaNZh4PxDhA5A2Rbp7AvWBWmsxuagjATHMGkcyUtv9zsKyU/xsPW1MTWmXRrtAaLYAynqF5pjYsbxB/RR3EoWjB7TpuU78PH+aOg6UkvFk+nPxBculdKFABwQqDCP8N2aep0JrZLU/l4h30Nlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/SFVH3L; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/SFVH3L"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso14044195ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785380019; x=1785984819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzHlbzp07A6zmCxCg5YXdZ7kjwi0+0pga8qi/02bv0M=;
        b=A/SFVH3Ls3d8rG2ZsX66UzGpJL3a57KCBqIJ5Kg7QAwX1JaxdRtCUhkX9616D+7YRF
         VuZkPG6KfuUIrWSHsVLYOc5FWjOop/YTvPQl6xqOW85hUhKKuXZ/ftcUepe5U1eaP6Sb
         TXRhQq736FSs8nNX3UX+XzSbX2QqMgJX+zbjTWdehAOOjla+xoTNn0u4gh/I/QvWiGn4
         YkJTpA+dTrkgj85EEBR56fiJw4aMvtIrwE7tUz5pWfQSPpQX4dxfXU8uk7IaPE89ldo1
         RjyShPe2IamLJpWZiTn3/9SNRcy3FAx1zc4/NeS2ZnIs+OD76XpbhNdt67+r6GYHSott
         WUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785380019; x=1785984819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzHlbzp07A6zmCxCg5YXdZ7kjwi0+0pga8qi/02bv0M=;
        b=G0DfDyIl0i4Pfb4o1OARhVRq4WdZjvA2Br5GvMDFBnK2DW9w64zczfQ9YGcZMqOnC6
         bePWEj3iW+DncMhYA8Lyv306pAijVnLxzthBozwBo4cm7WO8LjN+ZY+eMCk2gV5/s+el
         gJwTHRRfOWY9t0FgHQBAnUk2s0anZmBR1e8NtxUUE7zf7i3UnTiPZSOTL+MLf07XcsbQ
         1KTKDsxXmi4oHGgq9xhfol6wG0MCdL94UhwwYkBjlG94jhwwTsBYSrJAgac9PZN6+t5t
         OY8BVFRU/V7/V3FvMPUwWi99wyWZcbruD4bzzXk0F4b+eITpvQkVC6iWhGyvrmM5b4dU
         7Bpg==
X-Forwarded-Encrypted: i=1; AHgh+Rqpy1/Rf2IzZMDC1dNxtZSQ/BR8GlSdSd5Xuqrq8LamtBjk1NRXFOGH3dOxvgPlkeLVC0jDeNKFSwoAGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5zfFSscWWQp/QBbIiwStRzzfeVt8d5K/Wca8YRKXBKMMqZsA
	umXLh/H5ESR/mL7QOglBhsfx2WY7vEwgkFHpfDQJADaFfmTslbe/E6C5
X-Gm-Gg: AR+sD13C2k5wp6MIY+8VeePAvmK782lhVUpX+/hUuqUz8e34zOlHg+gWoB0Zmfz1RXY
	F8+6xA8o3Tg4rNtxMhniEKLt0tOpg/HcfqhBIxvm9/CU76XKKno+NjPmq9Ph8bEK/uibqPbP+ji
	dGLWYDVPKvJAO2i9S1ZKU187o0ZiIZTd5367IN64xwh8f/YYlQ/J7nZwqqIYgbC9mX2uMMJCLuT
	fC69gYjWYo8qs0wbybsIKllsPYC7o5Q7IDbRj7XNybB/LmFsJgqdBgUT1BtOflZTDYHzqfl044P
	KDL/p/9n6Z0zhuIV8cIce5PPu9lot6w0HbKhWz1He74MzSDxZtuPy5E8fFvlGVmAp/X/pnS7E4+
	4qFSmXnB3cDpLAS1SjJ/fLCt3D/D87v5P3QdQzZlhwHf5i+v8mJ6IBnZvOBe+kdy4UVPGt31EA7
	ejVgZ/p8mxM99caEf0+3egYolWQRJiPYsRE1NpvVgNzv5Mt2tvqVmDpaBY+wIqXqY76gHDyPQBo
	dZZZyL4x3o0qZtMH76z1busI+Rm7QsKTQ==
X-Received: by 2002:a17:903:3c30:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d035b9b940mr9963145ad.4.1785380019485;
        Wed, 29 Jul 2026 19:53:39 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm18656485ad.69.2026.07.29.19.53.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:53:39 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v3 3/5] zram: add level validation in zstd setup_params
Date: Thu, 30 Jul 2026 10:52:38 +0800
Message-ID: <20260730025240.17724-4-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730025240.17724-1-haoqinhuang7@gmail.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

zstd_setup_params() currently accepts any level and silently clamps
it via zstd_get_params(). Add explicit bounds checking using
zstd_max_clevel() to reject out-of-range levels early with an error
message. Since zstd_max_clevel() is a runtime function, the check
is done here rather than in the generic validation path.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_zstd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 2584f47c9b3c..6febb366f76e 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -60,6 +60,11 @@ static int zstd_setup_params(struct zcomp_params *params)
 	params->drv_data = zp;
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = zstd_default_clevel();
+	else if (params->level < -(int)ZSTD_TARGETLENGTH_MAX ||
+		 params->level > zstd_max_clevel()) {
+		pr_err("zstd: invalid compression level %d\n", params->level);
+		goto error;
+	}
 
 	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
 
-- 
2.43.7

