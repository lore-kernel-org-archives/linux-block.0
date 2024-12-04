Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001851C3C05;
	Wed,  4 Dec 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335359; cv=none; b=c8V0cIgZpztHMqTRf0Vu9zhjXLR6nbuAs4hB6SVK5nvZb9l8xKsgcjqMjcyOsH3oGdWTK4d3u+WphXZv62Glot6Y78q3nmcL8K9BkarkcSfRRe1K85EdF7i1BcceYvJ4yejPlRjSyk2Jie4seZcuxnUXNV+090LULLpHCBA2aAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335359; c=relaxed/simple;
	bh=x/6cjXwLIpZfwSRp36yamP6IaujEqfNuSpAlnson4kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goWcvHtj8iz8OzEyUDojTRuCDYrWz4UOJIzHDIi778NsBCQ7jhRIH9xRYMFI1pBeYmK0WI/pOc/YlpMF09eMVgMCWfK9rxKcN86AWkRopxAD6XB+XbADd+1xsXa/TZ6UcRPIGAmpegSddLRJgvHPIh212Y3SE00Z/nulr/5WvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaQRWsZe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaQRWsZe"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7250844b0ecso87599b3a.1;
        Wed, 04 Dec 2024 10:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335357; x=1733940157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bAlGt/tiVuSRFhJS9Rkw9mOuskNJthnKTcKF5ulNOvw=;
        b=eaQRWsZeyATGcCtVinzhMn9t7KS9yNRHOnurKhP0obzrBgwKbVcSXIEScR5GIlsSs5
         MWI7Kp7SoLC5toCyfBFFSwEdyV/dQWy8ZgS9VnQRStptuYzEh9z/2ySncfvipyreb3ba
         zgPz0badl9GjA+Q4bBc1aOIPH2biIvCG9ocNoiMus6KufZFIrhkkVE7PWscJ7CB+ZXHc
         E8sCnxkZUbEQLkukHcaBDps+Bqb8+itHJOk+RWWxspzqJVoc53oHXy6EgTRGfW1XdlJo
         sLzpHvJHRftA2iesZp/J3TwXjxg8XxU7+eF8xlPvWkGyPLriiU49migTdaJ5wYOxI26i
         s6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335357; x=1733940157;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAlGt/tiVuSRFhJS9Rkw9mOuskNJthnKTcKF5ulNOvw=;
        b=B0XaWcEoTs5JLVEP7xZzcw8ScFScbFupzM72ddxYzpr1+lU9vCWh3xnEYRG/JURGD1
         YxYfMaCJr6ejxeaGuoQF017IOPtINIEulANnljLeljFCtXOwwnCFBcmC81vqgKmgp7YM
         S3ZP2ZsUQye6WEKdbWe51Y4t9HIRTxqk0Ah7QnWn2KjgDs4bD2rij3zQF6z2HeVfsMM+
         PRJKAL3SndG3DYCqDSlHwQHH9iwuqokFYCdqZAd6kyLCDNaPbsa52Es5UGGz2hDlgS/X
         pgtxZZZX8qlUwShxMXe4OE1TiKTU9Nz8P6uMxOmLO8iY+Yiaq6acs9ZhRE97nv59wIW/
         8WgA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ahRLmOvz8uMvXfJL+xnaVHozUapbDx+bh2H73VtDTkzWfhQ0Mbwi1pZZ4wSTv85+glbNOPphHrr0uw==@vger.kernel.org, AJvYcCX4waq4EOrSATvtNI25Nu8VmyGhKGCBOwhtJwiZlBxS8i5pgpin4t1FQh7J90e2R7SfTj0IG0O/@vger.kernel.org, AJvYcCXpARw8rYyPbzIU7V4jtDnZpBLWY4hskJqRicGvO93OaFSANHmURkImzvCnVHgkfhukViRuKBCAGZ9YGbij@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAfFQCFEXUoYtbX6sHK4PyQYw9tlgf9VVJRqyn4x9GRbHWFhf
	KLW7jCee8svltMIZlSE+UOHHkOKyg2AQEv+xYnX3lTnyj4s/lOjg
X-Gm-Gg: ASbGncv+Ezd8odfUl+gnKH+BuZH6DvIpZ7nt6NZFU9GfvfQ6yOaDyuoTpkp0WT5Jp9p
	f2aEu+AqYRHAI1aA+8PitsRMtCL08GO1rWOnQC3Kb+SCnEENOtGuMKsbyb3ANS2uKYrKlVNeafx
	qwOTkfFkFmEGIuwf8SmpIxkI0rOc4CvmXTnKIlm6cbzzrgt1QoUK0iyobmT4MM2mqzVo1EGIC1Q
	UHtC5NTJpUFwgJa7hau3rmRvGKTuusZd23i/ogyKgd6LK7rz+brzCA8/+JKfFpPVOgb6x0=
X-Google-Smtp-Source: AGHT+IHeql1iWXSfpkc9alhz3TOTPqPIWd0paC+yeqbkwcITYB2dvWkcwBYhP1UiZzR3SpjSJkLP+g==
X-Received: by 2002:a05:6a00:3c8c:b0:71e:f4:dbc with SMTP id d2e1a72fcca58-7257fcced2cmr9725349b3a.25.1733335357173;
        Wed, 04 Dec 2024 10:02:37 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7258947b48fsm2064736b3a.47.2024.12.04.10.02.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Dec 2024 10:02:36 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] zram: fix uninitialized ZRAM not releasing backing device
Date: Thu,  5 Dec 2024 02:02:24 +0800
Message-ID: <20241204180224.31069-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204180224.31069-1-ryncsn@gmail.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Setting backing device is done before ZRAM initialization.
If we set the backing device, then remove the ZRAM module without
initializing the device, the backing device reference will be leaked
and the device will be hold forever.

Fix this by always check and release the backing device when resetting
or removing ZRAM.

Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
Reported-by: Desheng Wu <deshengwu@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: stable@vger.kernel.org
---
 drivers/block/zram/zram_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dd48df5b97c8..dfe9a994e437 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2335,6 +2335,9 @@ static void zram_reset_device(struct zram *zram)
 	zram->limit_pages = 0;
 
 	if (!init_done(zram)) {
+		/* Backing device could be set before ZRAM initialization. */
+		reset_bdev(zram);
+
 		up_write(&zram->init_lock);
 		return;
 	}
-- 
2.47.0

