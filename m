Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE238E5C5
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766401; cv=none; b=ngjXU4O9jDjZbfI8aEvSNwgX16aIlaMUgCEmdJFuTrztPi/QE5hv0AMC5LgLRRM1CDlpd9UOfZk+b5rfYUSIAOIGA2DDDyyGsLyW5xsf/ixLXfmK6BTo99cECALE0pxSdXp2kEY3stafudkpvqSJqom3PiT+/NhhDTf0SyMt+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766401; c=relaxed/simple;
	bh=YFqUBvSO+3osDwTCf3fVj8exPvmF9oURT8rlR7ezKYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbvR+WKxSI+UQI/8W3chpCpQlt9nrtQhf+LG6ZQMiL5pbQX7GkGkmPFJWQPy/48dq6qzDXoWf//1ds8JksqtSKNATcf3RTTO6h93RYp3D9sihozr/2nCnJ4PqhfnL4923phW15XpPYPCrjNRgOm/No9H6MByf7PlAU0BMq+J2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSGpxW6v; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSGpxW6v"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so1241470a12.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766399; x=1786371199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJJt6ZYMeTT+Uw9BVFL8Ftes7rDYfLSWSIV0qkYlx0Q=;
        b=cSGpxW6vTtGFkrFiy7KHrTWC+TEEzcLGfEjjFr3r3NHb5z6X8Ck4u1EQqFXeS+Prkx
         IiiJkudin+kB1P+eURgx5/MBZ8ZhU0phuhhuOTgpZ/tjLZ63/OeEENp6ZAgezpvmXEDe
         OSLKvruvXNyeWHRkzH5lV08B6Q7XlWafyORuR7//fdWCHIYr5ItpNApQgscWzcRfBjcK
         bCmmOHSUrTgkX3CWpKjO3fK8JaWv7sQkqXr+ZOOZwBoMA2JC2CYDBGrXE7H8vm0l40fr
         XcWwSQzOCYmopOYizXHEaxRMNkkE+9PmJ2QsYgTHwxQW2a5DjnjGh5tQqbZZPyPiqVKn
         smMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766399; x=1786371199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJJt6ZYMeTT+Uw9BVFL8Ftes7rDYfLSWSIV0qkYlx0Q=;
        b=LpKiDyeeTdWhFxOFotgA6zdSRKrD/76vy1YiuaEHuxlZdvG/oUU151wbyVV9ihi5sW
         OvfSL0onEDAt26YyJrtMg5mEEHdKBIy/YgvnadIf1tzmG4cNGS0jBrZ/oPZWxE495cXk
         UbA4qKjk8dmKNufsSbb46eLa3MwtRI4jsG36bANlNLIioD1S5o7tPb4N4hmDgM/A7RcD
         cD0HA3nBZyU82Bo/AoBZFa1yMCulDo1srFf4pleVs02JNyq9I7CJFNFSjYcTXgALaOip
         Y3a5S6MfxrVZ25KZGcQ2QWLVbo4RAFAqkcLKkCiBLFaSYU8G2i/y7fv8E7YF0iYxwTWw
         9JOw==
X-Forwarded-Encrypted: i=1; AHgh+RqAdIAu2qhQ7jVa9SVLKENmxR8/0UJ3AKYWR3MGYeHf1eV82Eh+JNOYbe/d/5aKDc096p07jR4advsuCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKHOnt9MEnnNbvrbZAQZWaPh9CH4o9fzdDx4yWaf9ooGREe32
	4nhE03IfFlzmsYy5ui15Pt35DWLo3Qj1fgcJ4tAC+Y3zmHkIxku3mcfn
X-Gm-Gg: AR+sD13fkZx9hX1GU4qLNPKFDk6oHcfcSULxkhS02XCElqHeGTcFjqo5dRFpEffVMOP
	jGPqcghqtSzXbLDaT2FzVKDk6FTAkcPC4jfNjaoMbHZPLrSLi5NSt2JR4f3EjPILUx1GdirOUrV
	AuntWi9WkRh/lOQ1r2MejTqPLspC2FLamk3YO2f0tktrJUXTJqPlb81PZ4giiULpzpS5c8baTWQ
	HaH1Mpbz2JwPibs9By/CD8euu9VE9vs5n1zhZafNqhDm4LCQqvLWvXp+rxMYMf46LwhVuD1sTPv
	KVGY3vSriwykgcHrLvQdVoKdaOZAFQ+IL4LbngIqVKOKqRLhrdJoBnUOBaERHrzOFEr3cW8NaOR
	U5Iwy0azFUAC5AWqdnN/p7c4mUIlC9H1jzQEFZs3JKXgou3i8JbCUYuqJIn9Figj7NhwIkiywJX
	lCZMXql5Qu2ES465Qi6Tb84HhRMHBeJPLDa1a1LURFpunbJ444Ddi6j/EUGKYFigfXU7nxySdoU
	HR4ylTUlKWhPB5HumvNLbHFYDCIgX9Z6Q==
X-Received: by 2002:a05:6a00:88c:b0:848:82f0:679a with SMTP id d2e1a72fcca58-84ee496ea21mr9867601b3a.52.1785766398733;
        Mon, 03 Aug 2026 07:13:18 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:cd52:f161:9c8a:ee77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebeasm3818360b3a.30.2026.08.03.07.13.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 07:13:17 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>
Subject: [PATCH v5 0/4] zram: fix zstd error paths and add parameter validation
Date: Mon,  3 Aug 2026 22:12:52 +0800
Message-ID: <20260803141256.60599-1-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730060133.80233-1-haoqinhuang7@gmail.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Patch 1 removes zstd_release_params() from both zstd_create() and
zstd_setup_params() error paths, the former is a layering violation
in a per-CPU callback, the latter is redundant as zcomp_init() already
calls release_params() on setup failure.

Patch 2 rejects zero-size dictionaries and prints an error on dict
load failure (currently errors are silently swallowed).

Patch 3 validates dict and level parameters in each backend's
.setup_params(), rejecting unsupported combinations and out-of-range
levels.

Patch 4 resets per-priority params on algorithm change before init.

Changes since v4:
  - Patch 1: merged zstd_setup_params() zstd_release_params() removal;
    reworded commit message
  - Patch 2: removed "zram:" prefix from pr_err (pr_fmt already adds
    it); reworded commit message
  - Patch 3: dropped lz4 U16_MAX upper bound (the library has no
    limit); changed lz4hc lower bound from LZ4HC_MIN_CLEVEL to < 1
    (the library supports levels 1-2); rebased on tree with deflate
    winbits validation
  - Patch 4: moved comp_params_reset() up instead of using a forward
    declaration

v4: https://lore.kernel.org/all/20260730060133.80233-1-haoqinhuang7@gmail.com/

Haoqin Huang (4):
  zram: do not release zstd global params from error paths
  zram: reject zero-size dictionary
  zram: validate parameters in each backend's setup_params
  zram: reset per-priority params when changing algorithm before init

 drivers/block/zram/backend_842.c     |  8 ++++++++
 drivers/block/zram/backend_deflate.c | 11 +++++++++++
 drivers/block/zram/backend_lz4.c     |  4 ++++
 drivers/block/zram/backend_lz4hc.c   |  4 ++++
 drivers/block/zram/backend_lzo.c     |  8 ++++++++
 drivers/block/zram/backend_lzorle.c  |  8 ++++++++
 drivers/block/zram/backend_zstd.c    |  7 +++++--
 drivers/block/zram/zram_drv.c        | 29 ++++++++++++++++------------
 8 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.43.7

