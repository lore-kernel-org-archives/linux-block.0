Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CE3F4858
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836335; cv=none; b=gbo7zlOv+x8UMB036Iv5tGRQrsUghg/IIf0lyeDAjQSgOduSNJwjMy4qju0cwRNxiLWhNGuaVbuDPOFOgyl+vDu9Qm2VZEf6t8SUkwXRzvgWv475F5qU24jC/o9UF6Oxk8gqQfp+r2jrp/Yd5IUmjjnAva4Ws6ey/hwmXmsVSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836335; c=relaxed/simple;
	bh=f7NqEchHgytQan2vuAYcxhw/Xs0Y5SEngUuoKv4fVFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLDg1ZvQLRm2NWcmvh/Z9XoEpQT1C+TftG+++wn6K6Ycks1uE3JfQg0ysjAwTdkE0/xOvNS1T8fJ3jjHJVsy8zP+pmXmuu9Cx9Ic4URAJeo1hNcF7yZqFzJfvE2a3yhK97S0lFJUE8gx3agIPKMVNZ+DuacsaykogWvSKkf7lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhspXNMR; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhspXNMR"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso1297281a91.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836330; x=1786441130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwqX8rqzfSDO3fbrOPC2Za3ssipdqnBrQbik6fwA0Dg=;
        b=nhspXNMRzpnjSE6YhDe+6ApW2zLb+KT08OwxRTB2fbyvzJ8fFfnr940NfU62+NqV3x
         0PnYZtWpirHpY/HjTFQOpMlZMbtWQSF/WjK8SSztf5xKIkHEJ5bTedod5K54eKImTHq6
         ++aLpEmhMz6gzg66pnACc8rwOelB6z+5jU4TnVDn71uh/YPJfwi+E35z9n+dUo9/3z4T
         /+xsMU8tD9etsg/zNpfy6ZYzlb9yvwMyEkJ2ve0qB3wdWNRrX7FsCA0ZCGrAsccPwemU
         VDZHH8qa6j+AiTiwaLwKwMnvLhn5JuPgMuw62CsSfYo5ss1cnkcRRxD+DW4BiFxadEYe
         FziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836330; x=1786441130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwqX8rqzfSDO3fbrOPC2Za3ssipdqnBrQbik6fwA0Dg=;
        b=RUC+EhoRAyn0Md03SiIP42mAVaL+1s11PpnecPj5LvP6LeUkgEhbHCsMXfbUGfPQB4
         ASCAikWoqhJAmY5dLLSlXbohkMGCbvPWkGCLUI351kK7Qup1OQmMx8OtOsXr6PpvIiO8
         bp3oBTkqaYj9ejSvr6AD61s/XpVZFydkXMlI8h/Z34B58B83XcUZ2u+NsADLmVzM+xfp
         gKVHgutCZpvidrcakGg2Cm0VDakJ5/E+RA93MXM8CmWnmslyAivqKjS4TW2MDMKhWUGs
         mvh9OxcIcain8+jqwCA+D+pyra/ngrLPWUh1g2w93xPB96Fg/kx+fnttPkYJ0raEnSnS
         8W6w==
X-Forwarded-Encrypted: i=1; AHgh+RoXG/iH7PgWTfzNE8vWa9rXM4UJKKvdTcoksQrUawLf3fZc5d412H7kUH5PFmooklaxeUgQQjTUo2FHLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlGc8h2fxl5YNePwWof/eRFhqurFix9O20iKlsmpzwLymh589
	CuleINlVjHaJuKDsKnpbWw76YGASpGqCLuVCuSubzfNoIZiFASoau8nm
X-Gm-Gg: AR+sD113aGj3Npx3p6wP9b1Dto5SSbv8Mf+cJvmwg+kKwJ7VRL32/0LX5f3Odh5BEkN
	+ZMKsfnfqbou4dv/bI8YeeCIPX9ioh1mirK9qAxl3eU+W38rO6fazmStJlJ+KZzDzqe/PUsT639
	DVOdvIyyb7UNhRtXwFbms0sa7GW3V1TjVNdh5MYq1yL9zypzUUMDdOLO2P9MYa7Wfw6ydYaWT1V
	kqAJsmcixp+qgDpQKOeUXn3ecTFpxZiZw9Xyit8Cf5TRt83pFUVAwMKoz1WgoX342wcYS1AqHMk
	wdXdpJUR28W2GycamMGrj67B6ofDQ6/rzOfyjp2xn48T9hZkHPOqbgLKss2XA6fgKdJzVsH7r9F
	5KYc1Z59/ko5wMikSnE1C7hMJNQ5gJym6cSZaMqgWqFLicYLSeWAJSXmJ5tYDhhiZGMZsbrIb8N
	nBVNhkr6UG3ni25yCeFzXMBvelZVeOMnUqfC2AyewhHwu+TplgzuY8PG8r9fSkBOp/BLy6ZLJxQ
	4kJeucjtY+m3jXAvWoXmknaZ094Sl2Vk/tTnhVyrs/S
X-Received: by 2002:a17:90b:5627:b0:387:e0bb:57ff with SMTP id 98e67ed59e1d1-38fbc58d37fmr11279418a91.38.1785836329931;
        Tue, 04 Aug 2026 02:38:49 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm1042633a91.16.2026.08.04.02.38.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 02:38:49 -0700 (PDT)
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
Subject: [PATCH v6 0/5] zram: fix zstd error paths and add parameter validation
Date: Tue,  4 Aug 2026 17:38:36 +0800
Message-ID: <20260804093841.67920-1-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260803141256.60599-1-haoqinhuang7@gmail.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Patch 1 removes zstd_release_params() from both zstd_create() and
zstd_setup_params() error paths -- the former is a layering violation
in a per-CPU callback, the latter is redundant as zcomp_init() already
calls release_params() on setup failure.

Patch 2 rejects zero-size dictionaries and prints distinct error
messages for sz < 0 (returns the original error code) and sz == 0
("empty file"). Currently errors are silently swallowed.

Patch 3 adds pr_fmt to each backend file so that pr_err() messages
are auto-prefixed with the algorithm name.

Patch 4 validates dict and level parameters in each backend's
.setup_params(), rejecting unsupported combinations and out-of-range
levels.

Patch 5 resets per-priority params on algorithm change before init.

Changes since v5:
  - Patch 2: split pr_err into sz < 0 and sz == 0 branches
  - New patch 3: add pr_fmt to all backends; tweak winbits message;
    add missing SPDX headers to lz4 and lz4hc
  - Patch 4: removed inline algo-name prefixes (now handled by pr_fmt);
    added comment for lz4hc < 1 lower bound; added braces to if
    branches for consistency

v5: https://lore.kernel.org/all/20260803141256.60599-1-haoqinhuang7@gmail.com/

Haoqin Huang (5):
  zram: do not release zstd global params from error paths
  zram: reject zero-size dictionary
  zram: add pr_fmt to backend files
  zram: validate parameters in each backend's setup_params
  zram: reset per-priority params when changing algorithm before init

 drivers/block/zram/backend_842.c     | 10 +++++++++
 drivers/block/zram/backend_deflate.c | 17 ++++++++++++--
 drivers/block/zram/backend_lz4.c     | 10 ++++++++-
 drivers/block/zram/backend_lz4hc.c   | 16 +++++++++++++-
 drivers/block/zram/backend_lzo.c     | 10 +++++++++
 drivers/block/zram/backend_lzorle.c  | 10 +++++++++
 drivers/block/zram/backend_zstd.c    | 11 +++++++---
 drivers/block/zram/zram_drv.c        | 33 ++++++++++++++++++----------
 8 files changed, 98 insertions(+), 19 deletions(-)

-- 
2.43.7

