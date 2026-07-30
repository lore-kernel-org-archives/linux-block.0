Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E237DEBB
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379989; cv=none; b=syRkNzDGCzOPX2GFwI3ldsx2g1LJvS1xoHonmbvasZQDZkIKTj0Wxh7WlqJwTHCoN0cShATkykQCc2nm0TcRRbzN4Z/FcKV7V4LSRwNXeWRBRS+IyIGDIRCD96ItbkKmi3Ay3GpG40SvxQ8MP56lnlIIzq8+75La3Rc7DAKiwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379989; c=relaxed/simple;
	bh=sypqW70MrsyqBot+XVZdwIYRMZMcxTaKqqxmlzCePKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0U2m54D4EkEy8VN/9enGf4quWG3JPpcAWvF0uu38/shhvjw4EtnYZ62v2XUaj7h20Mb3z9svFJ7temXMpp6uVrxNlb3ncsZX7QB60MbE7U4d061ld7WJztoB4bOzp6elJa2u0EL6IZvQq8g2scWBJJ+4GBI85yonj+kjUn4qoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjCFINsD; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjCFINsD"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf49dc298bso14085565ad.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785379988; x=1785984788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y91LzyECKt6x6yYCBVS7tnMsT4+U+u3P0rsL7gL1vxI=;
        b=BjCFINsDv50lgcCJjPINgKkgxZk9IotAwmbFK2NLcw686jMhEUSnGkB7iD3LVVOM23
         TXfXzD6wpyA2ZLBP7wEal/VTeKJ50bfzi30uQQjenqK7gIw6teOZa/t75KZnRp4Fhre9
         i1+nuFBpjnMcWOM+MTqf24bt6TSe8ls71EVWIXah4/YQwxFR1y5eQi6i0Y9tnw54MNnf
         SVTLGFCig9FzzfJ+kNAHRzt8DegqxvOezs8N6GbcVDrzOoWZAFmjlz0KTLh7O02u9Icm
         RXDRKzy37H5anF86lEm9hrE8JNvNDq10rcqa4R2+8x1mLjiPDQ5iepyafG8y4uEaYKk9
         AOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379988; x=1785984788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y91LzyECKt6x6yYCBVS7tnMsT4+U+u3P0rsL7gL1vxI=;
        b=OjsEZR4u1p6u26cLx9tN0YWWvf06EmSXz9pXriJdWjp/BM4RMmHXCAGrEOEa0/JMef
         KCcJ6eqTRiMJzWh1SeZ0JqIp546TCoEyCHHNuk4kcnvvxi5h2I6BgdkXR2WjFMjj09iL
         LQqahtCo0Dne8n69tPPax357zO92NSg7dp3V9vpXfBnpm9FzHk4B3xQEjkgVyzLuev11
         7hsFpPrkhzryv48i6WA6uPOmAn6JQO16wfFAa3IGt6igPnXn+xVhazsugKQe1P5Bt1dG
         syesqAFEAW3/vZu1sCHKfV1Id3q+eFcHypQtsc5gmz40rNI8fnyGExPu5COhNfHxlcBu
         pSkw==
X-Forwarded-Encrypted: i=1; AHgh+RrsC7lFzQBphsbkRYmeLHMMAKByw3MVoFCyfu87ioAE4pCqVhkk1IMKkLdgLQKIfbfjPxHwVpwDu8pu9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z1XHQkvQLUDjIt/wHVH/maJX3PnKqnDCRZZULSJOIjEIrEG/
	9bAOok8tQBd4mpJZuXYJUmSxwYLTcihBQ7jpOVJ+AmOZxxR3s8CoGdjZgVJFCRt3
X-Gm-Gg: AR+sD12y5PS4TB7CyMNFXtwPPrTjBaoW1ODq0GtzaMtfs2IkqahDNUv03ZSMtb0t07a
	s6U7iE85UGdcj8/OWxbPEOEBhRiPiZrqFlrnoj1RbafWiNp92tES+OsJvRjd352fqY4Xxo1fe5M
	ZMgGNcEOsO8wPbp7VLF2KG1MJnXmuU3iuMJ56FgZd/eNeL8ib9Kpyik/iDpVweUtbkCx+EHkkEZ
	fcm6bdtclrTEG7ItYBQag270JsqOxKygsFL5++Pt84+XfLTpVk3iLNrIhJSvb+rHdAEp+B4wSgG
	A2c7DLfgMY1ctU9M7D9hnLqU+wUtiTL37patCCqnes/zvgbf8vVWrDp11umZFNvVz9CwqG5LeNl
	nGT4KaxpPYtk55JxXRaQ5gT/1zi7OKLODpKgKfi2M3RuVMMiswTPLtZTNoPgt1DusDiCyx0Ony3
	tcHvE2ieHy62/Xy2ktAXw00OG+q+KWoSZVXKOwB/3MMqbp6a3/ELeTFix1y5e4bTUJwjrRcZ1cz
	nUK7h1AQUSDLbERq7VBYz2TbDDDKQxoP7lHv3aBcv5x
X-Received: by 2002:a17:903:3c44:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2d035b9b738mr8820895ad.3.1785379987935;
        Wed, 29 Jul 2026 19:53:07 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm18656485ad.69.2026.07.29.19.53.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:53:07 -0700 (PDT)
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
Subject: [PATCH v3 0/5] zram: fix zstd per-CPU error path and add parameter validation
Date: Thu, 30 Jul 2026 10:52:35 +0800
Message-ID: <20260730025240.17724-1-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Patch 1 removes zstd_release_params() from the per-CPU zstd_create()
error path since per-CPU callbacks should not free global resources.

Patch 2 rejects zero-size dictionaries and prints an error on dict
load failure (currently errors are silently swallowed).

Patches 3-4 add parameter validation: per-backend level bounds
checking in zstd_setup_params() (patch 3), and a generic
zcomp_validate_params() with per-backend caps to reject unsupported
dict/level parameters before storing (patch 4).

Patch 5 resets per-priority params on algorithm change before init.

Changes since v2:
  - Patch 1: removed "fix" from subject, reworded commit message
  - Patch 2: dropped atomic dict swap; kernel_read_file() already
    rejects empty files, so just use sz <= 0 and add pr_err
  - Patch 3: dropped ZSTD_MAX_CLEVEL header move, validate in
    setup_params using runtime zstd_max_clevel() instead
  - Patch 4: merged validate functions into zcomp_validate_params()
    with internal pr_err for specific error messages; sentinel
    level_max=-1 for zstd

v2: https://lore.kernel.org/all/20260728092935.31139-1-haoqinhuang7@gmail.com/

Haoqin Huang (5):
  zram: do not release zstd params in per-CPU error path
  zram: reject zero-size dictionary
  zram: add level validation in zstd setup_params
  zram: add per-backend caps and validate parameters early
  zram: reset per-priority params when changing algorithm before init

 drivers/block/zram/backend_842.c     |  1 +
 drivers/block/zram/backend_deflate.c |  3 +++
 drivers/block/zram/backend_lz4.c     |  3 +++
 drivers/block/zram/backend_lz4hc.c   |  3 +++
 drivers/block/zram/backend_lzo.c     |  1 +
 drivers/block/zram/backend_lzorle.c  |  1 +
 drivers/block/zram/backend_zstd.c    |  9 ++++++++-
 drivers/block/zram/zcomp.c           | 27 +++++++++++++++++++++++++++
 drivers/block/zram/zcomp.h           |  7 +++++++
 drivers/block/zram/zram_drv.c        | 15 ++++++++++++++-
 10 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.43.7

