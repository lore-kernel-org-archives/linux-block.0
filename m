Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C92750ED
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782543819; cv=none; b=YNH5XIngwsWme5skzlULxqFtJhTE5mcssKLducaK3z/ghfgPDlUCkFUdPVOiAd+C3vP6ynyMOsrgQIgdHewPoF40+wGIQawk8Aqs6k9VxNcsFvm3l1BaTkJdBYrS1A+Vky+gAcmCC8CEP2zvR51XZKH9qCvTorsShVEcAei7a1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782543819; c=relaxed/simple;
	bh=lZenipOb8Vy6mXAEE8hlpo9707k/hDHGnY4dUlew+/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skicrcHeNrZoKHv1gePGBDAL9CaPudWgrRIUGyXCOIfzh7RmY/3DxON+C2M83CRPXXM/ikS5d/dpjicfByj3ADHhYWWAXoZyFYLXYt7vgWdWUezvYo0VSZlfff4i8KyxwVPNH1PYDSGOLEwX9OXmfN1I+X6q+fJOMVaRDSTsXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIGwkn47; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIGwkn47"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2c6cfef9249so2378845ad.1
        for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782543818; x=1783148618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8aPMQNYLH8bNCRZYJwvFuQkI89TpkS65ZxxKsvSlpo=;
        b=MIGwkn47NdGSZ1jjkCFEqhkFaXIZJyATsyt8/2kBKUqqhpGBPwrcmi9Z5v3ZiKMnFU
         eaTrci5xIdqgOvxevq3Pd0XaXjpDXAA3V42MWzjRo2cYamOqWDmZqqPM/QvGKE4Q2pCr
         ivdTWEKwYP9uas4nE0dbmEi5Lll8h2ml5JlYeiquFVucURQc+ShTfeHANxHpOCSKimVN
         1n/wqeHgXeGd3rzaIOxKryPQNPs8EWQxc+j+MmjfB4Px90iP5GJzQQY3BQu15ER+zbjn
         zY7kQQHub4uf78uNdix4rzxYJsAgMREYEtV4O5jtQ81ubCgjzK9hcTy/C2kdlSX6l2MO
         SMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782543818; x=1783148618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8aPMQNYLH8bNCRZYJwvFuQkI89TpkS65ZxxKsvSlpo=;
        b=htXN57PcxogWewSrtaenj/g0OTY5x0KWpKM4woUoSEqrp4YM4Xf5vgBIdeJ3vqi0Ay
         EfGdjJ8rad8nqIKJG85U0BzMBrMIXpOUPOK0S/uZOX8MwJl1PIf2WQSZda2JvPOq8F0Q
         v0hyBazunP1fdGKtTHtEbEjJdnWeuzwQik96C9+OShW3PbboJ3ArMAck56ja8sTZ3c4K
         ST9Wm2ueG6MdHDT7OgC9sBHd6tBYc0dL4JuqekqWFXzSGQyquXn1Z7+ObOI17JKXhWjH
         wYQdsRzcTGYfdAX81SCiny73jdW4gLmCZVPY5leio4qr9iJs2va00jyXZ6WdywNy10yH
         Dl8A==
X-Forwarded-Encrypted: i=1; AHgh+RpcBLpDF2sj7EpB6cEE3/Cgl1AeeHn30BdwWGzVQCT4WWq3flsl8QIjEOkEqrLXNk7nTYJCxb0as9BvMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwS2Pqr/1kSfiR/mInJagHK/Gg7LJYmx2k6L0dljhgKhjhTStJ
	o0MwGnI7fOdPELf8JBoEDafM8LhikihXPH8pFbkMRZxukV1mKeuINqvS
X-Gm-Gg: AfdE7cm9tNMTBxgrzNkrsXnQbc1/SuKwICEplfXuCBPEgazX00ibxnCmCQFJuB2LfYs
	KMIeiWD+IUNbceoOvmXWgJLPsRA4N1UphcMZ0NIWQUbwVpzhSJmgm8aEh8hUMPOSWzvIUkkm6yf
	lxtwGAagWKrY8Al0jueLFxznNQzxXEvrKfTyKB9+Cjz/i4E6vfo4KKf1/FYucelqjr/x/YiQtVX
	xVf1U+XoUl/TbnvfxhHU90xwlSgapRwqXIXGbZ/pf2LSVOFtYg4xATd5SLpK0LWO2FvijVGZFTa
	K52bJdlXxJq/rVqfKYOGvN5O959VDvSfvcORKv1riVPpVMKej+KMFcJSlDqOeXWNQEIH5tzAqv6
	GTii5STJkwNBv/MJ0R20bL2alx/DbrFmbhpFeP8ioXWebU86XyAMAWO78c/xlm7qZWcNt+rMwa4
	gnITvuBclrwEKbNvSx7KkCPdAQiXr+3y8zzVeISiXC+zRODUBQgIZBO8rUGA==
X-Received: by 2002:a17:903:2f8b:b0:2c8:1c3e:9636 with SMTP id d9443c01a7336-2c9860ba606mr28756025ad.25.1782543817597;
        Sat, 27 Jun 2026 00:03:37 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([2409:8a00:1a20:7370:71bb:5f2e:c181:eb3e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f65088cesm51596995ad.80.2026.06.27.00.03.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 00:03:37 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk,
	terrelln@fb.com,
	dsterba@suse.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	haoqinhuang7@gmail.com,
	rongwei.wrw@gmail.com,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH 3/3] zram: reset per-priority params when changing algorithm before init
Date: Sat, 27 Jun 2026 15:02:16 +0800
Message-ID: <20260627070216.13511-3-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260627070216.13511-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Parameters validated against one algorithm may be invalid for another
(e.g. lz4 accepts level=65535 but zstd does not).  Although algorithm
changes are blocked after disksize is set, they are allowed before
device initialization.  Reset per-priority params on algorithm change
so that stale parameters do not silently carry over.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Reviewed-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a667d0672720..6b47586e8718 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,6 +57,7 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void slot_free(struct zram *zram, u32 index);
+static void comp_params_reset(struct zram *zram, u32 prio);
 #define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
 
 static void slot_lock_init(struct zram *zram, u32 index)
@@ -1681,6 +1682,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	}
 
 	comp_algorithm_set(zram, prio, alg);
+	comp_params_reset(zram, prio);
 	return 0;
 }
 
-- 
2.43.7

