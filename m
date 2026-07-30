Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8536A004
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391318; cv=none; b=uO7NMLPOsAjRTTmwo9CcCOy1ygKhYd1XroHu9zQINJPMFQ6z0uRD9K8qvvlZljzpmM5IUxv4Uw6lnnH+yqsRj/hSB3/YOx0IGCo2Qny0GBAP6oOkqPGsuOAiJl4Isl4InorH/NUlsRIFkB6kyT1YNHfDMNRulOHmJZ29vZXbg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391318; c=relaxed/simple;
	bh=OTfgRB8h0h7em4vm2fdnCKl20mxuPIzN8t712TCBYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRNcdVIWu7F01ckxPtq00z8+gRJcUqZoXyeHdoAcNgwArBUfT4IwhNcHBzUtr9FH+AI8o+Qz8/VbF5urO9Z/9RC2OhS9vKoi3KhSRfohAqPvc0MfL7HKV98bFDRe6idTDm+hiN37J4P2n9rgsQFHCaYm9NM62bqyLRGkW7lGugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxIpKWYO; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxIpKWYO"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso575727a91.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391314; x=1785996114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNtOEOP0A98+7wj8AbU95BZxH6nnJ0eJ7KtLByvsqoY=;
        b=HxIpKWYOXGuHDJ8uvQSkOQVCC2rtIhySTMde0FkTi1/MJq+r61SaUx9NR3QoiuCn+H
         OxK6ZVdMMTuxlVBgkR0hT0HrM8IYwmjA2HdMkhBjCAXHerlO4KRxbcaQ/ZAhvCjctLfH
         Y8TZ+IjJWQqnVpxl6YuBhuuDAIFY+cbP8vQfWrldVNkBX2DqY8LGGjn5eo5bg5KFIAYM
         YtLQ0lLahd/+wYkAR2dR7kjaWX7g7RfMF+KGBiHSUSM6P4fHzh6P9XJ7U8J1Ux5fRNXa
         SDA9vvew/R07RhHRD3+z5l7QREcwYx2I7k6qVNS04eocy3ChCKX96y/qVu/MmbTWZiwP
         vEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391314; x=1785996114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNtOEOP0A98+7wj8AbU95BZxH6nnJ0eJ7KtLByvsqoY=;
        b=Bv0/wd34OjptsnO91k6TsfD4UtyFa7p/gtoQa+alcXeTTKczsjL0C0Zawnh+A0VdV+
         tvYwlyVpzF/byfnU4ILy9gzLuVrC1z8cFS/9Dnwk9B/DSNwMoMZ4vqgSnvd8ACrGFv4U
         JPoT9zlLxgRM1nW2MxSY+qjBiSU4y/vFsQ+ImTbBFibCxWr0S5tDcGLPYrEb1HzL8GjX
         LhU96l76aJlJmzNbZgeYXWX2AdgQp6zlWp+Y/l4c6D2UPFdQ3B52DmzkZZvkbGAXyFDo
         FNy/1E0cvNOPjQU11ZMfQ8xg8WAvlOYs3mTsMP1+UMd6m89p9leVjQAmXVzJ4TtGrNkV
         yk2A==
X-Forwarded-Encrypted: i=1; AHgh+RoriT97I46bEjZe8Rvp7jvNR7V7dlGrG9gIXpBGX5FyVO62tVUBSqtb3762v6Vlaw2bU+dyqRJ5TeTenQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/OC78fDtg6n+yk3cftQUrXPydXxj1mo3omrXJaZWmitqWwAE
	Wn1T6V02JM1lX84nDBtk2FHQMhGqrsLzPsM6C2Ws0s7C3MwnfCX3ijsH
X-Gm-Gg: AR+sD11oMvxI/V3rA/8w2SIQxAmqMEVD043ckrK0wCA1rFnYx8kO6OEfTMq6YhFZZvu
	lv9z3dGwjLc89AmbAugoutl/OGo7uqJKahFivjNCqw3iwiXUvs77vlEEJN5SmIWiRRqFQUNk98F
	L/t8lq6QhZ/BUCvD6GZn8En05u+EkYoMMGQKMpnIzrKalpDTvVHcf3YIlLjI/q4bpHcng6+4au8
	eg86jXEEb6su145TJhFj7PL/dXbhzV2cp+MoJ62QR25Lw+HqMvj3nS0cul/0gB4cm6FQ+2ilL08
	wozp3EH5KK41608lfDR4F2aN5HBbScvOkK9OsZBWoPY3nPNWvVE86I6bxLO3boApitLyA0woize
	VrGPkfHh4inUYe/ec/ACdjEqT/XiLh9eCZ9U58q9TfNuEbViN5ILyMToivu0jt9hNyEfW2ujqLQ
	FRucJx8/jCAHnE7MF8LcjlwdeJS90hCHiJTYPCWFJkCHC0cfRz+w5Xe+URJ8WajUXDi837UtX+S
	9dOGyHBUTrPqcy8vonb1ivP000hGiqOlg==
X-Received: by 2002:a17:90b:1ccb:b0:38e:85fb:71b9 with SMTP id 98e67ed59e1d1-38f9be2b6f9mr1235553a91.4.1785391313584;
        Wed, 29 Jul 2026 23:01:53 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d6c8sm430737a91.3.2026.07.29.23.01.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 23:01:53 -0700 (PDT)
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
Subject: [PATCH v4 0/4] zram: fix zstd per-CPU error path and add parameter validation
Date: Thu, 30 Jul 2026 14:01:29 +0800
Message-ID: <20260730060133.80233-1-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730025240.17724-1-haoqinhuang7@gmail.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
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

Patch 3 moves parameter validation into each backend's .setup_params():
dict/level support checks for backends that don't support them, and
level bounds checking for those that do (zstd uses zstd_min_clevel()/
zstd_max_clevel(), lz4hc uses LZ4HC_MIN/MAX_CLEVEL, etc.).

Patch 4 resets per-priority params on algorithm change before init.

Changes since v3:
  - Patch 3-4: dropped the generic caps + zcomp_validate_params()
    approach in favor of per-backend .setup_params() validation,
    keeping zcomp.c free of any library headers

v3: https://lore.kernel.org/all/20260730025240.17724-1-haoqinhuang7@gmail.com/

Haoqin Huang (4):
  zram: do not release zstd params in per-CPU error path
  zram: reject zero-size dictionary
  zram: validate parameters in each backend's setup_params
  zram: reset per-priority params when changing algorithm before init

 drivers/block/zram/backend_842.c     | 8 ++++++++
 drivers/block/zram/backend_deflate.c | 9 +++++++++
 drivers/block/zram/backend_lz4.c     | 5 +++++
 drivers/block/zram/backend_lz4hc.c   | 5 +++++
 drivers/block/zram/backend_lzo.c     | 8 ++++++++
 drivers/block/zram/backend_lzorle.c  | 8 ++++++++
 drivers/block/zram/backend_zstd.c    | 6 +++++-
 drivers/block/zram/zram_drv.c        | 8 +++++++-
 8 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.43.7

